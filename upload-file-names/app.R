library(shiny)

fixUploadedFilesNames <- function(x) {
  if (is.null(x)) {
    return()
  }
  
  oldNames = x$datapath
  newNames = file.path(dirname(x$datapath),
                       x$name)
  file.rename(from = oldNames, to = newNames)
  x$datapath <- newNames
  x
}

ui <- fluidPage(
  fileInput("file", "Choose files", multiple = TRUE),
  h3("Original file input value"),
  dataTableOutput("originalfiles"),
  h3("New file input value"),
  dataTableOutput("newfiles")
)

server <- function(input, output, session) {
  output$originalfiles <- renderDataTable(
    input$file,
    options = list(dom = "", searching = FALSE)
  )
  output$newfiles <- renderDataTable(
    fixUploadedFilesNames(input$file),
    options = list(dom = "", searching = FALSE)
  )
}

shinyApp(ui = ui, server = server)