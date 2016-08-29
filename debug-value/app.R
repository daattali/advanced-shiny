library(shiny)

ui <- fluidPage(
  verbatimTextOutput("debug")
)

server <- function(input, output, session) {
  output$debug <- renderPrint({
    sessionInfo()
  })
}

shinyApp(ui = ui, server = server)