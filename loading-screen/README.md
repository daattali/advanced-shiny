# Loading screen

*Dean Attali, July 2015*

This simple app shows how to add a "Loading..." screen overlaying the main app while the app's server is initializing.  The main idea is to include an overlay element that covers the entire app (using CSS), hide the main app's UI, and at the end of the server function show the UI and hide the overlay.

Note that this will only show the Loading screen while the server is initializing, but it will not show up until the app's UI is finished rendering.