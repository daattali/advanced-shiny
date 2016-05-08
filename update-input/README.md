# Update multiple Shiny inputs without knowing input type 

*Dean Attali, July 2015*

Shiny allows you to update an input element only if you know the type of input. Furthermore, Shiny only allows you to update input elements one by one.  This Shiny app demonstrates a solution to these two problems.

First, the Shiny input builder functions are wrapped by a custom function that adds the input type information to the input's HTML. Then whenever you want to update an input only based on its ID, we can use JavaScript to determine the type of input, report it back to Shiny, and then call the correct update function.  This is done with a call to `updateShinyInput(session, "inputid", "new value")`. You can also use `updateShinyInputs(list(...))` to update many inputs together in one call.