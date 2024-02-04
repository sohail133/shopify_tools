$(document).ready(function () {
  // $('.select2').select2();

  $('body').on('change', '.selling-products', function(){
    searchSelling($(this));
  });
});

function searchSelling(event) {
  var formData = $('.selling-form').serialize();
  $.ajax({
    type: 'Get',
    url: event.attr('data-url'),
    data: formData
  });
}
