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
    includeScript("https://cdnjs.cloudflare.com/ajax/libs/jquery-scrollTo/1.4.3/jquery.scrollTo.min.js")
  ),
  
  # tab 1 contains 4 sections and a scrollspy on the left with text
  tabPanel(
    "tab1",
    div(id = "tab1-content",
        fluidRow(
          column(
            4,
            div(
              id = "tab1-scrollspy",
              class = "potential-scrollspy",
              tags$ul(
                class = "nav nav-pills nav-stacked",
                tags$li(tags$a(href = "#section1-1", "Section 1-1")),
                tags$li(tags$a(href = "#section1-2", "Section 1-2")),
                tags$li(tags$a(href = "#section1-3", "Section 1-3")),
                tags$li(tags$a(href = "#section1-4", "Section 1-4"))
              )
            )
          ),
          column(
            8,
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
        )
    )
  ),
  
  # tab 2 contains 3 sections and a scrollspy on the right without text
  tabPanel(
    "tab2",
    div(id = "tab2-content",
        fluidRow(
          column(
            8,
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
          ),
          column(
            4,
            div(
              id = "tab2-scrollspy",
              class = "potential-scrollspy",
              `data-offset` = 50,
              tags$ul(
                class = "nav nav-pills nav-stacked",
                tags$li(tags$a(href = "#section2-1")),
                tags$li(tags$a(href = "#section2-2")),
                tags$li(tags$a(href = "#section2-3"))
              )
            )
          )
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