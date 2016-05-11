# Automatically stop a Shiny app when closing the browser tab

When developing a Shiny app and running the app in the browser (as opposed to inside the RStudio Viewer), it can be annoying that when you close the browser window, the app is still running and you need to manually press "Esc" to kill it. By adding a single line to the server code `session$onSessionEnded(stopApp)`, a Shiny app will automatically stop running whenever the browser tab (or any session) is closed.

Note that this can be useful for local development, but you should be very careful not to deploy this code in a real server because you don't want your real Shiny app to stop every time a user leaves the app.