library(shiny)

ui <- fluidPage(
  selectInput("country", "Select country", list(
    "Europe" = c("Germany", "Spain"),
    "North America" = c("Canada", "United States" = "USA")
  ))
)

server <- function(input, output, session) {
}

shinyApp(ui = ui, server = server)