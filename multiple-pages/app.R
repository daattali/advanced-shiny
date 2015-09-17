library(shiny)
library(shinyjs)

shinyApp(
  ui = fluidPage(
    useShinyjs(),
    div(
      id = "step1",
      "Step 1"
    ),
    hidden(
      div(
        id = "step2",
        "Step 2"
      ),
      div(
        id = "step3",
        "Step 3"
      ),
      div(
        id = "step4",
        "Step 4"
      )
    ),
    br(),
    actionButton("prevBtn", "< Previous"),
    actionButton("nextBtn", "Next >")
  ),
  server = function(input, output, session) {
    numPages <- 4
    rv <- reactiveValues(page = 1, prevPage = 1)
    
    observe({
      toggleState(id = "prevBtn", condition = rv$page > 1)
      toggleState(id = "nextBtn", condition = rv$page < numPages)
      hide(sprintf("step%s", rv$prevPage))
      show(sprintf("step%s", rv$page))
    })
    
    navPage <- function(direction) {
      rv$prevPage <- rv$page
      rv$page <- rv$page + direction
    }
    
    observeEvent(input$prevBtn, navPage(-1))
    observeEvent(input$nextBtn, navPage(1))
  }
)