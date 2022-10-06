"use strict";

// Google Analytics for GA4
(function () {
	var s = document.createElement('script');
	s.async = true;
	s.src = "https://www.googletagmanager.com/gtag/js?id=G-LXQ6W8SL7X";
	document.head.appendChild(s);
})();
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', 'G-LXQ6W8SL7X');

// Google Analytics for UA
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-44831029-1', 'dencode.com');
ga('send', 'pageview');

(function (w, d) {
	$(d).ready(function () {
		$(d).on("click", "#loadFromFile", function () {
			gtag("event", "load_file");
			ga("send", "event", "value", "load-file");
		});
		
		$(d).on("click", "#loadFromQrcode", function () {
			gtag("event", "load_qrcode");
			ga("send", "event", "value", "load-qrcode");
		});
		
		$(d).on("click", ".popover-toggle.permanent-link", function () {
			var $this = $(this);
			if ($this.hasClass("active")) {
				var method = $this.closest("[data-dencode-method]").attr("data-dencode-method");
				gtag("event", "share", {
					method: "show",
					content_type: "link",
					item_id: method
				});
				ga("send", "event", "permanent-link", "show", method);
			}
		});
		
		/*
		$(d).on("click", "#permanentLink .share-link", function () {
			var $this = $(this);
			var shareMethod = $this.attr("data-share-method");
			ga("send", "event", "permanent-link", "share", shareMethod);
		});
		*/
		
		$(d).on("click", ".copy-to-clipboard", function () {
			var $this = $(this);
			var id = $this.attr("data-copy-id");
			gtag("event", "share", {
				method: "copy",
				content_type: "value",
				item_id: id
			});
			ga("send", "event", "value", "copy-to-clipboard", id);
		});
		
		$("#vLen").on("click", function () {
			var $this = $(this);
			if ($this.hasClass("active")) {
				gtag("event", "view_value_length");
				ga("send", "event", "v-len", "show");
			}
		});
		
		$("#follow").on("click", function () {
			var $this = $(this);
			if ($this.hasClass("active")) {
				gtag("event", "follow_on");
				ga("send", "event", "follow", "turn-on");
			} else {
				gtag("event", "follow_off");
				ga("send", "event", "follow", "turn-off");
			}
		});
		
		$("#decodedList").find("tr").on("selectrow.dencode", function () {
			var $row = $(this);
			var method = $row.attr("data-dencode-method");
			gtag("event", "select_item", {
				item_list_id: "decoded-list",
				items: [{item_id: method}]
			});
			ga("send", "event", "decoded-list", "select-row", method);
		});
		
		$("#encodedList").find("tr").on("selectrow.dencode", function () {
			var $row = $(this);
			var method = $row.attr("data-dencode-method");
			gtag("event", "select_item", {
				item_list_id: "encoded-list",
				items: [{item_id: method}]
			});
			ga("send", "event", "encoded-list", "select-row", method);
		});
	});
})(window, document);
