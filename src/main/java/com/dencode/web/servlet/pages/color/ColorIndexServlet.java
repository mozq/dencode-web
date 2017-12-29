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
package com.dencode.web.servlet.pages.color;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/color/*")
public class ColorIndexServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet() throws Exception {
		String type = "color";
		String methodPath = reqres().pathParam("");
		String method;
		boolean useOe = true;
		boolean useNl = true;
		boolean useTz = true;
		boolean hasEncoded = true;
		boolean hasDecoded = true;
		
		switch (methodPath) {
		case "name":
			method = "color.name";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "rgb":
			method = "color.rgb";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "hsl":
			method = "color.hsl";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "hsv":
			method = "color.hsv";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "cmy":
			method = "color.cmy";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "cmyk":
			method = "color.cmyk";
			useOe = false;
			useNl = false;
			useTz = false;
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

