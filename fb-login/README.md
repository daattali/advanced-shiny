# Facebook login through JavaScript in Shiny

This app shows how you can use the [AJAX-like system](../api-ajax) in Shiny to authorize a user using Facebook's JavaScript library and pass the user's information to R for processing. You'll need to set up your app with proper settings on Facebook's Developer Dashboard (most importantly the app URL), and add your Facebook App ID as the `appId` parameter in the [app.js](./www/app.js) file (in [this line](https://github.com/daattali/advanced-shiny/blob/6a9c78a2d437f40276842ec76934ac0b890b9d52/fb-login/www/app.js#L20)).

Here is the series of steps to get your app working locally as of September 2016:

- Go to [https://developers.facebook.com/apps](https://developers.facebook.com/apps)
- Click on *+ Add a New App* and fill in the required info
- When you get to the new app's Settings page, click on *+ Add Product*
- Select *Facebook Login*
- In the field for *Valid OAuth redirect URIs*, type `http://localhost:5000`
- Click *Save Changes*
- When running your shiny app:
  - You'll need to run your Shiny app using port 5000 because that's the port we used in the Facebook settings (eg. `runApp('fb-login', port = 5000)`)
  - You'll need to replace the `127.0.0.1` in the URL with `localhost` (Facebook doesn't work with 127.0.0.1)

When deploying an app on a shiny server or on shinyapps.io, you'll need to adjust the app settings acordingly.

Unfortunately these steps are not guaranteed to work forever - Facebook is known to change their API often, as well as the Developer Dashboard and all the available settings. I will not be maintaining this code to work with the ever-changing Facebook API, so if you're having problems setting up your app with the correct settings, just know that there are tons of other people also struggling with it, and use Google/Stackoverflow to try to figure it out :)
