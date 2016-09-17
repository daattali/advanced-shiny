library(shiny)

jscode <- '
$(function() {
  $(document).keypress(function(e) {
    Shiny.onInputChange("keypress1", e.key);
    Shiny.onInputChange("keypress2:mylist", e.key);
  });
});
'

shiny::registerInputHandler("mylist", function(data, ...) {
  list(data)
}, force = TRUE)

ui <- fluidPage(
  tags$head(tags$script(HTML(jscode))),
  h3("Press any key"),
  "Raw key press:",
  verbatimTextOutput("text1"),
  "Key press wrapped in a list:",
  verbatimTextOutput("text2")
)

server <- function(input, output, session) {
  output$text1 <- renderPrint({
    input$keypress1
  })
  output$text2 <- renderPrint({
    input$keypress2
  })
}

shinyApp(ui, server)