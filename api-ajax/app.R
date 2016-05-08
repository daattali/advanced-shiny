# Dean Attali, July 2015

library(shiny)

ui <- fluidPage(
  tags$head(
    includeScript("www/api.js"),  # Always include this file
    includeScript("www/app.js")   # JavaScript specific to this app
  ),
  actionButton("getRversion", "R version API call"),
  actionButton("errorFunction", "API call with error")
)

server <- function(input, output, session) {
  
  # include the API logic
  source("api.R", local = TRUE)$value
 
  api.getRversion <- function(params) {
    # don't forget you have access to all the parameters sent by javascript
    # inside the "params" variable
    
    # need to return a list (can be an empty list)
    retval <- list(
      success = TRUE,
      rversion = R.version.string
    )
    retval
  }

  api.errorExample <- function(params) {
    # this function will throw an error to show what happens on the javsacript
    # side when an error occurs
    stop("sample error message")
  } 
}

shinyApp(ui = ui, server = server)