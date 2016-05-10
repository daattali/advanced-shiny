library(shiny)
library(shinyjs)

withBusyIndicatorServer <- function(buttonId, expr) {
  loadingEl <- sprintf("[data-for-btn=%s] .btn-loading-indicator", buttonId)
  doneEl <- sprintf("[data-for-btn=%s] .btn-done-indicator", buttonId)
  errEl <- sprintf("[data-for-btn=%s] .btn-err", buttonId)
  disable(buttonId)
  show(selector = loadingEl)
  hide(selector = doneEl)
  hide(selector = errEl)
  on.exit({
    enable(buttonId)
    hide(selector = loadingEl)
  })
  
  tryCatch({
    value <- expr
    show(selector = doneEl)
    delay(2000, hide(selector = doneEl, anim = TRUE, animType = "fade",
                     time = 0.5))
    value
  }, error = function(err) { errorFunc(err, buttonId) })
}

errorFunc <- function(err, buttonId) {
  errEl <- sprintf("[data-for-btn=%s] .btn-err", buttonId)
  errElMsg <- sprintf("[data-for-btn=%s] .btn-err-msg", buttonId)
  cat(errElMsg)
  errMessage <- gsub("^ddpcr: (.*)", "\\1", err$message)
  html(html = errMessage, selector = errElMsg)
  show(selector = errEl, anim = TRUE, animType = "fade")
}

# Set up a button to have an animated loading indicator and a checkmark
# for better user experience
# Need to use with the corresponding `withBusyIndicator` server function
withBusyIndicatorUI <- function(button) {
  id <- button[['attribs']][['id']]
  div(
    `data-for-btn` = id,
    button,
    span(
      class = "btn-loading-container",
      hidden(
        img(src = "ajax-loader-bar.gif", class = "btn-loading-indicator"),
        icon("check", class = "btn-done-indicator")
      )
    ),
    hidden(
      div(class = "btn-err",
          div(icon("exclamation-circle"),
              tags$b("Error: "),
              span(class = "btn-err-msg")
          )
      )
    )
  )
}

ui <- fluidPage(
  useShinyjs(debug=T),
  tags$style(".btn-loading-container {
  margin-left: 10px;
             font-size: 1.2em;
             }
.btn-done-indicator {
  color: green;
             }
             
             .btn-err {
             margin-top: 10px;
             color: red;
             }"),
  selectInput("select", "Select an option",
              c("This one is okay" = "ok",
                "This will give an error" = "error")),
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
    withBusyIndicatorServer("uploadFilesBtn", {
      Sys.sleep(1)
      if (input$select == "error") {
        stop("choose another option")
      }
    })
  })
}

shinyApp(ui = ui, server = server)