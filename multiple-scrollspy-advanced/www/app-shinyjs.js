// initialize common scrollspy control
shinyjs.init = function() {
  $('body').scrollspy({ target: '.active-scrollspy' });
}

// update the active scrollspy control and refresh so that it will function
shinyjs.updateScrollspy = function(tab) {
  // make all scrollspy controls inactive
  $('active-scrollspy').removeClass('active-scrollspy');
  // get the content in the current tab
  var $tabContent = $('#' + tab + '-content');
  if ($tabContent.length) {
    // find the scrollspy control in the current tab
    var $scrollspy = $tabContent.find('.potential-scrollspy');
    if ($scrollspy.length) {
      // mark the scrollspy in the current tab as active
      $scrollspy.addClass('active-scrollspy');
      // figure out the offset for this scrollspy 
      var offset = 0;
      if ($scrollspy.data('offset')) {
        offset = $scrollspy.data('offset');
      }
      // update the scrollspy object
      $('body').data('bs.scrollspy').options.offset = offset;
      $('body').scrollspy('refresh');
      // unbind click events and re-bind clicks to animate scrolling
      $scrollspy.unbind('click.scrollto');
      $scrollspy.bind('click.scrollto', 'ul li a', function(event) {
        event.preventDefault();
        $.scrollTo(event.target.hash, 500, {
          offset: -offset
        });
      });
    }
  }
}