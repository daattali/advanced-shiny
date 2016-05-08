# Hide a tab

*Dean Attali, July 2015*

This app demonstrates how `shinyjs` can be used to hide/show a specific tab in a `tabsetPanel`.  In order to use this trick, the `tabsetPanel` must have an id. Using this id and the value of the specific tab you want to hide/show, you can call `shinyjs::hide()`/`shinyjs::show()`/`shinyjs::toggle()`.

This example makes use of the [shinyjs](https://github.com/daattali/shinyjs) package to show/hide the tab.