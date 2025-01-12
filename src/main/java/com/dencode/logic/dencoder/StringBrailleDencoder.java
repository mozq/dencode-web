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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.braille", hasEncoder=true, hasDecoder=true)
public class StringBrailleDencoder {
	// UEB;
	//   See: https://www.brailleauthority.org/ueb/abcs/abcs-ueb.html
	//   See: https://www.brailleauthority.org/ueb/symbols_list.pdf
	//   See: https://www.lighthouse.or.jp/tecti/ueb/foressen.pdf  (Japanese)
	
	private enum Type {
		UpperLetter,
		LowerLetter,
		Number,
		Symbol,
	}
	
	private enum Indicator {
		CapitalWord,
		CapitalPassage,
		AngleBracket, // <>
		CurlyBracket, // {}
		SquareBracket, // []
		RoundBracket, // ()
		DoubleQuote, // “”
		SingleQuote, // ‘’
	}
	
	
	private StringBrailleDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrBraille(DencodeCondition cond) {
		String variant = DencodeUtils.getOption(cond.options(), "string.braille.variant", "ueb1");
		
		return switch (variant) {
			default -> encStrBrailleUEB1(cond.value());
		};
	}
	
	@DencoderFunction
	public static String decStrBraille(DencodeCondition cond) {
		String variant = DencodeUtils.getOption(cond.options(), "string.braille.variant", "ueb1");
		
		return switch (variant) {
			default -> decStrBrailleUEB1(cond.value());
		};
	}
	
	
	private static String encStrBrailleUEB1(String value) {
		if (value == null || value.isEmpty()) {
			return "";
		}
		
		int len = value.length();
		
		Type prevType = null;
		List<Indicator> indicatorList = new ArrayList<>();
		
		StringBuilder sb = new StringBuilder(len * 2);
		for (int i = 0; i < len; i++) {
			char ch = value.charAt(i);
			
			if (isNumber(ch) || (prevType == Type.Number && isNumericSymbol(ch))) {
				// Number
				if (prevType != Type.Number) {
					sb.append('⠼'); // Dots-3456 (Number indicator)
				}
				
				sb.append(numberToBraille(ch));
				
				prevType = Type.Number;
			} else if (isLowerCaseLetter(ch)) {
				// Lower-case letter
				if (indicatorList.contains(Indicator.CapitalWord) || indicatorList.contains(Indicator.CapitalPassage)) {
					sb.append("⠠⠄"); // Dots-6 3 (Capitals terminator)
					removeIndicator(indicatorList, Indicator.CapitalWord);
					removeIndicator(indicatorList, Indicator.CapitalPassage);
				} else if (prevType == Type.Number && (isLowerCaseLetterA2J(ch))) {
					sb.append('⠰'); // Dots-56 (Grade 1 indicator)
				}
				
				sb.append(letterToBraille(ch));
				
				prevType = Type.LowerLetter;
			} else if (isUpperCaseLetter(ch)) {
				// Upper-case letter
				if (!indicatorList.contains(Indicator.CapitalWord) && !indicatorList.contains(Indicator.CapitalPassage)) {
					if (isNotLowerLetters(value, i + 1, 10, 2, 1)) {
						// Passage
						sb.append("⠠⠠⠠"); // Dots-6 6 6 (Capital passage indicator)
						indicatorList.add(Indicator.CapitalPassage);
					} else if (isUpperLetters(value, i + 1, 1)) {
						// Word
						sb.append("⠠⠠"); // Dots-6 6 (Capital word indicator)
						indicatorList.add(Indicator.CapitalWord);
					} else {
						// Letter
						sb.append('⠠'); // Dots-6 (Capital letter indicator)
					}
				}
				
				sb.append(letterToBraille(toLowerCaseLetter(ch)));
				
				prevType = Type.UpperLetter;
			} else if (isNewLine(ch)) {
				if (indicatorList.contains(Indicator.CapitalPassage)) {
					sb.append("⠠⠄"); // Dots-6 3 (Capitals terminator)
				}
				
				sb.append(ch);
				
				prevType = null;
				indicatorList.clear();
			} else if (isWhitespace(ch)) {
				sb.append('\u2800'); // Braille blank
				
				prevType = null;
			} else if (ch == '—' && charAt(value, i + 1, '\0') == '—') {
				sb.append("⠐⠠⠤"); // Dots-5 6 36 (U+2014 x 2 Long Em dash)
				i++;
				prevType = Type.Symbol;
			} else if (ch == '"') {
				// Double quote
				if (prevType == null) {
					sb.append('⠦'); // Dots-236 (Open quote)
					indicatorList.add(Indicator.DoubleQuote);
				} else if (indicatorList.contains(Indicator.DoubleQuote)) {
					if (removeIndicator(indicatorList, Indicator.DoubleQuote).contains(Indicator.CapitalPassage)) {
						// If a capital passage indicator is in the quote
						// Terminate the capital indicator
						sb.append("⠠⠄"); // Dots-6 3 (Capitals terminator)
					}
					sb.append('⠴'); // Dots-356 (Close quote)
				} else {
					sb.append("⠠⠶"); // Dots-6 2356 (Inches)
				}
				prevType = Type.Symbol;
			} else {
				String s;
				if ((s = openingSymbolToBraille(ch, indicatorList)) != null) {
					// Opening symbol
					sb.append(s);
					prevType = Type.Symbol;
				} else if ((s = closingSymbolToBraille(ch, indicatorList)) != null) {
					// Closing symbol
					sb.append(s);
					prevType = Type.Symbol;
				} else if ((s = symbolToBraille(ch)) != null) {
					// Symbol
					sb.append(s);
					prevType = Type.Symbol;
				} else {
					// Others
					sb.append(ch);
					prevType = null;
				}
			}
			
			if (prevType != Type.UpperLetter) {
				removeIndicator(indicatorList, Indicator.CapitalWord);
			}
		}
		
		if (indicatorList.contains(Indicator.CapitalPassage)) {
			sb.append("⠠⠄"); // Dots-6 3 (Capitals terminator)
			removeIndicator(indicatorList, Indicator.CapitalPassage);
		}
		
		return sb.toString();
	}
	
