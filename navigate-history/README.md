# Navigation in a Shiny app

*Dean Attali, July 2015*

Sometimes it's nice to be able to support navigation within a Shiny app, especially when there are multiple tabs or some other form of "multiple pages" in a Shiny app. Since Shiny apps are a single page, the browser nagivation buttons (previous/next page) don't work when "navigating" within a Shiny app.

This app shows a basic demonstration of how to implement a way to navigate a Shiny app by manually changing the URL when different tabs are loaded, and using the current URL to decide what to show when a new page is loaded.  In this app, every time you click on a new tab, the browser will behave as if you navigated to a new page, and you will be able to go back and forward using the browser navigation buttons.  Another nice feature is that after navigating to a certain tab, you can copy the URL or bookmark it, and when you open that page again, the Shiny app will restore the state of the app.

For example, try this sequence of events to see what this app can do:  
- load the app
- type some text into the search box in the Home tab
- click on "Search" (you will be redirected to the Search tab)
- click on the "About" tab
- click the "back" button in your browser navigation
- copy the URL
- click the "next" button in your browser navigation
- in a different window, go to the URL that you copied earlier (it will automatically navigate to the search page and show the search term)