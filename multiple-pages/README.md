# Shiny app with sequence of pages

*Dean Attali, July 2015*

This app demonstrates how to write a Shiny app that has a sequence of different pages, where the user can navigate to the next/previous page. This can be useful in many scenarios that involve a multi-step process. This behaviour can also be achieved by simply using tabs, but when using tabs the user can freely move from any tab to any other tab, while this approach restricts the user to only move to the previous/next step, and can also control when the user can move on to the next page (by enabling/disabling the navigation buttons using `shinyjs::enable` and `shinyjs::disable`).

This example makes use of the [shinyjs](https://github.com/daattali/shinyjs) package to show/hide the pages and to enable/disable the buttons.