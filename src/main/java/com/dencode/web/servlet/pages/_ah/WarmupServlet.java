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
package com.dencode.web.servlet.pages._ah;

import java.util.Locale;
import java.util.ResourceBundle;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletResponse;

import com.dencode.logic.DencodeMapper;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/_ah/warmup")
public class WarmupServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet() throws Exception {
		// Warm up
		
		// Initialize DencodeMapper
		DencodeMapper.init();
		
		// Cache messages
		String[] supportedLocaleIds = config().getString("locales").split(",");
		for (String id : supportedLocaleIds) {
			ResourceBundle.getBundle("messages", Locale.forLanguageTag(id));
		}
		
		// Response
		HttpServletResponse res = response();
		res.setStatus(HttpServletResponse.SC_OK);
		res.setHeader("Content-Type", "text/plain; charset=UTF-8");
	}
}
