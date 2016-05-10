ui <- fluidPage(
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: visible; content: 'An error occurred. Please contact the admin.'; }"
  ),
  textOutput("text1"),
  textOutput("text2")
)

server <- function(input, output, session) {
  output$text1 <- renderText({
    stop("Some error")
  })  
  output$text2 <- renderText({
    "Hello"
  })
}

shinyApp(ui, server)