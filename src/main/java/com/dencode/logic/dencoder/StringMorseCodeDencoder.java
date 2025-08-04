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
import java.util.Objects;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.morse-code", hasEncoder=true, hasDecoder=true)
public class StringMorseCodeDencoder {
	
	private static class Char {
		public char value;
		
		public Char(char value) { this.value = value; }
		@Override public int hashCode() { return Objects.hash(value); }
		@Override public boolean equals(Object obj) { return (value == ((Char)obj).value); }
	}
	
	private static class MorseTreeNode {
		public char value;
		public MorseTreeNode dit = null;
		public MorseTreeNode dah = null;
		
		public MorseTreeNode(char value) { this.value = value; }
	}
	
	public static final char CHAR_UNDEF = '\0';
	
	private static final String JAPANESE_VOICED_SOUND_MARK_CHARS = "ガギグゲゴザジズゼゾダヂヅデドバビブベボヴがぎぐげござじずぜぞだぢづでどばびぶべぼゔ";
	private static final String JAPANESE_UN_VOICED_SOUND_MARK_CHARS = "カキクケコサシスセソタチツテトハヒフヘホウかきくけこさしすせそたちつてとはひふへほう";
	private static final String JAPANESE_SEMI_VOICED_SOUND_MARK_CHARS = "パピプペポぱぴぷぺぽ";
	private static final String JAPANESE_UN_SEMI_VOICED_SOUND_MARK_CHARS = "ハヒフヘホはひふへほ";
	
	private static final Map<String, char[]> MAP_INTERNATIONAL = new HashMap<>() {
		private static final long serialVersionUID = 1L;
		{
			// See: https://en.wikipedia.org/wiki/Morse_code
			// See: https://www.itu.int/dms_pubrec/itu-r/rec/m/R-REC-M.1677-1-200910-I!!PDF-E.pdf
			
			put(".-", new char[] {'A', 'a'});
			put("-...", new char[] {'B', 'b'});
			put("-.-.", new char[] {'C', 'c'});
			put("-..", new char[] {'D', 'd'});
			put(".", new char[] {'E', 'e'});
			put("..-.", new char[] {'F', 'f'});
			put("--.", new char[] {'G', 'g'});
			put("....", new char[] {'H', 'h'});
			put("..", new char[] {'I', 'i'});
			put(".---", new char[] {'J', 'j'});
			put("-.-", new char[] {'K', 'k'});
			put(".-..", new char[] {'L', 'l'});
			put("--", new char[] {'M', 'm'});
			put("-.", new char[] {'N', 'n'});
			put("---", new char[] {'O', 'o'});
			put(".--.", new char[] {'P', 'p'});
			put("--.-", new char[] {'Q', 'q'});
			put(".-.", new char[] {'R', 'r'});
			put("...", new char[] {'S', 's'});
			put("-", new char[] {'T', 't'});
			put("..-", new char[] {'U', 'u'});
			put("...-", new char[] {'V', 'v'});
			put(".--", new char[] {'W', 'w'});
			put("-..-", new char[] {'X', 'x', '×'});
			put("-.--", new char[] {'Y', 'y'});
			put("--..", new char[] {'Z', 'z'});
			
			put(".----", new char[] {'1'});
			put("..---", new char[] {'2'});
			put("...--", new char[] {'3'});
			put("....-", new char[] {'4'});
			put(".....", new char[] {'5'});
			put("-....", new char[] {'6'});
			put("--...", new char[] {'7'});
			put("---..", new char[] {'8'});
			put("----.", new char[] {'9'});
			put("-----", new char[] {'0'});
			
			put(".-.-.-", new char[] {'.'});
			put("--..--", new char[] {','});
			put("---...", new char[] {':'});
			put("..--..", new char[] {'?'});
			put(".----.", new char[] {'\''});
			put("-....-", new char[] {'-'});
			put("-..-.", new char[] {'/'});
			put("-.--.", new char[] {'('});
			put("-.--.-", new char[] {')'});
			put(".-..-.", new char[] {'"'});
			put("-...-", new char[] {'='});
			put(".-.-.", new char[] {'+'});
			put(".--.-.", new char[] {'@'});
			
			// No standard
			put("-.-.--", new char[] {'!'});
			put(".-...", new char[] {'&'});
			put("-.-.-.", new char[] {';'});
			put("..--.-", new char[] {'_'});
			put("...-..-", new char[] {'$'});
			put("......", new char[] {'^'});
			
			// Non-Latin extensions
			put(".--.-", new char[] {'À', 'à', 'Å', 'å'});
			put(".-.-", new char[] {'Ä', 'ä', 'Æ', 'æ', 'Ą', 'ą'});
			put("-.-..", new char[] {'Ć', 'ć', 'Ĉ', 'ĉ', 'Ç', 'ç'});
			put("..-..", new char[] {'Đ', 'đ', 'É', 'é', 'Ę', 'ę'});
			put("..--.", new char[] {'Ð', 'ð'});
			put(".-..-", new char[] {'È', 'è', 'Ł', 'ł'});
			put("--.-.", new char[] {'Ĝ', 'ĝ'});
			put("----", new char[] {'Ĥ', 'ĥ', 'Š', 'š'});
			put(".---.", new char[] {'Ĵ', 'ĵ'});
			put("--.--", new char[] {'Ń', 'ń', 'Ñ', 'ñ'});
			put("---.", new char[] {'Ó', 'ó', 'Ö', 'ö', 'Ø', 'ø'});
			put("...-...", new char[] {'Ś', 'ś'});
			put("...-.", new char[] {'Ŝ', 'ŝ'});
			put(".--..", new char[] {'Þ', 'þ'});
			put("..--", new char[] {'Ü', 'ü', 'Ŭ', 'ŭ'});
			put("--..-.", new char[] {'Ź', 'ź'});
			put("--..-", new char[] {'Ż', 'ż'});
		}
	};
	
