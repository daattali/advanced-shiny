R shiny tricks (shinyjs - reset inputs, disable textinput when radio button is selected, loading..., state variables to use in ui - can be useful if want to use conditionalPanel with a variable that's calcualted in the server, global.R, splitting off big ui/server into files,  shiny debugging such as add a `options(warn=2)` at top of UI and server if getting a "ERRORR: canot open the conenction" butyou have no clue where the error's happening or what file it's failing at, ajax loading on image, ajax loading + error on submit button),  how to do toggle button (conditionalPanel with condition being input % 2 == 1)

withBusyIndicator

more breathing room in selectizeinput:

```
runApp(shinyApp(
  ui = fluidPage(
    tags$style(type='text/css', ".selectize-input { line-height: 40px; } .selectize-dropdown { line-height: 30px; }"),
    selectInput("test","Test", 1:5)
  ),
  server = function(input, output, session) {
  }
))
```

fix uploaded file names

```
#' When files get uploaded, their new filenames are gibberish.
#' This function renames all uploaded files to their original names
#' @param x The dataframe returned from a shiny::fileInput
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
```

show custom message when the'res an error in a reactive context

```
runApp(shinyApp(
  ui = fluidPage(
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: visible; content: 'An error occurred. Please contact the admin.'; }"
    ),
    textOutput("text")
  ),
  server = function(input, output, session) {
    output$text <- renderText({
      stop("lalala")
    })
  }
))
```

prepopulate input fields when app loads

```
runApp(shinyApp(
  ui = fluidPage(
    textInput("name", "Name"),
    numericInput("age", "Age", 25)
  ),
  server = function(input, output, session) {
    observe({
      query <- parseQueryString(session$clientData$url_search)
      if (!is.null(query[['name']])) {
        updateTextInput(session, "name", value = query[['name']])
      }
      if (!is.null(query[['age']])) {
        updateNumericInput(session, "age", value = query[['age']])
      }
    })
  }
))
```

when developing shiny app , its annoying that when you close the browser window the app is still alive.

```
runApp(shinyApp(
  ui = (),
  server = function(input, output, session) {
    session$onSessionEnded(function()stopApp())
  }
))
```

click button to close the current window

```
library(shinyjs)
jscode <- "shinyjs.closewindow = function() { window.close(); }"

runApp(shinyApp(
  ui = tagList(
    useShinyjs(),
    extendShinyjs(text = jscode),
    navbarPage(
      "test",
      id = "navbar",
      tabPanel(title = "tab1"),
      tabPanel(title = "", value = "Stop", icon = icon("power-off"))
    )
  ),
  server = function(input, output, session) {
    observe({
      if (input$navbar == "Stop") {
        js$closewindow();
        stopApp()
      }
    })
  }
))
```

remove tooltip in ggvis

```
library(shiny)
library(ggvis)

jscode <- 
"$(function() {
  $('#ggvis').click(function(){ $('#ggvis-tooltip').hide(); });
})
"

shinyApp(
  ui = fluidPage(
    tags$script(jscode),
    uiOutput("ggvis_ui"),
    ggvisOutput("ggvis")
  ),
  server = function(input, output, session) {
    mtcars %>% 
      ggvis(~wt, ~mpg) %>%
      layer_points() %>%
      add_tooltip(function(df) df$wt, on = "click") %>%
      bind_shiny("ggvis", "ggvis_ui")
  }
)
```

link to specific tab in app (simple vs complex: complex code is [here](https://github.com/rstudio/shiny/issues/772#issuecomment-112919149))

save all inputs in a shiny app and load them again (joe has a solution and ther's also shinyStore, but this is another solution) [here](http://stackoverflow.com/questions/32922190/saving-state-of-shiny-app-to-be-restored-later/32928505#32928505) (if using shinyjs reset, then it's safe to filter inputs by name, filter out ones with the prefix "shinyjs-")
