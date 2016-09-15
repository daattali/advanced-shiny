// Dean Attali, July 2015

facebook = function() {
  
  return {
    
    init : function() {

      // initialize facebook JDK
      (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s);
        js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk')); 
      window.fbAsyncInit = function() {
        FB.init({
          appId: '587632811407957',  // YOUR APP ID GOES HERE
          cookie: true, 
          version: 'v2.7'
        });
        FB.getLoginStatus(function(response) {
          console.log(response);
          facebook.statusChangeCallback(response);
        });
      };
      
      // register click handler to login
      $('#fbLoginBtn').click(function() {
        facebook.fbLogin(function(response) {
          var params = {};
          params['_method'] = 'fblogin';
          params['_callback'] = function(r){console.log(r)};
          params['user_id'] = response.authResponse.userID;
          params['access_token'] = response.authResponse.accessToken;
          api.call(params);
        });
      });
    },
    
    fbLogin : function(cb) {
      FB.login(function(response) {
        facebook.statusChangeCallback(response, cb);
      });
    },
    
    // This is called with the results from from FB.getLoginStatus().
    statusChangeCallback : function(response, cb) {
      console.log(response);
      if (response.status === 'connected') {
        FB.api('/me', function(response) {
          $("#fbStatus").html('Hi ' + response.name);
        });
        if (typeof cb !== "undefined") {
          cb(response);
        }
      } else if (response.status === 'not_authorized') {
        $("#fbStatus").html('Please authorize the app.');
      } else {
        $("#fbStatus").html('Please log into Facebook.');
      }
    },    
  }
}();

$(function () { facebook.init(); });
