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


import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Collection;
import java.util.Collections;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

public class HttpReqRes {
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private List<Locale> locales;
	private boolean isMultipartRequest;
	private Map<String, String[]> parameterMap;
	private Map<String, Part[]> parameterPartMap;

	public HttpReqRes(HttpServletRequest req, HttpServletResponse res) {
		this.request = req;
		this.response = res;
		
		this.locales = null;
		
		String contentType = req.getContentType();
		this.isMultipartRequest = (contentType != null && contentType.startsWith("multipart/form-data"));
		
		this.parameterMap = null;
		this.parameterPartMap = null;
	}


	public HttpServletRequest request() {
		return this.request;
	}

	public HttpServletResponse response() {
		return this.response;
	}
	
	public boolean isMultipartRequest() {
		return this.isMultipartRequest;
	}
	
	public Locale getLocale(Locale defaultLocale) {
		if (header("Accept-Language") == null) {
			return defaultLocale;
		} else {
			return request().getLocale();
		}
	}
	
	public List<Locale> getLocales(Locale defaultLocale) {
		if (this.locales == null) {
			if (header("Accept-Language") == null) {
				this.locales = List.of();
			} else {
				this.locales = Collections.list(request().getLocales());
			}
		}
		
		if (this.locales.isEmpty() && defaultLocale != null) {
			return List.of(defaultLocale);
		} else {
			return this.locales;
		}
	}
	
	public String header(String name) {
		return request().getHeader(name);
	}
	
	public String[] headers(String name) {
		Enumeration<String> headers = request().getHeaders(name);
		return (String[])Collections.list(headers).toArray();
	}
	
	public Set<String> headerNames() {
		Enumeration<String> headerNames = request().getHeaderNames();
		return Collections.unmodifiableSet(new LinkedHashSet<>(Collections.list(headerNames)));
	}
	
	private Map<String, String[]> paramMap() {
		if (this.parameterMap == null) {
			Map<String, String[]> map = request().getParameterMap();
			
			this.parameterMap = Collections.unmodifiableMap(map);
		}
		return this.parameterMap;
	}
	
	public Set<String> paramNames() {
		if (isMultipartRequest()) {
			return paramPartNames();
		} else {
			return paramMap().keySet();
		}
	}
	
	public boolean hasParam(String name) {
		if (isMultipartRequest()) {
			return hasParamPart(name);
		} else {
			if (name == null) {
				return false;
			}
			
			if (paramMap().containsKey(name)) {
				return true;
			}
			for (String key : paramMap().keySet()) {
				if (key.equalsIgnoreCase(name)) {
					return true;
				}
			}
			
			return false;
		}
	}

	public String param(String name) {
		return param(name, null);
	}
	
	public String param(String name, String defaultValue) {
		if (isMultipartRequest()) {
			return paramPartAsString(name, defaultValue);
		} else {
			if (name == null) {
				return defaultValue;
			}
			
			if (!hasParam(name)) {
				return defaultValue;
			}
			
			return request().getParameter(name);
		}
	}

	public String[] params(String name) {
		return params(name, null);
	}
	
	public String[] params(String name, String[] defaultValue) {
		if (isMultipartRequest()) {
			return paramPartsAsString(name, defaultValue);
		} else {
			if (!hasParam(name)) {
				return defaultValue;
			}
			
			return request().getParameterValues(name);
		}
	}
	
	private Collection<Part> paramParts() {
		Collection<Part> parts;
		try {
			parts = request().getParts();
		} catch (IOException | ServletException e) {
			throw new RuntimeException(e);
		}
		return parts;
	}
	
	private Map<String, Part[]> paramPartMap() {
		if (this.parameterPartMap == null) {
			Collection<Part> paramParts = paramParts();
			
			Map<String, Part[]> map = new LinkedHashMap<>(paramParts.size());
			for (Part paramPart : paramParts) {
				String name = paramPart.getName();
				Part[] parts = map.get(name);
				if (parts == null) {
					parts = new Part[] { paramPart };
				} else {
					Part[] newParts = new Part[parts.length + 1];
					System.arraycopy(parts, 0, newParts, 0, parts.length);
					newParts[parts.length] = paramPart;
					parts = newParts;
				}
				map.put(name, parts);
			}
			
			this.parameterPartMap = Collections.unmodifiableMap(map);
		}
		
		return this.parameterPartMap;
	}
	
	public Set<String> paramPartNames() {
		return paramPartMap().keySet();
	}
	
	public boolean hasParamPart(String name) {
		if (name == null) {
			return false;
		}
		
		if (paramPartMap().containsKey(name)) {
			return true;
		}
		for (String key : paramPartMap().keySet()) {
			if (key.equalsIgnoreCase(name)) {
				return true;
			}
		}
		
		return false;
	}
	
	public Part paramPart(String name) {
		return paramPart(name, null);
	}
	
	public Part paramPart(String name, Part defaultValue) {
		if (name == null) {
			return defaultValue;
		}
		
		if (!hasParamPart(name)) {
			return defaultValue;
		}
		
		Part part;
		try {
			part = request().getPart(name);
		} catch (IOException | ServletException e) {
			throw new RuntimeException(e);
		}
		
		return part;
	}
	
	public Part[] paramParts(String name) {
		return paramParts(name, null);
	}
	
