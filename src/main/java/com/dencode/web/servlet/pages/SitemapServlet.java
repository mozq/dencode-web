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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.annotation.WebServlet;

import com.dencode.logic.DencodeMapper;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("sitemap.xml")
public class SitemapServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final List<String> SUPPORTED_METHOD_PATHS;
	static {
		List<String> types = DencodeMapper.getAllTypes();
		List<String> methods = DencodeMapper.getAllMethods();
		
		List<String> paths = new ArrayList<>(1 + types.size() + methods.size());
		
		// Root paths
		paths.add("");
		
		// Type paths
		for (String type : types) {
			paths.add(type);
		}
		
		// Method paths
		for (String method : methods) {
			paths.add(method.replace('.', '/'));
		}
		
		SUPPORTED_METHOD_PATHS = Collections.unmodifiableList(paths);
	}
	
	private static final Map<String, String> SUPPORTED_LOCALE_MAP;
	static {
		String[] supportedLocaleIds = config().getAsStringArray("locales");
		Map<String, String> supportedLocaleMap = new LinkedHashMap<>();
		for (String id : supportedLocaleIds) {
			supportedLocaleMap.put(id, ResourceBundle.getBundle("messages", toLocale(id)).getString("locale.name"));
		}
		
		SUPPORTED_LOCALE_MAP = Collections.unmodifiableMap(supportedLocaleMap);
	}
	
	@Override
	protected void doGet() throws Exception {
		
		reqres().setAttribute("supportedMethodPaths", SUPPORTED_METHOD_PATHS);
		reqres().setAttribute("supportedLocaleMap", SUPPORTED_LOCALE_MAP);
		reqres().setAttribute("baseURL", getBaseURL(reqres()));
		
		forward("/WEB-INF/pages/sitemap.jsp");
	}
}
