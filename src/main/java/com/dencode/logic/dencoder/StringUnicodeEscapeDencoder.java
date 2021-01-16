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
package com.dencode.logic.dencoder;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.unicode-escape")
public class StringUnicodeEscapeDencoder {
	
	private StringUnicodeEscapeDencoder() {
		// NOP
	}
	
	@DencoderFunction
	public static String encStrUnicodeEscape(DencodeCondition cond) {
		return encStrUnicodeEscape(cond.value(),
				DencodeUtils.getOption(cond.options(), "encStrUnicodeEscapeSurrogatePairFormat", ""));
	}
	
	@DencoderFunction
	public static String decStrUnicodeEscape(DencodeCondition cond) {
		return decStrUnicodeEscape(cond.value());
	}
	
	
	private static String toUnicodeEscapeSpPattern(String spFormat) {
		switch (spFormat) {
			case "ubcp": return "\\u{%x}"; // for Swift, JS(ES6+), PHP, Ruby
			case "Ucp": return "\\U%08x"; // for C, Python
			default: return null; // for Java, JS(ES5)
		}
	}
	
	private static String encStrUnicodeEscape(String val, String spFormatType) {
		if (val == null) {
			return null;
		}
		
		String spPattern = toUnicodeEscapeSpPattern(spFormatType);
		
		boolean supportSurrogatePair = (spPattern != null && !spPattern.isEmpty());
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len * 6);
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (supportSurrogatePair && Character.isHighSurrogate(ch) && (i + 1 != len)) {
				// Surrogate Pair
				
				char lowCh = val.charAt(++i);
				
				int codePoint = Character.toCodePoint(ch, lowCh);
				
				sb.append(String.format(spPattern, codePoint));
			} else {
				String chHexStr = Integer.toHexString((int)ch);
				
				sb.append("\\u");
				StringUtilz.paddingLeft(sb, chHexStr, 4, '0');
			}
		}
		
		return sb.toString();
	}
	
	private static String decStrUnicodeEscape(String val) {
		if (val == null) {
			return null;
		}
		
		try {
			return StringUtilz.unescape(
					val,
					'\\',
					null,
					null,
					true
					);
		} catch (Exception e) {
			return null;
		}
	}
}
