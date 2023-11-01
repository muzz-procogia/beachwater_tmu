ui <- dashboardPage(
     dashboardHeader(title = "Beach Water Quality"),

     #sidebar tabs
     dashboardSidebar(
          collapsed=TRUE,
          sidebarMenu(id = "tabs",
                      menuItem("Home",
                               tabName = "landing",
                               icon = icon("home")),
                      # menuItem("Toronto",
                      #          tabName = "torland",
                      #          icon = icon("circle")),
                      # menuItem("Toronto Data Visualizations",
                      #          tabName = "tordata",
                      #          icon = icon("water",
                      #          class="water1")),
                      # menuItem("Toronto Predictive Models",
                      #          tabName = "Torpredict",
                      #          icon = icon("umbrella-beach")),
                      menuItem("Niagara",
                               tabName = "nialand",
                               icon = icon("square")),
                      menuItem("Niagara Data Visualizations",
                               tabName = "niadata",
                               icon = icon("water",
                               class="water2")),
                      menuItem("Niagara Predictive Models",
                               tabName = "Niagarapredicttab",
                               icon = icon("umbrella-beach"))
                      # menuItem("Vancouver",
                      #          tabName = "vanland",
                      #          icon = icon("cog")),
                      # menuItem("Vancouver Data Visualizations",
                      #          tabName = "Vandata",
                      #          icon = icon("water",
                      #          class="water3")),
                      # menuItem("Vancouver Predictive Models",
                      #          tabName = "Vanpredict",
                      #          icon = icon("umbrella-beach")),
                      # menuItem("Manitoba",
                      #          tabName = "manland",
                      #          icon = icon("star")),
                      # menuItem("Manitoba Data Visualizations",
                      #          tabName = "Mandata",
                      #          icon = icon("water",
                      #          class="water4")),
                      # menuItem("Manitoba Predictive Models",
                      #          tabName = "Manpredict",
                      #          icon = icon("umbrella-beach"))
     )),

     dashboardBody(
          tabItems(
               tabItem(tabName = "landing",
                       fluidRow(
                            tags$img(src = "beachpic1.png", style = 'position: absolute', height="100%", width="100%")),
                       box(actionButton(inputId = "niahome", label = "Niagara"),
                           width = 4, column(4, align="center"), background = "blue"),
                       # box(actionButton(inputId = "torhome", label = "Toronto"),
                       #     width = 4, column(4, align="center"), background = "red"),
                       # box(actionButton(inputId = "vanhome", label = "Vancouver"),
                       #     width = 4, column(4, align="center"), background = "lime"),
                       # box(actionButton(inputId = "manhome", label = "Manitoba"),
                       #     width = 4, column(4, align="center"), background = "aqua"),
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
