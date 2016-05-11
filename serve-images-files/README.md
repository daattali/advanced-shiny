# Serve files (images/text files/etc) instead of webpages from a Shiny app 

It is possible to serve an image or another file directly from your Shiny app instead of a webpage.  The method shown here is a simple proof-of-concept of how to achieve this functionality.  It supports passing GET parameters to the file-generating logic so that the file can be parameterized.

The main idea is to use `session$clientData$registerDataObj` to associate a file with a specific endpoint URL. Since this URL is generated dynamically and cannot be used by the user before accessing the app, the Shiny app automatically redirects the user to the requested file after generating it and figuring out the URL internally.

This example makes use of the [shinyjs](https://github.com/daattali/shinyjs) package.

---

[![Demo](./serve-images-files.gif)](./serve-images-files.gif)