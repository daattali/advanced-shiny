# Send a message from R (server) to JavaScript (client)

While Shiny is very powerful, there are many things that cannot be achieved in R and must be done in JavaScript. When including JavaScript code in a Shiny app, you sometimes need to send a message or a value from R to the JavaScript layer. This example how this is done.

Sending a message from Shiny to Javascript involves two steps: first, in R you need to call `session$sendCustomMessage(type, message)`, where `type` is a string that specifies what message handler to call and `message` is an R object that gets sent to the message handler. Then you need to write the message handler in JavaScript using the code `Shiny.addCustomMessageHandler(type, function(message) {...});`. Whenever Shiny sends a message of type `type`, the corresponding function in JavaScript will get called with the `message` as its argument. While this may sound complicated, looking at the example code shows how simple this is. Note that for this to work, the shiny server function must be defined with the `session` parameter, ie. `server <- function(input, output, session) {...}`. 

To send a message in the other direction (from JavaScript to R), see [Send a message from JavaScript to R](../message-javascript-to-r).

Another approach for calling JavaScript functions from Shiny which attempts to make the process easier is using the `extendShinyjs()` function from the [shinyjs](https://github.com/daattali/shinyjs) package.

[See a real shiny app where I used this concept](http://daattali.com/shiny/cfl/)