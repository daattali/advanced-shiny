# Dean Attali, October 2016

library(shiny)
library(shinyjs)

ui <- fluidPage(
  shinyjs::useShinyjs(),
  textInput("expr", label = "Enter an R expression",
            value = "shinyjs::info('Hello!')"),
  actionButton("run", "Run", class = "btn-success"),
  shinyjs::hidden(
    div(
      id = "error",
      style = "color: red; font-weight: bold;",
      div("Oops, that resulted in an error! Try again."),
      div("Error: ", br(),
          span(id = "errorMsg", style = "margin-left: 10px;"))
    )
  )
)

server <- function(input, output, session) {
  shinyEnv <- environment()

  observeEvent(input$run, {
    shinyjs::hide("error")
    
    tryCatch(
      isolate(
        eval(parse(text = input$expr), envir = shinyEnv)
      ),
      error = function(err) {
        shinyjs::html("errorMsg", as.character(shiny::tags$i(err$message)))
        shinyjs::show(id = "error", anim = TRUE, animType = "fade")
      }
    )
  })
}

shinyApp(ui = ui, server = server)