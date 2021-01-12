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

import java.nio.charset.Charset;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.annotation.WebServlet;

import com.dencode.logic.DencodeMapper;
import com.dencode.logic.model.DencodeCondition;
import com.dencode.web.logic.CommonLogic;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/dencode")
public class DencodeServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost() throws Exception {
		String type = reqres().param("t", "all");
		String method = reqres().param("m", "all");
		String val = reqres().param("v", "");
		String oe = CommonLogic.mapShortCharsetName(reqres().param("oe", "UTF-8"));
		String nl = reqres().param("nl", "crlf");
		String tz = reqres().param("tz", "UTC");
		
		Charset charset = Charset.forName(toCharsetName(oe));
		String lineBreak = toLineBreakString(nl);
		TimeZone timeZone = TimeZone.getTimeZone(tz);
		
		DencodeCondition cond = new DencodeCondition(val, charset, lineBreak, timeZone);
		
		cond.option().setEncStrBinSeparatorEach(reqres().param("encStrBinSeparatorEach", cond.option().getEncStrBinSeparatorEach()));
		cond.option().setEncStrHexSeparatorEach(reqres().param("encStrHexSeparatorEach", cond.option().getEncStrHexSeparatorEach()));
		cond.option().setEncStrHexCase(reqres().param("encStrHexCase", cond.option().getEncStrHexCase()));
		cond.option().setEncStrBase64LineBreakEach(reqres().param("encStrBase64LineBreakEach", cond.option().getEncStrBase64LineBreakEach()));
		cond.option().setEncStrUnicodeEscapeSurrogatePairFormat(reqres().param("encStrUnicodeEscapeSurrogatePairFormat", cond.option().getEncStrUnicodeEscapeSurrogatePairFormat()));
		cond.option().setEncCipherCaesarShift(reqres().paramAsInt("encCipherCaesarShift", cond.option().getEncCipherCaesarShift()));
		cond.option().setDecCipherCaesarShift(reqres().paramAsInt("decCipherCaesarShift", cond.option().getDecCipherCaesarShift()));
		cond.option().setEncCipherScytaleKey(reqres().paramAsInt("encCipherScytaleKey", cond.option().getEncCipherScytaleKey()));
		cond.option().setDecCipherScytaleKey(reqres().paramAsInt("decCipherScytaleKey", cond.option().getDecCipherScytaleKey()));
		cond.option().setEncCipherRailFenceKey(reqres().paramAsInt("encCipherRailFenceKey", cond.option().getEncCipherRailFenceKey()));
		cond.option().setDecCipherRailFenceKey(reqres().paramAsInt("decCipherRailFenceKey", cond.option().getDecCipherRailFenceKey()));
		
		Map<String, Object> dencodeResult = DencodeMapper.dencode(type, method, cond);
		
		responseAsJson(dencodeResult);
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
