#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#setwd("/Users/racheljardine/Desktop/BEACH/shiny app")
#setwd("/srv/dev-disk-by-uuid-3c29ef29-6ba4-4c7b-935f-a9227e2ccf33/NAS/Shiny/beachwaterCanada")
#Libraries
library(shiny)
    library(shinydashboard)
    library(leaflet)
    library(leaflet.minicharts)
    library(rvest)
    library(tidyverse)
    library(ggplot2)
    library(dplyr)
    library(kableExtra)
    library(bnlearn)
    library(rvest)
    library(xml2)


install.packages("shinydashboard", "leaflet", "leaflet.minicharts", "rvest", "tidyverse",
                 "ggplot2", "kableExtra", "rvest", "xml2")

`#Load datasets from file
BeachEcoli <- read.csv("BeachEcoli.csv")
BeachLocation <- read.csv("BeachLocation.csv")
AllWeather <- read.csv("AllWeather.csv")

###LOADING MODELS#####

#this is returning object of class bn.fit -  remove for mac
#BNTest <- read.net("example3.net", debug = FALSE)
#bn.net(BNTest)

#Loading In Toronto Model- Remove for Mac
#BNToronto200 <-read.net("TorontoModel.net", debug = TRUE)
#bn.net(BNToronto200)


#Loading In Niagara Model - Remove for mac
#BNNiagara200 <-read.net("NiagaraModel.net", debug = TRUE)
#bn.net(BNNiagara200)

#Loading In Winnipeg Model- Remove for Mac
#BNWinnipeg200 <-read.net("WinnipegModel.net", debug = TRUE)
#bn.net(BNWinnipeg200)


#Loading In Vancouver Model - Remove for mac
#BNVancouver200 <-read.net("VancouverModel.net", debug = TRUE)
#bn.net(BNVancouver200)

#options for R session
options(digits=2)
# check the sources of assets
ui <- dashboardPage(
    dashboardHeader(title = "Beach Water Quality"),



    #sidebar tabs
    dashboardSidebar(collapsed=TRUE,sidebarMenu(id = "tabs",
                                 menuItem("Home", tabName = "landing", icon = icon("home")),
                                 menuItem("Toronto", tabName = "torland", icon = icon("circle")),
                                 menuItem("Toronto Data Visualizations", tabName = "tordata", icon = icon("water", class="water1")),
                                 menuItem("Toronto Predictive Models", tabName = "Torpredict", icon = icon("umbrella-beach")),
                                 menuItem("Niagara", tabName = "nialand", icon = icon("square")),
                                 menuItem("Niagara Data Visualizations", tabName = "niadata", icon = icon("water", class="water2")),
                                 menuItem("Niagara Predictive Models", tabName = "Niagarapredicttab", icon = icon("umbrella-beach")),
                                 menuItem("Vancouver", tabName = "vanland", icon = icon("cog")),
                                menuItem("Vancouver Data Visualizations", tabName = "Vandata", icon = icon("water", class="water3")),
                                 menuItem("Vancouver Predictive Models", tabName = "Vanpredict", icon = icon("umbrella-beach")),
                                menuItem("Manitoba", tabName = "manland", icon = icon("star")),
                                 menuItem("Manitoba Data Visualizations", tabName = "Mandata", icon = icon("water", class="water4")),
                                 menuItem("Manitoba Predictive Models", tabName = "Manpredict", icon = icon("umbrella-beach"))
                                     )),

    dashboardBody(
        #tabitems all together
        tabItems(

          ##NEW FORMATTING FOR LANDING PAGE 1
          tabItem(tabName = "landing",
                  fluidRow(tags$img(src = "beachpic1.png", style = 'position: absolute', height="100%", width="100%")),
                  box(actionButton(inputId = "torhome", label = "Toronto"),
                      width = 4, column(4, align="center"), background = "red"),
                  box(actionButton(inputId = "niahome", label = "Niagara"),
                      width = 4, column(4, align="center"), background = "blue"),
                  box(actionButton(inputId = "vanhome", label = "Vancouver"),
                      width = 4, column(4, align="center"), background = "lime"),
                  box(actionButton(inputId = "manhome", label = "Manitoba"),
                      width = 4, column(4, align="center"), background = "aqua"),
         ),


 ###LANDING PAGES!###########

        #LANDING PAGE FOR TORONTO
        tabItem(tabName = "torland",
           fluidRow(tags$img(src = "beachpic1.png", style = 'position: absolute', height="100%", width="100%")),
                    box(actionButton(inputId = "tordata", label = "Toronto Data Visualizations"),
                       width = 4, column(4, align="center"), background = "red"),
                  box(actionButton(inputId = "Torpredict", label = "Toronto Predictive Models"),
                     width = 4, column(4, align="center"), background = "maroon"),
        ),

       #LANDING PAGE FOR NIA
       tabItem(tabName = "nialand",
               fluidRow(tags$img(src = "beachpic1.png", style = 'position: absolute', height="100%", width="100%")),
               box(actionButton(inputId = "niadata", label = "Niagara Data Visualizations"),
                   width = 4, column(4, align="center"), background = "blue"),
               box(actionButton(inputId = "Niagarapredicttab", label = "Niagara Predictive Models"),
                   width = 4, column(4, align="center"), background = "aqua"),
       ),

       #LANDING PAGE FOR VAN
       tabItem(tabName = "vanland",
               fluidRow(tags$img(src = "beachpic1.png", style = 'position: absolute', height="100%", width="100%")),
               box(actionButton(inputId = "Vandata", label = "Vancouver Data Visualizations"),
                   width = 4, column(4, align="center"), background = "blue"),
               box(actionButton(inputId = "Vanpredict", label = "Vancouver Predictive Models"),
                   width = 4, column(4, align="center"), background = "aqua"),
       ),


       #LANDING PAGE FOR Man
       tabItem(tabName = "manland",
               fluidRow(tags$img(src = "beachpic1.png", style = 'position: absolute', height="100%", width="100%")),
               box(actionButton(inputId = "Mandata", label = "Manitoba Data Visualizations"),
                   width = 4, column(4, align="center"), background = "blue"),
               box(actionButton(inputId = "Manpredict", label = "Manitoba Predictive Models"),
                   width = 4, column(4, align="center"), background = "aqua"),
       ),

###HISTORICAL DATA VISUALIZATIONS BY REGION (SECTION 1/2)####
#NOTE THIS HAS TO BE BROKEN UP LIKE THIS BECAUSE IT CANT BE IN SERVER FUNCTION SECTION

            #Tab for toronto data content
            tabItem(tabName = "tordata",
                    fluidRow(
                        box(width = 12,
                            tags$h1("Historical Water Quality and Environmental Data in Toronto"),
                            tags$h2("Data available from 2007 to 2020")
                            )),

                    #map and e coli plot
                    fluidRow(box(leafletOutput(outputId = "distPlot")),
                             box(varSelectInput(inputId = "Beach", label = "Beach:", data = BeachEcoli[,10:20]),
                                 plotOutput("Ecoliplot"))),

                    #table
                    fluidRow(box(width = 12, tableOutput("review"), title = "E. coli concentrations at Toronto beaches (CFU/100ml)")),

            #Weather plot
            fluidRow(box(width = 12,
                         varSelectInput(inputId = "Weather", label = "Seasonal environmental data:", data = AllWeather[,2:9]),
                         plotOutput("Weatherplot")))),


            #Tab for niagara data content
            tabItem(tabName = "niadata",
                    fluidRow(
                        box(width = 12,
                            tags$h1("Historical Water Quality and Environmental Data in Niagara Region"),
                            tags$h2("Data avilable from 2011 to 2019")
                            )),

                    #map
                    fluidRow(box(leafletOutput(outputId = "distPlotN")),
                             box(varSelectInput(inputId = "BeachN", label = "Beach:", data = BeachEcoli[,2:9]),
                                 plotOutput("EcoliplotN"))),

                    #table
                    fluidRow(box(width = 12, tableOutput("reviewN"),title = "E. coli concetrations at Niagara beaches (CFU/100ml)")),

            #Weather plot
            fluidRow(box(width = 12,
                varSelectInput(inputId = "WeatherN", label = "Seasonal environmental data:", data = AllWeather[,10:17]),
                         plotOutput("WeatherplotN")))),

       #Tab for Vancouver data content
       tabItem(tabName = "Vandata",
               fluidRow(
                 box(width = 12,
                     tags$h1("Historical Water Quality and Environmental Data in Vancouver Region"),
                     tags$h2("Data avilable from 2011 to 2019")
                 )),

               #map
               fluidRow(box(leafletOutput(outputId = "distPlotV")),
                        box(varSelectInput(inputId = "BeachV", label = "Beach:", data = BeachEcoli[,2:9]),
                            plotOutput("EcoliplotV"))),

               #table
               fluidRow(box(width = 12, tableOutput("reviewV"),title = "E. coli concetrations at Vancouver beaches (CFU/100ml)")),

               #Weather plot
               fluidRow(box(width = 12,
                            varSelectInput(inputId = "WeatherV", label = "Seasonal environmental data:", data = AllWeather[,10:17]),
                            plotOutput("WeatherplotV")))),

        #Tab for Manitoba data content
       tabItem(tabName = "Mandata",
               fluidRow(
                 box(width = 12,
                     tags$h1("Historical Water Quality and Environmental Data in Manitoba Region"),
                     tags$h2("Data avilable from 2011 to 2019")
                 )),

               #map
               fluidRow(box(leafletOutput(outputId = "distPlotM")),
                        box(varSelectInput(inputId = "BeachM", label = "Beach:", data = BeachEcoli[,2:9]),
                            plotOutput("EcoliplotM"))),

               #table
               fluidRow(box(width = 12, tableOutput("reviewM"),title = "E. coli concetrations at Manitoba beaches (CFU/100ml)")),

               #Weather plot
               fluidRow(box(width = 12,
                            varSelectInput(inputId = "WeatherM", label = "Seasonal environmental data:", data = AllWeather[,10:17]),
                            plotOutput("WeatherplotM")))),

##PREDICTIVE MODELS TABS



#Tab for Toronto Predictive Models
            tabItem(tabName = "Torpredict",
                    fluidRow(
                        box(title = "Predictions for Toronto Beaches. Enter in today's environmental data to create a prediction",
                            background = "blue", solidHeader = TRUE,
                            )

                    ),

                    fluidRow(
                        box(title = "Probability of exceeding water quality guidelines", background = "green", solidHeader = TRUE,
                            plotOutput("plottor"),
                            tags$h3("The probability (between 0-1) of E. coli exceeding the 200CFU/100mL guideline is:"),
                            tags$h3("0.35", style="color:red;font-size:50px"), ## change
                            textOutput("statsTor")),

                  ##CHANGE INPUT INTERPRETATIONS
                        box(selectInput(inputId = "input1t", label = "Waterfowl Count", choices= c("1 (0-50 birds)", "2(50-100 birds)","3 (100-150 birds)","4(150-200 birds)")),
                            selectInput(inputId = "input2t", label = "Yesterday's Observed Water Clarity", choices= c("1","2","3")),
                            selectInput(inputId = "input3t", label = "Yesterday's Geomean E.coli", choices= c("0 - 50", "50 - 100","100 - 200","200 - 3833")),
                            selectInput(inputId = "input4t", label = "Wind speed", choices= c("0 - 2.71667", "2.71667 - 3.56386","3.56386 - 4.55833","4.55833 - 12")),
                            selectInput(inputId = "input5t", label = "Yesterday's Max UV", choices= c("0 - 5.98", "5.98 - 7.1","7.1 - 7.92","7.92 - 11")),
                            selectInput(inputId = "input6t", label = "Stream Discharge", choices= c("0 - 1.25", "1.25 - 2.46","2.46 - 4.6","4.6 - 175")),
                            selectInput(inputId = "input7t", label = "48hr Rainfall", choices= c("0 - 5", "5 - 10", "10 - 117.4")),
                            selectInput(inputId = "input8t", label = "Yesterday's Mean Temperature", choices= c("8.6 - 17.21", "17.21 - 24","24 - 29.9"))),

                             uiOutput("inp1")),

                    fluidRow(box(numericInput(inputId = "Date", label = "Yesterday's date", value = 1),
                        tags$h3("Mean temperature:"),
                        verbatimTextOutput("TempTor"),
                        tags$h3("Total rainfall (mm):"),
                        verbatimTextOutput("RainTor"))
                    )
            ),



###NIAGARA PREDICTIVE MODELS TAB
#UI CODE NIAGARA
tabItem(tabName = "Niagarapredicttab",
        fluidRow(
          box(title = "Predictions for Niagara Beaches. Enter today's environmental data to create a prediction",
              background = "green", solidHeader = TRUE)
        ),

        fluidRow(
          box(title = "", background = "teal", solidHeader = TRUE,
              tags$h3("The probability (between 0-1) of E. coli exceeding the 200CFU/100mL guideline is:"),
              textOutput("result_text"),
              verbatimTextOutput("result_text")
          ),

          box(selectInput(inputId = "Maxuv", label = "Yesterday's MaxUV", choices = c("0 - 5.98", "5.98 - 7.1", "7.1 - 7.92", "7.92 - 12")),
              selectInput(inputId = "BuoyWave", label = "Avgvwh24??", choices = c("0-0.19", "0.19-0.37", "0.37-2")),
              selectInput(inputId = "ShoreWave", label = "Wave Height", choices = c("0 - 5", "5 - 10", "10 - 60")),
              selectInput(inputId = "Windspeed", label = "Wind speed", choices = c("0 - 3.15", "3.15 - 4.2", "4.2 - 5.6", "5.6 - 11.12")),
              selectInput(inputId = "Ecoli", label = "Yesterday's geomena e. coli", choices = c("1 - 50", "50-100", "100-200", "200-2072.7")),
              selectInput(inputId = "WaterTemp", label = "Water Temperature", choices = c("0 - 15", "15 - 23.44", "23.44-30")),
              selectInput(inputId = "Turbidity", label = "Turbidity", choices = c("0 - 5", "5 - 10", "10 - 713")),
              selectInput(inputId = "Rainfall", label = "48hrRainfall", choices = c("0 - 15", "15 - 23.44", "23.44-30")),
              selectInput(inputId = "Temp", label = "Yesterdays meantemp", choices = c("0 - 5", "5 - 10", "10 - 713")),
              actionButton("predictBtn", "Predict"),
              textOutput("result_text")
          )
        )
)


                 ),



                    )
        )



##START OF SERVER FUNCTION###
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
    #End of server bracket

# Run the application
shinyApp(ui = ui, server = server)
