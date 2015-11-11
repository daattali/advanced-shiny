library(shiny)
library(shinyjs)

jscode <- "
// Define a JavaScript function to navigate the page to where the file is served
shinyjs.navigate = function(url) {
  window.location.href = window.location.origin + window.location.pathname + url;
}
"

runApp(shinyApp(
  ui = fluidPage(
    useShinyjs(),
    extendShinyjs(text = jscode),
    
    # Portion of the app that lets the user cutomize a plot and then see
    # a URL to serve that plot
    hidden(div(id = "app",
      h3("Serve an image of a plot from 1 to n"),
      sliderInput("num", "n", 1, 50, 10),
      selectInput("col", "Colour", 
                  choices = c("black", "brown", "red", "blue", "green")),
      uiOutput("link")
    )),
    
    # Portion of the app shown when a user is on a page that serves a file
    hidden(div(id = "creating", h3("Creating the file...")))
  ),
  server = function(input, output, session) {
    
    # Show the user a friendly URL for accessing the plot 
    output$link <- renderUI({
      queryBuild <- sprintf("?num=%s&col=%s", input$num, input$col)
      externalUrl <- sprintf(
        "%s%s%s",
        session$clientData$url_hostname,
        session$clientData$url_pathname,
        queryBuild
      )
      
      tags$a(externalUrl, href = queryBuild, target = "_blank")
    })
    
    # Logic for associating the URL with the plot
    observe({
      query <- parseQueryString(session$clientData$url_search)
      
      # if we see a 'num' GET param, it means this is a request for a plot image
      if (!is.null(query$num)) {
        
        show("creating")
        
        # create a URL endpoint for the image
        myurl <- session$registerDataObj(
          name   = 'getplot',
          data   = query,
          filter = function(data, req) {
            
            # create the image (or it could be a text file or any other file)
            # the file needs to be saved so that it's possible to read it
            image <- tempfile()
            col <- data$col
            tryCatch({
              png(image, width = 600, height = 600)
              plot(seq(1, as.numeric(data$num)), main = date(), col = col)
            }, finally = dev.off())
            
            # submit an OK response, sending the file (image) as the content
            # if you're serving a different type of file, remember to change
            # the "image/png" to the correct MIME type
            shiny:::httpResponse(
              200, 'image/png', readBin(image, 'raw', file.info(image)[, 'size'])
            )
          }
        )
        
        # After creating the requested file and associating it with a URL, go
        # to that webpage using JavaScript
        js$navigate(myurl)
      } else {
        # if this is not a request for a file, show the Shiny app
        show("app")
      }
    })
  }
))