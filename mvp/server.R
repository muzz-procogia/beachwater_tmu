# Minimum viable product (MVP)

# Define server logic
server <- function(input, output, session) {

     # Define reactive values
     values <- reactiveValues(maxUV24 = NULL,
                              avgwspd = NULL,
                              rain48 = NULL,
                              meantemp24 = NULL,
                              predictionResult = NULL)

     # Helper Function to fetch and parse data from a JSON URL
     fetchData <- function(url) {
          data <- jsonlite::fromJSON(url)
          first_row <- data$rows$c[[1]]
          value <- first_row$v[[2]]
          return(value)
     }

     # Helper function to extract numeric range from input string
     getNumericRange <- function(inputString) {
          # Assuming the input format is "min - max"
          rangeParts <- strsplit(inputString, " - ")[[1]]
          return(as.numeric(rangeParts[1])) # Returns the lower bound of the range
     }

     # Reactive expression to determine the box color
     boxColour <- reactive({
          if (!is.null(values$predictionResult) && !is.na(values$predictionResult)) {
               percentage <- values$predictionResult
               if (percentage <= 30) {
                    return("success")
               } else if (percentage <= 65) {
                    return("warning")
               } else {
                    return("danger")
               }
          } else {
               return("gray-dark")  # Default color when app starts or if predictionResult is not valid
          }
     })


     # Function to determine the increment for Max24UV
     determineMax24UVIncrement <- function(value) {
          if (value >= 0 && value <= 5.98) {
               return("[0,5.98]")
          } else if (value > 5.98 && value <= 7.1) {
               return("(5.98,7.1]")
          } else if (value > 7.1 && value <= 7.92) {
               return("(7.1,7.92]")
          } else if (value > 7.92 && value <= 12) {
               return("(7.92,12]")
          } else {
               return(NA) # or handle out-of-range values as needed
          }
     }

     # Function to determine the increment for meantemp24
     determineMeantemp24Increment <- function(value) {
          if (value >= 7.3 && value <= 17.2) {
               return("[7.3,17.2]")
          } else if (value > 17.2 && value <= 24) {
               return("(17.2,24]")
          } else if (value > 24 && value <= 32.1) {
               return("(24,32.1]")
          } else {
               return(NA) # or handle out-of-range values as needed
          }
     }

     # Function to determine the increment for waveheight
     determineWaveHeightIncrement <- function(value) {
          if (value >= 0 && value <= 5) {
               return("[0,5]")
          } else if (value > 5 && value <= 10) {
               return("(5,10]")
          } else if (value > 10 && value <= 60) {
               return("(10,60]")
          } else {
               return(NA) # or handle out-of-range values as needed
          }
     }

     # Function to determine the increment for geomean24
     determineGeomean24Increment <- function(value) {
          if (value >= 1 && value <= 50) {
               return("[1,50]")
          } else if (value > 50 && value <= 100) {
               return("(50,100]")
          } else if (value > 100 && value <= 200) {
               return("(100,200]")
          } else if (value > 200 && value <= 2072.7) {
               return("(200,2072.7]")
          } else {
               return(NA) # or handle out-of-range values as needed
          }
     }

     # Function to determine the increment for watertemp
     determineWaterTempIncrement <- function(value) {
          if (value >= 0 && value <= 15) {
               return("[0,15]")
          } else if (value > 15 && value <= 23.4) {
               return("(15,23.4]")
          } else if (value > 23.4 && value <= 30) {
               return("(23.4,30]")
          } else {
               return(NA) # or handle out-of-range values as needed
          }
     }

     # Function to determine the increment for turbidity
     determineTurbidityIncrement <- function(value) {
          if (value >= 0 && value <= 5) {
               return("[0,5]")
          } else if (value > 5 && value <= 10) {
               return("(5,10]")
          } else if (value > 10 && value <= 713) {
               return("(10,713]")
          } else {
               return(NA) # or handle out-of-range values as needed
          }
     }

     # Initially hide the fetchedDataBox
     shinyjs::hide("fetchedDataBox")

     # Initially disable the Predict button
     shinyjs::disable("predictBtn")

     # Observer for the "Fetch Data" button
     observeEvent(input$fetchDataBtn, {
          message("automative data button press")
          # Fetch data for each metric

          maxUV24_value <- fetchData("https://niagarafalls.weatherstats.ca/data/forecast_uv-daily.json?refresh_count=1&browser_zone=Eastern+Standard+Time")

          avgwspd_value <- fetchData("https://niagarafalls.weatherstats.ca/data/wind_speed-daily.json?refresh_count=0&browser_zone=Eastern+Standard+Time")
          rain48_value <- fetchData("https://toronto.weatherstats.ca/data/rain-daily.json?refresh_count=0&browser_zone=Eastern+Standard+Time")
          meantemp24_value <- fetchData("https://niagarafalls.weatherstats.ca/data/temperature-daily.json?refresh_count=0&browser_zone=Eastern+Standard+Time")

          # Update reactive values
          values$maxUV24 <- maxUV24_value
          values$avgwspd <- avgwspd_value
          values$rain48 <- rain48_value
          values$meantemp24 <- meantemp24_value

          # Update UI with fetched data
          output$maxUV24 <- renderText({ paste("Max UV24:", maxUV24_value) })
          output$avgwspd <- renderText({ paste("Avgwspd:", avgwspd_value) })
          output$rain48 <- renderText({ paste("Rain48:", rain48_value) })
          output$meantemp24 <- renderText({ paste("Meantemp24:", meantemp24_value) })

          # Set initial values for edit inputs
          updateNumericInput(session, "maxUV24Input", value = maxUV24_value)
          updateNumericInput(session, "avgwspdInput", value = avgwspd_value)
          updateNumericInput(session, "rain48Input", value = rain48_value)
          updateNumericInput(session, "meantemp24Input", value = meantemp24_value)

          # Make the box and div visible
          shinyjs::show("fetchedDataBox")
          shinyjs::show("fetchedDataDiv")

          # Enable the Predict button once data is fetched
          shinyjs::enable("predictBtn")
     })

     # Toggle edit/display for maxUV24
     observeEvent(input$editMaxUV24, {
          shinyjs::toggle("maxUV24Display")
          shinyjs::toggle("maxUV24Edit")
          shinyjs::toggle("editMaxUV24")
          shinyjs::toggle("saveMaxUV24")
     })

     # Save new value for maxUV24
     observeEvent(input$saveMaxUV24, {
          shinyjs::toggle("maxUV24Display")
          shinyjs::toggle("maxUV24Edit")
          shinyjs::toggle("editMaxUV24")
          shinyjs::toggle("saveMaxUV24")

          # Update reactive value
          values$maxUV24 <- input$maxUV24Input
          output$maxUV24 <- renderText({ paste("Max UV24:", values$maxUV24) })
     })

     # Toggle edit/display for avgwspd
     observeEvent(input$editAvgwspd, {
          shinyjs::toggle("avgwspdDisplay")
          shinyjs::toggle("avgwspdEdit")
          shinyjs::toggle("editAvgwspd")
          shinyjs::toggle("saveAvgwspd")
     })

     # Save new value for avgwspd
     observeEvent(input$saveAvgwspd, {
          shinyjs::toggle("avgwspdDisplay")
          shinyjs::toggle("avgwspdEdit")
          shinyjs::toggle("editAvgwspd")
          shinyjs::toggle("saveAvgwspd")

          # Update reactive value
          values$avgwspd <- input$avgwspdInput
          output$avgwspd <- renderText({ paste("Avgwspd:", values$avgwspd) })
     })

     # Toggle edit/display for rain48
     observeEvent(input$editRain48, {
          shinyjs::toggle("rain48Display")
          shinyjs::toggle("rain48Edit")
          shinyjs::toggle("editRain48")
          shinyjs::toggle("saveRain48")
     })

     # Save new value for rain48
     observeEvent(input$saveRain48, {
          shinyjs::toggle("rain48Display")
          shinyjs::toggle("rain48Edit")
          shinyjs::toggle("editRain48")
          shinyjs::toggle("saveRain48")

          # Update reactive value
          values$rain48 <- input$rain48Input
          output$rain48 <- renderText({ paste("Rain48:", values$rain48) })
     })

     # Toggle edit/display for meantemp24
     observeEvent(input$editMeantemp24, {
          shinyjs::toggle("meantemp24Display")
          shinyjs::toggle("meantemp24Edit")
          shinyjs::toggle("editMeantemp24")
          shinyjs::toggle("saveMeantemp24")
     })

     # Save new value for meantemp24
     observeEvent(input$saveMeantemp24, {
          shinyjs::toggle("meantemp24Display")
          shinyjs::toggle("meantemp24Edit")
          shinyjs::toggle("editMeantemp24")
          shinyjs::toggle("saveMeantemp24")

          # Update reactive value
          values$meantemp24 <- input$meantemp24Input
          output$meantemp24 <- renderText({ paste("Meantemp24:", values$meantemp24) })
     })

     # Process inputs and return increments
     processedInputs <- eventReactive(input$predictBtn, {
          print("processing")
          # Fetch the values from inputs
          waveHeightInput <- input$WaveHeight
          geomean24Input <- input$Geomean24
          waterTempInput <- input$WaterTemp
          turbidityInput <- input$Turbidity

          # Use the reactive value
          maxUV24Value <- values$maxUV24
          message("maxUV24Increment:", maxUV24Value)
          message("waveHeightIncrement:", waveHeightInput)
          message("geomean24Increment:", geomean24Input)
          message("waterTempIncrement:", waterTempInput)
          message("turbidityIncrement:", turbidityInput)

          list(
          # Process the inputs through the respective functions
          waveHeightIncrement = determineWaveHeightIncrement(getNumericRange(waveHeightInput)),
          geomean24Increment = determineGeomean24Increment(getNumericRange(geomean24Input)),
          waterTempIncrement = determineWaterTempIncrement(getNumericRange(waterTempInput)),
          turbidityIncrement = determineTurbidityIncrement(getNumericRange(turbidityInput)),
          maxUV24Increment = determineMax24UVIncrement(maxUV24Value)

          )

     })

     # Use processed inputs in cpquery
     observeEvent(input$predictBtn, {
          req(processedInputs())
          print("observing")

          # Use the increments in cpquery
          increments <- processedInputs()
          #print(increments) # this prints the correct thing

          # Construct the evidence string
          evidenceString <- paste0(
               "(Max24UV == '", increments$maxUV24Increment, "' & ",
               "waveheight == '", increments$waveHeightIncrement, "' & ",
               "geomean24 == '", increments$geomean24Increment, "' & ",
               "watertemp == '", increments$waterTempIncrement, "' & ",
               "turbidity == '", increments$turbidityIncrement, "')"
          )

          message(evidenceString)

          # Construct the cpquery call as a string
          cpqueryString <- paste(
               "cpquery(baynet,",
               "event = (geomean200 == 'true'),",
               "evidence = ", evidenceString,
               ")"
          )

          # Evaluate the cpquery string
          predictionResult <- eval(parse(text = cpqueryString))

          predictionResultPercentage <- round(predictionResult * 100, 2)
          message("Result:", predictionResultPercentage)
          values$predictionResult <- predictionResultPercentage

          #Update the UI with the prediction result
          output$result_text <- renderText({
               if (!is.null(values$predictionResult)) {
                    paste0(values$predictionResult, " %")
               } else {
                    ""  # Default text when app starts or if predictionResult is not available
               }
          })



     })

     output$resultBox <- renderUI({
          box(id = "cardNiagaraProb",
              title = "",
              background = boxColour(),
              solidHeader = TRUE,
              width = 12,
              collapsible = FALSE,
              closable = FALSE,
              tags$h3("The probability (between 0-1) of E. coli exceeding the 200CFU/100mL guideline is:"),
              textOutput("result_text")
          )
     })

}