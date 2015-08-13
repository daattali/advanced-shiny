library(shiny)
library(shinyjs)

shinyApp(
  ui = fluidPage(
    useShinyjs(),
    checkboxInput("foo", "Show tab2", TRUE),
    tabsetPanel(
      id = "navbar",
      tabPanel(title = "tab1",
               value = "tab1",
               h1("Tab 1")
      ),
      tabPanel(title = "tab2",
               value = "tab2",
               h1("Tab 2")
      ),
      tabPanel(title = "tab3",
               value = "tab3",
               h1("Tab 3")
      )
    )
  ),
  server = function(input, output) {
    observe({
      toggle(condition = input$foo, selector = "#navbar li a[data-value=tab2]")
    })
  }
)