	private static final Map<String, char[]> MAP_JAPANESE = new HashMap<>() {
		private static final long serialVersionUID = 1L;
		{
			// See: https://en.wikipedia.org/wiki/Wabun_code
			
			put(".-", new char[] {'イ', 'ィ', 'い', 'ぃ'});
			put(".-.-", new char[] {'ロ', 'ろ'});
			put("-...", new char[] {'ハ', 'は'});
			put("-.-.", new char[] {'ニ', 'に'});
			put("-..", new char[] {'ホ', 'ほ'});
			put(".", new char[] {'ヘ', 'へ'});
			put("..-..", new char[] {'ト', 'と'});
			put("..-.", new char[] {'チ', 'ち'});
			put("--.", new char[] {'リ', 'り'});
			put("....", new char[] {'ヌ', 'ぬ'});
			put("-.--.", new char[] {'ル', 'る'});
			put(".---", new char[] {'ヲ', 'を'});
			put("-.-", new char[] {'ワ', 'わ'});
			put(".-..", new char[] {'カ', 'か'});
			put("--", new char[] {'ヨ', 'ョ', 'よ', 'ょ'});
			put("-.", new char[] {'タ', 'た'});
			put("---", new char[] {'レ', 'れ'});
			put("---.", new char[] {'ソ', 'そ'});
			put(".--.", new char[] {'ツ', 'ッ', 'つ', 'っ'});
			put("--.-", new char[] {'ネ', 'ね'});
			put(".-.", new char[] {'ナ', 'な'});
			put("...", new char[] {'ラ', 'ら'});
			put("-", new char[] {'ム', 'む'});
			put("..-", new char[] {'ウ', 'ゥ', 'う', 'ぅ'});
			put(".-..-", new char[] {'ヰ', 'ゐ'});
			put("..--", new char[] {'ノ', 'の'});
			put(".-...", new char[] {'オ', 'ォ', 'お', 'ぉ'});
			put("...-", new char[] {'ク', 'く'});
			put(".--", new char[] {'ヤ', 'ャ', 'や', 'ゃ'});
			put("-..-", new char[] {'マ', 'ま'});
			put("-.--", new char[] {'ケ', 'け'});
			put("--..", new char[] {'フ', 'ふ'});
			put("----", new char[] {'コ', 'こ'});
			put("-.---", new char[] {'エ', 'ェ', 'え', 'ぇ'});
			put(".-.--", new char[] {'テ', 'て'});
			put("--.--", new char[] {'ア', 'ァ', 'あ', 'ぁ'});
			put("-.-.-", new char[] {'サ', 'さ'});
			put("-.-..", new char[] {'キ', 'き'});
			put("-..--", new char[] {'ユ', 'ュ', 'ゆ', 'ゅ'});
			put("-...-", new char[] {'メ', 'め'});
			put("..-.-", new char[] {'ミ', 'み'});
			put("--.-.", new char[] {'シ', 'し'});
			put(".--..", new char[] {'ヱ', 'ゑ'});
			put("--..-", new char[] {'ヒ', 'ひ'});
			put("-..-.", new char[] {'モ', 'も'});
			put(".---.", new char[] {'セ', 'せ'});
			put("---.-", new char[] {'ス', 'す'});
			put(".-.-.", new char[] {'ン', 'ん'});
			
			put(".----", new char[] {'１', '1'});
			put("..---", new char[] {'２', '2'});
			put("...--", new char[] {'３', '3'});
			put("....-", new char[] {'４', '4'});
			put(".....", new char[] {'５', '5'});
			put("-....", new char[] {'６', '6'});
			put("--...", new char[] {'７', '7'});
			put("---..", new char[] {'８', '8'});
			put("----.", new char[] {'９', '9'});
			put("-----", new char[] {'０', '0'});
			
			put("..", new char[] {'゛', '\u3099'});
			put("..--.", new char[] {'゜', '\u309A'});
			put(".--.-", new char[] {'ー'});
			put(".-.-.-", new char[] {'、', '，', ','});
			put(".-.-..", new char[] {'。', '．', '.'});
			put("-.--.-", new char[] {'（', '('});
			put(".-..-.", new char[] {'）', ')'});
		}
	};
	
