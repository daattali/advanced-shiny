library(shiny)

foo <- function() {
  message("one message")
  Sys.sleep(1)
  message("two messages")
  Sys.sleep(1)
  warning("...and a warning")
}

ui <- fluidPage(
  shinyjs::useShinyjs(),
  actionButton("btn","Click me"),
  textOutput("text")
)

server <- function(input, output, session) {
  observeEvent(input$btn, {
    withCallingHandlers({
      shinyjs::html(id = "text", html = "")
      foo()
    },
    message = function(m) {
      shinyjs::html(id = "text", html = m$message, add = TRUE)
    },
    warning = function(m) {
      shinyjs::html(id = "text", html = m$message, add = TRUE)
    })
  })
}

shinyApp(ui, server)