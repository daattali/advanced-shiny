# Adding text (or inputs) to the navigation bar in a navbarPage

Traditionally, a `navbarPage()` only accepts tabs and menu items inside of it. Even though the Bootstrap navbar (which is what Shiny uses) supports adding text and input widgets into the navbar, Shiny doesn't have support for that. This app shows you how to very easily achieve that.

The idea is to write a wrapper around `navbarPage()` that accepts all the same parameters and simply calls `navbarPage()`, but also accepts a `text` parameter. After creating the navbar page with Shiny, we can modify the generated HTML to simply add the HTML for the text, as the app code shows.
