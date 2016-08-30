library(shiny)

ui <- fluidPage(
  textInput("name", "Name"),
  numericInput("age", "Age", 25)
)

server <- function(input, output, session) {
  observe({
    query <- parseQueryString(session$clientData$url_search)
    if (!is.null(query[['name']])) {
      updateTextInput(session, "name", value = query[['name']])
    }
    if (!is.null(query[['age']])) {
      updateNumericInput(session, "age", value = query[['age']])
    }
  })
}

shinyApp(ui, server)