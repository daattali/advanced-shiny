jscode <- '
$(function() {
  var $els = $("[data-proxy-click]");
  $.each(
    $els,
    function(idx, el) {
      var $el = $(el);
      var $proxy = $("#" + $el.data("proxyClick"));
      $el.keydown(function (e) {
        if (e.keyCode == 13) {
          $proxy.click();
        }
      });
    }
  );
});
'

runApp(shinyApp(
  ui = fluidPage(
    tags$head(tags$script(HTML(jscode))),
    actionButton("btn", "Click me to print the value in the text field"),
    div("Or press Enter when the text field is focused to \"press\" the button"),
    tagAppendAttributes(
      textInput("text", NULL, "foo"),
      `data-proxy-click` = "btn"
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$btn, {
      cat(input$text)
    })
  }
))
