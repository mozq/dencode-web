"use strict";

const _messageDefs = {
};
const _messagesTmpl = Hogan.compile($("#messagesTmpl").html());
let _latestMessage = null;


$("script[type='text/message']").each(function () {
	addMessageDefinition(newMessage(
			this.dataset.id,
			this.dataset.level,
			this.dataset.message,
			this.dataset.detail
			));
});


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
	_messageDefs[message.messageId] = formatMessage(message);
}

function getMessageDefinition(messageId) {
	let message = _messageDefs[messageId];
	if (!message) {
		message = _messageDefs["default.error"];
	}
	return message;
}

function setMessages(messages) {
	if (messages) {
		let messagesHtml = "";
		for (const message of messages) {
			_latestMessage = formatMessage(message);
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
