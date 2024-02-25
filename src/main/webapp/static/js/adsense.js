// Google AdSense
(function (window, document) {
	"use strict";
	
	const $ = new Commons(window, document);
	
	// Lazy load adsbygoogle.js
	const lazyLoadAdFn = $.on(window, "keydown click mousedown mousemove scroll", function () {
		$.off(window, "keydown click mousedown mousemove scroll", lazyLoadAdFn);
		
		const s = document.createElement("script");
		s.src = "//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js";
		s.async = true;
		document.body.appendChild(s);
	});
	
	$.onReady(function () {
		const elListRows = $.all(".dencoded-list tr");
		
		// Init Ads
		$.all(".adsbygoogle").forEach(() => {
			(window.adsbygoogle = window.adsbygoogle || []).push({});
		});
		
		// Show AdMiddle
		$.on(elListRows, "dencode:select-row", function () {
			const elAdBottom = $.id("adBottom");
			
			if (!elAdBottom.getElementsByClassName("adsbygoogle")[0]?.hasChildNodes()) {
				// Cannot load Ad
				return;
			}
			
			const adBottomRect = elAdBottom.getBoundingClientRect();
			if (adBottomRect.top < window.innerHeight && 0 < adBottomRect.bottom) {
				// AdBottom is in viewport
				return;
			}
			
			// Show AdMiddle
			const elAdMiddle = $.id("adMiddle");
			if (elAdMiddle) {
				this.parentNode.insertBefore(elAdMiddle, this.nextElementSibling);
				elAdMiddle.style.display = "";
			} else {
				const adMiddleHtml = $.id("adMiddleTmpl").innerHTML;
				
				const elTmpl = document.createElement("template");
				elTmpl.innerHTML = adMiddleHtml;
				const elAdMiddleNew = elTmpl.content;
				
				this.parentNode.insertBefore(elAdMiddleNew, this.nextElementSibling);
				(window.adsbygoogle = window.adsbygoogle || []).push({});
			}
		});
		
		// Hide AdMiddle
		$.on(elListRows, "dencode:deselect-row", function () {
			const elAdMiddle = $.id("adMiddle");
			if (elAdMiddle) {
				elAdMiddle.style.display = "none";
			}
		});
	});
})(window, document);
