# Multiple scrollspy - advanced

The Bootstrap *scrollspy* plugin does not support multiple scrollspy objects per page.
This Shiny app demonstrates how to support scrollspy on multiple tabs by allowing each tab to have its own independent scrollspy control and using JavaScript to ensure only the scrollspy on the current tab is activated. Look at the code to see how this is achieved.

This approach is very flexible and great to use when you want to define custom scrollspy controls on each tab. Initially I thought it'd be easy to simply "destroy" a scrollspy control and initialize a different one, but it seems like destorying scrollspy objects is not possible in Bootstrap 3 (although it sounds like in Bootstrap 4 it will be supported), so a more clever trick has to be used in order to "reset" the active scrollspy control.

This method also supports having a different offset for the scrollspy on each tab by adding a `data-offset` attribute to the scrollspy HTML tag. This method also uses the jQuery scrollTo plugin to animate the scrolling for a better UX.

This example makes use of the [shinyjs](https://github.com/daattali/shinyjs) package to call custom JavaScript functions.