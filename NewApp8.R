library(shiny)
library(bnlearn)
#setwd("/srv/dev-disk-by-uuid-3c29ef29-6ba4-4c7b-935f-a9227e2ccf33/NAS/Shiny/beachwaterCanada")

# Load  .net file
Niagara_Model <- read.net("NiagaraModel.net")

ui <- fluidPage(
  titlePanel("Bayesian Network Prediction"),

  sidebarLayout(
    sidebarPanel(
      # evidence elements
      selectInput("Max24UV", label = "Max24UV", choices = c("0 - 5.98", "5.98 - 7.1", "7.1 - 7.92", "7.92 - 12")),
      selectInput("avgvwh24", label = "avgvwh24", choices = c("0 - 0.19", "0.19 - 0.37", "0.37 - 2")),
      selectInput("waveheight", label = "waveheight", choices = c("0 - 5", "5 - 10", "10 - 60")),
      selectInput("avgwspd", label = "avgwspd", choices = c("0 - 3.15", "3.15 - 4.2", "4.2 - 5.6", "5.6 - 11.12")),
      selectInput("geomean24", label = "geomean24", choices = c("1 - 50", "50 - 100", "100 - 200", "200 - 2072.7")),
      selectInput("rain48", label = "rain48", choices = c("0 - 2.5", "2.5 - 7.6", "7.6 - 240")),
      selectInput("watertemp", label = "watertemp", choices = c("0 - 15", "15 - 23.44", "23.44 - 30")),
      selectInput("turbidity", label = "turbidity", choices = c("0 - 5", "5 - 10", "10 - 713")),
      selectInput("meantemp24", label = "meantemp24", choices = c("7.3 - 17.2", "17.2 - 24", "24 - 32.1")),
      actionButton("predictBtn", "Predict")
    ),

    mainPanel(
      h4("Prediction Results:"),
      verbatimTextOutput("predictionOutput")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$predictBtn, {
    # Prepare evidence for cpquery
    evidence <- list(
      Max24UV = as.numeric(unlist(strsplit(input$Max24UV, " - "))),
      avgvwh24 = as.numeric(unlist(strsplit(input$avgvwh24, " - "))),
      waveheight = as.numeric(unlist(strsplit(input$waveheight, " - "))),
      avgwspd = as.numeric(unlist(strsplit(input$avgwspd, " - "))),
      geomean24 = as.numeric(unlist(strsplit(input$geomean24, " - "))),
      rain48 = as.numeric(unlist(strsplit(input$rain48, " - "))),
      watertemp = as.numeric(unlist(strsplit(input$watertemp, " - "))),
      turbidity = as.numeric(unlist(strsplit(input$turbidity, " - "))),
      meantemp24 = as.numeric(unlist(strsplit(input$meantemp24, " - ")))
    )

    # Define the range of geomean200
    geomean200_range <- c(0, 1)
    pred_tables <- Niagara_Model[[7]][[4]][,,1 , , , ]

    # Perform conditional probability query using cpquery
    prediction <- cpquery(Niagara_Model, event = (geomean200 >= geomean200_range[1] & geomean200 <= geomean200_range[2]), evidence = evidence)

    # Display prediction results
    output$predictionOutput <- renderText({
      paste("Predicted probability of geomean200 between 0 and 1:", prediction)
    })
  })
}

shinyApp(ui = ui, server = server)