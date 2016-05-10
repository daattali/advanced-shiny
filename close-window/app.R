library(shinyjs)
jscode <- "shinyjs.closewindow = function() { window.close(); }"

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(text = jscode),
  actionButton("close", "Close window")
)

server <- function(input, output, session) {
  observeEvent(input$close, {
    js$closewindow()
    stopApp()
  })
}

shinyApp(ui, server)