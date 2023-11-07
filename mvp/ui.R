# Define UI
ui <- dashboardPage(
     title = "Beachwater Quality",
     dashboardHeader(),
     dashboardSidebar(
          sidebarMenu(
               id = "sidebarMenu", # Add an ID to the sidebarMenu for reference
               menuItem("Home", tabName = "home", icon = icon("home")),
               menuItem("Niagara", tabName = "nialand", icon = icon("tint"),
                        menuSubItem("Niagara Data Visualizations", tabName = "niadata"),
                        menuSubItem("Niagara Predictive Models", tabName = "Niagarapredicttab")
               )
          )
     ),
     dashboardBody(
         tabItems(
              tabItem(tabName = "home",
                      h2("Welcome to the Beachwater Quality Dashboard")
              ),
              tabItem(tabName = "nialand",
                      h2("Niagara Landing Page"),
                      actionButton("niadata", "Niagara Data Visualizations"),
                      actionButton("Niagarapredicttab", "Niagara Predictive Models")
              ),
              tabItem(tabName = "niadata",
                      h2("Niagara Data Visualizations"),
                      # Add other UI elements for visualizations here
                      h3("Visualizations will be added here")
              ),
              tabItem(tabName = "Niagarapredicttab",
                      h2("Niagara Predictive Models"),
                      # Add other UI elements for predictive models here
                      h3("Predictive model UI will be added here")
              )
         ),
         # Link the external JavaScript file at the end
         tags$script(src = "script.js")
     )
)
