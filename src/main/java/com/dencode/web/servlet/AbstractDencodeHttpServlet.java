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

import javax.servlet.http.HttpServletResponse;

import org.mifmi.commons4j.app.web.servlet.AbstractBasicHttpServlet;
import org.mifmi.commons4j.config.Config;
import org.mifmi.commons4j.config.ResourceBundleConfig;
import org.mifmi.commons4j.web.servlet.HttpReqRes;
import org.mifmi.commons4j.web.servlet.MifmiServletException;

import com.dencode.web.model.ResponseModel;
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;

public abstract class AbstractDencodeHttpServlet extends AbstractBasicHttpServlet {

	private static final long serialVersionUID = 1L;
	
	private static Logger log = Logger.getLogger(AbstractDencodeHttpServlet.class.getName());
	
	@Override
	protected void doInit() throws Exception {
		Locale locale = getLocale(reqres());
		reqres().setAttribute("locale", locale);
		reqres().setAttribute("locales", getLocales(locale, reqres()));
		
		useConfigResource("config", "conf");
		useMessagesResource("messages", "msg");
		setResponseMessagesAttributeName("messages");
		
		Config defaultLocaleMessages = new ResourceBundleConfig("messages", getLocales(getDefaultLocale(reqres()), reqres()));
		reqres().setAttribute("defaultLocaleName", defaultLocaleMessages.get("locale.name"));
	}

	@Override
	protected boolean handleError(Throwable e, String level) throws Exception {

		if (level == null || level.equals("fatal")) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} else if (level.equals("error")) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} else if (level.equals("warn")) {
			log.log(Level.WARNING, e.getLocalizedMessage(), e);
		} else {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
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
	protected Locale locale() {
		return reqres().attribute("locale");
	}

	@Override
	protected List<Locale> locales() {
		return reqres().attribute("locales");
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
