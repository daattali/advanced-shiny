library(shiny)
# Also uses parallel, shinyjs, tools

# Create a long-running task, executed in a forked process. (Doesn't work on Windows)
# 
# The return value is a promise-like object with three
# methods:
# - completed(): FALSE initially, then TRUE if the task succeeds,
#   fails, or is cancelled. Reactive, so when the state changes
#   any reactive readers will invalidate.
# - result(): Use this to get the return value. While execution is
#   in progress, performs a req(FALSE). If task succeeded, returns
#   the return value. If failed, throws error. Reactive, so when
#   the state changes any reactive readers will invalidate.
# - cancel(): Call this to prematurely terminate the task.
create_forked_task <- function(expr) {
  makeReactiveBinding("state")
  state <- factor("running",
                  levels = c("running", "success", "error", "cancel"),
                  ordered = TRUE
  )
  
  result <- NULL
  
  # Launch the task in a forked process. This always returns
  # immediately, and we get back a handle we can use to monitor
  # or kill the job.
  task_handle <- parallel::mcparallel({
    force(expr)
  })
  
  # Poll every 100 milliseconds until the job completes
  o <- observe({
    res <- parallel::mccollect(task_handle, wait = FALSE)
    if (is.null(res)) {
      invalidateLater(100)
    } else {
      o$destroy()
      if (!is.list(res) || length(res) != 1 || !inherits(res[[1]], "try-error")) {
        state <<- "success"
        result <<- res[[1]]
      } else {
        state <<- "error"
        result <<- attr(res[[1]], "condition", exact = TRUE)
      }
    }
  })
  
  list(
    completed = function() {
      state != "running"
    },
    result = function() {
      if (state == "running") {
        # If running, abort the current context silently.
        # We've taken a reactive dependency on "state" so if
        # the state changes the context will invalidate.
        req(FALSE)
      } else if (state == "success") {
        return(result)
      } else if (state == "error") {
        stop(result)
      } else if (state == "cancel") {
        validate(need(FALSE, "The operation was cancelled"))
      }
    },
    cancel = function() {
      if (state == "running") {
        state <<- "cancel"
        o$destroy()
        tools::pskill(task_handle$pid, tools::SIGTERM)
        tools::pskill(-task_handle$pid, tools::SIGTERM)
        parallel::mccollect(task_handle, wait = FALSE)
      }
    }
  )
}