// Dean Attali, July 2015

app = function() {
  
  return {
    
    init : function() {
  
      // register an api call to get the r version when the button is clicked
      // (this is clearly not an ideal usecase of an ajax system since this can
      // be achieved with pure shiny, but it's a simple demonstration of the system)
      $('#getRversion').click(function() {
        // each api call MUST have a "_method" param (what to call in R),
        // while "_callback" and "_failureCallback" are optional.
        // you can also add any other parameters that will be used by the
        // function in R
        var params = {};
        params['_method'] = 'getRversion';
        params['_callback'] = function(response) {
          alert("response: " + response.rversion);
        };
        params['someOtherParam'] = 'foobar';
        api.call(params);
      });
      
      $('#errorFunction').click(function() {
        var params = {};
        params['_method'] = 'errorExample';
        params['_failureCallback'] = function(response) {
          alert("Error: " + response.message);
        };
        params['someOtherParam'] = 'foobar';
        api.call(params);
      });      
    }
  }
}();

$(function () { app.init(); });