	public Part[] paramParts(String name, Part[] defaultValue) {
		if (name == null) {
			return defaultValue;
		}
		
		Part[] parts = paramPartMap().get(name);
		if (parts != null) {
			return parts;
		}
		for (Map.Entry<String, Part[]> keyValue : paramPartMap().entrySet()) {
			if (keyValue.getKey().equalsIgnoreCase(name)) {
				return keyValue.getValue();
			}
		}

		return defaultValue;
	}
	
	public String paramPartAsString(String name) {
		return paramPartAsString(name, null);
	}
	
	public String paramPartAsString(String name, String defaultValue) {
		Part part = paramPart(name, null);
		if (part == null) {
			return defaultValue;
		}
		
		return partToString(part, request().getCharacterEncoding());
	}
	
	public String[] paramPartsAsString(String name) {
		return paramPartsAsString(name, null);
	}
	
	public String[] paramPartsAsString(String name, String[] defaultValue) {
		Part[] parts = paramParts(name, null);
		if (parts == null) {
			return defaultValue;
		}
		
		int size = parts.length;
		String[] strs = new String[size];
		for (int i = 0; i < size; i++) {
			strs[i] = partToString(parts[i], request().getCharacterEncoding());
		}
		
		return strs;
	}
	
	private static String partToString(Part part, String charset) {
		if (part.getSize() == 0) {
			return "";
		}
		
		try (InputStream is = part.getInputStream()) {
			ByteArrayOutputStream result = new ByteArrayOutputStream((int)part.getSize());
			byte[] buffer = new byte[1024];
			for (int length; (length = is.read(buffer)) != -1; ) {
				result.write(buffer, 0, length);
			}
			
			return result.toString(charset);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	public String pathInfo() {
		return request().getPathInfo();
	}

	public String pathParam() {
		return pathParam(null);
	}
	
	public String pathParam(String defaultValue) {
		String pathInfo = pathInfo();
		if (pathInfo == null || pathInfo.isEmpty() || pathInfo.equals("/")) {
			return defaultValue;
		}
		
		String pathParam;
		if (pathInfo.startsWith("/")) {
			pathParam = pathInfo.substring(1);
		} else {
			pathParam = pathInfo;
		}
		
		return pathParam;
	}

	public String[] pathParams() {
		return pathParams(null);
	}
	
	public String[] pathParams(String[] defaultValue) {
		String pathParam = pathParam(null);
		if (pathParam == null) {
			return defaultValue;
		}
		
		String[] pathParams = pathParam.split("/");
		
		return pathParams;
	}
	

	public String cookie(String name) {
		return cookie(name, null);
	}
	
	public String cookie(String name, String defaultValue) {
		return cookie(name, defaultValue, false);
	}
	
	public String cookie(String name, String defaultValue, boolean rawValue) {
		Cookie[] cookies = request().getCookies();
		if (cookies == null) {
			return defaultValue;
		}
		
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(name)) {
				String value = cookie.getValue();
				if (rawValue || value == null || value.isEmpty()) {
					return value;
				} else {
					try {
						return URLDecoder.decode(value, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						return value;
					}
				}
			}
		}
		
		return defaultValue;
	}
	
	public void setCookie(String name, String value) {
		setCookie(name, value, -1);
	}

	public void setCookie(String name, String value, int expiry) {
		setCookie(name, value, expiry, false, false);
	}
	
	public void setCookie(String name, String value, int expiry, String path, String domain) {
		setCookie(name, value, expiry, false, false, path, domain);
	}
	
	public void setCookie(String name, String value, int expiry, boolean httpOnly, boolean secure) {
		setCookie(name, value, expiry, httpOnly, secure, null, null);
	}
	
	public void setCookie(String name, String value, int expiry, boolean httpOnly, boolean secure, String path, String domain) {
		Cookie cookie = new Cookie(name, (value == null) ? "" : value);
		cookie.setMaxAge(expiry);
		cookie.setHttpOnly(httpOnly);
		cookie.setSecure(secure);
		if (path != null) {
			cookie.setPath(path);
		}
		if (domain != null) {
			cookie.setDomain(domain);
		}
		setCookie(cookie);
	}
	
	public void setCookie(Cookie cookie) {
		response().addCookie(cookie);
	}
	
	public void removeCookie(String name) {
		setCookie(name, "", 0);
	}
	
	public HttpSession getSession(boolean create) {
		return request().getSession(create);
	}
	
	@SuppressWarnings("unchecked")
	public <T> T session(String name) {
		return (T)getSession(true).getAttribute(name);
	}
	
	public void setSession(String name, Object value) {
		getSession(true).setAttribute(name, value);
	}
	
	public void removeSession(String name) {
		getSession(true).removeAttribute(name);
	}
	
	@SuppressWarnings("unchecked")
	public <T> T attribute(String name) {
		return (T)request().getAttribute(name);
	}
	
	public void setAttribute(String name, Object value) {
		request().setAttribute(name, value);
	}
	
	public void removeAttribute(String name) {
		request().removeAttribute(name);
	}
	
	public void forward(String path) {
		try {
			request().getRequestDispatcher(path).forward(request(), response());
		} catch (ServletException | IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	public void redirect(String path) {
		try {
			response().setStatus(HttpServletResponse.SC_FOUND);
			response().setHeader("Location", path);
			response().flushBuffer(); 
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
}