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

import java.io.InputStream;
import java.nio.charset.Charset;
import java.time.ZoneId;
import java.util.Map;

import jakarta.servlet.annotation.WebServlet;

import com.dencode.logic.DencodeMapper;
import com.dencode.logic.model.DencodeCondition;
import com.dencode.web.logic.CommonLogic;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/dencode")
public class DencodeServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost() throws Exception {
		String type;
		String method;
		String val;
		String oe;
		String nl;
		String tz;
		Map<String, String> options;

		try (InputStream is = reqres().request().getInputStream()) {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> reqmap = mapper.readValue(is, new TypeReference<Map<String, Object>>() {});
			
			type = (String)reqmap.getOrDefault("type", "all");
			method = (String)reqmap.getOrDefault("method", "all.all");
			val = (String)reqmap.getOrDefault("value", "");
			oe = CommonLogic.mapShortCharsetName((String)reqmap.getOrDefault("oe", "UTF-8"));
			nl = (String)reqmap.getOrDefault("nl", "crlf");
			tz = (String)reqmap.getOrDefault("tz", "UTC");
			
			options = (Map<String, String>)reqmap.get("options");
		}
		
		Charset charset = Charset.forName(toCharsetName(oe));
		String lineBreak = toLineBreakString(nl);
		ZoneId zone = ZoneId.of(tz);
		
		DencodeCondition cond = new DencodeCondition(val, charset, lineBreak, zone, options);
		
		try {
			Map<String, Object> dencodeResult = DencodeMapper.dencode(type, method, cond);
			
			responseAsJson(dencodeResult);
		} catch (OutOfMemoryError e) {
			throw new IllegalArgumentException("Method: " + method + ", Value length: " + cond.value().length(), e);
		}
	}

	private static String toCharsetName(String oe) {
		if (oe == null || oe.isEmpty()) {
			return "UTF-8";
		}
		
		switch (oe) {
			case "Shift_JIS": return "windows-31j";
			case "ISO-2022-JP": return "x-windows-iso2022jp";
			case "windows-874": return "x-windows-874";
		}
		
		if (!Charset.isSupported(oe)) {
			return "UTF-8";
		}
		
		return oe;
	}
	
	private static String toLineBreakString(String nl) {

		String lineBreak;
		if (nl.equals("lf")) {
			lineBreak = "\n";
		} else if (nl.equals("cr")) {
			lineBreak = "\r";
		} else {
			// crlf
			lineBreak = "\r\n";
		}
		
		return lineBreak;
	}
}
