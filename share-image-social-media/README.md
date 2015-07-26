# Sharing images on social media

*Dean Attali, July 2015*

This is purely a JavaScript app and doesn't have much Shiny/R involved.  In order to share an image on social media, you need to provide a URL for the image. This means that if you generate an image in Shiny and want to share the image, you need to host it somewhere public. The easiest way to do this is to download the image to somewhere on your server that's publicly accessible and give the URL for that location as the image. The image URL is only needed at the moment of sharing, it doesn't have to be alive afterwards, so it'd be good to have a cron job that deletes images older than a few minutes.

**LinkedIn:**

I couldn't get the R-based OAuth authentication working using `httr` package, so instead all the code is purely in JavaScript. After clicking the "share" button, the user will first asked to log in and approve the app if they have never done so before. When the user is logged in, the image will be posted to their LinkedIn along with a message and a URL.

**Facebook:**

Since LinkedIn is using the pure JavaScript approach, I chose to do the same thing with Facebook. Similarly to with LinkedIn, a user will be asked to log in if they aren't, and then the image + message + URL will be shared.  **Important**: The Facebook app settings do not allow a URL of `localhost` or `127.0.0.1` to be used, so in order to run this app locally you will need to change the URL to `fuf.me` (the port number doesn't matter, it will work with any port). If you want to use this in a non local server, you need to create a new Facebook app and give it the URL of your app.

**Twitter:**

I can't figure out how to share images on Twitter :/ Posting a text status is easy, but it looks like Twitter recently purposely made it very hard to add images to status updates programatically -- from what I can see, it's not doable with JavaScript. There are examples using php and python. I couldn't figure a way to do it in R.  Twitter is really pushing to use its own commandline tool for this task (called *twurl*), they claim it's easy for uploading images, but the tool requires ruby and I dont have an environemnt with ruby right now. I'd be happy to see someone with more experience with the Twitter API get this working and show me how they did it :)