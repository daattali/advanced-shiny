library(shiny)
library(shinyjs)

ui <- navbarPage(
  "Bootstrap scrollspy on multiple tabs",
  id = "navbar",
  
  header = div(
    useShinyjs(),
    extendShinyjs("www/app-shinyjs.js"),
    includeCSS("www/app.css"),
    includeScript("www/app.js"),
    
    # create a common scrollspy
    div(
      id = "myscrollspy",
      tags$ul(
        class = "nav nav-pills nav-stacked"
      )
    )
  ),
  
  # tab 1 has 4 sections
  tabPanel(
    "tab1",
    div(id = "tab1-content",
        div(id = "section1-1",
            class = "scrollspy-section",
            p('Section 1-1')
        ),
        div(id = "section1-2",
            class = "scrollspy-section",
            p('Section 1-2')
        ),
        div(id = "section1-3",
            class = "scrollspy-section",
            p('Section 1-3')
        ),
        div(id = "section1-4",
            class = "scrollspy-section",
            p('Section 1-4')
        )
    )
  ),
  
  # tab 2 has 3 sections
  tabPanel(
    "tab2",
    div(id = "tab2-content",
        div(id = "section2-1",
            class = "scrollspy-section",
            p('Section 2-1')
        ),
        div(id = "section2-2",
            class = "scrollspy-section",
            p('Section 2-2')
        ),
        div(id = "section2-3",
            class = "scrollspy-section",
            p('Section 2-3')
        )
    )
  )
)

server <- function(input, output, session) {
  # when changing tabs, update the scrollspy control
  observeEvent(input$navbar, {
    js$updateScrollspy(input$navbar)
  })
}

shinyApp(ui = ui, server = server)