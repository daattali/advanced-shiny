# Update any Shiny input without knowing input type 

*Dean Attali, July 2015*

Shiny allows you to update an input element only if you know the type of input it is. Furthermore, Shiny only allows you to update input elements one by one.  This Shiny app demonstrates a solution to these two problems.

First, the common Shiny input builder functions are wrapped by a custom function that mimics the Shiny function but also adds the input type information to the input's HTML.  Then whenever you want to update an input only based on its ID, we can use JavaScript to determine the type of input, report it back to Shiny, and then call the correct update function.  This is done with a call to `updateShinyInput(session, "inputid", "new value")`. You can also use `updateShinyInputs(list(...))` to update many inputs together in one call.

Note that this solution assumes you're using the proper shiny functions to create inputs. More specifically, this won't work if creating input elements manually with HTML (for example, you should always call "textInput" rather than create a
<input type='button'> HTML).