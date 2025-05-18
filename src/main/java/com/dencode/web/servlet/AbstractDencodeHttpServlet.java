/*!
 * dencode-web
 * Copyright 2016 Mozq
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.dencode.web.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.dencode.web.model.Message;
import com.dencode.web.model.ResponseModel;
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletResponse;

public abstract class AbstractDencodeHttpServlet extends AbstractHttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Locale DEFAULT_LOCALE = Locale.ENGLISH;
	
	private static final ResourceBundle.Control CONTROL_NO_FALLBACK_LOCALE = new ResourceBundle.Control() {
		@Override
		public Locale getFallbackLocale(String baseName, Locale locale) {
			return null;
		}
	};
	
	private static final Logger LOGGER = Logger.getLogger(AbstractDencodeHttpServlet.class.getName());
	
	
	protected static ResourceBundle config() {
		return ResourceBundle.getBundle("config", Locale.ROOT);
	}
	
	private static ResourceBundle messages(List<Locale> locales) {
		for (Locale locale : locales) {
			try {
				return ResourceBundle.getBundle("messages", locale, CONTROL_NO_FALLBACK_LOCALE);
			} catch (MissingResourceException e) {
				continue;
			}
		}
		
		return ResourceBundle.getBundle("messages", DEFAULT_LOCALE);
	}
	
	@Override
	protected void doInit() throws Exception {
		String localeId = reqres().attribute("localeId");
		Locale locale = (localeId != null) ? Locale.forLanguageTag(localeId) : reqres().getLocale(null);
		if (locale == null) {
			locale = DEFAULT_LOCALE;
		}
		
		List<Locale> locales = toLocales(locale, reqres().getLocales(null));
		
		reqres().setAttribute("locale", locale);
		reqres().setAttribute("locales", locales);
		
		reqres().setAttribute("msg", messages(locales));
		
		ResourceBundle defaultLocaleMessages = messages(reqres().getLocales(locale));
		reqres().setAttribute("defaultLocaleName", defaultLocaleMessages.getString("locale.name"));
	}
	
	@Override
	protected void handleError(Throwable e) throws Exception {
		Message message;
		try {
			if (isCause(e, OutOfMemoryError.class)) {
				message = messageObject("data.capacity.error");
			} else {
				message = messageObject("default.error");
			}
		} catch (Exception e1) {
			message = null;
		}
		
		if (message != null) {
			addResponseMessage(message);
		}
		
		// Log error
		String level = (message == null) ? null : message.getLevel();
		switch (level) {
			case "warn" -> LOGGER.log(Level.WARNING, e.getLocalizedMessage(), e);
			default -> LOGGER.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
		
		// Response
		if (containsInHeader("Accept", "application/json")
				|| (containsInHeader("Accept", "*/*") && containsInHeader("Content-Type", "application/json"))) {
			responseAsJson(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, null);
		} else {
			response().sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
	
	protected Locale locale() {
		return reqres().attribute("locale");
	}
	
	protected List<Locale> locales() {
		return reqres().attribute("locales");
	}
	
	protected String message(String messageId, Object... params) {
		ResourceBundle bundle = reqres().attribute("msg");
		if (bundle == null) {
			return null;
		}
		
		String message = bundle.getString(messageId);
		if (message == null) {
			throw new IllegalArgumentException("Message not found : " + messageId);
		}
		
		message = formatMessage(message, params);
		
		return message;
	}
	
	protected Message messageObject(String messageId, Object... params) {
		ResourceBundle bundle = reqres().attribute("msg");
		if (bundle == null) {
			return null;
		}
		
		String message = bundle.getString(messageId);
		if (message == null) {
			throw new IllegalArgumentException("Message not found : " + messageId);
		}
		
		String level = bundle.getString(messageId + ".level");
		String detail = bundle.getString(messageId + ".detail");
		
		message = formatMessage(message, params);
		detail = formatMessage(detail, params);
		
		return new Message(messageId, level, message, detail);
	}
	
	private static String formatMessage(String message, Object... params) {
		if (message == null || params == null || params.length == 0) {
			return message;
		}
		
		return MessageFormat.format(message, params);
	}
	
	protected List<Message> getResponseMessages() {
		List<Message> messages = reqres().attribute("responseMessages");
		if (messages == null) {
			messages = new ArrayList<Message>();
			reqres().setAttribute("responseMessages", messages);
		}
		return messages;
	}
	
	protected void addResponseMessage(Message message) {
		getResponseMessages().add(message);
	}
	
	protected void addResponseMessage(String messageId, Object... params) {
		addResponseMessage(messageObject(messageId, params));
	}
	
	protected static String getBaseURL(HttpReqRes reqres) {
		String scheme = getRequestScheme(reqres);
		
		return scheme + "://" + reqres.request().getServerName();
	}
	
	protected static String getRequestScheme(HttpReqRes reqres) {
		String scheme = reqres.request().getHeader("X-Forwarded-Proto");
		if (scheme == null) {
			scheme = reqres.request().getScheme();
		}
		
		return scheme;
	}
	
	protected static String getRequestSubPath(HttpReqRes reqres) {
		String path = reqres.request().getServletPath();
		if (path == null) {
			path = "";
		} else {
			if (path.startsWith("/")) {
				path = path.substring(1);
			}
			String pathInfo = reqres.request().getPathInfo();
			if (pathInfo != null) {
				path += pathInfo;
			}
		}
		
		return path;
	}
	
	protected void responseAsJson(Object response) {
		responseAsJson(HttpServletResponse.SC_OK, response);
	}
	
	protected void responseAsJson(int statusCode, Object response) {
		
		ResponseModel responseModel = new ResponseModel();
		responseModel.setStatusCode(statusCode);
		responseModel.setMessages(getResponseMessages());
		responseModel.setResponse(response);

		HttpServletResponse res = response();
		
		res.setStatus(statusCode);
		res.setHeader("Content-Type", "application/json; charset=UTF-8");
		try (OutputStream out = res.getOutputStream()) {
			writeAsJson(out, responseModel);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	protected void writeAsJson(OutputStream out, Object value) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.setVisibility(PropertyAccessor.ALL, Visibility.NONE);
		mapper.setVisibility(PropertyAccessor.FIELD, Visibility.ANY);
		try {
			mapper.writeValue(out, value);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	private boolean containsInHeader(String headerName, String value) {
		String headerValue = reqres().header(headerName);
		if (headerValue == null) {
			return false;
		}
		
		if (!headerValue.contains(value)) {
			if (!headerValue.toLowerCase().contains(value.toLowerCase())) {
				return false;
			}
		}
		
		return true;
	}
	
	private static List<Locale> toLocales(Locale primaryLocale,  List<Locale> locales) {
		List<Locale> newLocales = new ArrayList<>(1 + locales.size());
		
		if (primaryLocale != null) {
			newLocales.add(primaryLocale);
		}
		
		newLocales.addAll(locales);
		
		return newLocales;
	}
	
	private static boolean isCause(Throwable t, Class<? extends Throwable> causeClass) {
		if (t == null) {
			return false;
		}
		
		if (causeClass.isInstance(t)) {
			return true;
		} else {
			return isCause(t.getCause(), causeClass);
		}
	}
}
