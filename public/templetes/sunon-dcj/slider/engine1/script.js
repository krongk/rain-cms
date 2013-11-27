// -----------------------------------------------------------------------------------
//***********************************************
// Obfuscated by Javascript Obfuscator
// http://javascript-source.com
//***********************************************
function ws_stack(d, a, b) {
  var e = jQuery;
  var c = e("li", b);
  this.go = function (k, h, n, m) {
    var g = c.length > 2 ? (k - h + 1) % c.length : 1;
    if (Math.abs(n) >= 1) {
      g = (n > 0) ? 0 : 1
    }
    g = !! g ^ !! d.revers;
    var i = (d.revers ? -1 : 1) + "00%";
    var j = e("ul", b);
    var l = document.all ? 0 : "0%";
    var f = e(c.get(g ? k : h)).clone().css({
      position: "absolute",
      "z-index": 4,
      width: "100%",
      top: 0,
      left: ((g ? i : l))
    });
    if (g) {
      f.appendTo(b)
    } else {
      f.insertAfter(j)
    } if (!g) {
      j.hide().css({
        left: -k + "00%"
      });
      if (d.fadeOut) {
        j.stop(true, true).fadeIn(d.duration)
      } else {
        j.show()
      }
    } else {
      if (d.fadeOut) {
        j.fadeOut(d.duration)
      }
    }
    f.animate({
      left: (g ? l : i)
    }, d.duration, "easeInOutExpo", function () {
      if (g) {
        j.css({
          left: -k + "00%"
        }).stop(true, true).show()
      }
      e(this).remove()
    });
    return k
  }
}; 
//***********************************************
// Obfuscated by Javascript Obfuscator
// http://javascript-source.com
//***********************************************
jQuery("#wowslider-container1").wowSlider({
  effect: "stack",
  prev: "",
  next: "",
  duration: 33 * 100,
  delay: 50 * 100,
  width: 1055,
  height: 448,
  autoPlay: true,
  playPause: false,
  stopOnHover: false,
  loop: false,
  bullets: true,
  caption: true,
  captionEffect: "fade",
  controls: true,
  onBeforeStep: 0,
  images: 0
});