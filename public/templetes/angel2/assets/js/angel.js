jQuery(document).ready(function($) {

	// Homepage carousel setup
	var homepage_carousel = $('#myCarousel');

	if( homepage_carousel.length ) {

		homepage_carousel.carousel({
			interval: false
		})

		homepage_carousel.touchwipe({
	          wipeLeft: function() { jQuery("#myCarousel").carousel('next'); },
	          wipeRight: function() { jQuery("#myCarousel").carousel('prev'); },
	          min_move_x: 20,
	          preventDefaultEvents: true
		});

	};

	// Contact map setup
	// visit: http://hpneo.github.io/gmaps/
	if ( $('#map').length ) {

		map = new GMaps({
		  div: '#map',
		  lat: -12.043333,
		  lng: -77.028333,
		  scrollwheel: false,
		});

		map.addMarker({
		  lat: -12.043333,
		  lng: -77.028333,
		  title: 'Your Company',
		  infoWindow: {
			  content: '<h4>Angel</h4><p>Place here any content you want</p>'
			}
		});

	};	
	

});