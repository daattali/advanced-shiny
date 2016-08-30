library(shiny)

css <- "
#large .selectize-input { line-height: 40px; }
#large .selectize-dropdown { line-height: 30px; }"

ui <- fluidPage(
  tags$style(type='text/css', css),
  selectInput("select1", "Regular select", LETTERS),
  div(id = "large",
    selectInput("select2", "Large select", LETTERS)
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)