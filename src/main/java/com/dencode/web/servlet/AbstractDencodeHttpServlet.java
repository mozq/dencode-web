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
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.http.HttpServletResponse;

import org.mifmi.commons4j.app.message.Message;
import org.mifmi.commons4j.app.message.MessageManager;
import org.mifmi.commons4j.app.message.MifmiMessageException;
import org.mifmi.commons4j.app.web.servlet.AbstractHttpServlet;
import org.mifmi.commons4j.config.Config;
import org.mifmi.commons4j.config.ResourceBundleConfig;
import org.mifmi.commons4j.util.ExceptionUtilz;
import org.mifmi.commons4j.web.servlet.HttpReqRes;
import org.mifmi.commons4j.web.servlet.MifmiServletException;

import com.dencode.web.model.ResponseModel;
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;

public abstract class AbstractDencodeHttpServlet extends AbstractHttpServlet {

	private static final long serialVersionUID = 1L;
	
	private static final Config CONFIG = new ResourceBundleConfig("config");
	
	private static final Logger LOGGER = Logger.getLogger(AbstractDencodeHttpServlet.class.getName());
	
	
	protected static Config config() {
		return CONFIG;
	}
	
	@Override
	protected void doInit() throws Exception {
		Locale locale = getLocale(reqres());
		setLocale(locale);

		reqres().setAttribute("conf", config().asMap());
		reqres().setAttribute("msg", messageManager().getMessageConfig().asMap());
		
		Config defaultLocaleMessages = new ResourceBundleConfig("messages", getLocales(getDefaultLocale(reqres()), reqres()));
		reqres().setAttribute("defaultLocaleName", defaultLocaleMessages.get("locale.name"));
	}
	
	protected boolean handleError(Throwable e, String level) throws Exception {

		if (level == null || level.equals("fatal")) {
			LOGGER.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} else if (level.equals("error")) {
			LOGGER.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} else if (level.equals("warn")) {
			LOGGER.log(Level.WARNING, e.getLocalizedMessage(), e);
		} else {
			LOGGER.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
		
		String acceptHeader = reqres().header("Accept");
		if (acceptHeader != null) {
			acceptHeader = acceptHeader.toLowerCase();
			if (acceptHeader.contains("application/json")) {
				responseAsJson(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, null);
				return false;
			}
		}
		
		response().sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		return false;
	}
	

	@Override
	protected boolean handleError(Throwable e) throws Exception {
		Message message;
		if (e instanceof MifmiMessageException) {
			message = ((MifmiMessageException)e).getMessageObject();
		} else {
			try {
				if (ExceptionUtilz.isCause(e, OutOfMemoryError.class)) {
					message = messageObject("data.capacity.error");
				} else {
					message = messageObject("default.error");
				}
			} catch (Exception e1) {
				message = null;
			}
		}
		if (message != null) {
			addResponseMessage(message);
		}
		return handleError(e, (message == null) ? null : message.getLevel());
	}
	
	protected void setLocale(Locale locale) {
		reqres().setAttribute("locale", locale);
		reqres().setAttribute("locales", getLocales(locale, reqres()));
		reqres().setAttribute("messageManager", null);
	}
	
	protected Locale locale() {
		return reqres().attribute("locale");
	}
	
	protected List<Locale> locales() {
		return reqres().attribute("locales");
	}
	
	protected MessageManager messageManager() {
		MessageManager messageManager = reqres().attribute("messageManager");
		if (messageManager == null) {
			messageManager = new MessageManager(new ResourceBundleConfig("messages", locales()));
			reqres().setAttribute("messageManager", messageManager);
		}
		return messageManager;
	}
	
	protected String message(String messageId) {
		return messageManager().loadMessage(messageId);
	}
	
	protected String message(String messageId, Object... params) {
		return messageManager().loadMessage(messageId, params);
	}
	
	protected Message messageObject(String messageId, Object... params) {
		return messageManager().loadMessageObject(messageId, params);
	}
	
	protected List<Message> getResponseMessages() {
		List<Message> messages = reqres().attribute("messages");
		if (messages == null) {
			messages = new ArrayList<Message>();
			reqres().setAttribute("messages", messages);
		}
		return messages;
	}
	
	protected void addResponseMessage(Message message) {
		getResponseMessages().add(message);
	}
	
	protected void addResponseMessage(String messageId, Object... params) {
		addResponseMessage(messageObject(messageId, params));
	}
	
	private static Locale getLocale(HttpReqRes reqres) {
		Locale attrLocale = reqres.attribute("locale");
		if (attrLocale != null) {
			return attrLocale;
		}
		
		return getDefaultLocale(reqres);
	}
	
	private static Locale getDefaultLocale(HttpReqRes reqres) {
		Locale locale = reqres.request().getLocale();
		if (locale != null) {
			return locale;
		}
		
		return Locale.getDefault();
	}
	
	private static List<Locale> getLocales(Locale primaryLocale, HttpReqRes reqres) {
		List<Locale> locales = new ArrayList<>();
		
		if (primaryLocale != null) {
			locales.add(primaryLocale);
		}
		
		Enumeration<?> localesEnum = reqres.request().getLocales();
		while (localesEnum.hasMoreElements()) {
			Locale locale = (Locale) localesEnum.nextElement();
			if (!locales.contains(locale)) {
				locales.add(locale);
			}
		}
		
		return locales;
	}
	
	protected static Locale toLocale(String localeId) {
		int idx = localeId.indexOf('-');
		if (idx == -1) {
			return new Locale(localeId);
		}
		
		return new Locale(localeId.substring(0, idx), localeId.substring(idx + 1));
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
			throw new MifmiServletException(e);
		}
	}

	protected void writeAsJson(OutputStream out, Object value) {
		ObjectMapper mapper = new ObjectMapper();
		mapper.setVisibility(PropertyAccessor.ALL, Visibility.NONE);
		mapper.setVisibility(PropertyAccessor.FIELD, Visibility.ANY);
		try {
			mapper.writeValue(out, value);
		} catch (IOException e) {
			throw new MifmiServletException(e);
		}
	}
}
