$(document).ready(function () {
    $('#iconLeft5').keyup(function () {
        ajaxRequestDescription();
    });

  $('#ecommerce-price-options').change(function () {
    ajaxRequestDescription();
  });
});

function ajaxRequestDescription() {
  var formData = $('#search-form').serialize();
  $.ajax({
    type: 'Get',
    url: '/descriptions',
    data: formData,
    success: function (response) {
        console.log(response);
    },
    error: function (error) {
        console.error(error);
    }
  });
}
