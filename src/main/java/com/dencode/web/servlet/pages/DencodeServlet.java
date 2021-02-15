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
import java.util.HashMap;
import java.util.Map;

import javax.servlet.annotation.WebServlet;

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
		
		if (reqres().request().getContentType().equals("application/json")) {
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
		} else {
			// Temporary code for migration
			// TODO: Remove this code after migration
			type = reqres().param("t", "all");
			method = reqres().param("m", "all.all");
			val = reqres().param("v", "");
			oe = CommonLogic.mapShortCharsetName(reqres().param("oe", "UTF-8"));
			nl = reqres().param("nl", "crlf");
			tz = reqres().param("tz", "UTC");
			
			options = new HashMap<>();
			options.put("encStrBinSeparatorEach", reqres().param("encStrBinSeparatorEach", null));
			options.put("encStrHexSeparatorEach", reqres().param("encStrHexSeparatorEach", null));
			options.put("encStrHexCase", reqres().param("encStrHexCase", null));
			options.put("encStrBase64LineBreakEach", reqres().param("encStrBase64LineBreakEach", null));
			options.put("encStrUnicodeEscapeSurrogatePairFormat", reqres().param("encStrUnicodeEscapeSurrogatePairFormat", null));
			options.put("encCipherCaesarShift", reqres().param("encCipherCaesarShift", null));
			options.put("decCipherCaesarShift", reqres().param("decCipherCaesarShift", null));
			options.put("encCipherScytaleKey", reqres().param("encCipherScytaleKey", null));
			options.put("decCipherScytaleKey", reqres().param("decCipherScytaleKey", null));
			options.put("encCipherRailFenceKey", reqres().param("encCipherRailFenceKey", null));
			options.put("decCipherRailFenceKey", reqres().param("decCipherRailFenceKey", null));
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
