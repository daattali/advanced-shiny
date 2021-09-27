# IMPORTANT: If you're using shiny version 1.6 or below, replace all instances of `navbar[[4]][[1]][[1]]` with `navbar[[3]][[1]]`

library(shiny)

# Call this function with all the regular navbarPage() parameters, plus a text parameter,
# if you want to add text to the navbar
navbarPageWithText <- function(..., text) {
  navbar <- navbarPage(...)
  textEl <- tags$p(class = "navbar-text", text)
  navbar[[4]][[1]][[1]]$children[[1]] <- htmltools::tagAppendChild(
    navbar[[4]][[1]][[1]]$children[[1]], textEl)
  navbar
}

# Call this function with an input (such as `textInput("text", NULL, "Search")`) if you
# want to add an input to the navbar
navbarPageWithInputs <- function(..., inputs) {
  navbar <- navbarPage(...)
  form <- tags$form(class = "navbar-form", inputs)
  navbar[[4]][[1]][[1]]$children[[1]] <- htmltools::tagAppendChild(
    navbar[[4]][[1]][[1]]$children[[1]], form)
  navbar
}

# When creating the UI, call our wrapper function instead of `navbarPage()`
ui <- navbarPageWithText(
  "Test app",
  tabPanel("tab1", "tab 1"),
  tabPanel("tab2", "tab 2"),
  text = "User: Dean"
)

server <- function(input, output, session) {
}

shinyApp(ui = ui, server = server)
