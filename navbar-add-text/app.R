library(shiny)

navbarPageWithText <- function(..., text) {
  navbar <- navbarPage(...)
  textEl <- tags$p(class = "navbar-text", text)
  navbar[[3]][[1]]$children[[1]] <- htmltools::tagAppendChild(
    navbar[[3]][[1]]$children[[1]], textEl)
  navbar
}

ui <- navbarPageWithText(
  "Test app",
  tabPanel("tab1", "tab 1"),
  tabPanel("tab2", "tab 2"),
  text = "User: Dean"
)

server <- function(input, output, session) {
}

shinyApp(ui = ui, server = server)
