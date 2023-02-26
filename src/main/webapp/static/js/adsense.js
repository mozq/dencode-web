// Google AdSense
(function (window, document) {
	"use strict";
	
	// Lazy load adsbygoogle.js
	$(window).on("keydown.lzads click.lzads mousedown.lzads mousemove.lzads scroll.lzads", function() {
		$(window).off(".lzads");
		
		const s = document.createElement("script");
		s.src = "//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js";
		s.async = true;
		document.body.appendChild(s);
	});
	
	$(document).ready(function () {
		const $listRows = $(".dencoded-list").find("tr");
		
		// Init Ads
		$(".adsbygoogle").each(function () {
			(window.adsbygoogle = window.adsbygoogle || []).push({});
		});
		
		// Show AdMiddle
		$listRows.on("selectrow.dencode", function () {
			const $row = $(this);
			
			const $window = $(window);
			const $adBottom = $("#adBottom");
			if ($adBottom.offset().top > $window.scrollTop() + $window.height()) {
				// AdBottom is out of display
				
				if ($adBottom.children().length) {
					// Can load Ad
					
					// Show AdMiddle
					const $adMiddle = $("#adMiddle");
					if ($adMiddle.length) {
						$adMiddle.detach().insertAfter($row).show();
					} else {
						const adMiddleHtml = $("#adMiddleTmpl").html();
						$row.after(adMiddleHtml);
						(window.adsbygoogle = window.adsbygoogle || []).push({});
					}
				}
			}
		});

		// Hide AdMiddle
		$listRows.on("deselectrow.dencode", function () {
			const $adMiddle = $("#adMiddle");
			$adMiddle.hide();
		});
	});
})(window, document);
