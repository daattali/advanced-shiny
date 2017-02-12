library(shiny)

source("create_forked_task.R")

ui <- fluidPage(
  shinyjs::useShinyjs(), # Initialize shinyjs library
  
  # Buttons to control job
  actionButton("start", "Start"),
  shinyjs::disabled(actionButton("stop", "Stop")),
  
  # This will display the job output
  tableOutput("out")
)

server <- function(input, output, session) {
  # Make "task" behave like a reactive value
  makeReactiveBinding("task")
  task <- NULL
  
  output$out <- renderTable({
    # The task starts out NULL but is required. The req() takes
    # care of ensuring that we only proceed if it's non-NULL.
    req(task)$result()
  })
  
  observeEvent(input$start, {
    shinyjs::enable("stop")
    shinyjs::disable("start")
    
    task <<- create_forked_task({
      # Pretend this takes a long time
      Sys.sleep(5)
      cars[sample(nrow(cars), 10),]
    })
    
    # Show progress message during task start
    prog <- Progress$new(session)
    prog$set(message = "Executing task, please wait...")
    
    o <- observe({
      # Only proceed when the task is completed (this could mean success,
      # failure, or cancellation)
      req(task$completed())
      
      # This observer only runs once
      o$destroy()
      
      # Close the progress indicator and update button state
      prog$close()
      shinyjs::disable("stop")
      shinyjs::enable("start")
    })
  })
  
  observeEvent(input$stop, {
    task$cancel()
  })
}

shinyApp(ui, server)