# Hide/show shinydashboard sidebar programmatically

A common question regarding `shinydashboard` is how to programmatically hide/show the sidebar.

To solve this problem, I first looked at the HTML and tried to see what happens when the button to toggle the sidebar is clicked. It seems like the `<body>` HTML tag gains and loses a CSS class "sidebar-collapse" when the toggle button is clicked. Therefore, all we have to do to show/hide the sidebar is simply remove/add that class to the document's body tag. This can easily be done using the [shinyjs](https://github.com/daattali/shinyjs) package.

---

[![Demo](./shinydashboard-sidebar-hide.gif)](./shinydashboard-sidebar-hide.gif)