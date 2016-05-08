// Given an element id, tell Shiny what the input type of that element is
shinyjs.getInputType = function(params) {
  params = shinyjs.getParams(params, {
    id : null,
    shinyUpdateInputId : null
  });
  var id = params.id;
  var $el = $('#' + id);
  // find the enclosing shiny input container for the given id
  if (!$el.hasClass('shiny-input-container')) {
    $el = $el.closest('.shiny-input-container');
    if (!$el.length) {    
      console.log('Could not find Shiny input element for id \"' + id + '\"');
      return;
    }
  }
  // find the input type of the element
  var inputType = $el.data('inputType');
  if (!inputType) {
    console.log('Could not find Shiny input type for id \"' + id + '\"');
    return;
  }
  // tell Shiny what input type this element is
  Shiny.onInputChange(params.shinyUpdateInputId, inputType);
}