library(shinyjs)
jscode <- "shinyjs.closeWindow = function() { window.close(); }"

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(text = jscode, functions = c("closeWindow")),
  actionButton("close", "Close window")
)

server <- function(input, output, session) {
  observeEvent(input$close, {
    js$closeWindow()
    stopApp()
  })
}

shinyApp(ui, server)