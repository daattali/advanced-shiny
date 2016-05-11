# Multiple scrollspy - basic

The Bootstrap *scrollspy* plugin does not support multiple scrollspy objects per page. This Shiny app demonstrates how to support scrollspy on multiple tabs by having one common scrollspy control that gets updated via JavaScript whenever a tab is changed to reflect the contents of the new tab. Look at the code to see how this is achieved.

This approach is useful if you don't want to have to hardcode the scrollspy code since it will automatically generate the scrollspy control for each tab. However, the major disadvantage of this approach is that if you want different pages to have very different looking scrollspy controls, it will be hard to achieve with this method because only one common control is created.

This example makes use of the [shinyjs](https://github.com/daattali/shinyjs) package to call custom JavaScript functions.