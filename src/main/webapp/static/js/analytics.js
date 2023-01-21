// Google Analytics for GA4
(function (window, document) {
	"use strict";
	
	const s = document.createElement('script');
	s.async = true;
	s.src = "https://www.googletagmanager.com/gtag/js?id=G-LXQ6W8SL7X";
	document.head.appendChild(s);
	
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'G-LXQ6W8SL7X');
	
	
	$(document).ready(function () {
		$(document).on("click", "#loadFromFile", function () {
			gtag("event", "load_file");
		});
		
		$(document).on("click", "#loadFromQrcode", function () {
			gtag("event", "load_qrcode");
		});
		
		$(document).on("click", ".popover-toggle.permanent-link", function () {
			const $this = $(this);
			if ($this.hasClass("active")) {
				const method = $this.closest("[data-dencode-method]").attr("data-dencode-method");
				gtag("event", "share", {
					method: "show",
					content_type: "link",
					item_id: method
				});
			}
		});
		
		$(document).on("click", ".copy-to-clipboard", function () {
			const $this = $(this);
			const id = $this.attr("data-copy-id");
			gtag("event", "share", {
				method: "copy",
				content_type: "value",
				item_id: id
			});
		});
		
		$(document).on("dencoded.dencode", function (ev, data, response) {
			if (data.value.length === 0) {
				return;
			}
			
			const latestMessage = getLatestMessage();
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
			const $this = $(this);
			if ($this.hasClass("active")) {
				gtag("event", "view_value_length");
			}
		});
		
		$("#follow").on("click", function () {
			const $this = $(this);
			if ($this.hasClass("active")) {
				gtag("event", "follow_on");
			} else {
				gtag("event", "follow_off");
			}
		});
		
		$("#decodedList").find("tr").on("selectrow.dencode", function () {
			const $row = $(this);
			const method = $row.attr("data-dencode-method");
			gtag("event", "select_item", {
				item_list_id: "decoded-list",
				items: [{item_id: method}]
			});
		});
		
		$("#encodedList").find("tr").on("selectrow.dencode", function () {
			const $row = $(this);
			const method = $row.attr("data-dencode-method");
			gtag("event", "select_item", {
				item_list_id: "encoded-list",
				items: [{item_id: method}]
			});
		});
	});
	
	function getLatestMessage() {
		const messageElm = document.querySelector("#messages div.alert:last-of-type");
		if (!messageElm) {
			return null;
		}
		
		const mElm = messageElm.querySelector("strong");
		const dElm = messageElm.querySelector("p");
		
		return {
			messageId: messageElm.dataset.messageId,
			level: messageElm.dataset.level,
			message: mElm.innerText,
			detail: (dElm) ? dElm.innerText : ""
		};
	}
})(window, document);
