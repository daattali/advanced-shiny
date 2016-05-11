# Sharing images on Facebook

There are two ways to share images on Facebook, and hence there are two share buttons in the sample app. The first one (easier) uses the conventional way of sharing an image on Facebook using an image URL and will ask the user to confirm sharing. The second method shares a base64 encoded image (which means we get get the image data straight from Shiny) and can be done completely programatically, but it's a little bit more hacky.

A user will be asked to log in to Facebook if they aren't logged in. Note that the Facebook app settings do not allow a URL of `localhost` or `127.0.0.1` to be used, so in order to run this app locally you will need to change the URL to `fuf.me`.