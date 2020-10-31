"use strict";

// Google AdSense
(function (w, d) {
	
	// Lazy load adsbygoogle.js
	$(w).on("keydown.lzads click.lzads mousedown.lzads mousemove.lzads touchstart.lzads scroll.lzads", function() {
		$(w).off(".lzads");
		
		var s = d.createElement("script");
		s.src = "//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js";
		s.async = true;
		d.body.appendChild(s);
	});
	
	$(d).ready(function () {
		var $listRows = $(".dencoded-list").find("tr");
		
		// Init Ads
		$(".adsbygoogle").each(function () {
			(w.adsbygoogle = w.adsbygoogle || []).push({});
		});
		
		// Show AdMiddle
		$listRows.on("selectrow.dencode", function () {
			var $row = $(this);
			
			var $window = $(w);
			var $adBottom = $("#adBottom");
			if ($adBottom.offset().top > $window.scrollTop() + $window.height()) {
				// AdBottom is out of display
				
				if ($adBottom.children().length) {
					// Can load Ad
					
					// Show AdMiddle
					var $adMiddle = $("#adMiddle");
					if ($adMiddle.length) {
						$adMiddle.detach().insertAfter($row).show();
					} else {
						var adMiddleHtml = $("#adMiddleTmpl").html();
						$row.after(adMiddleHtml);
						(w.adsbygoogle = w.adsbygoogle || []).push({});
					}
				}
			}
		});

		// Hide AdMiddle
		$listRows.on("deselectrow.dencode", function () {
			var $adMiddle = $("#adMiddle");
			$adMiddle.hide();
		});
	});
})(window, document);
