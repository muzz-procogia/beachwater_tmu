server <- function(input, output, session) {

     set.seed(122)
     histdata <- rnorm(500, mean = 150, sd = 30)


     #Action buttons on home page
     observeEvent(input$torhome, {updateTabItems(session, "tabs", selected = "torland")})
     observeEvent(input$niahome, {updateTabItems(session, "tabs", selected = "nialand")})
     observeEvent(input$vanhome, {updateTabItems(session, "tabs", selected = "vanland")})
     observeEvent(input$manhome, {updateTabItems(session, "tabs", selected = "manland")})


     #Action buttons on Each region's landing page
     observeEvent(input$tordata, {updateTabItems(session, "tabs", selected = "tordata")})
     observeEvent(input$Torpredict, {updateTabItems(session, "tabs", selected = "Torpredict")})
     observeEvent(input$niadata, {updateTabItems(session, "tabs", selected = "niadata")})
     observeEvent(input$Niagarapredicttab, {updateTabItems(session, "tabs", selected = "Niagarapredicttab")})
     observeEvent(input$Vandata, {updateTabItems(session, "tabs", selected = "Vandata")})
     observeEvent(input$Vanpredict, {updateTabItems(session, "tabs", selected = "Vanpredict")})
     observeEvent(input$Mandata, {updateTabItems(session, "tabs", selected = "Mandata")})
     observeEvent(input$Manpredict, {updateTabItems(session, "tabs", selected = "Manpredict")})

     ###HISTORICAL DATA VISUALIZATIONS PT 2/2####

     ####TORONTO DESCRIPTIVE
     #Beach map on Toronto page
     output$distPlot <- renderLeaflet({
          leaflet() %>%
               setView(lng = -79.3, lat = 43.7, zoom = 9)  %>% #setting the view over Lakes
               addTiles() %>%
               addCircles(data = BeachLocation, lat = ~ Lat_DD, lng = ~ Long_DD, weight = 10, radius = 1000,
                          label = ~as.character(paste0(Beach_Name)), color = "blue", fillOpacity = 0.5)

     })

     #Historical plots toronto
     output$Ecoliplot <- renderPlot({
          ggplot(BeachEcoli, aes(Year, !!input$Beach))+geom_point(size = 3)+geom_line()+ggtitle("Seasonal Mean E.coli")+
               theme(text = element_text(size=20))
     })

     #Weather plots toronto
     output$Weatherplot <- renderPlot({
          ggplot(AllWeather, aes(Year, !!input$Weather))+geom_point(size = 4)+geom_line()+ggtitle(input$Weather)+
               theme(text = element_text(size=20))
     })

     #Descriptive table Toronto
     output$review <- function(){
          dt <- BeachLocation[9:19,]
          dt %>%
               knitr::kable("html") %>%
               kable_styling("striped","hover")}

     ####NIAGARA DESCRIPTIVE
     #Beach map on Niagara page
     output$distPlotN <- renderLeaflet({
          leaflet() %>%
               setView(lng = -79.2, lat = 43.0, zoom = 9)  %>% #setting the view over Lakes
               addTiles() %>%
               addCircles(data = BeachLocation, lat = ~ Lat_DD, lng = ~ Long_DD, weight = 10, radius = 1000,
                          label = ~as.character(paste0(Beach_Name)), color = "blue", fillOpacity = 0.5)

     })

     #Historical plots niagara
     output$EcoliplotN <- renderPlot({
          ggplot(BeachEcoli, aes(Year, !!input$BeachN))+geom_point(size = 3)+geom_line()+ggtitle("Seasonal Mean E.coli")+
               theme(text = element_text(size=20))
     })

     #Descriptive table niagara
     output$reviewN <- function(){
          dt <- BeachLocation[1:8,-c(6:9)]
          dt %>%
               knitr::kable("html") %>%
               kable_styling("striped","hover")}

     #Weather plots niagara
     output$WeatherplotN <- renderPlot({
          ggplot(AllWeather, aes(Year, !!input$WeatherN))+geom_line()+geom_point(size = 4)+ggtitle(input$WeatherN)+
               theme(text = element_text(size=20))
     })

     ####VANCOUVER DESCRIPTIVE
     #Beach map on Vancover page
     output$distPlotV <- renderLeaflet({
          leaflet() %>%
               setView(lng = -123.0, lat = 49.3, zoom = 9)  %>% #setting the view over Lakes # DOUBLE CHECK THESE COORDINATES ARE OK WITH TEAM
               addTiles() %>%
               addCircles(data = BeachLocation, lat = ~ Lat_DD, lng = ~ Long_DD, weight = 10, radius = 1000,
                          label = ~as.character(paste0(Beach_Name)), color = "blue", fillOpacity = 0.5)

     })

     #Historical plots Vancouver
     output$EcoliplotV <- renderPlot({
          ggplot(BeachEcoli, aes(Year, !!input$BeachV))+geom_point(size = 3)+geom_line()+ggtitle("Seasonal Mean E.coli")+
               theme(text = element_text(size=20))
     })

     #Descriptive table Vancouver
     output$reviewV <- function(){
          dt <- BeachLocation[1:8,-c(6:9)]
          dt %>%
               knitr::kable("html") %>%
               kable_styling("striped","hover")}

     #Weather plots Vancouver
     output$WeatherplotV <- renderPlot({
          ggplot(AllWeather, aes(Year, !!input$WeatherV))+geom_line()+geom_point(size = 4)+ggtitle(input$WeatherV)+
               theme(text = element_text(size=20))
     })

     ####Manitoba DESCRIPTIVE    SEAHORSE
     #Beach map on Manitoba page
     output$distPlotM <- renderLeaflet({
          leaflet() %>%
               setView(lng = -96.6, lat = 50.5, zoom = 9)  %>% #setting the view over Lakes # DOUBLE CHECK THESE COORDINATES ARE OK WITH TEAM
               addTiles() %>%
               addCircles(data = BeachLocation, lat = ~ Lat_DD, lng = ~ Long_DD, weight = 10, radius = 1000,
                          label = ~as.character(paste0(Beach_Name)), color = "blue", fillOpacity = 0.5)

     })

     #Historical plots Manitoba
     output$EcoliplotM <- renderPlot({
          ggplot(BeachEcoli, aes(Year, !!input$BeachM))+geom_point(size = 3)+geom_line()+ggtitle("Seasonal Mean E.coli")+
               theme(text = element_text(size=20))
     })

     #Descriptive table Manitoba
     output$reviewM <- function(){
          dt <- BeachLocation[1:8,-c(6:9)]
          dt %>%
               knitr::kable("html") %>%
               kable_styling("striped","hover")}

     #Weather plots Manitoba
     output$WeatherplotM <- renderPlot({
          ggplot(AllWeather, aes(Year, !!input$WeatherM))+geom_line()+geom_point(size = 4)+ggtitle(input$WeatherM)+
               theme(text = element_text(size=20))
     })



     #Toronto beach parameters, inputs for plot
     ## RIGHT NOW, the Toronto predictive is running on the BN test. Need to get overlapping variables sorted before we can move ahead
     #    output$stats <- renderText({
     #       cpquery(BNTest, (C1=="true"),(C2=="'input$input1'")) #tricky tricky, doesn't want to accept input as text
     #     })
     #this will likely be #the cpquery - IT IS NOT
     ## note to ## this out rachel li200==1),
     #  evidence <- (waterfowlcat
     # cpquery(BNToronto200, event(Eco==input1 & waterqual2==input2 & geomean24==input3 & avgwspd==input4 & maxUV24==input5 &
     #strmdis==input6 & rain48==input7 & meantemp24==input8))

     ## Rachels try
     # eval (parse(text=paste("cpquery(fitted = BNToronto200,",
     #        event(Geomean200==1),
     #       evidence = ())))

     #Toronto model output ==  fixed WITH cpquery included **insert spot**
     ###

     ###MODEL OUTPUT

     output$prob <- renderText({
          event <- paste0(Geomean200== 1)
          evidence <- (waterfowlcat =="', input$input1, '")&(waterqual2 =="', input$input2, '")&(geomean24 =="', input$input3, '")&
               (avgwspd =="', input$input4, '")&(MaxUV24 =="', input$input5, '")&(strmdis =="', input$input6, '")&
               (rain48 =="', input$input7, '")&(meantemp24 =="', input$input8, '")
          eval(parse(text=paste('cpquery(fitted=BNToronto200,event = ', event, ',evidence = ', evidence, ',n,debug = TRUE)')
          ))})




     #Toronto predictive model graph
     output$plottor <- renderPlot({
          barplot(0.35,horiz = TRUE, xlim = c(0,1))
          abline(v=0.7)
     })

     # NIAGARA OUTPUT.
     #SERVER CODE NIAGARA
     ## TRIEED AS EVAL PARSE - NO LUCK

     # Load Bayesian network from the .net file
     Niagara_Model <- read.net("NiagaraModel.net")
     observe({
          print(input$Maxuv)
          print(input$BuoyWave)
     })
     output$prob <- renderText({
          event <- paste0("(outcome-no input == '", input$outcome200, "')")
          evidence <- paste0("(Yesterday's MaxUV == '", input$Maxuv, "') & ",
                             "(Avgvwh?? == '", input$BuoyWave, "') & ",
                             "(Wave Height == '", input$ShoreWave, "') & ",
                             "(Wind speed == '", input$Windspeed, "') & ",
                             "(Yesterday's geomean e. coli == '", input$Ecoli, "') & ",
                             "(Water Temperature == '", input$WaterTemp, "') & ",
                             "(Turbidity == '", input$Turbidity, "') & ",
                             "(48hrRainfall == '", input$Rainfall, "') & ",
                             "(Yesterday's meantemp == '", input$Temp, "')")

          # Using a formula and passing it to cpquery function directly
          result <- cpquery(
               fitted = Niagara_Model,
               event = as.formula(event),
               evidence = as.formula(evidence),
               debug = TRUE
          )

          # Do something with the result, like returning a formatted string
          result_text <- paste("Result of cpquery:", result)

          result_text
     })



     ###BACKBURNER
     #  output$prob <- renderText({
     #   event <- paste0("(outcome-no input == '", input$outcome200, "')")
     #  evidence <- paste0("(Yesterday's MaxUV == '", input$Maxuv, "') & ",
     #                    "(Avgvwh?? == '", input$BuoyWave, "') & ",
     #                   "(Wave Height == '", input$ShoreWave, "') & ",
     #                  "(Wind speed == '", input$Windspeed, "') & ",
     #                 "(Yesterday's geomean e. coli == '", input$Ecoli, "') & ",
     #                "(Water Temperature == '", input$WaterTemp, "') & ",
     #               "(Turbidity == '", input$Turbidity, "') & ",
     #              "(48hrRainfall == '", input$Rainfall, "') & ",
     #                     "(Yesterday's meantemp == '", input$Temp, "')")
     #
     #   query <- paste0("cpquery(fitted = Niagara_Model, event = ", event, ", evidence = ", evidence, ", debug = TRUE)")
     #    result <- eval(parse(text = query))


     #  result_text
     #  })

     #ON BACKBURNER
     #   Nia_Outcome <- reactive({
     #  max24uv <- as.numeric(input$Maxuv)
     #   avgvwh24 <- as.numeric(input$BuoyWave)
     #  shorewave <- as.numeric(input$ShoreWave)
     #  windspeed <- as.numeric(input$Windspeed)
     #    ecoli24 <- as.numeric(input$Ecoli)
     #    watertemp <- as.numeric(input$WaterTemp)
     #    turbidity <- as.numeric(input$Turbidity)
     #    rain48 <- as.numeric(input$Rainfall)
     #    meantemp24 <- as.numeric(input$Temp)
     #
     #    geomean200_eval <- "geomean200"
     #    predictionNia <- cpquery(
     #      fitted = Niagara_Model,
     #      event = nodes(geomean200_eval),
     #      evidence = data.frame(
     #        Max24UV = I(interval(max24uv)),
     #        avgvwh24 = I(interval(avgvwh24)),
     #        shorewave = I(interval(shorewave)),
     #        windspeed = I(interval(windspeed)),
     #        ecoli24 = I(interval(ecoli24)),
     #        watertemp = I(interval(watertemp)),
     #        turbidity = I(interval(turbidity)),
     #        rainfall = I(interval(rain48)),
     #        meantemp24 = I(interval(meantemp24))
     #    )
     #   )
     #   predictionNia
     #  })

     output$predictionNia <- renderText({
          prediction_Nia <- Nia_Outcome()
          Nia_Prediction_text <- paste("Predicted Probability:", round(prediction_Nia, 2))
          HTML(Nia_Prediction_text)
     })


     #Niagara beach parameters, inputs for plot
     # dataNia <- reactive({
     #  rnorm(1, mean = input$input10, sd= 5)}) #this will likely be the cpquery
     #  cpquery(ModelToronto, event(Ecoli200==1),evidence(Waveheight==input10 & avgwh24==input20 & Ecoli24==input30 & avgwspd==input40 & turbidlog==input50 &MaxUV24==input60 & rain48==input70 & watertemp==input80 & meantemp24==input90))


     #Niagara predictive model graph
     # output$plotnia <- renderPlot({
     #  barplot(0.35,horiz = TRUE, xlim = c(0,1))
     # abline(v=0.7)
     #  })

     #Niagara sumary stats
     # output$statsNia <- renderPrint({
     #  summary(dataNia()) #note the parenthesis to call data like a function
     #})

     #importing rain and temp for toronto

     urltor <- read_html("https://climate.weather.gc.ca/climate_data/daily_data_e.html?StationID=51459")
     urltor <- html_table(urltor)
     weather2 <- as.data.frame(urltor)
     output$TempTor <- renderPrint({weather2$Mean.Temp.Definition.C[input$Date]})
     output$RainTor <- renderPrint({weather2$Total.Precip.Definitionmm[input$Date]})



}
