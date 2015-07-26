// Dean Attali, July 2015

app = function() {
  
  // the message to share
  var payload = {
    picture : 'http://deanattali.com/img/deanimg.jpeg',
    link : 'http://deanattali.com',
    title : 'Dean Attali',
    caption : 'Short tagline goes here',
    description : 'This is the loooooooooooonger description where you can write more'
  };

  return {
    
    init : function() {
      
      // initialize facebook JDK
      (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s);
        js.id = id;
        js.src = 'http://connect.facebook.net/en_US/sdk.js';
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));  
      window.fbAsyncInit = function() {
        FB.init({
          appId: '978725282157807', //  Facebook app ID (works when app is at URL fuf.me)
          cookie: true, 
          version: 'v2.4'
        });
      };      
      
      // register click event on linkedin share button
      $("#linkedinShareBtn").click(function() {
        IN.User.authorize(app.linkedinShare);
      });
      
      // register click event on facebook share button
      $('#fbShareBtn').click(app.facebookShare);
    },
    
    // share image on linkedin
    linkedinShare : function() {
      var params = { 
        "content": {
          "title" : payload.title,
          "description" : payload.description,
          "submitted-image-url" : payload.picture,
          "submitted-url" : payload.link
        },
        "visibility": { 
          "code": "anyone"
        }
      };
      IN.API.Raw("/people/~/shares?format=json")
        .method("POST")
        .body(JSON.stringify(params))
        .result(function(o){ alert("LinkedIn share success!"); console.log(o); })
        .error(function(o){ alert("LinkedIn shard error"); console.log(o); });
    },

    // share image on facebook    
    facebookShare : function() {
      var params = {
          method : 'feed',
          picture : payload.picture,
          link : payload.link,
          name : payload.title,
          caption : payload.caption,
          description : payload.description
      }
      FB.ui(params, function(response) {
        if (response && response.post_id) {
          alert('Facebook share success!');
          console.log(response);
        } else {
          alert('Facebook share error')
          console.log(response);
        }
      });    
    }
  }
}();

$(function () { app.init(); });