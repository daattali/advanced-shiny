library(shiny)
library(shinyjs)

source("update-input.R")

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs("www/app-shinyjs.js"),
  
  textInput("text", "Text input", "some text"),
  selectInput("select", "Select input", LETTERS),
  numericInput("numeric", "Numeric input", 5),
  actionButton("btn", "Update text to 'new value', select to 'G', and number to '9'", class = "btn-primary")
)

server <- function(input, output, session) {
  observeEvent(input$btn, {
    newValues <- list("text"    = "new value",
                      "select"  = "G",
                      "numeric" = 9)
    updateShinyInputs(session, newValues)
    # OR one by one
    # updateShinyInput(session, "text", "new value")
  })
}

shinyApp(ui = ui, server = server)