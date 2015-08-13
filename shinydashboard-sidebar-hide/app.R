library(shiny)
library(shinydashboard)
library(shinyjs)

shinyApp(
  ui = 
    dashboardPage(
      dashboardHeader(),
      dashboardSidebar(),
      dashboardBody(
        shinyjs::useShinyjs(),
        actionButton("showSidebar", "Show sidebar"),
        actionButton("hideSidebar", "Hide sidebar")
      )
    ),
  server = function(input, output) {
    observeEvent(input$showSidebar, {
      shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
    })
    observeEvent(input$hideSidebar, {
      shinyjs::addClass(selector = "body", class = "sidebar-collapse")
    })
  }
)