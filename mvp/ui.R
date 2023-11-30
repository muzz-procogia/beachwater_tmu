# Minimum viable product (MVP)

# Define UI
ui <- dashboardPage(
     title = "Beachwater Quality",
     dashboardHeader(),
     dashboardSidebar(
          sidebarMenu(
               id = "sidebarMenu", # Add an ID to the sidebarMenu for reference
               menuItem("Home", tabName = "home", icon = icon("home")),
               menuItem("Niagara", tabName = "nialand", icon = icon("tint"),
                        menuSubItem("Data Visualizations", tabName = "niadata", icon =icon("chart-area")),
                        menuSubItem("Predictive Models", tabName = "Niagarapredicttab", icon =icon("table"))
               )
          ),
          div(style = "position: absolute; bottom: 0; width: 95%; overflow-x: hidden;",
              tags$img(src = "tmu-logo.png", style = "max-width: 100%; height: auto; display: block; margin-left: auto; margin-right: auto;")
          )
     ),
     dashboardBody(
          useShinyjs(),
          tags$head(
               tags$link(rel = "stylesheet", type = "text/css", href = "stylesheet.css")
          ),
         tabItems(
              tabItem(tabName = "home",
                      tags$h2("Welcome to the Beachwater Quality Dashboard"),
                      tags$p("This interactive dashboard provides historical data and predictive models for beach water quality across the Niagara region. Utilize this tool to explore trends, patterns, and forecasts that can help in making informed decisions about water safety and quality."),
                      tags$p("Features of this dashboard include:"),
                      tags$ul(
                           tags$li("Historical Water Quality Data: Visualize the historical E. coli concentrations and other environmental data collected from various beaches."),
                           tags$li("Predictive Models: Access predictive models that estimate the probability of water quality guidelines being exceeded, based on environmental factors."),
                           tags$li("Customizable Visualizations: Interact with the data by selecting different parameters to customize the visualizations according to your needs.")
                      ),
                      tags$p("To get started:"),
                      tags$ol(
                           tags$li("Use the sidebar to navigate between different sections of the dashboard."),
                           tags$li("Select 'Niagara' to view data visualizations or predictive models specific to the Niagara region."),
                           tags$li("Interact with the visualizations by choosing different beaches, date ranges, or environmental parameters."),
                           tags$li("Utilize the predictive models by inputting today's environmental data to receive forecasts on water quality.")
                      ),
                      tags$p("Please note that the data available ranges from 2011 to 2019, providing a comprehensive overview of the water quality during this period."),
                      tags$p("If you have any questions or require further assistance, please refer to the help section or contact the support team.")
              ),
              tabItem(tabName = "nialand",
                      h2("Niagara Landing Page"),
                      actionButton("niadata", "Niagara Data Visualizations"),
                      actionButton("Niagarapredicttab", "Niagara Predictive Models")
              ),
              # Niagara
              tabItem(tabName = "niadata",
                      fluidRow(
                           box(width = 12,
                               tags$h1("Historical Water Quality and Environmental Data in Niagara Region"),
                               tags$h2("Data available from 2011 to 2019")
                           )
                      ),
                      # Map and E. coli plot placeholders
                      fluidRow(
                           box(leafletOutput(outputId = "distPlotN"), width = 6),
                           box(plotOutput("EcoliplotN"), width = 6)
                      ),
                      # Table for E. coli concentrations
                      fluidRow(
                           box(width = 12, tableOutput("reviewN"), title = "E. coli concentrations at Niagara beaches (CFU/100ml)")
                      ),
                      # Weather plot placeholder
                      fluidRow(
                           box(width = 12,
                               varSelectInput(inputId = "WeatherN", label = "Seasonal environmental data:", data = AllWeather[,10:17]),
                               plotOutput("WeatherplotN")
                           )
                      )
              ),
              tabItem(tabName = "Niagarapredicttab",
                      fluidRow(
                           box(id = "cardHeaderNiagara",
                               title = paste("Predictions for Niagara Beaches. Enter today's (", format(Sys.Date(), "%B %d, %Y"),") environmental data to create a prediction"),
                               background = "info",
                               solidHeader = TRUE,
                               width = 12,
                               collapsible = FALSE,
                               closable = FALSE
                           )
                      ),
                      fluidRow(
                          # First column for the result text and fetched data
                          column(width = 6,
                               uiOutput("resultBox"),
                               # Hidden div for displaying fetched data
                               box(
                                   id = "fetchedDataBox",
                                   width = 12,
                                   collapsible = FALSE,
                                   closable = FALSE,
                                   div(id = "fetchedDataDiv", style = "display: none;",
                                       tags$h4("Fetched Environmental Data:"),

                                       #maxUV
                                       div(id = "maxUV24Display", textOutput("maxUV24")),
                                       div(id = "maxUV24Edit",
                                           style = "display: none;",
                                           numericInput("maxUV24Input", label = NULL, value = 0)),
                                       actionButton("editMaxUV24", "Edit UV Index", class = "btn-sm"),
                                       actionButton("saveMaxUV24", "Save UV Index", class = "btn-sm save-btn", style = "display: none;"),

                                       #avgvhwh24
                                       # div(id = "avgvhwh24Display", textOutput("avgvhwh24")),
                                       # div(id = "avgvhwh24Edit",
                                       #     style = "display: none;",
                                       #     numericInput("avgvhwh24Input", label = NULL, value = 0)),
                                       # actionButton("editAvgvhwh24", "Edit", class = "btn-sm"),
                                       # actionButton("saveAvgvhwh24", "Save", class = "btn-sm", style = "display: none;"),

                                       #avgwspd
                                       div(id = "avgwspdDisplay", textOutput("avgwspd")),
                                       div(id = "avgwspdEdit",
                                           style = "display: none;",
                                           numericInput("avgwspdInput", label = NULL, value = 0)),
                                       actionButton("editAvgwspd", "Edit Wind Speed", class = "btn-sm"),
                                       actionButton("saveAvgwspd", "Save Wind Speed", class = "btn-sm save-btn", style = "display: none;"),


                                       #rain48
                                       div(id = "rain48Display", textOutput("rain48")),
                                       div(id = "rain48Edit",
                                           style = "display: none;",
                                           numericInput("rain48Input", label = NULL, value = 0)),
                                       actionButton("editRain48", "Edit Rainfall", class = "btn-sm"),
                                       actionButton("saveRain48", "Save Rainfall", class = "btn-sm save-btn", style = "display: none;"),

                                       #meantemp24
                                       div(id = "meantemp24Display", textOutput("meantemp24")),
                                       div(id = "meantemp24Edit",
                                           style = "display: none;",
                                           numericInput("meantemp24Input", label = NULL, value = 0)),
                                       actionButton("editMeantemp24", "Edit Temperature", class = "btn-sm"),
                                       actionButton("saveMeantemp24", "Save Temperature", class = "btn-sm save-btn", style = "display: none;")
                                   )
                               )
                           ),
                          # Second column for the user inputted data
                           column(width = 6,
                                box(id ="cardNiagaraUserInput",
                                    width = 12,
                                    collapsible = FALSE,
                                    closable = FALSE,
                                    tags$h4("Environmental Data:"),
                                    selectInput(inputId = "WaveHeight", label = "Wave Height", choices = c("0 - 5.00", "5.01 - 10.00", "10.01 - 60")),
                                    selectInput(inputId = "Geomean24", label = "Yesterday's geomean e. coli", choices = c("1 - 50.00", "50.01 - 100.00", "100.01 - 200.00", "200.01 - 2072.7")),
                                    selectInput(inputId = "WaterTemp", label = "Water Temperature (°C)", choices = c("0 - 15.00", "15.01 - 23.44", "23.45 - 30")),
                                    selectInput(inputId = "Turbidity", label = "Turbidity", choices = c("0 - 5.00", "5.01 - 10.00", "10.01 - 713")),
                                    bs4Dash::actionButton("fetchDataBtn", "Fetch Data"),
                                    actionButton("predictBtn", "Predict")
                                )
                         )
                      )
              )
         ),
         # Link the external JavaScript file at the end
         tags$script(src = "script.js")
     )
)
