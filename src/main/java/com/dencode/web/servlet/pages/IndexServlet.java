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
package com.dencode.web.servlet.pages;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.function.Function;
import java.util.stream.Collectors;

import com.dencode.logic.DencodeMapper;
import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("")
public class IndexServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Map<String, String> TZ_MAP;
	static {
		Instant now = Instant.now();
		Map<String, String> tzMap = ZoneId.getAvailableZoneIds().stream()
				.collect(Collectors.toMap(
					Function.identity(),
					id -> {
						ZoneId zone = ZoneId.of(id);
						ZoneOffset offset = zone.getRules().getStandardOffset(now);
						String offsetId = offset.getId();
						if (offsetId.equals("Z")) {
							offsetId = "+00:00";
						}
						
						String name = offsetId + " " + id;
						
						return name;
					}
				));
		
		TZ_MAP = tzMap.entrySet().stream()
				.sorted(Map.Entry.comparingByValue())
				.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (x, y) -> y, LinkedHashMap::new));
	}
	
	private static final Map<String, String> SUPPORTED_LOCALE_MAP;
	static {
		String[] supportedLocaleIds = config().getString("locales").split(",");
		
		SUPPORTED_LOCALE_MAP = Arrays.stream(supportedLocaleIds)
				.collect(Collectors.toMap(
					Function.identity(),
					id -> ResourceBundle.getBundle("messages", Locale.forLanguageTag(id)).getString("locale.name"),
					(x, y) -> y,
					LinkedHashMap::new
				));
	}
	
	private static final String DENCODER_DEFS_JSON;
	static {
		Collection<Dencoder> dencoderDefinitions = DencodeMapper.getAllDencoderDefinitions();
		
		StringBuilder sb = new StringBuilder();
		boolean notFirst = false;
		sb.append('{');
		for (Dencoder dencoder : dencoderDefinitions) {
			if (notFirst) {
				sb.append(',');
			}
			notFirst = true;
			
			sb.append('"').append(dencoder.method()).append('"');
			sb.append(':');
			sb.append('{');
			sb.append('"').append("hasEncoder").append('"').append(':').append(dencoder.hasEncoder()).append(',');
			sb.append('"').append("hasDecoder").append('"').append(':').append(dencoder.hasDecoder()).append(',');
			sb.append('"').append("useOe").append('"').append(':').append(dencoder.useOe()).append(',');
			sb.append('"').append("useNl").append('"').append(':').append(dencoder.useNl()).append(',');
			sb.append('"').append("useTz").append('"').append(':').append(dencoder.useTz());
			sb.append('}');
		}
		sb.append('}');
		
		DENCODER_DEFS_JSON = sb.toString();
	}
	
	@Override
	protected void doGet() throws Exception {
		String v = reqres().param("v", "");
		String oe = "UTF-8";
		String oex = message("oe.ext.default");
		String nl = "lf";
		String tz = "UTC";
		
		String type = reqres().attribute("type");
		if (type == null) {
			type = "all";
		}

		String method = reqres().attribute("method");
		if (method == null) {
			method = "all.all";
		}
		
		Dencoder dencoder = DencodeMapper.getDencoderDefinition(type, method);
		if (dencoder == null) {
			reqres().response().sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		reqres().setAttribute("type", type);
		reqres().setAttribute("method", method);
		reqres().setAttribute("v", v);
		reqres().setAttribute("oe", oe);
		reqres().setAttribute("oex", oex);
		reqres().setAttribute("nl", nl);
		reqres().setAttribute("tz", tz);
		reqres().setAttribute("tzMap", TZ_MAP);
		
		reqres().setAttribute("baseURL", getBaseURL(reqres()));
		
		if (reqres().attribute("basePath") == null) {
			String basePath = request().getContextPath();
			String localeId = reqres().attribute("localeId");
			if (localeId != null && !localeId.isEmpty()) {
				basePath = basePath + "/" + localeId;
			}
			reqres().setAttribute("basePath",  basePath);
		}
		
		if (reqres().attribute("currentPath") == null) {
			reqres().setAttribute("currentPath", "");
		}
		
		reqres().setAttribute("hasEncoder", dencoder.hasEncoder());
		reqres().setAttribute("hasDecoder", dencoder.hasDecoder());
		
		reqres().setAttribute("types", DencodeMapper.getAvailableTypesOf(type));
		reqres().setAttribute("methods", DencodeMapper.getAvailableMethodsOf(type, method));
		reqres().setAttribute("dencoderDefsJson", DENCODER_DEFS_JSON);
		
		reqres().setAttribute("supportedLocaleMap", SUPPORTED_LOCALE_MAP);
		
		
		forward("/WEB-INF/pages/index.jsp");
	}
}
