library(shiny)

ui <- fluidPage(
  actionButton("toggle", "Toggle the following text"),
  conditionalPanel(
    condition = "input.toggle % 2 == 0",
    "This text gets toggled on and off"
  )
)

server <- function(input, output, session) {
}

shinyApp(ui = ui, server = server)