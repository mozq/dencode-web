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

@Dencoder(type="string", method="string.program-string")
public class StringProgramStringDencoder {
	
	private static final char PROGRAM_STRING_ESCAPE_CHAR = '\\';
	private static final char[] PROGRAM_STRING_TARGET_CHARS = {'\0', '\u0007', '\b', '\t', '\n', '\u000B', '\f', '\r', '\"', '\''};
	private static final char[] PROGRAM_STRING_ESCAPED_CHARS = {'0', 'a', 'b', 't', 'n', 'v', 'f', 'r', '\"', '\''};
	
	private StringProgramStringDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrProgramString(DencodeCondition cond) {
		return encStrProgramString(cond.value());
	}
	
	@DencoderFunction
	public static String decStrProgramString(DencodeCondition cond) {
		return decStrProgramString(cond.value());
	}
	
	private static String encStrProgramString(String val) {
		if (val == null) {
			return null;
		}
		return "\"" + StringUtilz.escape(
				val,
				PROGRAM_STRING_ESCAPE_CHAR,
				PROGRAM_STRING_TARGET_CHARS,
				PROGRAM_STRING_ESCAPED_CHARS
				)
				+ "\"";
	}
	
	private static String decStrProgramString(String val) {
		if (val == null || val.length() < 2) {
			return null;
		}
		if (!(val.charAt(0) == '\"' && val.charAt(val.length() - 1) == '\"')) {
			if (!(val.charAt(0) == '\'' && val.charAt(val.length() - 1) == '\'')) {
				return null;
			}
		}
		val = val.substring(1, val.length() - 1);
		return StringUtilz.unescape(
				val,
				PROGRAM_STRING_ESCAPE_CHAR,
				PROGRAM_STRING_TARGET_CHARS,
				PROGRAM_STRING_ESCAPED_CHARS,
				true
				);
	}
}
