library(shiny)
library(shinyjs)

ui <- navbarPage(
  "Navigating in Shiny app",
  id = "navbar",
  header = tagList(
    useShinyjs(),
    extendShinyjs("www/app-shinyjs.js"),
    includeScript("www/app.js")
  ),
  
  tabPanel("Home", value = "home",
           h2("Home tab"),
           textInput("text", "Enter string to search", "foo"),
           actionButton("go", "Search")
  ),
  tabPanel("Search", value = "search",
           h2("Search results:",
              textOutput("searchString", inline = TRUE)
           )
  ),
  tabPanel("About", value = "about",
           "Basic demo of supporting navigation in a Shiny app by",
           tags$a("Dean Attali", href = "http://deanattali.com")
  )
)

server <- function(input, output, session) {
  
  values <- reactiveValues(
    
    # variable to keep track of whether or not the tab switching is manual (by the
    # user) or automatic (restoring the app's state on initialization or prev/next buttons)    
    autoNavigating = 0,
    
    # search string
    searchString = ""
  )
  
  # show the search string
  output$searchString <- renderText({
    values$searchString
  })  
  
  # go to the search tab when clicking the button
  observeEvent(input$go, {
    values$searchString <- input$text
    updateTabsetPanel(session, "navbar", "search")
  })
  
  # ----- navigation logic -----
  
  # when the app initializes, if there is a history in the URL, navigate to it
  observeEvent(session$clientData$url_search, {
    # if there is a history in the URL, restore the state
    if (nchar(session$clientData$url_search) > 1) {
      # when the app starts, the input$navbar gets triggered, but we don't
      # want to trigger the navigation function because the user didn't actively
      # navigate anywhere
      values$autoNavigating <- values$autoNavigating + 1
      
      restore(session$clientData$url_search)
    }
  })
  
  # restore the Shiny app's state based on the URL
  restore <- function(qs) {
    data <- parseQueryString(qs)
    
    if (!is.null(data[['page']])) {
      # we're about to change tabs programatically, so don't trigger the
      # navigation function
      values$autoNavigating <- values$autoNavigating + 1
      
      # change to the correct tab
      updateTabsetPanel(session, "navbar", data[['page']])
      
      # if the given tab has some more information we wnat to initialize,
      # do it here
      if (data[['page']] == "search") {
        if (!is.null(data[['query']])) {
          values$searchString <- data[['query']]
          updateTextInput(session, "text", value = data[['query']])
        }
      }
    }
  }
  
  # when the user changes tabs, save the state in the URL
  observeEvent(input$navbar, {
    if (values$autoNavigating > 0) {
      values$autoNavigating <- values$autoNavigating - 1
      return()
    }
    
    if (input$navbar == "search") {
      shinyjs::js$updateHistory(page = "search", query = values$searchString)
    } else {
      shinyjs::js$updateHistory(page = input$navbar)
    }
  })
  
  # when the user clicks prev/next buttons in the browser, restore the state
  observeEvent(input$navigatedTo, {
    restore(input$navigatedTo)
  })
}

shinyApp(ui = ui, server = server)