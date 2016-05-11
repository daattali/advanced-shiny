# Show user a generic error message when a Shiny error occurs in an output

*Dean Attali, July 2015*

When a Shiny output encounters an error, the exact error message will be shown to the user in place of the output. This is generally a good feature because it's easier to debug when you know the exact error. But sometimes this is undesireable if you want to keep the specifics of what happened unknown to the user, and you prefer to just show the user a generic "Some error occurred; please contact us" message. This may sound counter intuitive, but you can actually do this with a tiny bit of CSS, as this example shows.