	private static final Map<String, char[]> MAP_RUSSIAN = new HashMap<>() {
		private static final long serialVersionUID = 1L;
		{
			// See: https://en.wikipedia.org/wiki/Russian_Morse_code
			
			put(".-", new char[] {'А', 'а'});
			put("-...", new char[] {'Б', 'б'});
			put(".--", new char[] {'В', 'в'});
			put("--.", new char[] {'Г', 'г'});
			put("-..", new char[] {'Д', 'д'});
			put(".", new char[] {'Е', 'е', 'Ё', 'ё'});
			put("...-", new char[] {'Ж', 'ж'});
			put("--..", new char[] {'З', 'з'});
			put("..", new char[] {'И', 'и'});
			put(".---", new char[] {'Й', 'й'});
			put("-.-", new char[] {'К', 'к'});
			put(".-..", new char[] {'Л', 'л'});
			put("--", new char[] {'М', 'м'});
			put("-.", new char[] {'Н', 'н'});
			put("---", new char[] {'О', 'о'});
			put(".--.", new char[] {'П', 'п'});
			put(".-.", new char[] {'Р', 'р'});
			put("...", new char[] {'С', 'с'});
			put("-", new char[] {'Т', 'т'});
			put("..-", new char[] {'У', 'у'});
			put("..-.", new char[] {'Ф', 'ф'});
			put("....", new char[] {'Х', 'х'});
			put("-.-.", new char[] {'Ц', 'ц'});
			put("---.", new char[] {'Ч', 'ч'});
			put("----", new char[] {'Ш', 'ш'});
			put("--.-", new char[] {'Щ', 'щ'});
			put("--.--", new char[] {'Ъ', 'ъ'});
			put("-.--", new char[] {'Ы', 'ы'});
			put("-..-", new char[] {'Ь', 'ь'});
			put("..-..", new char[] {'Э', 'э', 'Ѣ', 'ѣ'});
			put("..--", new char[] {'Ю', 'ю'});
			put(".-.-", new char[] {'Я', 'я'});
			
			put(".----", new char[] {'1'});
			put("..---", new char[] {'2'});
			put("...--", new char[] {'3'});
			put("....-", new char[] {'4'});
			put(".....", new char[] {'5'});
			put("-....", new char[] {'6'});
			put("--...", new char[] {'7'});
			put("---..", new char[] {'8'});
			put("----.", new char[] {'9'});
			put("-----", new char[] {'0'});
			
			put("......", new char[] {'.'});
			put(".-.-.-", new char[] {','});
			put("---...", new char[] {':'});
			put("-.-.-", new char[] {';'});
			put("-.--.-", new char[] {'(', ')'});
			put(".----.", new char[] {'\''});
			put(".-..-.", new char[] {'"'});
			put("-....-", new char[] {'—'});
			put("-..-.", new char[] {'/'});
			put("..--..", new char[] {'?'});
			put("--..--", new char[] {'!'});
			put("-...-", new char[] {'-'});
			put(".--.-.", new char[] {'@'});
		}
	};
	
	private static final Map<Char, String> ENC_MAP_INTERNATIONAL = toEncodingMap(MAP_INTERNATIONAL);
	private static final MorseTreeNode DEC_NODE_INTERNATIONAL = toDecodingNode(MAP_INTERNATIONAL);
	
