"use strict";

var _defaultErrorMessage = newMessage(null, "fatal", "Error", "Error");
var _messagesTmpl = Hogan.compile($("#messagesTmpl").html());

function handleAjaxResponse(data) {
	if (data.redirectUrl) {
		redirect(data.redirectUrl);
	}
	if (data.messages !== null && 0 < data.messages.length) {
		setMessages(data.messages);
		focusMessages();
	}
}
function handleAjaxSuccess(data, dataType) {
	handleAjaxResponse(data);
}
function handleAjaxError(xhr, textStatus, errorThrown) {
	try {
		var data = $.parseJSON(xhr.responseText);
		handleAjaxResponse(data);
	} catch (e) {
		setMessage(_defaultErrorMessage);
		focusMessages();
	}
}
function focusMessages() {
	jumpInnerPageId("messages", -10, false);
}

function toMessageType(level) {
	switch (level) {
	case "success":
		return "success";
	case "info":
		return "info";
	case "warn":
		return "warning";
	case "error": //FALLTHRU
	case "fatal": //FALLTHRU
	default:
		return "danger";
	}
}
function newMessage(messageId, level, message, detail) {
	return {
		"messageId": messageId,
		"level": level,
		"type": toMessageType(level),
		"message": message,
		"detail": detail
	};
}
function formatMessage(message) {
	if (message.type) {
		return message;
	} else {
		return newMessage(
				message.messageId,
				message.level,
				message.message,
				message.detail
				);
	}
}
function setDefaultErrorMessage(message) {
	_defaultErrorMessage = message;
}
function setMessages(messages) {
	if (messages) {
		var messagesHtml = "";
		for (var i in messages) {
			messagesHtml += _messagesTmpl.render(formatMessage(messages[i]));
		}
		$("#messages").html(messagesHtml);
	}
}
function setMessage(message) {
	$("#messages").html(_messagesTmpl.render(formatMessage(message)));
}
function addMessage(message) {
	$("#messages").append(_messagesTmpl.render(formatMessage(message)));
}
function clearMessages() {
	$("#messages").empty();
}

function redirect(url) {
	window.location.href = url;
}

function jumpInnerPageId(id, offset, changeUrlHash) {
    $("html, body").stop().animate(
    		{ scrollTop: $("#" + id).offset().top + offset },
    		100,
    		"swing",
    		function () {
    			if (changeUrlHash) {
    		        window.location.hash = "";
    		        window.location.hash = id;
    			}
    		});
}

function escapeHTML(value) { 
	return value.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;")
			.replace(/"/g, "&quot;")
			.replace(/'/g, "&#39;");
}

function br(value) {
	if (value == null) {
		return value;
	}
	return value.replace(/\n/g, "<br />");
}

function separateThousand(num) {
	var strNum = String(num);
	
	var decPos = strNum.indexOf(".");
	var dec = null;
	if (0 <= decPos) {
		dec = strNum.substring(decPos);
		strNum = strNum.substring(0, decPos);
	}
	
	if (3 < strNum.length) {
		strNum = strNum.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
	}
	
	if (dec !== null) {
		strNum += dec;
	}
	
	return strNum;
}
