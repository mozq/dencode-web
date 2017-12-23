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
package com.dencode.web.servlet.pages.hash;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/hash/*")
public class HashIndexServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet() throws Exception {
		String type = "hash";
		String methodPath = reqres().pathParam("");
		String method;
		boolean useOe = true;
		boolean useNl = true;
		boolean useTz = true;
		boolean hasEncoded = true;
		boolean hasDecoded = true;
		
		switch (methodPath) {
		case "md2":
			method = "hash.md2";
			useTz = false;
			hasDecoded = false;
			break;
		case "md5":
			method = "hash.md5";
			useTz = false;
			hasDecoded = false;
			break;
		case "sha1":
			method = "hash.sha1";
			useTz = false;
			hasDecoded = false;
			break;
		case "sha128":
			method = "hash.sha128";
			useTz = false;
			hasDecoded = false;
			break;
		case "sha256":
			method = "hash.sha256";
			useTz = false;
			hasDecoded = false;
			break;
		case "sha384":
			method = "hash.sha384";
			useTz = false;
			hasDecoded = false;
			break;
		case "sha512":
			method = "hash.sha512";
			useTz = false;
			hasDecoded = false;
			break;
		case "crc32":
			method = "hash.crc32";
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
		
		forward("/index");
	}
}

