ui <- fluidPage()

server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)