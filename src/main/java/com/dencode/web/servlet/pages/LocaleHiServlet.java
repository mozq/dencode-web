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

import java.util.Locale;

import javax.servlet.annotation.WebServlet;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/hi/*")
public class LocaleHiServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String LOCALE_NAME = "hi";
	
	private static final Locale LOCALE = new Locale(LOCALE_NAME);
	
	@Override
	protected void doGet() throws Exception {
		String path = reqres().pathParam("");

		reqres().setAttribute("localeName", LOCALE_NAME);
		reqres().setAttribute("locale", LOCALE);
		
		reqres().setAttribute("currentPath", path);
		
		forward("/" + path);
	}
}

