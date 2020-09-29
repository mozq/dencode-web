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

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;

import org.mifmi.commons4j.web.servlet.MifmiServletException;

import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/config")
public class ConfigServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet() throws Exception {
		HttpServletResponse res = response();
		res.setStatus(HttpServletResponse.SC_OK);
		res.setHeader("Content-Type", "application/json; charset=UTF-8");
		
		try (OutputStream out = res.getOutputStream()) {
			writeAsJson(out, config().asMap());
		} catch (IOException e) {
			throw new MifmiServletException(e);
		}
	}
}
