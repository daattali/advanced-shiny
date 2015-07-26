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
  actionButton("fbShareBtn", "Share image on Facebook")
)

server <- function(input, output, session) {
}

shinyApp(ui = ui, server = server)