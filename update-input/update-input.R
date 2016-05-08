# Create a function that wraps a Shiny input function in code that adds information
# about the tag type
updateableInput <- function(inputType) {
  function(...) {
    shinyFuncName <- as.character(as.list(match.call()[1]))
    shinyFunc <- get(shinyFuncName, envir = as.environment("package:shiny"))
    shiny::tagAppendAttributes(
      shinyFunc(...),
      `data-input-type` = inputType
    )
  }
}

# define what Shiny inputs you want to support
# (the following three common input types are tested; the code here probably will
# not work as-is for ALL inputs but you should be able to modify it slightly for
# other inputs)
textInput <- updateableInput("Text")
numericInput <- updateableInput("Numeric")
selectInput <- updateableInput("Select")

# Update a single Shiny input without specifying its type
updateShinyInput <- function(session, id, value) {
  shinyUpdateInputId <- paste0("shiny-update-input-", id)
  js$getInputType(id, shinyUpdateInputId)
  shiny::observeEvent(session$input[[shinyUpdateInputId]], {
    inputType <- session$input[[shinyUpdateInputId]]
    updateFunc <- sprintf("update%sInput", inputType)
    funcParams <- list(session = session, inputId = id)
    
    if (inputType == "Select") {
      funcParams[['selected']] <- value
    } else {
      funcParams[['value']] <- value
    }
    
    do.call(updateFunc, funcParams)
  })
}

# Update multiple Shiny inputs simultaneously
updateShinyInputs <- function(session, updates) {
  lapply(names(updates), function(id) {
    updateShinyInput(session, id, updates[[id]])
  })
}
