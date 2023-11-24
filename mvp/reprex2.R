library(shiny)
library(bnlearn)

# Load your Bayesian network
baynet <- read.net("datasets/Nov15NiagaraModel.net")

# Define UI
ui <- fluidPage(
     titlePanel("Shiny Reprex with bnlearn"),
     sidebarLayout(
          sidebarPanel(
               selectInput("uvInput", "Select UV Value", choices = c(1, 4, 7, 10)),
               actionButton("predictBtn", "Predict")
          ),
          mainPanel(
               textOutput("result")
          )
     )
)

# Define server logic
server <- function(input, output, session) {

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

     # Process inputs and return increments
     processedInputs <- eventReactive(input$predictBtn, {
          uvValue <- as.numeric(input$uvInput)
          maxUV24Increment <- determineMax24UVIncrement(uvValue)
          return(maxUV24Increment)
     })

     # Use processed inputs in cpquery
     observeEvent(input$predictBtn, {
          req(processedInputs())
          increment <- processedInputs()
          print(increment)

          # Constructing the evidence string dynamically
          evidenceString <- paste0("(Max24UV == '", increment, "')")

          # Using eval(parse(...)) to execute cpquery with dynamic evidence
          predictionResult <- eval(parse(text = paste(
               'cpquery(baynet,
                        event = (geomean200 == "true"),
                        evidence = ', evidenceString, ',
                        debug = TRUE)'
          )))

          output$result <- renderText({ predictionResult })
     })
}

# Run the application
shinyApp(ui = ui, server = server)
