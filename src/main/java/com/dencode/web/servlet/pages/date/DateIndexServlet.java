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
package com.dencode.web.servlet.pages.date;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/date/*")
public class DateIndexServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet() throws Exception {
		String type = "date";
		String methodPath = reqres().pathParam("");
		String method;
		boolean useOe = true;
		boolean useNl = true;
		boolean useTz = true;
		boolean hasEncoded = true;
		boolean hasDecoded = true;
		
		switch (methodPath) {
		case "unix-time":
			method = "date.unix-time";
			useOe = false;
			useNl = false;
			hasDecoded = false;
			break;
		case "w3cdtf":
			method = "date.w3cdtf";
			useOe = false;
			useNl = false;
			hasDecoded = false;
			break;
		case "iso8601":
			method = "date.iso8601";
			useOe = false;
			useNl = false;
			hasDecoded = false;
			break;
		case "rfc2822":
			method = "date.rfc2822";
			useOe = false;
			useNl = false;
			hasDecoded = false;
			break;
		case "ctime":
			method = "date.ctime";
			useOe = false;
			useNl = false;
			hasDecoded = false;
			break;
		case "japanese-era":
			method = "date.japanese-era";
			useOe = false;
			useNl = false;
			hasDecoded = false;
			break;
		default:
			reqres().response().sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		
		reqres().setAttribute("type", type);
		reqres().setAttribute("method", method);
		
		reqres().setAttribute("useOe", useOe);
		reqres().setAttribute("useNl", useNl);
		reqres().setAttribute("useTz", useTz);
		
		reqres().setAttribute("hasEncoded", hasEncoded);
		reqres().setAttribute("hasDecoded", hasDecoded);
		
		if (reqres().attribute("currentPath") == null) {
			reqres().setAttribute("currentPath", getRequestSubPath(reqres()));
		}
		
		forward("/index");
	}
}

