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

(function (w, d) {
	$(d).ready(function () {
		$(d).on("click", "#loadFromFile", function () {
			gtag("event", "load_file");
		});
		
		$(d).on("click", "#loadFromQrcode", function () {
			gtag("event", "load_qrcode");
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
			}
		});
		
		$(d).on("click", ".copy-to-clipboard", function () {
			var $this = $(this);
			var id = $this.attr("data-copy-id");
			gtag("event", "share", {
				method: "copy",
				content_type: "value",
				item_id: id
			});
		});
		
		$(d).on("dencoded.dencode", function (ev, data, response) {
			if (data.value.length === 0) {
				return;
			}
			
			var latestMessage = getLatestMessage();
			gtag("event", "dencoded", {
				dencode_type: data.type,
				dencode_method: data.method,
				dencode_value_length: data.value.length,
				dencode_oe: data.oe,
				dencode_nl: data.nl,
				dencode_tz: data.tz,
				dencode_error: (latestMessage) ? true : false,
				dencode_message_id: (latestMessage) ? latestMessage.messageId : "",
				dencode_message: (latestMessage) ? latestMessage.message : ""
			});
		});
		
		$("#vLen").on("click", function () {
			var $this = $(this);
			if ($this.hasClass("active")) {
				gtag("event", "view_value_length");
			}
		});
		
		$("#follow").on("click", function () {
			var $this = $(this);
			if ($this.hasClass("active")) {
				gtag("event", "follow_on");
			} else {
				gtag("event", "follow_off");
			}
		});
		
		$("#decodedList").find("tr").on("selectrow.dencode", function () {
			var $row = $(this);
			var method = $row.attr("data-dencode-method");
			gtag("event", "select_item", {
				item_list_id: "decoded-list",
				items: [{item_id: method}]
			});
		});
		
		$("#encodedList").find("tr").on("selectrow.dencode", function () {
			var $row = $(this);
			var method = $row.attr("data-dencode-method");
			gtag("event", "select_item", {
				item_list_id: "encoded-list",
				items: [{item_id: method}]
			});
		});
	});
})(window, document);
