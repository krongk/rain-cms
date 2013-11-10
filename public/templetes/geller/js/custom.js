/* Carousel for image */
$('.carousel').carousel();


/* Carousel */

$('#carousel_container').carouFredSel({
	responsive: true,
	width: '100%',
   direction: 'right',
	scroll: {
      items: 4,
      delay: 2000,
      duration: 1000
   },
   prev : {
      button	: "#car_prev",
      key		: "left"
   },
   next : {
      button	: "#car_next",
      key		: "right"
   },
	items: {	
		visible: {
         min: 1,
			max: 4
		}
	}
});

/* LiquidSlider */

$(function(){
     $('#slider-id').liquidSlider();
});


/* prettyPhoto Gallery */

jQuery(".prettyphoto").prettyPhoto({
   overlay_gallery: false, social_tools: false
});

/* Isotype */

// cache container
var $container = $('#portfolio');
// initialize isotope
$container.isotope({
  // options...
});

// filter items when filter link is clicked
$('#filters a').click(function(){
  var selector = $(this).attr('data-filter');
  $container.isotope({ filter: selector });
  return false;
});               