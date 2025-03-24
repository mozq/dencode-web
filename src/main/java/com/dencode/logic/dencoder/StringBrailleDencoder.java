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
	// Japanese;
	//   See: [ISBN 978-4-907272-23-4] 特定非営利活動法人 全国視覚障害者情報提供施設協会. 点訳のてびき 第４版. Tokyo, Japan: 読書工房, 2019.  (Japanese)
	
	private enum Type {
		UpperLetter,
		LowerLetter,
		Number,
		Symbol,
		JP_Kana,
	}
	
	private enum Indicator {
		CapitalWord,
		CapitalPassage,
		AngleBracket(true), // <>
		CurlyBracket(true), // {}
		SquareBracket(true), // []
		RoundBracket(true), // ()
		DoubleQuote(true), // “”
		SingleQuote(true), // ‘’
		JP_Gaiji,
		JP_CornerBracket(true), // 「」
		JP_CornerBracket2(true), // 「」
		JP_WhiteCornerBracket(true), // 『』
		JP_RoundBracket(true), // ()
		JP_RoundBracket2(true), // ()
		JP_WhiteParenthesis(true), // ⦅⦆｟ ｠
		;
		
		private boolean bracket;
		private Indicator() { this(false); }
		private Indicator(boolean bracket) { this.bracket = bracket; }
		public boolean isBracket() { return this.bracket; }
	}
	
	
	private StringBrailleDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrBraille(DencodeCondition cond) {
		String variant = DencodeUtils.getOption(cond.options(), "string.braille.variant", "ueb1");
		
		return switch (variant) {
			case "japanese" -> encStrBrailleJapanese(cond.value());
			default -> encStrBrailleUEB1(cond.value());
		};
	}
	
	@DencoderFunction
	public static String decStrBraille(DencodeCondition cond) {
		String variant = DencodeUtils.getOption(cond.options(), "string.braille.variant", "ueb1");
		
		return switch (variant) {
			case "japanese" -> decStrBrailleJapanese(cond.value(), false);
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
			
			if (isNumber(ch)) {
				// Number
				if (prevType != Type.Number) {
					sb.append('⠼'); // Dots-3456 (Number indicator)
				}
				
				sb.append(numberToBraille(ch));
				
				prevType = Type.Number;
			} else if (prevType == Type.Number && isNumericSymbol(ch)) {
				// Numeric symbol
				sb.append(numericSymbolToBraille(ch));
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
			
			if (isBraille(ch)) {
				// Braille
				char dch;
				if (prevType == Type.Number && (dch = brailleToNumber(ch, false)) != ch) {
					// Number
					sb.append(dch);
					prevType = Type.Number;
				} else if (prevType == Type.Number && (dch = brailleToNumericSymbol(ch)) != ch) {
					// Numeric symbol
					sb.append(dch);
					prevType = Type.Number;
				} else if ((dch = brailleToLetter(ch, false)) != ch) {
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
				} else if ((dch = braille3ToSymbol(ch, ch2, ch3)) != ch) {
					// Symbol
					sb.append(dch);
					i += 2;
					prevType = Type.Symbol;
				} else if ((dch = braille2ToSymbol(ch, ch2)) != ch) {
					// Symbol
					sb.append(dch);
					i++;
					prevType = Type.Symbol;
				} else if ((dch = braille1ToSymbol(ch)) != ch) {
					// Symbol
					sb.append(dch);
					prevType = Type.Symbol;
				} else if (ch == '⠐' && ch2 == '⠠' && ch3 == '⠤') { // Dots-5 6 36 (U+2014 x 2 Long Em dash)
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
	
	private static String encStrBrailleJapanese(String value) {
		if (value == null || value.isEmpty()) {
			return "";
		}
		
		int len = value.length();
		
		Type prevType = null;
		List<Indicator> indicatorList = new ArrayList<>();
		
		StringBuilder sb = new StringBuilder(len * 2);
		for (int i = 0; i < len; i++) {
			char ch = value.charAt(i);
			char ch2 = charAt(value, i + 1, '\0');
			
			if (isNumber(ch)) {
				// Number
				if (prevType != Type.Number) {
					sb.append('⠼'); // Dots-3456 (Number indicator)
				}
				
				sb.append(numberToBraille(ch));
				
				prevType = Type.Number;
				removeIndicator(indicatorList, Indicator.JP_Gaiji);
			} else if (prevType == Type.Number && jp_isNumericSymbol(ch)) {
				// Numeric symbol
				sb.append(jp_numericSymbolToBraille(ch));
			} else if (isLowerCaseLetter(ch)) {
				// Lower-case letter
				if (!indicatorList.contains(Indicator.JP_Gaiji)) {
					sb.append('⠰'); // Dots-56 (Gaiji indicator)
					indicatorList.add(Indicator.JP_Gaiji);
				}
				
				if (indicatorList.contains(Indicator.CapitalWord)) {
					// Terminate capital indicator
					sb.append('⠰'); // Dots-56 (Gaiji indicator)
					removeIndicator(indicatorList, Indicator.CapitalWord);
				}
				
				sb.append(letterToBraille(ch));
				
				prevType = Type.LowerLetter;
			} else if (isUpperCaseLetter(ch)) {
				// Upper-case letter
				if (!indicatorList.contains(Indicator.JP_Gaiji)) {
					sb.append('⠰'); // Dots-56 (Gaiji indicator)
					indicatorList.add(Indicator.JP_Gaiji);
				}
				
				if (!indicatorList.contains(Indicator.CapitalWord)) {
					if (isUpperLetters(value, i + 1, 2)) {
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
			} else if ((ch == '.' || ch == '．') && indicatorList.contains(Indicator.JP_Gaiji)) {
				sb.append('⠲'); // Dots-256
				prevType = Type.LowerLetter;
			} else if (ch == '/' || ch == '／' && indicatorList.contains(Indicator.JP_Gaiji)) {
				sb.append('⠌'); // Dots-34
				prevType = Type.LowerLetter;
			} else if (isNewLine(ch)) {
				sb.append(ch);
				
				prevType = null;
				indicatorList.clear();
			} else if (isWhitespace(ch)) {
				sb.append('\u2800'); // Braille blank
				
				prevType = null;
				removeIndicator(indicatorList, Indicator.JP_Gaiji);
			} else if (ch == '-' || ch == '－') {
				if (indicatorList.contains(Indicator.JP_CornerBracket)) {
					// Corner bracket '「」' points a same braille '⠤',
					// so translate a hyphen '-' to a braille blank in the bracket
					sb.append('\u2800'); // Braille blank
				} else {
					sb.append('⠤'); // Dots-36
				}
				
				prevType = Type.Symbol;
				removeIndicator(indicatorList, Indicator.JP_Gaiji); // Tsunagi indicator resets Gaiji indicator
			} else {
				// Japanese
				
				boolean isPrevNumber = (prevType == Type.Number);
				boolean isPrevGaiji = indicatorList.contains(Indicator.JP_Gaiji);
				
				boolean tsunagiIndicator = false;
				int trailingBlanks = 0;
				String dstr;
				
				removeIndicator(indicatorList, Indicator.JP_Gaiji);
				
				if (ch == '、') {
					dstr = "⠰"; // Dots-56
					prevType = Type.Symbol;
					trailingBlanks = 1;
				} else if (ch == '。') {
					dstr = "⠲"; // Dots-256
					prevType = Type.Symbol;
					trailingBlanks = 2;
				} else if (ch == '?' || ch == '？') {
					dstr = "⠢"; // Dots-26
					prevType = Type.Symbol;
					trailingBlanks = 2;
				} else if (ch == '!' || ch == '！') {
					dstr = "⠖"; // Dots-235
					prevType = Type.Symbol;
					trailingBlanks = 2;
				} else if (ch == '・') {
					dstr = "⠐"; // Dots-5
					prevType = Type.Symbol;
					trailingBlanks = 1;
				} else {
					if ((dstr = jp_kana2ToBraille(ch, ch2)) != null) {
						prevType = Type.JP_Kana;
						tsunagiIndicator = ((isPrevNumber && jp_isNumericBraille(dstr.charAt(0))) || isPrevGaiji);
						i++;
					} else if ((dstr = jp_kana1ToBraille(ch)) != null) {
						prevType = Type.JP_Kana;
						tsunagiIndicator = ((isPrevNumber && jp_isNumericBraille(dstr.charAt(0))) || isPrevGaiji);
					} else if ((dstr = jp_lowerKanaToBraille(ch)) != null) {
						prevType = Type.JP_Kana;
					} else if ((dstr = jp_bracketSymbolToBraille(ch, indicatorList)) != null) {
						prevType = Type.Symbol;
						if (jp_isBracketPair(ch2, ch)) {
							// If the next character is a same bracket pair,
							// put a blank
							trailingBlanks = 1;
						}
					} else if ((dstr = jp_symbolToBraille(ch)) != null) {
						prevType = Type.Symbol;
					} else {
						dstr = null;
						prevType = null;
					}
				}
				
				if (dstr == null) {
					// Unsupported character
					sb.append(ch);
				} else {
					if (tsunagiIndicator) {
						sb.append('⠤'); // Dots-36
					}
					
					sb.append(dstr);
					
					if (trailingBlanks != 0 && !jp_isTrailingCharacter(ch2)) {
						for (int bi = 0; bi < trailingBlanks; bi++) {
							sb.append('\u2800'); // Braille blank
						}
					}
				}
			}
			
			if (prevType != Type.UpperLetter) {
				removeIndicator(indicatorList, Indicator.CapitalWord);
			}
		}
		
		return sb.toString();
	}
	
	private static String decStrBrailleJapanese(String value, boolean hiragana) {
		if (value == null || value.isEmpty()) {
			return "";
		}
		
		int len = value.length();
		int lastIdx = len - 1;
		
		Type prevType = null;
		boolean inCapitalLetter = false;
		boolean inCapitalWord = false;
		List<Indicator> bracketIndicators = new ArrayList<>();
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i <= lastIdx; i++) {
			char ch = value.charAt(i);
			char ch2 = charAt(value, i + 1, '\0');
			char ch3 = charAt(value, i + 2, '\0');
			
			inCapitalWord &= (prevType == Type.UpperLetter);
			
			if (isBraille(ch)) {
				// Braille
				char dch;
				String dstr;
				if (prevType == Type.Number && (dch = brailleToNumber(ch, true)) != ch) {
					// Number
					sb.append(dch);
					prevType = Type.Number;
				} else if (prevType == Type.Number && (dch = jp_brailleToNumericSymbol(ch)) != ch) {
					// Numeric symbol
					sb.append(dch);
				} else if ((prevType == Type.LowerLetter || prevType == Type.UpperLetter) && ch == '⠠') { // Dots-6 (Capital letter indicator)
					// Capital letter indicator
					if (ch == '⠠' && ch2 == '⠠') { // Dots-6 6 (Capital word indicator)
						i++;
						prevType = Type.UpperLetter;
						inCapitalWord = true;
					} else {  // Dots-6 (Capital letter indicator)
						prevType = Type.UpperLetter;
						inCapitalLetter = true;
					}
				} else if ((prevType == Type.LowerLetter || prevType == Type.UpperLetter) && (dch = brailleToLetter(ch, true)) != ch) {
					// Letter
					if (inCapitalLetter || inCapitalWord) {
						dch = toUpperCaseLetter(dch);
						prevType = Type.UpperLetter;
						inCapitalLetter = false;
					} else {
						prevType = Type.LowerLetter;
					}
					sb.append(dch);
				} else if ((prevType == Type.LowerLetter || prevType == Type.UpperLetter) && ch == '⠲') { // Dots-256
					sb.append('．');
					prevType = Type.LowerLetter;
				} else if ((prevType == Type.LowerLetter || prevType == Type.UpperLetter) && ch == '⠌') { // Dots-34
					sb.append('／');
					prevType = Type.LowerLetter;
				} else if ((prevType == Type.LowerLetter || prevType == Type.UpperLetter || prevType == Type.Number) && ch == '⠤') { // Dots-36
					if (ch2 == '⠰' || ch2 == '⠼') { // Dots-56 (Gaiji indicator)), Dots-3456 (Number indicator)
						// A following character is a letter or number
						// Hyphen
						sb.append('－');
						prevType = Type.Symbol;
					} else {
						// Tsunagi indicator
						prevType = null;
					}
				} else if ((dch = jp_braille2ToLowerKana(ch, ch2, hiragana)) != ch) {
					// Kana
					sb.append(dch);
					prevType = Type.JP_Kana;
					i++;
				} else if ((dch = jp_braille2ToSymbol(ch, ch2)) != ch) {
					// Symbol
					sb.append(dch);
					prevType = Type.Symbol;
					i++;
				} else if ((dch = jp_braille2ToBracketSymbol(ch, ch2, bracketIndicators)) != ch) {
					// Bracket
					sb.append(dch);
					prevType = Type.Symbol;
					i++;
				} else if ((dch = jp_braille1ToBracketSymbol(ch, bracketIndicators)) != ch) {
					// Bracket
					sb.append(dch);
					prevType = Type.Symbol;
				} else if (ch == '\u2800') { // Braille blank
					sb.append('　');
					prevType = null;
				} else if (ch == '⠼') { // Dots-3456 (Number indicator)
					prevType = Type.Number;
				} else if (ch == '⠰' && jp_isTrailingBraille(ch2)) { // Dots-56
					sb.append('、');
					prevType = Type.Symbol;
					i += countBlankBraille(ch2);
				} else if (ch == '⠰') { // Dots-56
					// Gaiji indicator
					prevType = Type.LowerLetter;
				} else if (ch == '⠲' && jp_isTrailingBraille(ch2)) { // Dots-256
					sb.append('。');
					prevType = Type.Symbol;
					i += countBlankBraille(ch2, ch3);
				} else if (ch == '⠢' && jp_isTrailingBraille(ch2)) { // Dots-26
					sb.append('？');
					prevType = Type.Symbol;
					i += countBlankBraille(ch2, ch3);
				} else if (ch == '⠖' && jp_isTrailingBraille(ch2)) { // Dots-235
					sb.append('！');
					prevType = Type.Symbol;
					i += countBlankBraille(ch2, ch3);
				} else if (ch == '⠐' && jp_isTrailingBraille(ch2)) { // Dots-5
					sb.append('・');
					prevType = Type.Symbol;
					i += countBlankBraille(ch2);
				} else if ((dch = jp_braille2ToKana1(ch, ch2, hiragana)) != ch) {
					// Kana
					sb.append(dch);
					prevType = Type.JP_Kana;
					i++;
				} else if ((dstr = jp_braille2ToKana2(ch, ch2, hiragana)) != null) {
					// Kana
					sb.append(dstr);
					prevType = Type.JP_Kana;
					i++;
				} else if ((dch = jp_braille1ToKana1(ch, hiragana)) != ch) {
					// Kana
					sb.append(dch);
					prevType = Type.JP_Kana;
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
			default -> ch;
		};
	}
	
	private static char brailleToNumber(char ch, boolean fullWidth) {
		return switch (ch) {
			case '⠁' -> (fullWidth) ? '１' : '1'; // Dots-1
			case '⠃' -> (fullWidth) ? '２' : '2'; // Dots-12
			case '⠉' -> (fullWidth) ? '３' : '3'; // Dots-14
			case '⠙' -> (fullWidth) ? '４' : '4'; // Dots-145
			case '⠑' -> (fullWidth) ? '５' : '5'; // Dots-15
			case '⠋' -> (fullWidth) ? '６' : '6'; // Dots-124
			case '⠛' -> (fullWidth) ? '７' : '7'; // Dots-1245
			case '⠓' -> (fullWidth) ? '８' : '8'; // Dots-125
			case '⠊' -> (fullWidth) ? '９' : '9'; // Dots-24
			case '⠚' -> (fullWidth) ? '０' : '0'; // Dots-245
			default -> ch;
		};
	}
	
	private static char numericSymbolToBraille(char ch) {
		return switch (ch) {
			case '.', '．' -> '⠲'; // Dots-256
			case ',', '，' -> '⠂'; // Dots-2
			case ' ' -> '⠐'; // Dots-5 (U+2007 Numeric space)
			default -> ch;
		};
	}
	
	private static char brailleToNumericSymbol(char ch) {
		return switch (ch) {
			case '⠲' -> '.'; // Dots-256
			case '⠂' -> ','; // Dots-2
			case '⠐' -> ' '; // Dots-5 (U+2007 Numeric space)
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
			default -> ch;
		};
	}
	
	private static char brailleToLetter(char ch, boolean fullWidth) {
		return switch (ch) {
			case '⠁' -> (fullWidth) ? 'ａ' : 'a'; // Dots-1
			case '⠃' -> (fullWidth) ? 'ｂ' : 'b'; // Dots-12
			case '⠉' -> (fullWidth) ? 'ｃ' : 'c'; // Dots-14
			case '⠙' -> (fullWidth) ? 'ｄ' : 'd'; // Dots-145
			case '⠑' -> (fullWidth) ? 'ｅ' : 'e'; // Dots-15
			case '⠋' -> (fullWidth) ? 'ｆ' : 'f'; // Dots-124
			case '⠛' -> (fullWidth) ? 'ｇ' : 'g'; // Dots-1245
			case '⠓' -> (fullWidth) ? 'ｈ' : 'h'; // Dots-125
			case '⠊' -> (fullWidth) ? 'ｉ' : 'i'; // Dots-24
			case '⠚' -> (fullWidth) ? 'ｊ' : 'j'; // Dots-245
			case '⠅' -> (fullWidth) ? 'ｋ' : 'k'; // Dots-13
			case '⠇' -> (fullWidth) ? 'ｌ' : 'l'; // Dots-123
			case '⠍' -> (fullWidth) ? 'ｍ' : 'm'; // Dots-134
			case '⠝' -> (fullWidth) ? 'ｎ' : 'n'; // Dots-1345
			case '⠕' -> (fullWidth) ? 'ｏ' : 'o'; // Dots-135
			case '⠏' -> (fullWidth) ? 'ｐ' : 'p'; // Dots-1234
			case '⠟' -> (fullWidth) ? 'ｑ' : 'q'; // Dots-12345
			case '⠗' -> (fullWidth) ? 'ｒ' : 'r'; // Dots-1235
			case '⠎' -> (fullWidth) ? 'ｓ' : 's'; // Dots-234
			case '⠞' -> (fullWidth) ? 'ｔ' : 't'; // Dots-2345
			case '⠥' -> (fullWidth) ? 'ｕ' : 'u'; // Dots-136
			case '⠧' -> (fullWidth) ? 'ｖ' : 'v'; // Dots-1236
			case '⠺' -> (fullWidth) ? 'ｗ' : 'w'; // Dots-2456
			case '⠭' -> (fullWidth) ? 'ｘ' : 'x'; // Dots-1346
			case '⠽' -> (fullWidth) ? 'ｙ' : 'y'; // Dots-13456
			case '⠵' -> (fullWidth) ? 'ｚ' : 'z'; // Dots-1356
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
	
	private static char braille1ToSymbol(char ch) {
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
	
	private static char braille2ToSymbol(char ch, char ch2) {
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
	
	private static char braille3ToSymbol(char ch, char ch2, char ch3) {
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
	
	
	private static char jp_numericSymbolToBraille(char ch) {
		return switch (ch) {
			case '.', '．' -> '⠂'; // Dots-2
			case ',', '，' -> '⠄'; // Dots-3
			default -> ch;
		};
	}
	
	private static char jp_brailleToNumericSymbol(char ch) {
		return switch (ch) {
			case '⠂' -> '．'; // Dots-2
			case '⠄' -> '，'; // Dots-3
			default -> ch;
		};
	}
	
	private static String jp_kana1ToBraille(char ch) {
		return switch (ch) {
			case 'ア', 'あ' -> "⠁"; // Dots-1
			case 'イ', 'い' -> "⠃"; // Dots-12
			case 'ウ', 'う' -> "⠉"; // Dots-14
			case 'エ', 'え' -> "⠋"; // Dots-124
			case 'オ', 'お' -> "⠊"; // Dots-24
			
			case 'カ', 'か' -> "⠡"; // Dots-16
			case 'キ', 'き' -> "⠣"; // Dots-126
			case 'ク', 'く' -> "⠩"; // Dots-146
			case 'ケ', 'け' -> "⠫"; // Dots-1246
			case 'コ', 'こ' -> "⠪"; // Dots-246
			
			case 'サ', 'さ' -> "⠱"; // Dots-156
			case 'シ', 'し' -> "⠳"; // Dots-1256
			case 'ス', 'す' -> "⠹"; // Dots-1456
			case 'セ', 'せ' -> "⠻"; // Dots-12456
			case 'ソ', 'そ' -> "⠺"; // Dots-2456
			
			case 'タ', 'た' -> "⠕"; // Dots-135
			case 'チ', 'ち' -> "⠗"; // Dots-1235
			case 'ツ', 'つ' -> "⠝"; // Dots-1345
			case 'テ', 'て' -> "⠟"; // Dots-12345
			case 'ト', 'と' -> "⠞"; // Dots-2345
			
			case 'ナ', 'な' -> "⠅"; // Dots-13
			case 'ニ', 'に' -> "⠇"; // Dots-123
			case 'ヌ', 'ぬ' -> "⠍"; // Dots-134
			case 'ネ', 'ね' -> "⠏"; // Dots-1234
			case 'ノ', 'の' -> "⠎"; // Dots-234
			
			case 'ハ', 'は' -> "⠥"; // Dots-136
			case 'ヒ', 'ひ' -> "⠧"; // Dots-1236
			case 'フ', 'ふ' -> "⠭"; // Dots-1346
			case 'ヘ', 'へ' -> "⠯"; // Dots-12346
			case 'ホ', 'ほ' -> "⠮"; // Dots-2346
			
			case 'マ', 'ま' -> "⠵"; // Dots-1356
			case 'ミ', 'み' -> "⠷"; // Dots-12356
			case 'ム', 'む' -> "⠽"; // Dots-13456
			case 'メ', 'め' -> "⠿"; // Dots-123456
			case 'モ', 'も' -> "⠾"; // Dots-23456
			
			case 'ラ', 'ら' -> "⠑"; // Dots-15
			case 'リ', 'り' -> "⠓"; // Dots-125
			case 'ル', 'る' -> "⠙"; // Dots-145
			case 'レ', 'れ' -> "⠛"; // Dots-1245
			case 'ロ', 'ろ' -> "⠚"; // Dots-245
			
			case 'ヤ', 'や' -> "⠌"; // Dots-34
			case 'ユ', 'ゆ' -> "⠬"; // Dots-346
			case 'ヨ', 'よ' -> "⠜"; // Dots-345
			
			case 'ワ', 'わ' -> "⠄"; // Dots-3
			case 'ヰ', 'ゐ' -> "⠆"; // Dots-23
			case 'ヱ', 'ゑ' -> "⠖"; // Dots-235
			case 'ヲ', 'を' -> "⠔"; // Dots-35
			
			case 'ン', 'ん' -> "⠴"; // Dots-356
			case 'ッ', 'っ' -> "⠂"; // Dots-2
			case 'ー' -> "⠒"; // Dots-25
			
			case 'ヴ', 'ゔ' -> "⠐⠉"; // Dots-5 14
			
			case 'ガ', 'が' -> "⠐⠡"; // Dots-5 16
			case 'ギ', 'ぎ' -> "⠐⠣"; // Dots-5 126
			case 'グ', 'ぐ' -> "⠐⠩"; // Dots-5 146
			case 'ゲ', 'げ' -> "⠐⠫"; // Dots-5 1246
			case 'ゴ', 'ご' -> "⠐⠪"; // Dots-5 246
			
			case 'ザ', 'ざ' -> "⠐⠱"; // Dots-5 156
			case 'ジ', 'じ' -> "⠐⠳"; // Dots-5 1256
			case 'ズ', 'ず' -> "⠐⠹"; // Dots-5 1456
			case 'ゼ', 'ぜ' -> "⠐⠻"; // Dots-5 12456
			case 'ゾ', 'ぞ' -> "⠐⠺"; // Dots-5 2456
			
			case 'ダ', 'だ' -> "⠐⠕"; // Dots-5 135
			case 'ヂ', 'ぢ' -> "⠐⠗"; // Dots-5 1235
			case 'ヅ', 'づ' -> "⠐⠝"; // Dots-5 1345
			case 'デ', 'で' -> "⠐⠟"; // Dots-5 12345
			case 'ド', 'ど' -> "⠐⠞"; // Dots-5 2345
			
			case 'バ', 'ば' -> "⠐⠥"; // Dots-5 136
			case 'ビ', 'び' -> "⠐⠧"; // Dots-5 1236
			case 'ブ', 'ぶ' -> "⠐⠭"; // Dots-5 1346
			case 'ベ', 'べ' -> "⠐⠯"; // Dots-5 12346
			case 'ボ', 'ぼ' -> "⠐⠮"; // Dots-5 2346
			
			case 'パ', 'ぱ' -> "⠠⠥"; // Dots-6 136
			case 'ピ', 'ぴ' -> "⠠⠧"; // Dots-6 1236
			case 'プ', 'ぷ' -> "⠠⠭"; // Dots-6 1346
			case 'ペ', 'ぺ' -> "⠠⠯"; // Dots-6 12346
			case 'ポ', 'ぽ' -> "⠠⠮"; // Dots-6 2346
			
			default -> null;
		};
	}
	
	private static String jp_kana2ToBraille(char ch, char ch2) {
		return switch (ch) {
			case 'イ', 'い' -> switch (ch2) {
				case 'ェ', 'ぇ' -> "⠈⠋"; // 拗音符+エ (外来語)
				default -> null;
			};
			case 'キ', 'き' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠈⠡"; // 拗音符+カ
				case 'ュ', 'ゅ' -> "⠈⠩"; // 拗音符+ク
				case 'ェ', 'ぇ' -> "⠈⠫"; // 拗音符+ケ (外来語)
				case 'ョ', 'ょ' -> "⠈⠪"; // 拗音符+コ
				default -> null;
			};
			case 'シ', 'し' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠈⠱"; // 拗音符+サ
				case 'ュ', 'ゅ' -> "⠈⠹"; // 拗音符+ス
				case 'ェ', 'ぇ' -> "⠈⠻"; // 拗音符+セ (外来語)
				case 'ョ', 'ょ' -> "⠈⠺"; // 拗音符+ソ
				default -> null;
			};
			case 'ス', 'す' -> switch (ch2) {
				case 'ィ', 'ぃ' -> "⠈⠳"; // 拗音符+シ (外来語)
				default -> null;
			};
			case 'チ', 'ち' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠈⠕"; // 拗音符+タ
				case 'ュ', 'ゅ' -> "⠈⠝"; // 拗音符+ツ
				case 'ェ', 'ぇ' -> "⠈⠟"; // 拗音符+テ (外来語)
				case 'ョ', 'ょ' -> "⠈⠞"; // 拗音符+ト
				default -> null;
			};
			case 'テ', 'て' -> switch (ch2) {
				case 'ィ', 'ぃ' -> "⠈⠗"; // 拗音符+チ (外来語)
				case 'ュ', 'ゅ' -> "⠨⠝"; // 拗半濁音符+ツ (外来語)
				default -> null;
			};
			case 'ニ', 'に' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠈⠅"; // 拗音符+ナ
				case 'ュ', 'ゅ' -> "⠈⠍"; // 拗音符+ヌ
				case 'ェ', 'ぇ' -> "⠈⠏"; // 拗音符+ネ (外来語)
				case 'ョ', 'ょ' -> "⠈⠎"; // 拗音符+ノ
				default -> null;
			};
			case 'ヒ', 'ひ' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠈⠥"; // 拗音符+ハ
				case 'ュ', 'ゅ' -> "⠈⠭"; // 拗音符+フ
				case 'ェ', 'ぇ' -> "⠈⠯"; // 拗音符+ヘ (外来語)
				case 'ョ', 'ょ' -> "⠈⠮"; // 拗音符+ホ
				default -> null;
			};
			case 'ミ', 'み' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠈⠵"; // 拗音符+マ
				case 'ュ', 'ゅ' -> "⠈⠽"; // 拗音符+ム
				case 'ョ', 'ょ' -> "⠈⠾"; // 拗音符+モ
				default -> null;
			};
			case 'リ', 'り' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠈⠑"; // 拗音符+ラ
				case 'ュ', 'ゅ' -> "⠈⠙"; // 拗音符+ル
				case 'ョ', 'ょ' -> "⠈⠚"; // 拗音符+ロ
				default -> null;
			};
			case 'ギ', 'ぎ' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠘⠡"; // 拗濁音符+カ
				case 'ュ', 'ゅ' -> "⠘⠩"; // 拗濁音符+ク
				case 'ョ', 'ょ' -> "⠘⠪"; // 拗濁音符+コ
				default -> null;
			};
			case 'ジ', 'じ' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠘⠱"; // 拗濁音符+サ
				case 'ュ', 'ゅ' -> "⠘⠹"; // 拗濁音符+ス
				case 'ェ', 'ぇ' -> "⠘⠻"; // 拗濁音符+セ (外来語)
				case 'ョ', 'ょ' -> "⠘⠺"; // 拗濁音符+ソ
				default -> null;
			};
			case 'ズ', 'ず' -> switch (ch2) {
				case 'ィ', 'ぃ' -> "⠘⠳"; // 拗濁音符+シ (外来語)
				default -> null;
			};
			case 'ヂ', 'ぢ' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠘⠕"; // 拗濁音符+タ
				case 'ュ', 'ゅ' -> "⠘⠝"; // 拗濁音符+ツ
				case 'ョ', 'ょ' -> "⠘⠞"; // 拗濁音符+ト
				default -> null;
			};
			case 'デ', 'で' -> switch (ch2) {
				case 'ィ', 'ぃ' -> "⠘⠗"; // 拗濁音符+チ (外来語)
				case 'ュ', 'ゅ' -> "⠸⠝"; // [456]+ツ (外来語)
				default -> null;
			};
			case 'ビ', 'び' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠘⠥"; // 拗濁音符+ハ
				case 'ュ', 'ゅ' -> "⠘⠭"; // 拗濁音符+フ
				case 'ョ', 'ょ' -> "⠘⠮"; // 拗濁音符+ホ
				default -> null;
			};
			case 'ピ', 'ぴ' -> switch (ch2) {
				case 'ャ', 'ゃ' -> "⠨⠥"; // 拗半濁音符+ハ
				case 'ュ', 'ゅ' -> "⠨⠭"; // 拗半濁音符+フ
				case 'ョ', 'ょ' -> "⠨⠮"; // 拗半濁音符+ホ
				default -> null;
			};
			case 'ウ', 'う' -> switch (ch2) {
				case 'ァ', 'ぁ' -> "⠢⠁"; // 疑問符+ア (外来語)
				case 'ィ', 'ぃ' -> "⠢⠃"; // 疑問符+イ (外来語)
				case 'ェ', 'ぇ' -> "⠢⠋"; // 疑問符+エ (外来語)
				case 'ォ', 'ぉ' -> "⠢⠊"; // 疑問符+オ (外来語)
				default -> null;
			};
			case 'ク', 'く' -> switch (ch2) {
				case 'ァ', 'ぁ' -> "⠢⠡"; // 疑問符+カ (外来語)
				case 'ィ', 'ぃ' -> "⠢⠣"; // 疑問符+キ (外来語)
				case 'ェ', 'ぇ' -> "⠢⠫"; // 疑問符+ケ (外来語)
				case 'ォ', 'ぉ' -> "⠢⠪"; // 疑問符+コ (外来語)
				default -> null;
			};
			case 'ツ', 'つ' -> switch (ch2) {
				case 'ァ', 'ぁ' -> "⠢⠕"; // 疑問符+タ (外来語)
				case 'ィ', 'ぃ' -> "⠢⠗"; // 疑問符+チ (外来語)
				case 'ェ', 'ぇ' -> "⠢⠟"; // 疑問符+テ (外来語)
				case 'ォ', 'ぉ' -> "⠢⠞"; // 疑問符+ト (外来語)
				default -> null;
			};
			case 'ト', 'と' -> switch (ch2) {
				case 'ゥ', 'ぅ' -> "⠢⠝"; // 疑問符+ツ (外来語)
				default -> null;
			};
			case 'フ', 'ふ' -> switch (ch2) {
				case 'ァ', 'ぁ' -> "⠢⠥"; // 疑問符+ハ (外来語)
				case 'ィ', 'ぃ' -> "⠢⠧"; // 疑問符+ヒ (外来語)
				case 'ェ', 'ぇ' -> "⠢⠯"; // 疑問符+ヘ (外来語)
				case 'ォ', 'ぉ' -> "⠢⠮"; // 疑問符+ホ (外来語)
				case 'ュ', 'ゅ' -> "⠨⠬"; // 拗半濁音符+ユ (外来語)
				case 'ョ', 'ょ' -> "⠨⠜"; // 拗半濁音符+ヨ (外来語)
				default -> null;
			};
			case 'ヴ', 'ゔ' -> switch (ch2) {
				case 'ァ', 'ぁ' -> "⠲⠥"; // 句点符+ハ (外来語)
				case 'ィ', 'ぃ' -> "⠲⠧"; // 句点符+ヒ (外来語)
				case 'ェ', 'ぇ' -> "⠲⠯"; // 句点符+ヘ (外来語)
				case 'ォ', 'ぉ' -> "⠲⠮"; // 句点符+ホ (外来語)
				case 'ュ', 'ゅ' -> "⠸⠬"; // [456]+ユ (外来語)
				case 'ョ', 'ょ' -> "⠸⠜"; // [456]+ヨ (外来語)
				default -> null;
			};
			case 'グ', 'ぐ' -> switch (ch2) {
				case 'ァ', 'ぁ' -> "⠲⠡"; // 句点符+カ (外来語)
				case 'ィ', 'ぃ' -> "⠲⠣"; // 句点符+キ (外来語)
				case 'ェ', 'ぇ' -> "⠲⠫"; // 句点符+ケ (外来語)
				case 'ォ', 'ぉ' -> "⠲⠪"; // 句点符+コ (外来語)
				default -> null;
			};
			case 'ド', 'ど' -> switch (ch2) {
				case 'ゥ', 'ぅ' -> "⠲⠝"; // 句点符+ツ (外来語)
				default -> null;
			};
			default -> null;
		};
	}
	
	private static String jp_lowerKanaToBraille(char ch) {
		return switch (ch) {
			case 'ァ', 'ぁ' -> "⠘⠁"; // Dots-45 1
			case 'ィ', 'ぃ' -> "⠘⠃"; // Dots-45 12
			case 'ゥ', 'ぅ' -> "⠘⠉"; // Dots-45 14
			case 'ェ', 'ぇ' -> "⠘⠋"; // Dots-45 124
			case 'ォ', 'ぉ' -> "⠘⠊"; // Dots-45 24
			
			case 'ャ', 'ゃ' -> "⠘⠌"; // Dots-45 34
			case 'ュ', 'ゅ' -> "⠘⠬"; // Dots-45 346
			case 'ョ', 'ょ' -> "⠘⠜"; // Dots-45 345
			
			case 'ヮ', 'ゎ' -> "⠘⠄"; // Dots-45 3
			
			default -> null;
		};
	}
	
	private static char jp_braille1ToKana1(char ch, boolean hiragana) {
		return switch (ch) {
			case '⠁' -> (hiragana) ? 'あ' : 'ア'; // Dots-1
			case '⠃' -> (hiragana) ? 'い' : 'イ'; // Dots-12
			case '⠉' -> (hiragana) ? 'う' : 'ウ'; // Dots-14
			case '⠋' -> (hiragana) ? 'え' : 'エ'; // Dots-124
			case '⠊' -> (hiragana) ? 'お' : 'オ'; // Dots-24
			
			case '⠡' -> (hiragana) ? 'か' : 'カ'; // Dots-16
			case '⠣' -> (hiragana) ? 'き' : 'キ'; // Dots-126
			case '⠩' -> (hiragana) ? 'く' : 'ク'; // Dots-146
			case '⠫' -> (hiragana) ? 'け' : 'ケ'; // Dots-1246
			case '⠪' -> (hiragana) ? 'こ' : 'コ'; // Dots-246
			
			case '⠱' -> (hiragana) ? 'さ' : 'サ'; // Dots-156
			case '⠳' -> (hiragana) ? 'し' : 'シ'; // Dots-1256
			case '⠹' -> (hiragana) ? 'す' : 'ス'; // Dots-1456
			case '⠻' -> (hiragana) ? 'せ' : 'セ'; // Dots-12456
			case '⠺' -> (hiragana) ? 'そ' : 'ソ'; // Dots-2456
			
			case '⠕' -> (hiragana) ? 'た' : 'タ'; // Dots-135
			case '⠗' -> (hiragana) ? 'ち' : 'チ'; // Dots-1235
			case '⠝' -> (hiragana) ? 'つ' : 'ツ'; // Dots-1345
			case '⠟' -> (hiragana) ? 'て' : 'テ'; // Dots-12345
			case '⠞' -> (hiragana) ? 'と' : 'ト'; // Dots-2345
			
			case '⠅' -> (hiragana) ? 'な' : 'ナ'; // Dots-13
			case '⠇' -> (hiragana) ? 'に' : 'ニ'; // Dots-123
			case '⠍' -> (hiragana) ? 'ぬ' : 'ヌ'; // Dots-134
			case '⠏' -> (hiragana) ? 'ね' : 'ネ'; // Dots-1234
			case '⠎' -> (hiragana) ? 'の' : 'ノ'; // Dots-234
			
			case '⠥' -> (hiragana) ? 'は' : 'ハ'; // Dots-136
			case '⠧' -> (hiragana) ? 'ひ' : 'ヒ'; // Dots-1236
			case '⠭' -> (hiragana) ? 'ふ' : 'フ'; // Dots-1346
			case '⠯' -> (hiragana) ? 'へ' : 'ヘ'; // Dots-12346
			case '⠮' -> (hiragana) ? 'ほ' : 'ホ'; // Dots-2346
			
			case '⠵' -> (hiragana) ? 'ま' : 'マ'; // Dots-1356
			case '⠷' -> (hiragana) ? 'み' : 'ミ'; // Dots-12356
			case '⠽' -> (hiragana) ? 'む' : 'ム'; // Dots-13456
			case '⠿' -> (hiragana) ? 'め' : 'メ'; // Dots-123456
			case '⠾' -> (hiragana) ? 'も' : 'モ'; // Dots-23456
			
			case '⠑' -> (hiragana) ? 'ら' : 'ラ'; // Dots-15
			case '⠓' -> (hiragana) ? 'り' : 'リ'; // Dots-125
			case '⠙' -> (hiragana) ? 'る' : 'ル'; // Dots-145
			case '⠛' -> (hiragana) ? 'れ' : 'レ'; // Dots-1245
			case '⠚' -> (hiragana) ? 'ろ' : 'ロ'; // Dots-245
			
			case '⠌' -> (hiragana) ? 'や' : 'ヤ'; // Dots-34
			case '⠬' -> (hiragana) ? 'ゆ' : 'ユ'; // Dots-346
			case '⠜' -> (hiragana) ? 'よ' : 'ヨ'; // Dots-345
			
			case '⠄' -> (hiragana) ? 'わ' : 'ワ'; // Dots-3
			case '⠆' -> (hiragana) ? 'ゐ' : 'ヰ'; // Dots-23
			case '⠖' -> (hiragana) ? 'ゑ' : 'ヱ'; // Dots-235
			case '⠔' -> (hiragana) ? 'を' : 'ヲ'; // Dots-35
			
			case '⠴' -> (hiragana) ? 'ん' : 'ン'; // Dots-356
			case '⠂' -> (hiragana) ? 'っ' : 'ッ'; // Dots-2
			case '⠒' -> 'ー'; // Dots-25
			
			default -> ch;
		};
	}
	
	private static char jp_braille2ToKana1(char ch, char ch2, boolean hiragana) {
		return switch (ch) {
			case '⠐' -> switch (ch2) { // Dots-5
				case '⠉' -> (hiragana) ? 'ゔ' : 'ヴ'; // Dots-5 14
				
				case '⠡' -> (hiragana) ? 'が' : 'ガ'; // Dots-5 16
				case '⠣' -> (hiragana) ? 'ぎ' : 'ギ'; // Dots-5 126
				case '⠩' -> (hiragana) ? 'ぐ' : 'グ'; // Dots-5 146
				case '⠫' -> (hiragana) ? 'げ' : 'ゲ'; // Dots-5 1246
				case '⠪' -> (hiragana) ? 'ご' : 'ゴ'; // Dots-5 246
				
				case '⠱' -> (hiragana) ? 'ざ' : 'ザ'; // Dots-5 156
				case '⠳' -> (hiragana) ? 'じ' : 'ジ'; // Dots-5 1256
				case '⠹' -> (hiragana) ? 'ず' : 'ズ'; // Dots-5 1456
				case '⠻' -> (hiragana) ? 'ぜ' : 'ゼ'; // Dots-5 12456
				case '⠺' -> (hiragana) ? 'ぞ' : 'ゾ'; // Dots-5 2456
				
				case '⠕' -> (hiragana) ? 'だ' : 'ダ'; // Dots-5 135
				case '⠗' -> (hiragana) ? 'ぢ' : 'ヂ'; // Dots-5 1235
				case '⠝' -> (hiragana) ? 'づ' : 'ヅ'; // Dots-5 1345
				case '⠟' -> (hiragana) ? 'で' : 'デ'; // Dots-5 12345
				case '⠞' -> (hiragana) ? 'ど' : 'ド'; // Dots-5 2345
				
				case '⠥' -> (hiragana) ? 'ば' : 'バ'; // Dots-5 136
				case '⠧' -> (hiragana) ? 'び' : 'ビ'; // Dots-5 1236
				case '⠭' -> (hiragana) ? 'ぶ' : 'ブ'; // Dots-5 1346
				case '⠯' -> (hiragana) ? 'べ' : 'ベ'; // Dots-5 12346
				case '⠮' -> (hiragana) ? 'ぼ' : 'ボ'; // Dots-5 2346
				
				default -> ch;
			};
			
			case '⠠' -> switch (ch2) { // Dots-6
				case '⠥' -> (hiragana) ? 'ぱ' : 'パ'; // Dots-6 136
				case '⠧' -> (hiragana) ? 'ぴ' : 'ピ'; // Dots-6 1236
				case '⠭' -> (hiragana) ? 'ぷ' : 'プ'; // Dots-6 1346
				case '⠯' -> (hiragana) ? 'ぺ' : 'ペ'; // Dots-6 12346
				case '⠮' -> (hiragana) ? 'ぽ' : 'ポ'; // Dots-6 2346
				
				default -> ch;
			};
			
			default -> ch;
		};
	}
	
	private static String jp_braille2ToKana2(char ch, char ch2, boolean hiragana) {
		return switch (ch) {
			case '⠈' -> switch (ch2) { // 拗音符
				case '⠋' -> (hiragana) ? "いぇ" : "イェ"; // 拗音符+エ (外来語)
				
				case '⠡' -> (hiragana) ? "きゃ" : "キャ"; // 拗音符+カ
				case '⠩' -> (hiragana) ? "きゅ" : "キュ"; // 拗音符+ク
				case '⠫' -> (hiragana) ? "きぇ" : "キェ"; // 拗音符+ケ (外来語)
				case '⠪' -> (hiragana) ? "きょ" : "キョ"; // 拗音符+コ
				
				case '⠱' -> (hiragana) ? "しゃ" : "シャ"; // 拗音符+サ
				case '⠹' -> (hiragana) ? "しゅ" : "シュ"; // 拗音符+ス
				case '⠻' -> (hiragana) ? "しぇ" : "シェ"; // 拗音符+セ (外来語)
				case '⠺' -> (hiragana) ? "しょ" : "ショ"; // 拗音符+ソ
				
				case '⠳' -> (hiragana) ? "すぃ" : "スィ"; // 拗音符+シ (外来語)
				
				case '⠕' -> (hiragana) ? "ちゃ" : "チャ"; // 拗音符+タ
				case '⠝' -> (hiragana) ? "ちゅ" : "チュ"; // 拗音符+ツ
				case '⠟' -> (hiragana) ? "ちぇ" : "チェ"; // 拗音符+テ (外来語)
				case '⠞' -> (hiragana) ? "ちょ" : "チョ"; // 拗音符+ト
				
				case '⠗' -> (hiragana) ? "てぃ" : "ティ"; // 拗音符+チ (外来語)
				
				case '⠅' -> (hiragana) ? "にゃ" : "ニャ"; // 拗音符+ナ
				case '⠍' -> (hiragana) ? "にゅ" : "ニュ"; // 拗音符+ヌ
				case '⠏' -> (hiragana) ? "にぇ" : "ニェ"; // 拗音符+ネ (外来語)
				case '⠎' -> (hiragana) ? "にょ" : "ニョ"; // 拗音符+ノ
				
				case '⠥' -> (hiragana) ? "ひゃ" : "ヒャ"; // 拗音符+ハ
				case '⠭' -> (hiragana) ? "ひゅ" : "ヒュ"; // 拗音符+フ
				case '⠯' -> (hiragana) ? "ひぇ" : "ヒェ"; // 拗音符+ヘ (外来語)
				case '⠮' -> (hiragana) ? "ひょ" : "ヒョ"; // 拗音符+ホ
				
				case '⠵' -> (hiragana) ? "みゃ" : "ミャ"; // 拗音符+マ
				case '⠽' -> (hiragana) ? "みゅ" : "ミュ"; // 拗音符+ム
				case '⠾' -> (hiragana) ? "みょ" : "ミョ"; // 拗音符+モ
				
				case '⠑' -> (hiragana) ? "りゃ" : "リャ"; // 拗音符+ラ
				case '⠙' -> (hiragana) ? "りゅ" : "リュ"; // 拗音符+ル
				case '⠚' -> (hiragana) ? "りょ" : "リョ"; // 拗音符+ロ
				
				default -> null;
			};
			case '⠘' -> switch (ch2) { // 拗濁音符
				case '⠡' -> (hiragana) ? "ぎゃ" : "ギャ"; // 拗濁音符+カ
				case '⠩' -> (hiragana) ? "ぎゅ" : "ギュ"; // 拗濁音符+ク
				case '⠪' -> (hiragana) ? "ぎょ" : "ギョ"; // 拗濁音符+コ
				
				case '⠱' -> (hiragana) ? "じゃ" : "ジャ"; // 拗濁音符+サ
				case '⠹' -> (hiragana) ? "じゅ" : "ジュ"; // 拗濁音符+ス
				case '⠻' -> (hiragana) ? "じぇ" : "ジェ"; // 拗濁音符+セ (外来語)
				case '⠺' -> (hiragana) ? "じょ" : "ジョ"; // 拗濁音符+ソ
				
				case '⠳' -> (hiragana) ? "ずぃ" : "ズィ"; // 拗濁音符+シ (外来語)
				
				case '⠕' -> (hiragana) ? "ぢゃ" : "ヂャ"; // 拗濁音符+タ
				case '⠝' -> (hiragana) ? "ぢゅ" : "ヂュ"; // 拗濁音符+ツ
				case '⠞' -> (hiragana) ? "ぢょ" : "ヂョ"; // 拗濁音符+ト
				
				case '⠗' -> (hiragana) ? "でぃ" : "ディ"; // 拗濁音符+チ (外来語)
				
				case '⠥' -> (hiragana) ? "びゃ" : "ビャ"; // 拗濁音符+ハ
				case '⠭' -> (hiragana) ? "びゅ" : "ビュ"; // 拗濁音符+フ
				case '⠮' -> (hiragana) ? "びょ" : "ビョ"; // 拗濁音符+ホ
				
				default -> null;
			};
			case '⠨' -> switch (ch2) { // 拗半濁音符
				case '⠝' -> (hiragana) ? "てゅ" : "テュ"; // 拗半濁音符+ツ (外来語)
				
				case '⠥' -> (hiragana) ? "ぴゃ" : "ピャ"; // 拗半濁音符+ハ
				case '⠭' -> (hiragana) ? "ぴゅ" : "ピュ"; // 拗半濁音符+フ
				case '⠮' -> (hiragana) ? "ぴょ" : "ピョ"; // 拗半濁音符+ホ
				
				case '⠬' -> (hiragana) ? "ふゅ" : "フュ"; // 拗半濁音符+ユ (外来語)
				case '⠜' -> (hiragana) ? "ふょ" : "フョ"; // 拗半濁音符+ヨ (外来語)
				
				default -> null;
			};
			case '⠢' -> switch (ch2) { // 疑問符
				case '⠁' -> (hiragana) ? "うぁ" : "ウァ"; // 疑問符+ア (外来語)
				case '⠃' -> (hiragana) ? "うぃ" : "ウィ"; // 疑問符+イ (外来語)
				case '⠋' -> (hiragana) ? "うぇ" : "ウェ"; // 疑問符+エ (外来語)
				case '⠊' -> (hiragana) ? "うぉ" : "ウォ"; // 疑問符+オ (外来語)
				
				case '⠡' -> (hiragana) ? "くぁ" : "クァ"; // 疑問符+カ (外来語)
				case '⠣' -> (hiragana) ? "くぃ" : "クィ"; // 疑問符+キ (外来語)
				case '⠫' -> (hiragana) ? "くぇ" : "クェ"; // 疑問符+ケ (外来語)
				case '⠪' -> (hiragana) ? "くぉ" : "クォ"; // 疑問符+コ (外来語)
				
				case '⠕' -> (hiragana) ? "つぁ" : "ツァ"; // 疑問符+タ (外来語)
				case '⠗' -> (hiragana) ? "つぃ" : "ツィ"; // 疑問符+チ (外来語)
				case '⠟' -> (hiragana) ? "つぇ" : "ツェ"; // 疑問符+テ (外来語)
				case '⠞' -> (hiragana) ? "つぉ" : "ツォ"; // 疑問符+ト (外来語)
				
				case '⠝' -> (hiragana) ? "とぅ" : "トゥ"; // 疑問符+ツ (外来語)
				
				case '⠥' -> (hiragana) ? "ふぁ" : "ファ"; // 疑問符+ハ (外来語)
				case '⠧' -> (hiragana) ? "ふぃ" : "フィ"; // 疑問符+ヒ (外来語)
				case '⠯' -> (hiragana) ? "ふぇ" : "フェ"; // 疑問符+ヘ (外来語)
				case '⠮' -> (hiragana) ? "ふぉ" : "フォ"; // 疑問符+ホ (外来語)
				
				default -> null;
			};
			case '⠲' -> switch (ch2) { // 句点符
				case '⠥' -> (hiragana) ? "ゔぁ" : "ヴァ"; // 句点符+ハ (外来語)
				case '⠧' -> (hiragana) ? "ゔぃ" : "ヴィ"; // 句点符+ヒ (外来語)
				case '⠯' -> (hiragana) ? "ゔぇ" : "ヴェ"; // 句点符+ヘ (外来語)
				case '⠮' -> (hiragana) ? "ゔぉ" : "ヴォ"; // 句点符+ホ (外来語)
				
				case '⠡' -> (hiragana) ? "ぐぁ" : "グァ"; // 句点符+カ (外来語)
				case '⠣' -> (hiragana) ? "ぐぃ" : "グィ"; // 句点符+キ (外来語)
				case '⠫' -> (hiragana) ? "ぐぇ" : "グェ"; // 句点符+ケ (外来語)
				case '⠪' -> (hiragana) ? "ぐぉ" : "グォ"; // 句点符+コ (外来語)
				
				case '⠝' -> (hiragana) ? "どぅ" : "ドゥ"; // 句点符+ツ (外来語)
				
				default -> null;
			};
			case '⠸' -> switch (ch2) { // [456]
				case '⠝' -> (hiragana) ? "でゅ" : "デュ"; // [456]+ツ (外来語)
				
				case '⠬' -> (hiragana) ? "ゔゅ" : "ヴュ"; // [456]+ユ (外来語)
				case '⠜' -> (hiragana) ? "ゔょ" : "ヴョ"; // [456]+ヨ (外来語)
				
				default -> null;
			};
			
			default -> null;
		};
	}
	
	private static char jp_braille2ToLowerKana(char ch, char ch2, boolean hiragana) {
		return switch (ch) {
			case '⠘' -> switch (ch2) {
				case '⠁' -> (hiragana) ? 'ぁ' : 'ァ'; // Dots-45 1
				case '⠃' -> (hiragana) ? 'ぃ' : 'ィ'; // Dots-45 12
				case '⠉' -> (hiragana) ? 'ぅ' : 'ゥ'; // Dots-45 14
				case '⠋' -> (hiragana) ? 'ぇ' : 'ェ'; // Dots-45 124
				case '⠊' -> (hiragana) ? 'ぉ' : 'ォ'; // Dots-45 24
				
				case '⠌' -> (hiragana) ? 'ゃ' : 'ャ'; // Dots-45 34
				case '⠬' -> (hiragana) ? 'ゅ' : 'ュ'; // Dots-45 346
				case '⠜' -> (hiragana) ? 'ょ' : 'ョ'; // Dots-45 345
				
				case '⠄' -> (hiragana) ? 'ゎ' : 'ヮ'; // Dots-45 3
				
				default -> ch;
			};
			
			default -> ch;
		};
	}
	
	private static String jp_bracketSymbolToBraille(char ch, List<Indicator> indicatorList) {
		Indicator lastBracket = getLastBracketIndicator(indicatorList);
		
		return switch (ch) {
			case '「' -> {
				if (lastBracket == Indicator.JP_CornerBracket) {
					indicatorList.add(Indicator.JP_CornerBracket2);
					yield "⠰⠄"; // Dots-56 3
				} else {
					indicatorList.add(Indicator.JP_CornerBracket);
					yield "⠤"; // Dots-36
				}
			}
			case '『' -> {
				indicatorList.add(Indicator.JP_WhiteCornerBracket);
				yield "⠰⠤"; // Dots-56 36
			}
			case '(', '（' -> {
				if (lastBracket == Indicator.JP_RoundBracket) {
					indicatorList.add(Indicator.JP_RoundBracket2);
					yield "⠐⠶"; // Dots-5 2356
				} else {
					indicatorList.add(Indicator.JP_RoundBracket);
					yield "⠶"; // Dots-2356
				}
			}
			case '⦅', '｟' -> {
				indicatorList.add(Indicator.JP_WhiteParenthesis);
				yield "⠰⠶"; // Dots-56 2356
			}
			
			case '」' -> {
				if (lastBracket == Indicator.JP_CornerBracket2) {
					removeIndicator(indicatorList, Indicator.JP_CornerBracket2);
					yield "⠠⠆"; // Dots-6 23
				} else {
					removeIndicator(indicatorList, Indicator.JP_CornerBracket);
					yield "⠤"; // Dots-36
				}
			}
			case '』' -> {
				removeIndicator(indicatorList, Indicator.JP_WhiteCornerBracket);
				yield "⠤⠆"; // Dots-36 23
			}
			case ')', '）' -> {
				if (lastBracket == Indicator.JP_RoundBracket2) {
					removeIndicator(indicatorList, Indicator.JP_RoundBracket2);
					yield "⠶⠂"; // Dots-2356 2
				} else {
					removeIndicator(indicatorList, Indicator.JP_RoundBracket);
					yield "⠶"; // Dots-2356
				}
			}
			case '⦆', '｠' -> {
				removeIndicator(indicatorList, Indicator.JP_WhiteParenthesis);
				yield "⠶⠆"; // Dots-2356 23
			}
			
			default -> null;
		};
	}
	
	private static char jp_braille1ToBracketSymbol(char ch, List<Indicator> indicatorList) {
		Indicator lastBracket = getLastBracketIndicator(indicatorList);
		
		if (ch == '⠤') { // Dots-36
			if (lastBracket == Indicator.JP_CornerBracket) {
				removeIndicator(indicatorList, Indicator.JP_CornerBracket);
				return '」';
			} else {
				indicatorList.add(Indicator.JP_CornerBracket);
				return '「';
			}
		} else if (ch == '⠶') { // Dots-2356
			if (lastBracket == Indicator.JP_RoundBracket) {
				removeIndicator(indicatorList, Indicator.JP_RoundBracket);
				return '）';
			} else {
				indicatorList.add(Indicator.JP_RoundBracket);
				return '（';
			}
		}
		
		return ch;
	}
	
	private static char jp_braille2ToBracketSymbol(char ch, char ch2, List<Indicator> indicatorList) {
		if (ch == '⠰' && ch2 == '⠄') { // Dots-56 3
			indicatorList.add(Indicator.JP_CornerBracket2);
			return '「';
		} else if (ch == '⠠' && ch2 == '⠆') { // Dots-6 23
			removeIndicator(indicatorList, Indicator.JP_CornerBracket2);
			return '」';
		} else if (ch == '⠰' && ch2 == '⠤') { // Dots-56 36
			indicatorList.add(Indicator.JP_WhiteCornerBracket);
			return '『';
		} else if (ch == '⠤' && ch2 == '⠆') { // Dots-36 23
			removeIndicator(indicatorList, Indicator.JP_WhiteCornerBracket);
			return '』';
		} else if (ch == '⠐' && ch2 == '⠶') { // Dots-5 2356
			indicatorList.add(Indicator.JP_RoundBracket2);
			return '（';
		} else if (ch == '⠶' && ch2 == '⠂') { // Dots-2356 2
			removeIndicator(indicatorList, Indicator.JP_RoundBracket2);
			return '）';
		} else if (ch == '⠰' && ch2 == '⠶') { // Dots-56 2356
			indicatorList.add(Indicator.JP_WhiteParenthesis);
			return '｟';
		} else if (ch == '⠶' && ch2 == '⠆') { // Dots-2356 23
			removeIndicator(indicatorList, Indicator.JP_WhiteParenthesis);
			return '｠';
		}
		
		return ch;
	}

	private static String jp_symbolToBraille(char ch) {
		return switch (ch) {
			case '%', '％' -> "⠰⠏"; // Dots-56 1234
			case '&', '＆' -> "⠰⠯"; // Dots-56 12346
			case '#', '＃' -> "⠰⠩"; // Dots-56 146
			case '*', '＊' -> "⠰⠡"; // Dots-56 16
			case '@', '＠' -> "⠰⠪"; // Dots-56 246
			
			case '○' -> "⠂⠵"; // Dots-2 1356 (伏せ字)
			case '△' -> "⠂⠷"; // Dots-2 12356 (伏せ字)
			case '□' -> "⠂⠽"; // Dots-2 13456 (伏せ字)
			case '×' -> "⠂⠿"; // Dots-2 123456 (伏せ字)
			
			case '〜' -> "⠤⠤"; // Dots-36 36
			
			default -> null;
		};
	}

	private static char jp_braille2ToSymbol(char ch, char ch2) {
		return switch (ch) {
			case '⠰' -> switch (ch2) { // Dots-56
				case '⠏' -> '％'; // Dots-56 1234
				case '⠯' -> '＆'; // Dots-56 12346
				case '⠩' -> '＃'; // Dots-56 146
				case '⠡' -> '＊'; // Dots-56 16
				case '⠪' -> '＠'; // Dots-56 246
				
				default -> ch;
			};
			case '⠂' -> switch (ch2) { // Dots-2
				case '⠵' -> '○'; // Dots-2 1356 (伏せ字)
				case '⠷' -> '△'; // Dots-2 12356 (伏せ字)
				case '⠽' -> '□'; // Dots-2 13456 (伏せ字)
				case '⠿' -> '×'; // Dots-2 123456 (伏せ字)
				
				default -> ch;
			};
			case '⠤' -> switch (ch2) { // Dots-36
				case '⠤' -> '〜'; // Dots-36 36
				
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
	
	private static boolean isBraille(char ch) {
		return ('\u2800' <= ch && ch <= '\u283F');
	}
	
	private static boolean isWhitespace(char ch) {
		return Character.isWhitespace(ch) || ch == '　' || ch == '\u2800';
	}
	
	private static boolean isNewLine(char ch) {
		return (ch == '\r' || ch == '\n');
	}
	
	private static boolean isLineEnd(char ch) {
		return isNewLine(ch) || ch == '\0';
	}
	
	private static boolean isNumber(char ch) {
		return ('0' <= ch && ch <= '9') || ('０' <= ch && ch <= '９');
	}
	
	private static boolean isNumericSymbol(char ch) {
		return (numericSymbolToBraille(ch) != ch);
	}
	
	private static boolean jp_isNumericSymbol(char ch) {
		return (jp_numericSymbolToBraille(ch) != ch);
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
				return (i != from) && !isLowerCaseLetter(ch);
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
	
	private static boolean jp_isBracketPair(char ch1, char ch2) {
		return switch (ch1) {
			case '「' -> (ch2 == '」');
			case '『' -> (ch2 == '』');
			case '（', '(' -> (ch2 == '）' || ch2 == ')');
			case '｟', '⦅' -> (ch2 == '｠' || ch2 == '⦆');
			default -> false;
		};
	}
	
	private static boolean jp_isNumericBraille(char ch) {
		return (brailleToNumber(ch, true) != ch) || (jp_brailleToNumericSymbol(ch) != ch);
	}
	
	private static boolean jp_isTrailingCharacter(char ch) {
		return isLineEnd(ch)
				|| isWhitespace(ch)
				|| ch == '、'
				|| ch == '。'
				|| ch == '？' || ch == '?'
				|| ch == '！' || ch == '!'
				|| ch == '」'
				|| ch == '』'
				|| ch == '）' || ch == ')'
				|| ch == '｠' || ch == '⦆'
				;
	}
	
	private static boolean jp_isTrailingBraille(char ch) {
		return isLineEnd(ch)
				|| ch == '\u2800' // Braille blank
				|| ch == '⠰' // Dots-56 '、'
				|| ch == '⠲' // Dots-256 '。'
				|| ch == '⠢' // Dots-26 '？'
				|| ch == '⠖' // Dots-235 '！'
				|| ch == '⠤' // Dots-36 '」', '』'
				|| ch == '⠶' // Dots-2356 '）', '｠'
				;
	}
	
	private static int countBlankBraille(char ch1) {
		return countBlankBraille(ch1, '\0');
	}
	
	private static int countBlankBraille(char ch1, char ch2) {
		int count = 0;
		if (ch1 == '\u2800') { // Braille blank
			count++;
			if (ch2 == '\u2800') { // Braille blank
				count++;
			}
		}
		return count;
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
	
	private static Indicator getLastBracketIndicator(List<Indicator> indicatorList) {
		for (int i = indicatorList.size() - 1; 0 <= i; i--) {
			Indicator indicator = indicatorList.get(i);
			if (indicator.isBracket()) {
				return indicator;
			}
		}
		
		return null;
	}
}
