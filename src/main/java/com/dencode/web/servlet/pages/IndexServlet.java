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

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.annotation.WebServlet;

import org.mifmi.commons4j.util.DateUtilz;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/index")
public class IndexServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet() throws Exception {
		String v = reqres().param("v", "");
		String oe = reqres().param("oe", reqres().cookie("oe", ""));
		String oex = reqres().cookie("oex", message("label.oe.ext.default"));
		String nl = reqres().param("nl", reqres().cookie("nl", ""));
		String tz = reqres().param("tz", reqres().cookie("tz", null));
		if (tz == null) {
			tz = DateUtilz.localeToTimeZone(request().getLocale()).getID();
		}
		
		String type = reqres().attribute("type");
		if (type == null) {
			type = "all";
		}

		String method = reqres().attribute("method");
		if (method == null) {
			method = "all";
		}
		
		String[] tzList = TimeZone.getAvailableIDs();
		Map<String, String> tzMap = new HashMap<String, String>(tzList.length);
		for (String id : tzList) {
			if (id.startsWith("Etc/")) {
				continue;
			}
			TimeZone timeZone = TimeZone.getTimeZone(id);
			long offsetMins = timeZone.getRawOffset() / (60 * 1000);
			String sign = "+";
			if (offsetMins < 0) {
				offsetMins = -offsetMins;
				sign = "-";
			}
			long hours = offsetMins / 60;
			long minutes = offsetMins - (hours * 60);
			String name = String.format("%s%02d%02d %s", sign, hours, minutes, id);
			tzMap.put(id, name);
		}
		List<Map.Entry<String, String>> tzMapList = new ArrayList<Map.Entry<String, String>>(tzMap.entrySet());
		Collections.sort(tzMapList, new Comparator<Map.Entry<String, String>>() {
			@Override
			public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
				String v1 = o1.getValue();
				String v2 = o2.getValue();
				if (v1.startsWith("-") && v2.startsWith("+")) {
					return 1;
				} else if (v1.startsWith("+") && v2.startsWith("-")) {
					return -1;
				} else {
					return v1.compareTo(v2);
				}
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
		
		if (reqres().attribute("currentPath") == null) {
			reqres().setAttribute("currentPath", "");
		}
		
		if (type.equals("all")) {
			reqres().setAttribute("useOe", true);
			reqres().setAttribute("useNl", true);
			reqres().setAttribute("useTz", true);
			
			reqres().setAttribute("hasEncoded", true);
			reqres().setAttribute("hasDecoded", true);
		}
		
		forward("/WEB-INF/pages/index.jsp");
	}
}

