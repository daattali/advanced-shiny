library(shiny)

mycss <- "
#plot-container {
  position: relative;
}
#loading-spinner {
  position: absolute;
  left: 50%;
  top: 50%;
  z-index: -1;
  margin-top: -33px;  /* half of the spinner's height */
  margin-left: -33px; /* half of the spinner's width */
}
#plot.recalculating {
  z-index: -2;
}
"

ui <- fluidPage(
  tags$head(tags$style(HTML(mycss))),
  actionButton("btn", "Plot (takes 2 seconds)"),
  div(id = "plot-container",
      tags$img(src = "spinner.gif",
               id = "loading-spinner"),
      plotOutput("plot")
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    input$btn
    
    Sys.sleep(2)
    plot(rnorm(50))
  })
}

shinyApp(ui, server)