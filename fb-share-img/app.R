# Dean Attali, July 2015

library(shiny)

ui <- fluidPage(
  tags$head(
    includeScript("www/app.js")
  ),
  h3("In order for Facebook sharing to work, you need to change the URL from 127.0.0.1 to 'fuf.me'"),
  actionButton("fbShareBtn", "Share image with popup (URL)"), br(), br(),
  actionButton("fbShare64Btn", "Share image programatically (base-64, generated in Shiny)"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  # generate a random plot each time with timestamp, just to have a unique plot each time
  output$plot <- renderPlot({
    num <- as.integer(sample(5:100, 1))
    plot(1:num, main = paste(num, Sys.time()))
  })
}

shinyApp(ui = ui, server = server)