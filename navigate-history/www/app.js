// whenever the user navigates with the previous/next buttons in the browser,
// tell the Shiny app to restore the history based on the URL navigated to
$(function() {
  window.onpopstate = function (event) {
   Shiny.onInputChange('navigatedTo', location.search)
  } 
});