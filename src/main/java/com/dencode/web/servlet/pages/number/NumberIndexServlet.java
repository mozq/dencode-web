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
package com.dencode.web.servlet.pages.number;

import javax.servlet.annotation.WebServlet;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/number/*")
public class NumberIndexServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet() throws Exception {
		String type = "number";
		String method = "number." + reqres().pathParam("all");
		
		reqres().setAttribute("type", type);
		reqres().setAttribute("method", method);
		
		if (reqres().attribute("currentPath") == null) {
			reqres().setAttribute("currentPath", getRequestSubPath(reqres()));
		}
		
		forward("/");
	}
}

