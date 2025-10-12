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
import java.nio.charset.StandardCharsets;
import java.time.DateTimeException;
import java.time.ZoneId;
import java.util.Map;

import com.dencode.logic.DencodeMapper;
import com.dencode.logic.model.DencodeCondition;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.annotation.WebServlet;

@WebServlet("/dencode")
public class DencodeServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static class DencodeRequest {
		public String type;
		public String method;
		public String value;
		public String oe;
		public String nl;
		public String tz;
		public Map<String, String> options;
	}
	
	
	private static final Charset DEFAULT_CHARSET = StandardCharsets.UTF_8;
	private static final String DEFAULT_LINE_BREAK = "\n";
	private static final ZoneId DEFAULT_ZONE_ID = ZoneId.of("UTC");
	
	
	@Override
	protected void doPost() throws Exception {
		DencodeRequest req;
		try (InputStream is = request().getInputStream()) {
			req = new ObjectMapper().readValue(is, DencodeRequest.class);
		}
		
		Charset charset = toCharset(req.oe, DEFAULT_CHARSET);
		String lineBreak = toLineBreakString(req.nl, DEFAULT_LINE_BREAK);
		ZoneId zone = toZoneId(req.tz, DEFAULT_ZONE_ID);
		
		DencodeCondition cond = new DencodeCondition(req.value, charset, lineBreak, zone, req.options);
		
		try {
			Map<String, Object> dencodeResult = DencodeMapper.dencode(req.type, req.method, cond);
			
			responseAsJson(dencodeResult);
		} catch (OutOfMemoryError e) {
			throw new IllegalArgumentException("Method: " + req.method + ", Value length: " + cond.value().length(), e);
		}
	}
	
	private static String toCharsetName(String oe) {
		return switch (oe) {
			case "Shift_JIS" -> "windows-31j";
			case "ISO-2022-JP" -> "x-windows-iso2022jp";
			case "windows-874" -> "x-windows-874";
			default -> oe;
		};
	}
	
	private static Charset toCharset(String oe, Charset defaultCharset) {
		if (oe == null) {
			return defaultCharset;
		}
		
		try {
			return Charset.forName(toCharsetName(oe));
		} catch (IllegalArgumentException e) {
			return defaultCharset;
		}
	}
	
	private static String toLineBreakString(String nl, String defaultNl) {
		if (nl == null) {
			return defaultNl;
		}
		
		return switch (nl) {
			case "crlf" -> "\r\n";
			case "lf" -> "\n";
			case "cr" -> "\r";
			default -> defaultNl;
		};
	}
	
	private static ZoneId toZoneId(String tz, ZoneId defaultTz) {
		if (tz == null) {
			return defaultTz;
		}
		
		try {
			return ZoneId.of(tz);
		} catch (DateTimeException e) {
			return defaultTz;
		}
	}
}