	private static String decStrBrailleUEB1(String value) {
		if (value == null || value.isEmpty()) {
			return "";
		}
		
		int len = value.length();
		int lastIdx = len - 1;
		
		Type prevType = null;
		boolean inCapitalLetter = false;
		boolean inCapitalWord = false;
		boolean inCapitalPassage = false;
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i <= lastIdx; i++) {
			char ch = value.charAt(i);
			char ch2 = charAt(value, i + 1, '\0');
			char ch3 = charAt(value, i + 2, '\0');
			
			inCapitalWord &= (prevType == Type.UpperLetter);
			
			if ('\u2800' <= ch && ch <= '\u283F') {
				// Braille
				char dch;
				if (prevType == Type.Number) {
					// Number
					char nch = brailleToNumber(ch);
					if (nch != ch) {
						sb.append(nch);
						prevType = Type.Number;
					} else {
						// Re-parse as non-number
						prevType = null;
						i--;
					}
				} else if ((dch = brailleToLetter(ch)) != ch) {
					// Letter
					if (inCapitalLetter || inCapitalWord || inCapitalPassage) {
						dch = toUpperCaseLetter(dch);
						prevType = Type.UpperLetter;
						inCapitalLetter = false;
					} else {
						prevType = Type.LowerLetter;
					}
					sb.append(dch);
				} else if (ch == '\u2800') { // Braille blank
					sb.append(' ');
					prevType = null;
				} else if (prevType == null && ch == '⠦') { // Dots-236 (Open quote)
					sb.append('"');
					prevType = Type.Symbol;
				} else if (ch == '⠴') { // Dots-356 (Close quote)
					sb.append('"');
					prevType = Type.Symbol;
				} else if (ch == '⠼') { // Dots-3456 (Number indicator)
					prevType = Type.Number;
				} else if (ch == '⠰') { // Dots-56 (Grade 1 indicator)
					if (prevType == Type.Number) {
						prevType = null;
					}
				} else if ((dch = brailleToSymbol3(ch, ch2, ch3)) != ch) {
					// Symbol
					sb.append(dch);
					i += 2;
					prevType = Type.Symbol;
				} else if ((dch = brailleToSymbol2(ch, ch2)) != ch) {
					// Symbol
					sb.append(dch);
					i++;
					prevType = Type.Symbol;
				} else if ((dch = brailleToSymbol1(ch)) != ch) {
					// Symbol
					sb.append(dch);
					prevType = Type.Symbol;
				} else if (ch == '⠐' && ch2 == '⠠' & ch3 == '⠤') { // Dots-5 6 36 (U+2014 x 2 Long Em dash)
					sb.append('—').append('—');
					i += 2;
					prevType = Type.Symbol;
				} else if (ch == '⠠' && ch2 == '⠄') { // Dots-6 3 (Capitals terminator)
					i++;
					prevType = null;
					inCapitalLetter = false;
					inCapitalWord = false;
					inCapitalPassage = false;
				} else if (ch == '⠠' && ch2 == '⠠' && ch3 == '⠠') { // Dots-6 6 6 (Capital passage indicator)
					i += 2;
					prevType = Type.UpperLetter;
					inCapitalPassage = true;
				} else if (ch == '⠠' && ch2 == '⠠') { // Dots-6 6 (Capital word indicator)
					i++;
					prevType = Type.UpperLetter;
					inCapitalWord = true;
				} else if (ch == '⠠') { // Dots-6 (Capital letter indicator)
					prevType = Type.UpperLetter;
					inCapitalLetter = true;
				} else {
					// Unsupported Braille
					sb.append(ch);
					prevType = null;
				}
			} else {
				// Non-Braille
				sb.append(ch);
				prevType = null;
			}
		}
		
