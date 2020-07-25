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
package com.dencode.web.servlet.pages.string;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/string/*")
public class StringIndexServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet() throws Exception {
		String type = "string";
		String methodPath = reqres().pathParam("");
		String method;
		boolean useOe = true;
		boolean useNl = true;
		boolean useTz = true;
		boolean hasEncoded = true;
		boolean hasDecoded = true;
		
		switch (methodPath) {
		case "bin":
			method = "string.bin";
			useTz = false;
			break;
		case "hex":
			method = "string.hex";
			useTz = false;
			break;
		case "html-escape":
			method = "string.html-escape";
			useTz = false;
			break;
		case "url-encoding":
			method = "string.url-encoding";
			useTz = false;
			break;
		case "punycode":
			method = "string.punycode";
			useOe = false;
			useNl = false;
			useTz = false;
			break;
		case "base32":
			method = "string.base32";
			useTz = false;
			break;
		case "base64":
			method = "string.base64";
			useTz = false;
			break;
		case "quoted-printable":
			method = "string.quoted-printable";
			useTz = false;
			break;
		case "unicode-escape":
			method = "string.unicode-escape";
			useOe = false;
			useTz = false;
			break;
		case "program-string":
			method = "string.program-string";
			useOe = false;
			useTz = false;
			break;
		case "naming-convention":
			method = "string.naming-convention";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "camel-case":
			method = "string.camel-case";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "snake-case":
			method = "string.snake-case";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "kebab-case":
			method = "string.kebab-case";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "character-width":
			method = "string.character-width";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "letter-case":
			method = "string.letter-case";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "text-initials":
			method = "string.text-initials";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "text-reverse":
			method = "string.text-reverse";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "unicode-normalization":
			method = "string.unicode-normalization";
			useOe = false;
			useNl = false;
			useTz = false;
			break;
		case "line-sort":
			method = "string.line-sort";
			useOe = false;
			useNl = false;
			useTz = false;
			hasDecoded = false;
			break;
		case "line-unique":
			method = "string.line-unique";
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

