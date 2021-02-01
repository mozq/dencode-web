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

import java.util.ResourceBundle;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;

import com.dencode.logic.DencodeMapper;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/_ah/warmup")
public class WarmupServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet() throws Exception {
		// Warm up
		DencodeMapper.init();
		
		String[] locales = config().getAsStringArray("locales");
		for (String locale : locales) {
			ResourceBundle.getBundle("messages", toLocale(locale));
		}
		
		// Response
		HttpServletResponse res = response();
		res.setStatus(HttpServletResponse.SC_OK);
		res.setHeader("Content-Type", "text/plain; charset=UTF-8");
	}
}
