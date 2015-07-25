# Dean Attali, July 2015

library(shiny)
library(shinyjs)

ui <- fluidPage(
  tags$head(
    includeScript("www/api.js"),
    includeScript("www/app.js")
  ),
  actionButton("getRversion", "R version API call"),
  actionButton("errorFunction", "API call with error")
)

server <- function(input, output, session) {
  
  # include the API logic
  source("api.R", local = TRUE)$value
 
  api.getRversion <- function(params) {
    # do some stuff
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
    stop("some error happened")
  } 
}

shinyApp(ui = ui, server = server)