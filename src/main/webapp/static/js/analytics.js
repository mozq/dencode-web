// Google Analytics for GA4
((window, document) => {
	"use strict";
	
	const $ = new Commons(window, document);
	
	const s = document.createElement('script');
	s.async = true;
	s.src = "https://www.googletagmanager.com/gtag/js?id=G-LXQ6W8SL7X";
	document.head.appendChild(s);
	
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'G-LXQ6W8SL7X');
	
	
	$.onReady(function () {
		$.on("#loadFromFile", "click", function () {
			gtag("event", "load_file");
		});
		
		$.on("#loadFromQrcode", "click", function () {
			gtag("event", "load_qrcode");
		});
		
		$.on(".popover-toggle.permanent-link", "click", function () {
			if (this.classList.contains("active")) {
				const method = this.closest("[data-dencode-method]").getAttribute("data-dencode-method");
				gtag("event", "share", {
					method: "show",
					content_type: "link",
					item_id: method
				});
			}
		});
		
		$.on(".copy-to-clipboard", "click", function () {
			const id = this.getAttribute("data-copy-id");
			gtag("event", "share", {
				method: "copy",
				content_type: "value",
				item_id: id
			});
		});
		
		$.on(document, "dencode:dencoded", function (ev) {
			const data = ev.detail.requestData;
			
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
		
		$.on($.id("vLen"), "click", function () {
			if (this.classList.contains("active")) {
				gtag("event", "view_value_length");
			}
		});
		
		$.on($.id("follow"), "click", function () {
			if (this.classList.contains("active")) {
				gtag("event", "follow_on");
			} else {
				gtag("event", "follow_off");
			}
		});
		
		$.on($.all("#decodedList tr"), "dencode:select-row", function () {
			const method = this.getAttribute("data-dencode-method");
			gtag("event", "select_item", {
				item_list_id: "decoded-list",
				items: [{item_id: method}]
			});
		});
		
		$.on($.all("#encodedList tr"), "dencode:select-row", function () {
			const method = this.getAttribute("data-dencode-method");
			gtag("event", "select_item", {
				item_list_id: "encoded-list",
				items: [{item_id: method}]
			});
		});
	});
	
	function getLatestMessage() {
		const elMessage = $.one("#messages div.alert:last-of-type");
		if (!elMessage) {
			return null;
		}
		
		const mElm = elMessage.querySelector("strong");
		const dElm = elMessage.querySelector("p");
		
		return {
			messageId: elMessage.dataset.messageId,
			level: elMessage.dataset.level,
			message: mElm.innerText,
			detail: (dElm) ? dElm.innerText : ""
		};
	}
})(window, document);
