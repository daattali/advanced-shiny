# The idea is to place a spinner image in the same container as the plot
# and center it, but give it a below-default z-index
# Whenever the plot is recalculting, make the plot's z-index even lower
# so that the spinner will show

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

runApp(shinyApp(
  ui = fluidPage(
    tags$head(tags$style(HTML(mycss))),
    actionButton("btn", "Plot (takes 2 seconds)"),
    div(id = "plot-container",
        tags$img(src = "http://i.imgur.com/hTbi7JM.gif",
                 id = "loading-spinner"),
        plotOutput("plot")
    )
  ),
  server = function(input, output, session) {
    output$plot <- renderPlot({
      if (input$btn == 0) return()
      Sys.sleep(2)
      plot(rnorm(50))
    })
  }
))
