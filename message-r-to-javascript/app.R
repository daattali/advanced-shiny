jscode <- '
Shiny.addCustomMessageHandler("mymessage", function(message) {
  alert(message);
});
'

ui <- fluidPage(
  tags$head(tags$script(HTML(jscode))),
  textInput("text", "Enter text", "Hello"),
  actionButton("btn", "JavaScript popup")
)

server <- function(input, output, session) {
  observeEvent(input$btn, {
    session$sendCustomMessage("mymessage", input$text)
  })
}

shinyApp(ui, server)