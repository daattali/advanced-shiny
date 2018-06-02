# Create a reactive trigger

A reactive trigger can be used when you want to be able to explicitly trigger a reactive expression. You can think of it as being similar to an action button, except instead of clicking on a button to trigger an expression, you can programatically cause the trigger. This concept and code was created by Joe Cheng (author of shiny).

To use a reactive trigger, define the construct with this code:

```
makeReactiveTrigger <- function() {
  rv <- reactiveValues(a = 0)
  list(
    depend = function() {
      rv$a
      invisible()
    },
    trigger = function() {
      rv$a <- isolate(rv$a + 1)
    }
  )
}
```

Then you can instantiate a reactive trigger with

```
myTrigger <- makeReactiveTrigger()
```

To use it, you need to call `myTrigger$depend()` in any reactive code that should re-run when the trigger is fired, and you can call `myTrigger$trigger()` to set off the trigger. You can have multiple reactive triggers, think of each one as a button that gets pressed programatically.
