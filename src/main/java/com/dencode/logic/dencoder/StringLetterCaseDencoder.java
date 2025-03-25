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

import java.util.Locale;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.letter-case", hasEncoder=true, hasDecoder=false)
public class StringLetterCaseDencoder {
	
	private StringLetterCaseDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrUpperCase(DencodeCondition cond) {
		return encStrUpperCase(cond.value());
	}
	
	@DencoderFunction
	public static String encStrLowerCase(DencodeCondition cond) {
		return encStrLowerCase(cond.value());
	}
	
	@DencoderFunction
	public static String encStrSwapCase(DencodeCondition cond) {
		return encStrSwapCase(cond.value());
	}
	
	@DencoderFunction
	public static String encStrCapitalize(DencodeCondition cond) {
		return encStrCapitalize(cond.value());
	}
	
	@DencoderFunction
	public static String encStrAlternatingCaps(DencodeCondition cond) {
		String variant = DencodeUtils.getOption(cond.options(), "string.letter-case.alt-variant", "lower-upper");
		
		return switch (variant) {
			case "vowels-upper" -> encStrAlternatingCaps_Vowels(cond.value(), true);
			case "vowels-lower" -> encStrAlternatingCaps_Vowels(cond.value(), false);
			case "upper-lower" -> encStrAlternatingCaps(cond.value(), true);
			default /* lower-upper */ -> encStrAlternatingCaps(cond.value(), false);
		};
	}
	
	
	private static String encStrUpperCase(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		return val.toUpperCase(Locale.US);
	}
	
	private static String encStrLowerCase(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		return val.toLowerCase(Locale.US);
	}
	
	private static String encStrSwapCase(String val) {
		return StringUtilz.swapCase(val);
	}
	
	private static String encStrCapitalize(String val) {
		return StringUtilz.capitalize(val, true);
	}
	
	private static String encStrAlternatingCaps(String val, boolean firstUpper) {
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		
		boolean upper = firstUpper;
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (Character.isWhitespace(ch)) {
				sb.append(ch);
			} else {
				if (Character.isUpperCase(ch) && !upper) {
					// Upper to lower
					sb.append(Character.toLowerCase(ch));
				} else if (Character.isLowerCase(ch) && upper) {
					// Lower to upper
					sb.append(Character.toUpperCase(ch));
				} else {
					// Other non-letters
					sb.append(ch);
				}
				
				upper = !upper;
			}
		}
		
		return sb.toString();
	}
	
	private static String encStrAlternatingCaps_Vowels(String val, boolean vowelsUpper) {
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (Character.isUpperCase(ch)) {
				boolean vowels = switch (ch) {
					case 'A', 'E', 'I', 'O', 'U' -> true; // Half-width
					case 'Ａ', 'Ｅ', 'Ｉ', 'Ｏ', 'Ｕ' -> true; // Full-width
					case 'А', 'Э', 'О', 'У', 'Ы', 'Я', 'Е', 'Ё', 'Ю', 'И' -> true; // Russian
					default -> false;
				};
				
				if ((vowels && !vowelsUpper) || (!vowels && vowelsUpper)) {
					// To lower
					sb.append(Character.toLowerCase(ch));
				} else {
					// Keep upper
					sb.append(ch);
				}
			} else if (Character.isLowerCase(ch)) {
				boolean vowels = switch (ch) {
					case 'a', 'e', 'i', 'o', 'u' -> true; // Half-width
					case 'ａ', 'ｅ', 'ｉ', 'ｏ', 'ｕ' -> true; // Full-width
					case 'а', 'э', 'о', 'у', 'ы', 'я', 'е', 'ё', 'ю', 'и' -> true; // Russian
					default -> false;
				};
				
				if ((vowels && vowelsUpper) || (!vowels && !vowelsUpper)) {
					// To upper
					sb.append(Character.toUpperCase(ch));
				} else {
					// Keep lower
					sb.append(ch);
				}
			} else {
				// Other non-letters
				sb.append(ch);
			}
		}
		
		return sb.toString();
	}
}