		return sb.toString();
	}
	
	private static char numberToBraille(char ch) {
		return switch (ch) {
			case '1', '１' -> '⠁'; // Dots-1
			case '2', '２' -> '⠃'; // Dots-12
			case '3', '３' -> '⠉'; // Dots-14
			case '4', '４' -> '⠙'; // Dots-145
			case '5', '５' -> '⠑'; // Dots-15
			case '6', '６' -> '⠋'; // Dots-124
			case '7', '７' -> '⠛'; // Dots-1245
			case '8', '８' -> '⠓'; // Dots-125
			case '9', '９' -> '⠊'; // Dots-24
			case '0', '０' -> '⠚'; // Dots-245
			case '.', '．' -> '⠲'; // Dots-256
			case ',', '，' -> '⠂'; // Dots-2
			case ' ' -> '⠐'; // Dots-5 (U+2007 Numeric space)
			default -> throw new IllegalArgumentException("ch=" + ch);
		};
	}
	
	private static char brailleToNumber(char ch) {
		return switch (ch) {
			case '⠁' -> '1'; // Dots-1
			case '⠃' -> '2'; // Dots-12
			case '⠉' -> '3'; // Dots-14
			case '⠙' -> '4'; // Dots-145
			case '⠑' -> '5'; // Dots-15
			case '⠋' -> '6'; // Dots-124
			case '⠛' -> '7'; // Dots-1245
			case '⠓' -> '8'; // Dots-125
			case '⠊' -> '9'; // Dots-24
			case '⠚' -> '0'; // Dots-245
			case '⠲' -> '.'; // Dots-256
			case '⠂' -> ','; // Dots-2
			case '⠐' -> ' '; // Dots-5 (U+2007 Numeric space)
			case '⠌' -> '/'; // Dots-456 34
			default -> ch;
		};
	}
	
	private static char letterToBraille(char ch) {
		return switch (ch) {
			case 'a', 'ａ' -> '⠁'; // Dots-1
			case 'b', 'ｂ' -> '⠃'; // Dots-12
			case 'c', 'ｃ' -> '⠉'; // Dots-14
			case 'd', 'ｄ' -> '⠙'; // Dots-145
			case 'e', 'ｅ' -> '⠑'; // Dots-15
			case 'f', 'ｆ' -> '⠋'; // Dots-124
			case 'g', 'ｇ' -> '⠛'; // Dots-1245
			case 'h', 'ｈ' -> '⠓'; // Dots-125
			case 'i', 'ｉ' -> '⠊'; // Dots-24
			case 'j', 'ｊ' -> '⠚'; // Dots-245
			case 'k', 'ｋ' -> '⠅'; // Dots-13
			case 'l', 'ｌ' -> '⠇'; // Dots-123
			case 'm', 'ｍ' -> '⠍'; // Dots-134
			case 'n', 'ｎ' -> '⠝'; // Dots-1345
			case 'o', 'ｏ' -> '⠕'; // Dots-135
			case 'p', 'ｐ' -> '⠏'; // Dots-1234
			case 'q', 'ｑ' -> '⠟'; // Dots-12345
			case 'r', 'ｒ' -> '⠗'; // Dots-1235
			case 's', 'ｓ' -> '⠎'; // Dots-234
			case 't', 'ｔ' -> '⠞'; // Dots-2345
			case 'u', 'ｕ' -> '⠥'; // Dots-136
			case 'v', 'ｖ' -> '⠧'; // Dots-1236
			case 'w', 'ｗ' -> '⠺'; // Dots-2456
			case 'x', 'ｘ' -> '⠭'; // Dots-1346
			case 'y', 'ｙ' -> '⠽'; // Dots-13456
			case 'z', 'ｚ' -> '⠵'; // Dots-1356
			default -> throw new IllegalArgumentException("ch=" + ch);
		};
	}
	
	private static char brailleToLetter(char ch) {
		return switch (ch) {
			case '⠁' -> 'a'; // Dots-1
			case '⠃' -> 'b'; // Dots-12
			case '⠉' -> 'c'; // Dots-14
			case '⠙' -> 'd'; // Dots-145
			case '⠑' -> 'e'; // Dots-15
			case '⠋' -> 'f'; // Dots-124
			case '⠛' -> 'g'; // Dots-1245
			case '⠓' -> 'h'; // Dots-125
			case '⠊' -> 'i'; // Dots-24
			case '⠚' -> 'j'; // Dots-245
			case '⠅' -> 'k'; // Dots-13
			case '⠇' -> 'l'; // Dots-123
			case '⠍' -> 'm'; // Dots-134
			case '⠝' -> 'n'; // Dots-1345
			case '⠕' -> 'o'; // Dots-135
			case '⠏' -> 'p'; // Dots-1234
			case '⠟' -> 'q'; // Dots-12345
			case '⠗' -> 'r'; // Dots-1235
			case '⠎' -> 's'; // Dots-234
			case '⠞' -> 't'; // Dots-2345
			case '⠥' -> 'u'; // Dots-136
			case '⠧' -> 'v'; // Dots-1236
			case '⠺' -> 'w'; // Dots-2456
			case '⠭' -> 'x'; // Dots-1346
			case '⠽' -> 'y'; // Dots-13456
			case '⠵' -> 'z'; // Dots-1356
			default -> ch;
		};
	}
	
	private static String openingSymbolToBraille(char ch, List<Indicator> indicatorList) {
		return switch (ch) {
			case '<', '＜' -> { indicatorList.add(Indicator.AngleBracket); yield "⠈⠣"; } // Dots-4 126 (Angle bracket, opening)
			case '{', '｛' -> { indicatorList.add(Indicator.CurlyBracket); yield "⠸⠣"; } // Dots-456 126 (Curly bracket, opening)
			case '[', '［' -> { indicatorList.add(Indicator.SquareBracket); yield "⠨⠣"; } // Dots-46 126 (Square bracket, opening)
			case '(', '（' -> { indicatorList.add(Indicator.RoundBracket); yield "⠐⠣"; } // Dots-5 126 (Round bracket, opening)
			case '“' -> { indicatorList.add(Indicator.DoubleQuote); yield "⠘⠦"; } // Dots-45 236 (U+201C Left double quote)
			case '‘' -> { indicatorList.add(Indicator.SingleQuote); yield "⠠⠦"; } // Dots-6 236 (U+2018 Left single quote)
			default -> null;
		};
	}
	
	private static String closingSymbolToBraille(char ch, List<Indicator> indicatorList) {
		Indicator indicator;
		String braille;
		switch (ch) {
			case '>', '＞' -> { indicator = Indicator.AngleBracket; braille = "⠈⠜"; } // Dots-4 345 (Angle bracket, closing)
			case '}', '｝' -> { indicator = Indicator.CurlyBracket; braille = "⠸⠜"; } // Dots-456 345 (Curly bracket, closing)
			case ']', '］' -> { indicator = Indicator.SquareBracket; braille = "⠨⠜"; } // Dots-46 345 (Square bracket, closing)
			case ')', '）' -> { indicator = Indicator.RoundBracket; braille = "⠐⠜"; } // Dots-5 345 (Round bracket, closing)
			case '”' -> { indicator = Indicator.DoubleQuote; braille = "⠘⠴"; } // Dots-45 356 (U+201D Right double quote)
			case '’' -> { indicator = Indicator.SingleQuote; braille = "⠠⠴"; } // Dots-6 356 (U+2019 Right single quote)
			default -> { indicator = null; braille = null; }
		};
		
		if (braille == null) {
			return null;
		}
		
		if (removeIndicator(indicatorList, indicator).contains(Indicator.CapitalPassage)) {
			// If a capital passage indicator is in the quote
			// Terminate the capital indicator
			braille = "⠠⠄" + braille; // Dots-6 3 (Capitals terminator)
		}
		
		return braille;
	}
	
	private static String symbolToBraille(char ch) {
		return switch (ch) {
			case ',', '，' -> "⠂"; // Dots-2
			case ';', '；' -> "⠆"; // Dots-23
			case '!', '！' -> "⠖"; // Dots-235
			case '?', '？' -> "⠦"; // Dots-236
			case ':', '：' -> "⠒"; // Dots-25
			case '.', '．' -> "⠲"; // Dots-256
			case '\'', '＇' -> "⠄"; // Dots-3
			case '-', '－' -> "⠤"; // Dots-36
			
			case '′' -> "⠶"; // Dots-2356 (Prime)
			case '″' -> "⠶⠶"; // Dots-2356 2356 (Double prime)
			
			case '@', '＠' -> "⠈⠁"; // Dots-4 1
			case '&', '＆' -> "⠈⠯"; // Dots-4 12346
			case '£', '￡' -> "⠈⠇"; // Dots-4 123
			case '₣' -> "⠈⠋"; // Dots-4 124
			case '¢', '￠' -> "⠈⠉"; // Dots-4 14
			case '€' -> "⠈⠑"; // Dots-4 15
			case '$', '＄' -> "⠈⠎"; // Dots-4 234
			case '₦' -> "⠈⠝"; // Dots-4 1345
			case '¥', '￥' -> "⠈⠽"; // Dots-4 13456
			case '^', '＾' -> "⠈⠢"; // Dots-4 26
			case '~', '～' -> "⠈⠔"; // Dots-4 35
			
			case '®' -> "⠘⠗"; // Dots-45 1235
			case '©' -> "⠘⠉"; // Dots-45 14
			case '´' -> "⠘⠌"; // Dots-45 34 (U+00B4 Acute accent)
			case '`', '｀' -> "⠘⠡"; // Dots-45 16 (U+0060 Grave accent)
			case '™' -> "⠘⠞"; // Dots-45 2345
			case '°' -> "⠘⠚"; // Dots-45 245 (U+00B0 Degree)
			case '♀' -> "⠘⠭"; // Dots-45 1346 (Female)
			case '♂' -> "⠘⠽"; // Dots-45 13456 (Male)
			case '¶' -> "⠘⠏"; // Dots-45 1234 (Paragraph)
			case '§' -> "⠘⠎"; // Dots-45 234 (Section)
			
			case '%', '％' -> "⠨⠴"; // Dots-46 356
			case '_', '＿' -> "⠨⠤"; // Dots-46 36 (Low line)
			
			case '|', '｜' -> "⠸⠳"; // Dots-456 1256 (Vertical line)
			case '#', '＃' -> "⠸⠹"; // Dots-456 1456
			case '•' -> "⠸⠲"; // Dots-456 256 (U+2022 Bullet)
			case '/', '／' -> "⠸⠌"; // Dots-456 34
			case '\\', '＼' -> "⠸⠡"; // Dots-456 16
			
			case '〃' -> "⠐⠂"; // Dots-5 2 (U+3003 Ditto)
			case '+', '＋' -> "⠐⠖"; // Dots-5 235 (U+002B Plus sign)
			case '×' -> "⠐⠦"; // Dots-5 236 (U+00D7 Multiplication sign)
			case '=', '＝' -> "⠐⠶"; // Dots-5 2356
			case '÷' -> "⠐⠌"; // Dots-5 34 (U+00F7 Division sign)
			case '*', '＊' -> "⠐⠔"; // Dots-5 35
			case '−' -> "⠐⠤"; // Dots-5 36 (U+2212 Minus sign)
			
			case '—' -> "⠠⠤"; // Dots-6 36 (U+2014 Em dash)
			
			case '†' -> "⠈⠠⠹"; // Dots-4 6 1456 (Dagger)
			case '‡' -> "⠈⠠⠻"; // Dots-4 6 12456 (Double dagger)
			
			case '¡' -> "⠘⠰⠖"; // Dots-45 56 235 (Inverted exclamation mark)
			case '¿' -> "⠘⠰⠦"; // Dots-45 56 236 (Inverted question mark)
			
			default -> null;
		};
	}
	
	private static char brailleToSymbol1(char ch) {
		return switch (ch) {
			case '⠂' -> ','; // Dots-2
			case '⠆' -> ';'; // Dots-23
			case '⠖' -> '!'; // Dots-235
			case '⠦' -> '?'; // Dots-236
			case '⠒' -> ':'; // Dots-25
			case '⠲' -> '.'; // Dots-256
			case '⠄' -> '\''; // Dots-3
			case '⠤' -> '-'; // Dots-36
			case '⠶' -> '′'; // Dots-2356 (Prime)
			
			case'\u2800' -> ' '; // Braille blank
			default -> ch;
		};
	}
	
	private static char brailleToSymbol2(char ch, char ch2) {
		return switch (ch) {
			case '⠶' -> // Dots-2356
				switch (ch2) {
					case '⠶' -> '″'; // Dots-2356 2356 (Double prime)
					default -> ch;
				};
			case '⠈' -> // Dots-4
				switch (ch2) {
					case '⠣' -> '<'; // Dots-4 126 (Angle bracket, opening)
					case '⠜' -> '>'; // Dots-4 345 (Angle bracket, closing)
					case '⠁' -> '@'; // Dots-4 1
					case '⠯' -> '&'; // Dots-4 12346
					case '⠇' -> '£'; // Dots-4 123
					case '⠋' -> '₣'; // Dots-4 124
					case '⠉' -> '¢'; // Dots-4 14
					case '⠑' -> '€'; // Dots-4 15
					case '⠎' -> '$'; // Dots-4 234
					case '⠝' -> '₦'; // Dots-4 1345
					case '⠽' -> '¥'; // Dots-4 13456
					case '⠢' -> '^'; // Dots-4 26
					case '⠔' -> '~'; // Dots-4 35
					default -> ch;
				};
			case '⠘' -> // Dots-45
				switch (ch2) {
					case '⠦' -> '“'; // Dots-45 236 (U+201C Left double quote)
					case '⠴' -> '”'; // Dots-45 356 (U+201D Right double quote)
					case '⠗' -> '®'; // Dots-45 1235
					case '⠉' -> '©'; // Dots-45 14
					case '⠌' -> '´'; // Dots-45 34 (U+00B4 Acute accent)
					case '⠡' -> '`'; // Dots-45 16 (U+0060 Grave accent)
					case '⠞' -> '™'; // Dots-45 2345
					case '⠚' -> '°'; // Dots-45 245 (U+00B0 Degree)
					case '⠭' -> '♀'; // Dots-45 1346 (Female)
					case '⠽' -> '♂'; // Dots-45 13456 (Male)
					case '⠏' -> '¶'; // Dots-45 1234 (Paragraph)
					case '⠎' -> '§'; // Dots-45 234 (Section)
					default -> ch;
				};
			case '⠸' -> // Dots-456
				switch (ch2) {
					case '⠣' -> '{'; // Dots-456 126 (Curly bracket, opening)
					case '⠜' -> '}'; // Dots-456 345 (Curly bracket, closing)
					case '⠳' -> '|'; // Dots-456 1256 (Vertical line)
					case '⠹' -> '#'; // Dots-456 1456
					case '⠲' -> '•'; // Dots-456 256 (U+2022 Bullet)
					case '⠌' -> '/'; // Dots-456 34
					case '⠡' -> '\\'; // Dots-456 16
					default -> ch;
				};
			case '⠨' -> // Dots-46
				switch (ch2) {
					case '⠣' -> '['; // Dots-46 126 (Square bracket, opening)
					case '⠜' -> ']'; // Dots-46 345 (Square bracket, closing)
					case '⠴' -> '%'; // Dots-46 356
					case '⠤' -> '_'; // Dots-46 36 (Low line)
					default -> ch;
				};
			case '⠐' -> // Dots-5
				switch (ch2) {
					case '⠣' -> '('; // Dots-5 126 (Round bracket, opening)
					case '⠜' -> ')'; // Dots-5 345 (Round bracket, closing)
					case '⠂' -> '〃'; // Dots-5 2 (U+3003 Ditto)
					case '⠖' -> '+'; // Dots-5 235 (U+002B Plus sign)
					case '⠦' -> '×'; // Dots-5 236 (U+00D7 Multiplication sign)
					case '⠶' -> '='; // Dots-5 2356
					case '⠌' -> '÷'; // Dots-5 34 (U+00F7 Division sign)
					case '⠔' -> '*'; // Dots-5 35
					case '⠤' -> '−'; // Dots-5 36 (U+2212 Minus sign)
					default -> ch;
				};
			case '⠠' -> // Dots-6
				switch (ch2) {
					case '⠦' -> '‘'; // Dots-6 236 (U+2018 Left single quote)
					case '⠴' -> '’'; // Dots-6 356 (U+2019 Right single quote)
					case '⠤' -> '—'; // Dots-6 36 (U+2014 Em dash)
					
					case '⠶' -> '"'; // Dots-6 2356 (Inches)
					default -> ch;
				};
			default -> ch;
		};
	}
	
	private static char brailleToSymbol3(char ch, char ch2, char ch3) {
		return switch (ch) {
			case '⠈' -> // Dots-4
				switch (ch2) {
					case '⠠' -> // Dots-6
						switch (ch3) {
							case '⠹' -> '†'; // Dots-4 6 1456 (Dagger)
							case '⠻' -> '‡'; // Dots-4 6 12456 (Double dagger)
							default -> ch;
						};
					default -> ch;
				};
			case '⠘' -> // Dots-45
			switch (ch2) {
				case '⠰' -> // Dots-56
					switch (ch3) {
						case '⠖' -> '¡'; // Dots-45 56 235 (Inverted exclamation mark)
						case '⠦' -> '¿'; // Dots-45 56 236 (Inverted question mark)
						default -> ch;
					};
				default -> ch;
			};
			default -> ch;
		};
	}
	
	private static char charAt(String str, int index, char defaultValue) {
		if (str.length() <= index) {
			return defaultValue;
		}
		
		return str.charAt(index);
	}
	
	private static boolean isWhitespace(char ch) {
		return Character.isWhitespace(ch) || ch == '　' || ch == '\u2800';
	}
	
	private static boolean isNewLine(char ch) {
		return (ch == '\r' || ch == '\n');
	}
	
	private static boolean isNumber(char ch) {
		return ('0' <= ch && ch <= '9') || ('０' <= ch && ch <= '９');
	}
	
	private static boolean isNumericSymbol(char ch) {
		return (
				ch == '.' || ch == ',' ||
				ch == '．' || ch == '，' ||
				ch == ' ' // Numeric space
				);
	}
	
	private static boolean isUpperCaseLetter(char ch) {
		return ('A' <= ch && ch <= 'Z') || ('Ａ' <= ch && ch <= 'Ｚ');
	}
	
	private static boolean isLowerCaseLetter(char ch) {
		return ('a' <= ch && ch <= 'z') || ('ａ' <= ch && ch <= 'ｚ');
	}
	
	private static boolean isLowerCaseLetterA2J(char ch) {
		return ('a' <= ch && ch <= 'j') || ('ａ' <= ch && ch <= 'ｊ');
	}
	
	private static char toUpperCaseLetter(char ch) {
		if ('a' <= ch && ch <= 'z') {
			return (char)(ch + ('A' - 'a'));
		} else if ('ａ' <= ch && ch <= 'ｚ') {
			return (char)(ch + ('Ａ' - 'ａ'));
		}
		
		return ch;
	}
	
	private static char toLowerCaseLetter(char ch) {
		if ('A' <= ch && ch <= 'Z') {
			return (char)(ch + ('a' - 'A'));
		} else if ('Ａ' <= ch && ch <= 'Ｚ') {
			return (char)(ch + ('ａ' - 'Ａ'));
		}
		
		return ch;
	}
	
	private static boolean isUpperLetters(String value, int from, int len) {
		int to = from + len;
		if (value.length() < to) {
			return false;
		}
		
		for (int i = from; i < to; i++) {
			char ch = value.charAt(i);
			
			if (!isUpperCaseLetter(ch)) {
				return false;
			}
		}
		
		return true;
	}
	
	private static boolean isNotLowerLetters(String value, int from, int maxLen, int minLetterCount, int minWhitespaceCount) {
		if (value.length() <= from) {
			return false;
		}
		
		int to = Math.min(from + maxLen, value.length());
		int letterCount = 0;
		int whitespaceCount = 0;
		
		for (int i = from; i < to; i++) {
			char ch = value.charAt(i);
			
			if (isLowerCaseLetter(ch)) {
				return false;
			}
			
			if (isUpperCaseLetter(ch)) {
				letterCount++;
			} else if (isWhitespace(ch)) {
				whitespaceCount++;
			}
			
			if (minLetterCount <= letterCount && minWhitespaceCount <= whitespaceCount) {
				return true;
			}
		}
		
		return false;
	}
	
	private static List<Indicator> removeIndicator(List<Indicator> indicatorList, Indicator indicator) {
		int idx = indicatorList.lastIndexOf(indicator);
		if (idx == -1) {
			return Collections.emptyList();
		}
		
		List<Indicator> sub = indicatorList.subList(idx, indicatorList.size());
		List<Indicator> removedIndicatorList = new ArrayList<>(sub);
		sub.clear();
		
		return removedIndicatorList;
	}
	
}
