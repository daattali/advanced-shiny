library(shiny)

jscode <- '
$(function() {
  $(document).keypress(function(e) {
    if (e.key == "1" || e.key == "2" || e.key == "3") {
      Shiny.onInputChange("clickbox", [e.key, Math.random()]);
    }
  });
});
'

ui <- fluidPage(
  tags$head(tags$script(HTML(jscode))),
  h3("Press the keys 1, 2, 3 on your keyboard to tick/untick the boxes"),
  checkboxInput("check1", "One"),
  checkboxInput("check2", "Two"),
  checkboxInput("check3", "Three")
)

server <- function(input, output, session) {
  observeEvent(input$clickbox, {
    boxname <- paste0("check", input$clickbox[1])
    updateCheckboxInput(session, boxname, value = !input[[boxname]])
  })
}

shinyApp(ui, server)