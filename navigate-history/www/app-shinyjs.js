// whenever the user navigates with the previous/next buttons in the browser,
// tell the Shiny app to restore the history based on the URL navigated to
shinyjs.init = function() {
  window.onpopstate = function (event) {
    Shiny.onInputChange('navigatedTo', location.search);
  } 
}

// update the URL to reflect the current state 
shinyjs.updateHistory = function(params) {
  var queryString = [];
  for (var key in params) {
    queryString.push(encodeURIComponent(key) + '=' + encodeURIComponent(params[key]));
  }
  queryString = '?' + queryString.join('&');
  history.pushState(null, null, queryString)
}