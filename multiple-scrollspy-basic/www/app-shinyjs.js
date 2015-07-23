// update scrollspy control with the contents of the current tab
// and refresh the control to make the changes take effect
shinyjs.updateScrollspy = function(tab) {
  if (tab == 'tab1' || tab == 'tab2') {
    var $tabContent = $('#' + tab + '-content');
    var tabSections = $tabContent.find('.scrollspy-section');
    var scrollspyHtml = '';
    $.each(tabSections, function(idx, el) {
        scrollspyHtml += '<li><a href=\"#' + el.id + '\"></a></li>';
    });
    $('#myscrollspy').children('ul').html(scrollspyHtml);
    $('body').scrollspy('refresh');
  }
}