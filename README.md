R shiny tricks (shinyjs - reset inputs, disable, hide), global.R, 
global.R, splitting off big ui/server into files



- [Simple AJAX system for Shiny apps (JS -> R -> JS communication)](#api-ajax) ([code](./api-ajax))
- [Automatically stop a Shiny app when closing the browser tab](#auto-kill-app) ([code](./auto-kill-app))
- [TODO](#busy-indicator) ([code](./busy-indicator))
- [Close the window (and stop the app) with a button click](#close-window) ([code](./close-window))
- [Show user a generic error message when a Shiny error occurs in an output](#error-custom-message) ([code](./error-custom-message))
- [Facebook login through JavaScript in Shiny](#fb-login) ([code](./fb-login))
- [Sharing images on Facebook](#fb-share-img) ([code](./fb-share-img))
- [Hide a tab](#hide-tab) ([code](./hide-tab))
- [Loading screen](#loading-screen) ([code](./loading-screen))
- [Shiny app with sequence of pages](#multiple-pages) ([code](./multiple-pages))
- [Multiple scrollspy - advanced](#multiple-scrollspy-advanced) ([code](./multiple-scrollspy-advanced))
- [Multiple scrollspy - basic](#multiple-scrollspy-basic) ([code](./multiple-scrollspy-basic))
- [Navigation in a Shiny app](#navigate-history) ([code](./navigate-history))
- [Show a spinning "loading" animation while a plot is recalculating](#plot-spinner) ([code](./plot-spinner))
- [Press the Enter key to simulate a button press](#proxy-click) ([code](./proxy-click))
- [Select input with more breathing room](#select-input-large) ([code](./select-input-large))
- [Serve files (images/text files/etc) instead of webpages from a Shiny app ](#serve-images-files) ([code](./serve-images-files))
- [TODO](#server-to-ui-variable) ([code](./server-to-ui-variable))
- [Hide/show shinydashboard sidebar programatically](#shinydashboard-sidebar-hide) ([code](./shinydashboard-sidebar-hide))
- [Toggle a UI element (alternate between show/hide) with a button](#simple-toggle) ([code](./simple-toggle))
- [Update multiple Shiny inputs without knowing input type ](#update-input) ([code](./update-input))
- [TODO](#upload-file-names) ([code](./upload-file-names))
- [Prepopulate Shiny inputs when an app loads based on URL parameters](#url-inputs) ([code](./url-inputs))


<h3 id="api-ajax">Simple AJAX system for Shiny apps (JS -> R -> JS communication)</h3>

**[Link to code](./api-ajax)**

Sometimes it's useful to be able to call an R function from JavaScript and use the return value from R back in JavaScript. This sort of communication is usually done with AJAX in JavaScript. This app shows how to implement a simple and ultra lightweight AJAX-like system in Shiny, to be able to call functions in R.

<h3 id="auto-kill-app">Automatically stop a Shiny app when closing the browser tab</h3>

**[Link to code](./auto-kill-app)**

When developing a Shiny app and running the app in the browser (as opposed to inside the RStudio Viewer), it can be annoying that when you close the browser window, the app is still running and you need to manually press "Esc" to kill it. By adding a single line to the server code `session$onSessionEnded(stopApp)`, a Shiny app will automatically stop running whenever the browser tab (or any session) is closed.

<h3 id="busy-indicator">TODO</h3>

**[Link to code](./busy-indicator)**



<h3 id="close-window">Close the window (and stop the app) with a button click</h3>

**[Link to code](./close-window)**

This simple example shows how you can have a button that, when clicked, will close the current browser tab and stop the running Shiny app (you can choose to do only one of these two actions).

<h3 id="error-custom-message">Show user a generic error message when a Shiny error occurs in an output</h3>

**[Link to code](./error-custom-message)**

When a Shiny output encounters an error, the exact error message will be shown to the user in place of the output. This is generally a good feature because it's easier to debug when you know the exact error. But sometimes this is undesireable if you want to keep the specifics of what happened unknown to the user, and you prefer to just show the user a generic "Some error occurred; please contact us" message. This may sound counter intuitive, but you can actually do this with a tiny bit of CSS, as this example shows.

<h3 id="fb-login">Facebook login through JavaScript in Shiny</h3>

**[Link to code](./fb-login)**

This app shows how you can use the [AJAX-like system](./api-ajax) in Shiny to authorize a user using Facebook's JavaScript library and pass the user's information to R for processing.

<h3 id="fb-share-img">Sharing images on Facebook</h3>

**[Link to code](./fb-share-img)**

There are two ways to share images on Facebook: either using an image URL and a popup dialog, or by programatically supplying the Facebook API with a base64 encoded image. This example shows both.

<h3 id="hide-tab">Hide a tab</h3>

**[Link to code](./hide-tab)**

This app demonstrates how `shinyjs` can be used to hide/show a specific tab in a `tabsetPanel`.  In order to use this trick, the `tabsetPanel` must have an id. Using this id and the value of the specific tab you want to hide/show, you can call `shinyjs::hide()`/`shinyjs::show()`/`shinyjs::toggle()`.

[![Demo](./hide-tab/hide-tab.gif)](./hide-tab)

<h3 id="loading-screen">Loading screen</h3>

**[Link to code](./loading-screen)**

This simple app shows how to add a "Loading..." screen overlaying the main app while the app's server is initializing.  The main idea is to include an overlay element that covers the entire app (using CSS), hide the main app's UI, and at the end of the server function show the UI and hide the overlay.

[![Demo](./loading-screen/loading-screen.gif)](./loading-screen)

<h3 id="multiple-pages">Shiny app with sequence of pages</h3>

**[Link to code](./multiple-pages)**

This app demonstrates how to write a Shiny app that has a sequence of different pages, where the user can navigate to the next/previous page. This can be useful in many scenarios that involve a multi-step process. This behaviour can also be achieved by simply using tabs, but when using tabs the user can freely move from any tab to any other tab, while this approach restricts the user to only move to the previous/next step, and can also control when the user can move on to the next page.

[![Demo](./multiple-pages/multiple-pages.gif)](./multiple-pages)

<h3 id="multiple-scrollspy-advanced">Multiple scrollspy - advanced</h3>

**[Link to code](./multiple-scrollspy-advanced)**

The Bootstrap *scrollspy* plugin does not support multiple scrollspy objects per page.
This Shiny app demonstrates how to support scrollspy on multiple tabs by allowing each tab to have its own independent scrollspy control and using JavaScript to ensure only the scrollspy on the current tab is activated.

<h3 id="multiple-scrollspy-basic">Multiple scrollspy - basic</h3>

**[Link to code](./multiple-scrollspy-basic)**

The Bootstrap *scrollspy* plugin does not support multiple scrollspy objects per page. This Shiny app demonstrates how to support scrollspy on multiple tabs by having one common scrollspy control that gets updated via JavaScript whenever a tab is changed to reflect the contents of the new tab.

<h3 id="navigate-history">Navigation in a Shiny app</h3>

**[Link to code](./navigate-history)**

Sometimes it's nice to be able to support navigation within a Shiny app, especially when there are multiple tabs or some other form of "multiple pages" in a Shiny app. Since Shiny apps are a single page, the browser nagivation buttons (previous/next page) don't work when "navigating" within a Shiny app. You also can't bookmark a certain "page" in a Shiny app - every time you go to an app, you will be shown the initial state of the app. This app shows how to implement basic navigation in Shiny apps.

[![Demo](./navigate-history/navigate-history.gif)](./navigate-history)

<h3 id="plot-spinner">Show a spinning "loading" animation while a plot is recalculating</h3>

**[Link to code](./plot-spinner)**

When a Shiny plot is recalculating, the plot gets grayed out. This app shows how you can add a spinner wheel on top of the plot while it is recalculating, to make it clear to the user that the plot is reloading. There can be many different ways to achieve a similar result using different combinations of HTML/CSS, this example is just the simplest one I came up with.

[![Demo](./plot-spinner/plot-spinner.gif)](./plot-spinner)

<h3 id="proxy-click">Press the Enter key to simulate a button press</h3>

**[Link to code](./proxy-click)**

This is a simple app with a tiny bit of JavaScript that shows you how to cause an Enter key press inside an input to trigger a click on a button.

<h3 id="select-input-large">Select input with more breathing room</h3>

**[Link to code](./select-input-large)**

One common CSS question in Shiny is how to make the select input dropdown menu have some more whitespace.  It's actually very easy to do with just two CSS rules, as demonstrated in this example.

[![Demo](./select-input-large/selectize-large.gif)](./select-input-large)

<h3 id="serve-images-files">Serve files (images/text files/etc) instead of webpages from a Shiny app </h3>

**[Link to code](./serve-images-files)**

It is possible to serve an image or another file directly from your Shiny app instead of a webpage.  The method shown here is a simple proof-of-concept of how to achieve this functionality.  It also supports passing GET parameters to the file-generating logic so that the file can be parameterized.

[![Demo](./serve-images-files/serve-images-files.gif)](./serve-images-files)

<h3 id="server-to-ui-variable">TODO</h3>

**[Link to code](./server-to-ui-variable)**



<h3 id="shinydashboard-sidebar-hide">Hide/show shinydashboard sidebar programatically</h3>

**[Link to code](./shinydashboard-sidebar-hide)**

A common question regarding `shinydashboard` is how to programatically hide/show the sidebar. This can very easily be done using the [shinyjs](https://github.com/daattali/shinyjs) package, as demonstrated here.

[![Demo](./shinydashboard-sidebar-hide/shinydashboard-sidebar-hide.gif)](./shinydashboard-sidebar-hide)

<h3 id="simple-toggle">Toggle a UI element (alternate between show/hide) with a button</h3>

**[Link to code](./simple-toggle)**

Sometimes you want to toggle a section of the UI every time a button is clicked. This app shows how to achieve very basic toggle functionality using `conditionalPanel()`. If you want anything more advanced, you can use the `toggle()` function from the [shinyjs](https://github.com/daattali/shinyjs) package.

<h3 id="update-input">Update multiple Shiny inputs without knowing input type </h3>

**[Link to code](./update-input)**

Shiny allows you to update an input element only if you know the type of input. Furthermore, Shiny only allows you to update input elements one by one.  This Shiny app shows how you can update an input only using its ID and without knowing its type, and how to update multiple inputs together.

<h3 id="upload-file-names">TODO</h3>

**[Link to code](./upload-file-names)**



<h3 id="url-inputs">Prepopulate Shiny inputs when an app loads based on URL parameters</h3>

**[Link to code](./url-inputs)**

This simple app demonstrates how you can fill out certain input fields when a Shiny app loads based on URL parameters.

[![Demo](./url-inputs/url-inputs.gif)](./url-inputs)