library(shiny)

ui <- fluidPage(
  selectInput("num", "Choose a number", 1:10),
  conditionalPanel(
    condition = "output.square",
    "That's a perfect square!"
  )
)

server <- function(input, output, session) {
  output$square <- reactive({
    sqrt(as.numeric(input$num)) %% 1 == 0
  })
  outputOptions(output, 'square', suspendWhenHidden = FALSE)
}

shinyApp(ui = ui, server = server)