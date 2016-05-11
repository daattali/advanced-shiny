# Facebook login through JavaScript in Shiny

This app shows how you can use the [AJAX-like system](../api-ajax) in Shiny to authorize a user using Facebook's JavaScript library and pass the user's information to R for processing. Because of Facebook's app settings, in order for the app to work properly locally, you need to replace `127.0.0.1` in the URL with `fuf.me` (testing FB apps locally is a big pain and is out of the scope of this example, you might have to do lots of Googling and StackOverflow-ing to get it right).

Note that this example uses the [AJAX system](../api-ajax) shown in another example.