# Use a custom function to convert the JavaScript data into an R object

When using `Shiny.onInputChange(name, data)` (as described [here](../message-javascript-to-r)), you are passing in a JavaScript object (`data`) and expect it to get converted to an R object (`input$name`). This conversion happens by serializing and deserializing the data to and from JSON. Usually `input$name` will look exactly like you'd expect it to, but it is possible for the conversion process to not do exactly what you want. Alternatively, you may just want to alter the data slightly in R before presenting it to Shiny.

This is where the `shiny::registerInputHandler()` function comes in: it allows you to transform the data passed in from JavaScript before it gets used as `input$`. For example, suppose you use `Shiny.onInputChange("myobj", value)` to send a value from JavaScript to R, but you want `input$myobj` to be automatically converted into a list. There are two simple steps you'd need to follow:

1. In JavaScript, change `Shiny.onInputChange("myobj", value)` to `Shiny.onInputChange("myobj:mylist", value)`. Notice that we append `:<type>` to the name of the object. This specifices the type of object that is being passed to Shiny, so that Shiny will know what handler to call when deserialization its value.

2. In R, define the following function:

  ```
  shiny::registerInputHandler("mylist", function(data, ...) {
    list(data)
  }, force = TRUE)
  ```

Now if you access `input$myobj` in shiny, the value will be wrapped in a list. Of course this particular example isn't terribly useful, but this principle can be applied in real apps (for example, you can see how I've used it in [`timevis`](https://github.com/daattali/timevis/blob/v0.2/R/utils.R#L2-L7)).