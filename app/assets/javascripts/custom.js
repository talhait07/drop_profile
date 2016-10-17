/* ===== Navbar Search ===== */

$('#navbar-search > a').on('click', function() {
    $('#navbar-search > a > i').toggleClass('fa-search fa-times');
    $("#navbar-search-box").toggleClass('show hidden animated fadeInUp');
    return false;
});

/* ===== Lost password form ===== */

$('.pwd-lost > .pwd-lost-q > a').on('click', function() {
    $(".pwd-lost > .pwd-lost-q").toggleClass("show hidden");
    $(".pwd-lost > .pwd-lost-f").toggleClass("hidden show animated fadeIn");
    return false;
});

/* ===== Thumbs rating ===== */

$('.rating .voteup').on('click', function () {
    var up = $(this).closest('div').find('.up');
    up.text(parseInt(up.text(),10) + 1);
    return false;
});
$('.rating .votedown').on('click', function () {
    var down = $(this).closest('div').find('.down');
    down.text(parseInt(down.text(),10) + 1);
    return false;
});

/* ===== Responsive Showcase ===== */

$('.responsive-showcase ul > li > i').on('click', function() {
    var device = $(this).data('device');
    $('.responsive-showcase ul > li > i').addClass("inactive");
    $(this).removeClass("inactive");
    $('.responsive-showcase img').removeClass("show");
    $('.responsive-showcase img').addClass("hidden");
    $('.responsive-showcase img' + device).toggleClass("hidden show");
    $('.responsive-showcase img' + device).addClass("animated fadeIn");
    return false;
});

/* ===== Services ===== */

$('.service-item').hover (function() {
    $(this).children("i").toggleClass("fa-rotate-90");
    return false;
});

/* ===== Theme Options ===== */

$('.b-theme-options__trigger').on('click', function() {
    $(this).toggleClass("hidden show");
    $('.b-theme-options__box').toggleClass("hidden show");
    return false;
});

$('.b-theme-options-box__close').on('click', function() {
    $('.b-theme-options__trigger').toggleClass("hidden show");
    $('.b-theme-options__box').toggleClass("hidden show");
    return false;
});

/* ===== Flash messages ===== */

setTimeout(function(){
  $('.alert').remove();
}, 10000);


$(document).ready(function(){
  /* ===== Reset Form ===== */
  $(document).on('click', '.reset-form', function(){
    $(this).closest('form')[0].reset();
    $(this).closest('form').find('.raty-level-input').raty({
      scoreName: function() { return $(this).attr('data-name'); },
      starHalf: '/assets/raty/star-half.png',
      starOff: '/assets/raty/star-off.png',
      starOn: '/assets/raty/star-on.png'
    });
  });

  /* ====== Social link share ====== */
  $(document).on('click', '.link_share', function(){
    window.open($(this).attr('href'),'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=400,width=600');
    return false;
  });
});