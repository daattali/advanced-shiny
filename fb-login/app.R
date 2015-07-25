# Dean Attali, July 2015

library(shiny)
library(shinyjs)

ui <- fluidPage(
  tags$head(
    includeScript("www/api.js"),
    includeScript("www/app.js")
  ),
  actionButton("fbLoginBtn", "Login with Facebook"),
  div(id = "fbStatus")
)

server <- function(input, output, session) {
  source("api.R", local = TRUE)$value
 
  api.fblogin <- function(params) {
    fbGraphUrl <- "https://graph.facebook.com"
    fbGraphPath <- "me"
    token <- params$access_token
    url <- sprintf("%s/%s", fbGraphUrl, fbGraphPath)
    response <- httr::GET(url, query = list(access_token = token))
    
    if (httr::status_code(response) == 200) {
      name <- httr::content(response)$name
      cat(name)
      # now we can register the user in our database and process them
      return(list(success = TRUE, name = name))
    } else {
      stop("OpenGraph did not succeed")
    }
  }
}

shinyApp(ui = ui, server = server)