library(shiny)

ui <- navbarPage(
  title = "Split app code across multiple files",
  # include the UI for each tab
  source(file.path("ui", "tab1.R"),  local = TRUE)$value,
  source(file.path("ui", "tab2.R"),  local = TRUE)$value
)

server <- function(input, output, session) {
  # Include the logic (server) for each tab
  source(file.path("server", "tab1.R"),  local = TRUE)$value
  source(file.path("server", "tab2.R"),  local = TRUE)$value
}

shinyApp(ui = ui, server = server)