	private static final Map<Char, String> ENC_MAP_JAPANESE = toEncodingMap(MAP_JAPANESE);
	private static final MorseTreeNode DEC_NODE_JAPANESE = toDecodingNode(MAP_JAPANESE);
	
	private static final Map<Char, String> ENC_MAP_RUSSIAN = toEncodingMap(MAP_RUSSIAN);
	private static final MorseTreeNode DEC_NODE_RUSSIAN = toDecodingNode(MAP_RUSSIAN);
	
	
	private StringMorseCodeDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrMorseCode(DencodeCondition cond) {
		String variant = DencodeUtils.getOption(cond.options(), "string.morse-code.variant", "international");
		
		Map<Char, String> encMap = switch (variant) {
		case "international" -> ENC_MAP_INTERNATIONAL;
		case "japanese" -> ENC_MAP_JAPANESE;
		case "russian" -> ENC_MAP_RUSSIAN;
		default -> ENC_MAP_INTERNATIONAL;
		};
		
		return encStrMorseCode(cond.value(), encMap, '.', '-', '/', ' ');
	}
	
	@DencoderFunction
	public static String decStrMorseCode(DencodeCondition cond) {
		String variant = DencodeUtils.getOption(cond.options(), "string.morse-code.variant", "international");
		
		MorseTreeNode node = switch (variant) {
		case "international" -> DEC_NODE_INTERNATIONAL;
		case "japanese" -> DEC_NODE_JAPANESE;
		case "russian" -> DEC_NODE_RUSSIAN;
		default -> DEC_NODE_INTERNATIONAL;
		};
		
		return decStrMorseCode(cond.value(), node, '.', '-', ' ');
	}
	
	
	private static String encStrMorseCode(String value, Map<Char, String> encMap, char dit, char dah, char wordSpace, char letterSpace) {
		if (value == null || value.isEmpty()) {
			return "";
		}
		
		int len = value.length();
		Char c = new Char(CHAR_UNDEF);
		
		boolean needsLetterSpace = false;
		StringBuilder sb = new StringBuilder(len * 5);
		for (int i = 0; i < len; i++) {
			char ch = value.charAt(i);
			
			if (isNewLine(ch)) {
				sb.append(ch);
				needsLetterSpace = false;
				continue;
			}
			
			if (needsLetterSpace) {
				sb.append(letterSpace);
			}
			needsLetterSpace = true;
			
			if (Character.isWhitespace(ch) || ch == '　') {
				sb.append(wordSpace);
			} else {
				char ch1;
				char ch2;
				if (hasVoicedSoundMark(ch)) {
					ch1 = removeVoicedSoundMark(ch);
					ch2 = '゛';
				} else if (hasSemiVoicedSoundMark(ch)) {
					ch1 = removeSemiVoicedSoundMark(ch);
					ch2 = '゜';
				} else {
					ch1 = ch;
					ch2 = CHAR_UNDEF;
				}

				c.value = ch1;
				String code = encMap.get(c);
				if (code == null) {
					// Unsupported letter
					sb.append(ch);
				} else {
					sb.append(code);
					
					if (ch2 != CHAR_UNDEF) {
						c.value = ch2;
						code = encMap.get(c);
						if (code == null) {
							// Unsupported letter
							sb.append(ch);
						} else {
							sb.append(letterSpace);
							sb.append(code);
						}
					}
				}
			}
		}
		
		return sb.toString();
	}
	
