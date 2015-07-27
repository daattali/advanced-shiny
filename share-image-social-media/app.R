# Dean Attali, July 2015

library(shiny)

ui <- fluidPage(
  tags$head(
    includeScript("www/app.js"),
    tags$script(type = "text/javascript", src = "https://platform.linkedin.com/in.js",
                "api_key : 75ha6w7oiq97kx
                 authorize : true")
  ),
  p("Sharing on LinkedIn works (via JavaScript)"),
  actionButton("linkedinShareBtn", "Share image on LinkedIn"), br(), br(),
  p("Sharing on Facebook works, but the demo Facebook app I created only works",
    "when the URL is 'fuf.me'. If you run the app locally (so the URL is 127.0.0.1),",
    "you can change that localhost IP to 'fuf.me'."),
  actionButton("fbShareBtn", "Share image on Facebook (URL)"), br(), br(),
  p("Sharing an image to Facebook using its base 64 string rather than using an image URL",
    "is also possible."),
  actionButton("fbShare64Btn", "Share image below on Facebook (base-64, generated in Shiny)"),
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