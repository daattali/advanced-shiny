jscode <- '
$(function() {
  $(document).keypress(function(e) {
    if (e.key == "1" || e.key == "2" || e.key == "3") {
      Shiny.onInputChange("clickbox", e.key);
    }
  });
});
'

ui <- fluidPage(
  tags$head(tags$script(HTML(jscode))),
  h3("Press the keys 1, 2, 3 on your keyboard to tick/untick the boxes"),
  checkboxInput("check1", "One"),
  checkboxInput("check2", "Two"),
  checkboxInput("check3", "Three"),
  p("If you noticed that you can't press the same key multiple times in a row,",
    a("see the follow-up example",
      href = "https://github.com/daattali/advanced-shiny/tree/master/message-javascript-to-r-force"),
    "to see how to fix that")
)

server <- function(input, output, session) {
  observeEvent(input$clickbox, {
    boxname <- paste0("check", input$clickbox)
    updateCheckboxInput(session, boxname, value = !input[[boxname]])
  })
}

shinyApp(ui, server)