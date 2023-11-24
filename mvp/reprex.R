library(shiny)

# Dummy function to simulate cpquery behavior
dummyFunction <- function(increment) {
     # Simulate some processing based on the increment
     result <- paste("Processed increment:", increment)
     return(result)
}

# Define UI
ui <- fluidPage(
     titlePanel("Shiny Reprex"),
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
          if (value >= 1 && value <= 3) {
               return("[1,3]")
          } else if (value > 3 && value <= 6) {
               return("(3,6]")
          } else if (value > 6 && value <= 9) {
               return("(6,9]")
          } else if (value > 9 && value <= 12) {
               return("(9,12]")
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

     # Use processed inputs in dummy function
     observeEvent(input$predictBtn, {
          req(processedInputs())
          increment <- processedInputs()
          predictionResult <- dummyFunction(increment)
          output$result <- renderText({ predictionResult })
     })
}

# Run the application
shinyApp(ui = ui, server = server)
