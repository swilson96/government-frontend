//= require_tree ./vendor
//= require_tree ./modules

var $document = $(document);

$document.ready(function () {
  if ($document.find('.js-tabs').length) {
    $document.tabs({
      scrollOnload: true
    });
  }
});
