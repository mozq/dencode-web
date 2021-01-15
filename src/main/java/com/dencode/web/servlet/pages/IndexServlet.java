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
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;

import org.mifmi.commons4j.config.ConfigNotFoundException;
import org.mifmi.commons4j.util.DateUtilz;

import com.dencode.web.logic.CommonLogic;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/index")
public class IndexServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet() throws Exception {
		String v = reqres().param("v", "");
		String oe = CommonLogic.mapShortCharsetName(reqres().param("oe", reqres().cookie("oe", "UTF-8")));
		String oex = (!oe.startsWith("UTF")) ? oe : reqres().cookie("oex", message("oe.ext.default"));
		String nl = reqres().param("nl", reqres().cookie("nl", ""));
		String tz = reqres().param("tz", reqres().cookie("tz", null));
		if (tz == null) {
			TimeZone timeZone = DateUtilz.localeToTimeZone(request().getLocale());
			if (timeZone == null) {
				tz = "UTC";
			} else {
				tz = timeZone.getID();
			}
		}
		
		String type = reqres().attribute("type");
		if (type == null) {
			type = "all";
		}

		String method = reqres().attribute("method");
		if (method == null) {
			method = "all";
		}
		
		Set<String> tzList = ZoneId.getAvailableZoneIds();
		Map<String, String> tzMap = new HashMap<String, String>(tzList.size());
		Instant now = Instant.now();
		for (String id : tzList) {
			if (id.startsWith("Etc/")) {
				continue;
			}
			
			ZoneId zone = ZoneId.of(id);
			ZoneOffset offset = zone.getRules().getStandardOffset(now);
			String offsetId = offset.getId();
			if (offsetId.equals("Z")) {
				offsetId = "±00:00";
			}
			
			String name = offsetId + " " + id;
			
			tzMap.put(id, name);
		}
		List<Map.Entry<String, String>> tzMapList = new ArrayList<Map.Entry<String, String>>(tzMap.entrySet());
		Collections.sort(tzMapList, new Comparator<Map.Entry<String, String>>() {
			@Override
			public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
				String v1 = o1.getValue();
				String v2 = o2.getValue();
				return v1.compareTo(v2);
			}
		});
		
		reqres().setCookie("oe", oe, -1, "/", null);
		reqres().setCookie("oex", oex, -1, "/", null);
		reqres().setCookie("nl", nl, -1, "/", null);
		reqres().setCookie("tz", tz, -1, "/", null);
		
		reqres().setAttribute("type", type);
		reqres().setAttribute("method", method);
		reqres().setAttribute("v", v);
		reqres().setAttribute("oe", oe);
		reqres().setAttribute("oex", oex);
		reqres().setAttribute("nl", nl);
		reqres().setAttribute("tz", tz);
		reqres().setAttribute("tzMap", tzMapList);
		
		if (reqres().attribute("basePath") == null) {
			String basePath = request().getContextPath();
			String localeName = reqres().attribute("localeName");
			if (localeName != null && !localeName.isEmpty()) {
				basePath = basePath + "/" + localeName;
			}
			reqres().setAttribute("basePath",  basePath);
		}
		
		if (reqres().attribute("currentPath") == null) {
			reqres().setAttribute("currentPath", "");
		}
		
		try {
			reqres().setAttribute("useOe", config().getAsBoolean(method + ".useOe"));
			reqres().setAttribute("useNl", config().getAsBoolean(method + ".useNl"));
			reqres().setAttribute("useTz", config().getAsBoolean(method + ".useTz"));
			
			reqres().setAttribute("hasEncoded", config().getAsBoolean(method + ".hasEncoded"));
			reqres().setAttribute("hasDecoded", config().getAsBoolean(method + ".hasDecoded"));
		} catch (ConfigNotFoundException e) {
			reqres().response().sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		forward("/WEB-INF/pages/index.jsp");
	}
}
