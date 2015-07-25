// Dean Attali, July 2015

api = function() {
  
  // create a unique id
  function guid() {
    function s4() {
      return Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);
    }
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
      s4() + '-' + s4() + s4() + s4();
  }
  
  // keep track of all the calls currently in progress
  calls = {};
  
  return {
    
    // this is the main function to use: call "api.call(params)" to make
    // an AJAX call
    call : function(params) {
      var reqid = guid();
      calls[reqid] = params;
      params['_reqid'] = reqid;
      Shiny.onInputChange('api', params);
    },
    
    // callback from R when a call is done
    callback : function(response) {
      // grab the request id and get the original parameters of this call
      var reqid = response._reqid;
      delete response['_reqid'];
      var call = calls[reqid];
      
      // remove this call from the list of calls in progress
      delete calls[reqid];
      
      // if the user specified a callback, call it
      var callback = call._callback;
      if (callback) {
        callback(response);
      }
    },
    
    // callback from R when an error occurs during an api call
    failureCallback : function(response) {
      console.log("API error!");
      console.log(response);
      
      var reqid = response._reqid;
      delete response['_reqid'];
      var call = calls[reqid];
      delete calls[reqid];
      var callback = call._failureCallback;
      if (callback) {
        callback(response);
      }
    }    
  };
}();

$(function () {
  Shiny.addCustomMessageHandler('api.callback', api.callback);
  Shiny.addCustomMessageHandler('api.failureCallback', api.failureCallback);
});