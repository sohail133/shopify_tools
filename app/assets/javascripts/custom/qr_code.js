$(document).ready(function() {
  initializeSelect2();
  $('body').on('change', '.selected-logo, .qr-generate-code', function () {
    updateQrCode();
  });

  $('body').on('click', '.qr-frame-button', function(){
    var frame_id = $(this).attr('data-id');
    $('#qr-frame').val(frame_id);
  });

  $('body').on('click', '.download_qr_image', function(){
    var format = $(this).attr('img-ext');
    downloadImage(format);
  });
});
// Target Selection Section JS
const target_option = document.getElementsByClassName('target_url_product_options')[0]
const target_store = document.getElementsByClassName('target_url_store_home')[0]
const target_parent = document.getElementsByClassName('target_parent')[0]
const target_other = document.getElementsByClassName('target_url_other')[0]
const target_selection = document.getElementsByClassName('target_type_selection')[0]
const store_url = document.getElementById('store_url')
const previous_selected = $('select.target_type_selection option:selected').val();

target_option?.remove();
target_other?.remove();
target_store?.remove();

handleTargetOptions();

target_selection?.addEventListener('change', (e) => {
  handleTargetOptions();
});

function handleTargetOptions() {
  if (target_selection?.value === 'products_page') {
    target_parent?.appendChild(target_option)
    target_store?.remove();
    target_other?.remove();
    if (!window.location.href.includes('edit')) {
      initializeSelect2();
    }
  } else if (target_selection?.value === 'store_home') {
    target_option?.remove();
    target_other?.remove();
    target_parent?.appendChild(target_store)
    updateQrCode();
  } else if (target_selection?.value === 'other') {
      ``
    target_option?.remove();
    target_store?.remove();
    target_parent?.appendChild(target_other)
  } else {
    target_option?.remove();
    target_store?.remove();
    target_other?.remove();
  }
}

// QR Code Ajax call for all sections
function updateQrCode() {
  var formData = $('#qr_code_form').serialize();
  $.ajax({
    type: 'GET',
    url: "/qr_codes/generate_qr_code",
    data: formData
  })
}

function openFileInput() {
  const fileInput = document.getElementById('fileInput');
  fileInput.click();
}

const fileInput = document.getElementById('fileInput');
fileInput?.addEventListener('change', handleFileUpload);

function handleFileUpload(event) {
  var token = $('meta[name=csrf-token]').attr('content');
  const selectedFile = event.target.files[0];
  const shop_domain = $('#shop').val();

  if (selectedFile) {
    const allowedFormats = ['image/png', 'image/jpeg', 'image/jpg'];
    if (allowedFormats.indexOf(selectedFile.type) === -1) {
      alert('Only PNG, JPEG, and JPG files are allowed.');
      return;
    }

    var formData = new FormData();
    formData.append('image', selectedFile);
    formData.append('shop', shop_domain);
    $.ajax({
      type: 'POST',
      url: '/file_uploader',
      headers: {
        'X-CSRF-Token': token
      },
      data: formData,
      processData: false,
      contentType: false
    });
  }
}

//Download QR code images
function downloadImage(format) {
  var formData = $('#qr_code_form').serialize();

  var link = document.createElement('a');
  link.href = '/file_uploader/download_image?image=' + formData + '&format=' + format;
  link.click();
}
// Initialize Select2 for QR code.

function initializeSelect2(){
  $('.select-3-all').select2({
    templateResult: function(data) {
      if (!data.id) {
        return data.text;
      }
      var imageUrl = data.element.getAttribute('data-image');
      var optionText = data.text;
      return $('<span><img height="30px" width="30px" src="' + imageUrl + '" class="select-image" /> ' + optionText + '</span>');
    },
    templateSelection: function(data) {
      if (!data.id) {
        return data.text;
      }
      var imageUrl = data.element.getAttribute('data-image');
      var optionText = data.text;
      return $('<span><img height="30px" width="30px" src="' + imageUrl + '" class="select-image" /> ' + optionText + '</span>');
    }
  });
}

