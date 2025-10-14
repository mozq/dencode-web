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

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.program-string", hasEncoder=true, hasDecoder=true, useNl=true)
public class StringProgramStringDencoder {
	
	private static final char ESCAPE_CHAR = '\\';
	
	private StringProgramStringDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrProgramString(DencodeCondition cond) {
		return encStrProgramString(
				cond.value(),
				DencodeUtils.getOption(cond.options(), "string.program-string.quotes", "double")
				);
	}
	
	@DencoderFunction
	public static String decStrProgramString(DencodeCondition cond) {
		return decStrProgramString(cond.value());
	}
	
	private static String encStrProgramString(String val, String quotes) {
		if (val == null) {
			return null;
		}
		
		char quoteChar = switch (quotes) {
			case "double" -> '\"';
			case "single" -> '\'';
			default -> '\0';
		};
		
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		
		if (quoteChar != '\0') {
			sb.append(quoteChar);
		}
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			switch (ch) {
				case '\0' -> sb.append(ESCAPE_CHAR).append('0');
				case '\u0007' -> sb.append(ESCAPE_CHAR).append('a');
				case '\b' -> sb.append(ESCAPE_CHAR).append('b');
				case '\t' -> sb.append(ESCAPE_CHAR).append('t');
				case '\n' -> sb.append(ESCAPE_CHAR).append('n');
				case '\u000B' -> sb.append(ESCAPE_CHAR).append('v');
				case '\f' -> sb.append(ESCAPE_CHAR).append('f');
				case '\r' -> sb.append(ESCAPE_CHAR).append('r');
				case ESCAPE_CHAR -> sb.append(ESCAPE_CHAR).append(ESCAPE_CHAR);
				default -> {
					if (ch == quoteChar) {
						sb.append(ESCAPE_CHAR);
					}
					sb.append(ch);
				}
			}
		}
		
		if (quoteChar != '\0') {
			sb.append(quoteChar);
		}
		
		return sb.toString();
	}
	
	private static String decStrProgramString(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int len = val.length();
		
		if (2 <= len) {
			char fc = val.charAt(0);
			char lc = val.charAt(len - 1);
			if ((fc == '\"' && lc == '\"')
				|| (fc == '\'' && lc == '\'')) {
				// Trim quotes
				val = val.substring(1, len - 1);
				len = val.length();
			}
		}
		
		int beginIdx = val.indexOf(ESCAPE_CHAR);
		if (beginIdx == -1) {
			return val;
		}
		
		int idx = 0;
		StringBuilder sb = new StringBuilder(len);
		do {
			sb.append(val, idx, beginIdx);
			
			int refIdx = beginIdx + 1;
			if (len <= refIdx) {
				break;
			}
			
			char escCh = val.charAt(refIdx++);
			if (escCh == 'u' || escCh == 'x' || escCh == 'U') {
				// Unicode escape
				
				int endIdx;
				boolean hasBrace = false;
				if (escCh == 'u' || escCh == 'x') {
					if (DencodeUtils.charAt(val, refIdx) == '{') {
						// u{XXXX} / x{XXXX}
						refIdx++;
						hasBrace = true;
						endIdx = val.indexOf('}', refIdx, Math.min(refIdx + 10, len));
					} else if (escCh == 'u') {
						// uXXXX
						endIdx = refIdx + 4;
					} else {
						// Unmatched
						endIdx = -1;
					}
				} else {
					// UXXXXXXXX
					endIdx = refIdx + 8;
				}
				
				if (len < endIdx || 8 < endIdx - refIdx) {
					endIdx = -1;
				}
				
				if (endIdx != -1) {
					try {
						int cp = (int)Long.parseLong(val, refIdx, endIdx, 16);
						sb.appendCodePoint(cp);
						
						if (hasBrace) {
							endIdx++;
						}
					} catch (IllegalArgumentException e) {
						// Illegal number format or code point
						endIdx = -1;
					}
				}
				
				if (endIdx == -1) {
					// Unmatched
					sb.append(escCh);
					idx = beginIdx + 2;
				} else {
					// Matched
					idx = endIdx;
				}
			} else {
				char ch = switch (escCh) {
					case '0' -> '\0';
					case 'a' -> '\u0007';
					case 'b' -> '\b';
					case 't' -> '\t';
					case 'n' -> '\n';
					case 'v' -> '\u000B';
					case 'f' -> '\f';
					case 'r' -> '\r';
					default -> escCh;
				};
				sb.append(ch);
				idx = refIdx;
			}
		} while (idx < len && (beginIdx = val.indexOf(ESCAPE_CHAR, idx)) != -1);
		
		sb.append(val, idx, len);
		
		return sb.toString();
	}
}