	private static String decStrMorseCode(String value, MorseTreeNode rootNode, char dit, char dah, char decodedWordSpace) {
		if (value == null || value.isEmpty()) {
			return "";
		}
		
		int len = value.length();
		int lastIdx = len - 1;
		
		StringBuilder sb = new StringBuilder(len);
		MorseTreeNode node = rootNode;
		int codeStartIdx = -1;
		for (int i = 0; i <= lastIdx; i++) {
			char ch = value.charAt(i);
			boolean isLast = (i == lastIdx);
			
			boolean isEndOfWord = isLast;
			int nch = -1;
			if (isDit(ch)) {
				if (node != null) {
					node = node.dit;
				}
				if (codeStartIdx == -1) {
					codeStartIdx = i;
				}
			} else if (isDah(ch)) {
				if (node != null) {
					node = node.dah;
				}
				if (codeStartIdx == -1) {
					codeStartIdx = i;
				}
			} else if (isLetterSpace(ch)) {
				isEndOfWord = true;
			} else if (isWordSpace(ch)) {
				nch = decodedWordSpace;
				isEndOfWord = true;
			} else if (isNewLine(ch)) {
				nch = ch;
				isEndOfWord = true;
			} else {
				// Unsupported letter
				nch = ch;
				isEndOfWord = true;
			}
			
			if (isEndOfWord) {
				if (node == rootNode) {
					// NOP
				} else {
					char c = (node == null) ? CHAR_UNDEF : node.value;
					if (c != CHAR_UNDEF) {
						if (c == '゛') {
							DencodeUtils.appendCombinedVoicedSoundMark(sb);
						} else if (c == '゜') {
							DencodeUtils.appendCombinedSemiVoicedSoundMark(sb);
						} else {
							sb.append(c);
						}
					} else {
						// Unsupported code
						sb.append(value, codeStartIdx, i + (isLast ? 1 : 0));
					}
				}
				
				if (nch != -1) {
					sb.append((char)nch);
				}
				
				node = rootNode;
				codeStartIdx = -1;
			}
		}
		
		return sb.toString();
	}
	
	private static Map<Char, String> toEncodingMap(Map<String, char[]> map) {
		Map<Char, String> m = new HashMap<>(map.size() * 2);
		for (Map.Entry<String, char[]> entry : map.entrySet()) {
			for (char ch : entry.getValue()) {
				m.put(new Char(ch), entry.getKey());
			}
		}
		return m;
	}
	
	private static MorseTreeNode toDecodingNode(Map<String, char[]> map) {
		MorseTreeNode rootNode = new MorseTreeNode(CHAR_UNDEF);
		
		for (Map.Entry<String, char[]> entry : map.entrySet()) {
			String codes = entry.getKey();
			char ch = entry.getValue()[0];
			
			MorseTreeNode node = rootNode;
			int lastIdx = codes.length() - 1;
			for (int i = 0; i <= lastIdx; i++) {
				char code = codes.charAt(i);
				boolean isLast = (i == lastIdx);
				
				if (isDit(code)) {
					if (node.dit == null) {
						node.dit = new MorseTreeNode((isLast) ? ch : CHAR_UNDEF);
					} else {
						if (isLast) {
							assert (node.dit.value == CHAR_UNDEF);
							node.dit.value = ch;
						}
					}
					node = node.dit;
				} else if (isDah(code)) {
					if (node.dah == null) {
						node.dah = new MorseTreeNode((isLast) ? ch : CHAR_UNDEF);
					} else {
						if (isLast) {
							assert (node.dah.value == CHAR_UNDEF);
							node.dah.value = ch;
						}
					}
					node = node.dah;
				} else {
					assert false;
				}
			}
		}
		
		return rootNode;
	}
	
	private static boolean isDit(char ch) {
		return (ch == '.' || ch == '・' || ch == '·');
	}
	
	private static boolean isDah(char ch) {
		return (ch == '-' || ch == '_' || ch == '=' || ch == '=' || ch == '－' || ch == '―' || ch == '−');
	}
	
	private static boolean isLetterSpace(char ch) {
		return (ch == ' ' || ch == '　');
	}
	
	private static boolean isWordSpace(char ch) {
		return (ch == '/' || ch == '／');
	}
	
	private static boolean isNewLine(char ch) {
		return (ch == '\r' || ch == '\n');
	}
	
	private static boolean hasVoicedSoundMark(char ch) {
		return JAPANESE_VOICED_SOUND_MARK_CHARS.indexOf(ch) != -1;
	}
	
	private static boolean hasSemiVoicedSoundMark(char ch) {
		return JAPANESE_SEMI_VOICED_SOUND_MARK_CHARS.indexOf(ch) != -1;
	}
	
	private static char removeVoicedSoundMark(char ch) {
		int idx = JAPANESE_VOICED_SOUND_MARK_CHARS.indexOf(ch);
		if (idx == -1) {
			return ch;
		}
		
		return JAPANESE_UN_VOICED_SOUND_MARK_CHARS.charAt(idx);
	}
	
	private static char removeSemiVoicedSoundMark(char ch) {
		int idx = JAPANESE_SEMI_VOICED_SOUND_MARK_CHARS.indexOf(ch);
		if (idx == -1) {
			return ch;
		}
		
		return JAPANESE_UN_SEMI_VOICED_SOUND_MARK_CHARS.charAt(idx);
	}
}
