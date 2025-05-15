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

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.annotation.WebServlet;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/")
public class RootServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Pattern LOCALE_PATH_PATTERN = Pattern.compile("/([a-z]{2}(?:\\-[A-Za-z]{2})?)/(.*)");
	
	@Override
	protected void doGet() throws Exception {
		String servletPath = reqres().request().getServletPath();
		
		Matcher localePathMatcher = LOCALE_PATH_PATTERN.matcher(servletPath);
		if (localePathMatcher.matches()) {
			// Locale path
			String localeId = localePathMatcher.group(1);
			String subPath = localePathMatcher.group(2);
			
			String[] supportedLocaleIds = config().getString("locales").split(",");
			for (String supportedLocaleId : supportedLocaleIds) {
				if (localeId.equals(supportedLocaleId)) {
					reqres().setAttribute("localeId", localeId);
					reqres().setAttribute("currentPath", subPath);
					
					forward("/" + subPath);
					return;
				}
			}
		}
		
		// Forward to default servlet
		getServletContext().getNamedDispatcher("default").forward(reqres().request(), reqres().response());
	}
}
