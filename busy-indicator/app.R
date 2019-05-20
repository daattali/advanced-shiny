library(shiny)

source("helpers.R") # Load all the code needed to show feedback on a button click

ui <- fluidPage(
  selectInput("select", "Select an option",
              c("This one is okay" = "ok",
                "This will give an error" = "error")),
  
  # Wrap the button in the function `withBusyIndicatorUI()`
  withBusyIndicatorUI(
    actionButton(
      "uploadFilesBtn",
      "Process data",
      class = "btn-primary"
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$uploadFilesBtn, {
    # When the button is clicked, wrap the code in a call to `withBusyIndicatorServer()`
    withBusyIndicatorServer("uploadFilesBtn", {
      Sys.sleep(1)
      if (input$select == "error") {
        stop("choose another option")
      }
    })
  })
}

shinyApp(ui = ui, server = server)
