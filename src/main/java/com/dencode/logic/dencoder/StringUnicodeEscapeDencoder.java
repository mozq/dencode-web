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

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.unicode-escape", hasEncoder=true, hasDecoder=true, useNl=true)
public class StringUnicodeEscapeDencoder {
	
	private static char[] NOTATION_PREFIXES = new char[]{'\\', '%', '&', '0', 'U'};
	private static Pattern NOTATION_PATTERN_CODE = Pattern.compile("\\\\u([0-9a-fA-F]{1,4})|\\\\U([0-9a-fA-F]{1,8})|\\\\u\\{([0-9a-fA-F]{1,6})\\}|\\\\x\\{([0-9a-fA-F]{1,6})\\}|\\\\([0-9a-fA-F]{1,6}) ?|&#x([0-9a-fA-F]{1,6});?|%u([0-9a-fA-F]{1,4})|0x([0-9a-fA-F]{1,6}) ?|U\\+([0-9a-fA-F]{1,6}) ?");
	private static Pattern NOTATION_PATTERN_NAME = Pattern.compile("\\\\N\\{(.+?)\\}");
	
	private static final String TYPE_CODE_UNIT = "cu";
	private static final String TYPE_CODE_POINT = "cp";
	private static final String TYPE_CHAR_NAME = "cn";
	
	private static final String DEFAULT_NOTATION = "cubu";
	
	private static final Map<String, String[]> NOTATION_FORMATS = new HashMap<>() {
		private static final long serialVersionUID = 1L;
		{
			// Key: Notation
			// Value: Formats [type, upper-case BMP, lower-case BMP, upper-case non-BMP, lower-case non-BMP, separator]
			put("cubu", new String[] {TYPE_CODE_UNIT, "\\u%04X", "\\u%04x", null, null, null}); // Code unit / backslash + "u"
			put("cpbu_bU", new String[] {TYPE_CODE_POINT, "\\u%04X", "\\u%04x", "\\U%08X", "\\U%08x", null}); // Code point / backslash + "u" / backslash + "U"
			put("cpbu_bub", new String[] {TYPE_CODE_POINT, "\\u%04X", "\\u%04x", "\\u{%X}", "\\u{%x}", null}); // Code point / backslash + "u" / backslash + "u" + braces
			put("cpbub", new String[] {TYPE_CODE_POINT, "\\u{%X}", "\\u{%x}", "\\u{%X}", "\\u{%x}", null}); // Code point / backslash + "u" + braces
			put("cpbxb", new String[] {TYPE_CODE_POINT, "\\x{%X}", "\\x{%x}", "\\x{%X}", "\\x{%x}", null}); // Code point / backslash + "x" + braces
			put("cpb", new String[] {TYPE_CODE_POINT, "\\%X", "\\%x", "\\%X", "\\%x", null}); // Code point / backslash
			put("cpahx", new String[] {TYPE_CODE_POINT, "&#x%X;", "&#x%x;", "&#x%X;", "&#x%x;", null}); // Code point / ampersand + hash + "x"
			put("cupu", new String[] {TYPE_CODE_UNIT, "%%u%04X", "%%u%04x", null, null, null}); // Code unit / percent + "u"
			put("cp", new String[] {TYPE_CODE_POINT, "U+%04X", "U+%04x", "U+%X", "U+%x", " "}); // Code point / "U+"
			put("cp0x", new String[] {TYPE_CODE_POINT, "0x%X", "0x%x", "0x%X", "0x%x", " "}); // Code point / "0x"
			put("cnbNb", new String[] {TYPE_CHAR_NAME, "\\N{%s}", "\\N{%s}", "\\N{%s}", "\\N{%s}", null}); // Character name / backslash + "N" + braces
		}
	};
	
	private StringUnicodeEscapeDencoder() {
		// NOP
	}
	
	@DencoderFunction
	public static String encStrUnicodeEscape(DencodeCondition cond) {
		return encStrUnicodeEscape(
				cond.value(),
				DencodeUtils.getOption(cond.options(), "string.unicode-escape.notation", DEFAULT_NOTATION),
				!DencodeUtils.getOption(cond.options(), "string.unicode-escape.case", "upper").equals("lower")
				);
	}
	
	@DencoderFunction
	public static String decStrUnicodeEscape(DencodeCondition cond) {
		return decStrUnicodeEscape(cond.value());
	}
	
	private static String encStrUnicodeEscape(String val, String notation, boolean upperCase) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		String[] formats = NOTATION_FORMATS.get(notation);
		if (formats == null) {
			formats = NOTATION_FORMATS.get(DEFAULT_NOTATION); // Default format
		}
		
		String type = formats[0];
		String bmpFormat = (upperCase) ? formats[1] : formats[2];
		String nbmpFormat = (upperCase) ? formats[3] : formats[4];
		String separator = formats[5];
		boolean hasSpFormat = (nbmpFormat != null);
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len * 6);
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (i != 0 && separator != null) {
				sb.append(separator);
			}
			
			int codePoint = (hasSpFormat) ? val.codePointAt(i) : (int)ch;
			
			String format;
			if (Character.isBmpCodePoint(codePoint)) {
				// BMP
				format = bmpFormat;
			} else {
				// non-BMP (Surrogate Pair)
				format = nbmpFormat;
				i++;
			}
			
			if (type.equals(TYPE_CHAR_NAME)) {
				// Character name
				String name = Character.getName(codePoint);
				if (name == null) {
					// Unknown character
					sb.appendCodePoint(codePoint);
				} else {
					sb.append(String.format(format, name));
				}
			} else {
				// Code point / Code unit
				sb.append(String.format(format, codePoint));
			}
		}
		
		return sb.toString();
	}
	
	private static String decStrUnicodeEscape(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int idx = StringUtilz.indexOf(val, NOTATION_PREFIXES);
		if (idx == -1) {
			return val;
		}
		
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		sb.append(val, 0, idx);
		
		Matcher codeMatcher = NOTATION_PATTERN_CODE.matcher(val);
		Matcher nameMatcher = NOTATION_PATTERN_NAME.matcher(val);
		
		char prevCh = '\0';
		for (int i = idx; i < len; i++) {
			char ch = val.charAt(i);
			
			if (ch == '\\' || ch == '%' || ch == '&' || ch == '0' || ch == 'U') {
				if (ch == '\\' && prevCh == '\\') {
					// Escaped "\"
					prevCh = '\0';
				} else if (codeMatcher.region(i, len).lookingAt()) {
					// Code point / Code unit
					String code = findMatchedGroup(codeMatcher);
					
					try {
						int cp = Integer.parseInt(code, 16);
						sb.appendCodePoint(cp);
					} catch (IllegalArgumentException e) {
						sb.append(codeMatcher.group());
					}

					prevCh = '\0';
					i = codeMatcher.end() - 1;
				} else if (nameMatcher.region(i, len).lookingAt()) {
					// Character name
					String name = findMatchedGroup(nameMatcher);
					
					try {
						int cp = Character.codePointOf(name);
						sb.appendCodePoint(cp);
					} catch (IllegalArgumentException e) {
						sb.append(nameMatcher.group());
					}

					prevCh = '\0';
					i = nameMatcher.end() - 1;
				} else {
					sb.append(ch);
					prevCh = ch;
				}
			} else {
				sb.append(ch);
				prevCh = ch;
			}
		}
		
		return sb.toString();
	}
	
	private static String findMatchedGroup(Matcher matcher) {
		String v = null;
		for (int i = 1; i <= matcher.groupCount(); i++) {
			v = matcher.group(i);
			if (v != null) {
				break;
			}
		}
		
		return v;
	}
}
