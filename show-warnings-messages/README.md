# Show a function's messages and warnings to the user

Sometimes when you call a function, it may print out some messages and/or warnings to the console. If you want to be able to relay these warnings/messages to your app in real time, you can combine `withCallingHandlers` with the `html` function from [shinyjs](https://github.com/daattali/shinyjs).

(Originally developed as an [answer on StackOverflow](http://stackoverflow.com/questions/30474538/possible-to-show-console-messages-written-with-message-in-a-shiny-ui))
