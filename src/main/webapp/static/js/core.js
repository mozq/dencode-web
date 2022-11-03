"use strict";

var _messageDefs = {
	"__default": newMessage(null, "fatal", "Error", "Error")
};
var _messagesTmpl = Hogan.compile($("#messagesTmpl").html());
var _latestMessage = null;

function handleAjaxResponse(data) {
	if (data.redirectUrl) {
		redirect(data.redirectUrl);
	}
	if (data.messages !== null && 0 < data.messages.length) {
		setMessages(data.messages);
		focusMessages();
	}
}

function focusMessages() {
	window.scroll({
		top: document.getElementById("messages").offsetTop -10,
		behavior: "smooth"
	});
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

function addMessageDefinition(message) {
	if (message.messageId) {
		_messageDefs[message.messageId] = formatMessage(message);
	} else {
		_messageDefs["__default"] = formatMessage(message);
	}
}

function getMessageDefinition(messageId) {
	if (messageId) {
		var message = _messageDefs[messageId];
		if (!message) {
			message = _messageDefs["__default"];
		}
		return message;
	} else {
		return _messageDefs["__default"];
	}
}

function setMessages(messages) {
	if (messages) {
		var messagesHtml = "";
		for (var i in messages) {
			_latestMessage = formatMessage(messages[i]);
			messagesHtml += _messagesTmpl.render(_latestMessage);
		}
		$("#messages").html(messagesHtml);
	}
}

function setMessage(message) {
	_latestMessage = formatMessage(message);
	$("#messages").html(_messagesTmpl.render(_latestMessage));
}

function addMessage(message) {
	_latestMessage = formatMessage(message);
	$("#messages").append(_messagesTmpl.render(_latestMessage));
}

function clearMessages() {
	_latestMessage = null;
	$("#messages").empty();
}

function getLatestMessage() {
	return _latestMessage;
}

function redirect(url) {
	window.location.href = url;
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
