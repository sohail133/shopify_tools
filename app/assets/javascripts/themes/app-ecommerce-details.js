//  File Name: app-ecommerce-details.js
//  Description: App Ecommerce Details js.
//  ----------------------------------------------------------------------------------------------
//  Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
//  Author: PIXINVENT
//  Author URL: http://www.themeforest.net/user/pixinvent
// ================================================================================================
$(document).ready(function () {
  var mySwiper14 = new Swiper('.swiper-responsive-breakpoints', {
    slidesPerView: 5,
    spaceBetween: 55,
    // init: false,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    breakpoints: {
      1600: {
        slidesPerView: 4,
        spaceBetween: 55,
      },
      1300: {
        slidesPerView: 3,
        spaceBetween: 55,
      },
      900: {
        slidesPerView: 2,
        spaceBetween: 55,
      },
      768: {
        slidesPerView: 1,
        spaceBetween: 55,
      }
    },
    autoplay: {
      delay: 3000, // Set the delay between slides (in milliseconds)
      disableOnInteraction: false, // Autoplay will not be disabled when the user interacts with the slider
    },
  });
  // product color options
  $(".product-color-options li").on("click", function () {
    $this = $(this);
    $this.addClass('selected').siblings().removeClass('selected');
  })
})

// slider for card start


$(document).ready(function () {
  var mySwiper;

  function initSwiper() {
    var cardWidth = $('.grid-card').outerWidth();
    var slidesToShow;

    if (cardWidth >= 1600) {
      slidesToShow = 4;
    } else if (cardWidth >= 1300) {
      slidesToShow = 3;
    } else if (cardWidth >= 900) {
      slidesToShow = 2;
    } else {
      slidesToShow = 1;
    }

    mySwiper = new Swiper('.card-swiper', {
      slidesPerView: slidesToShow,
      spaceBetween: 55,
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      autoplay: {
        delay: 3000,
        disableOnInteraction: false,
      },
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
        type: 'custom', // Set the type to 'custom' to customize the pagination dots
        renderCustom: function (swiper, current, total) {
          var paginationHtml = '';
          for (var i = 0; i < total; i++) {
            var isActive = i === current - 1 ? 'active' : ''; // Set the 'active' class for the current slide
            paginationHtml += '<span class="swiper-pagination-bullet ' + isActive + '"></span>';
          }
          return paginationHtml;
        },
      },
    });

    // Initialize Swiper pagination
    mySwiper.pagination.update();

    // Set the active class on pagination dots when the slide changes
    mySwiper.on('slideChange', function () {
      var activeIndex = mySwiper.activeIndex;
      $('.swiper-pagination-bullet').removeClass('active');
      $('.swiper-pagination-bullet').eq(activeIndex).addClass('active');
    });
  }

  initSwiper();

  // Update Swiper on window resize
  $(window).on('resize', function () {
    mySwiper.destroy(true, true);
    initSwiper();
  });

  // product color options
  $(".product-color-options li").on("click", function () {
    $this = $(this);
    $this.addClass('selected').siblings().removeClass('selected');
  });
});
















// ends