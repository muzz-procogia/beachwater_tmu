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
                           box(title = "Predictions for Niagara Beaches. Enter today's environmental data to create a prediction",
                               background = "success", solidHeader = TRUE,
                               width = 12
                           )
                      ),
                      fluidRow(
                           box(title = "", background = "info", solidHeader = TRUE, width = 6,
                               tags$h3("The probability (between 0-1) of E. coli exceeding the 200CFU/100mL guideline is:"),
                               textOutput("result_text")
                           ),
                           box(width = 6,
                               selectInput(inputId = "Maxuv", label = "Yesterday's MaxUV", choices = c("0 - 5.98", "5.98 - 7.1", "7.1 - 7.92", "7.92 - 12")),
                               selectInput(inputId = "BuoyWave", label = "Avgvwh24??", choices = c("0-0.19", "0.19-0.37", "0.37-2")),
                               selectInput(inputId = "ShoreWave", label = "Wave Height", choices = c("0 - 5", "5 - 10", "10 - 60")),
                               selectInput(inputId = "Windspeed", label = "Wind speed", choices = c("0 - 3.15", "3.15 - 4.2", "4.2 - 5.6", "5.6 - 11.12")),
                               selectInput(inputId = "Ecoli", label = "Yesterday's geomena e. coli", choices = c("1 - 50", "50-100", "100-200", "200-2072.7")),
                               selectInput(inputId = "WaterTemp", label = "Water Temperature", choices = c("0 - 15", "15 - 23.44", "23.44-30")),
                               selectInput(inputId = "Turbidity", label = "Turbidity", choices = c("0 - 5", "5 - 10", "10 - 713")),
                               selectInput(inputId = "Rainfall", label = "48hrRainfall", choices = c("0 - 15", "15 - 23.44", "23.44-30")),
                               selectInput(inputId = "Temp", label = "Yesterdays meantemp", choices = c("0 - 5", "5 - 10", "10 - 713")),
                               actionButton("predictBtn", "Predict")
                           )
                      )
              )
         ),
         # Link the external JavaScript file at the end
         tags$script(src = "script.js")
     )
)
