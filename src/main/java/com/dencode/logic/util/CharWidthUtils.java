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
package com.dencode.logic.util;

import java.util.EnumSet;

public class CharWidthUtils {
	
	public static enum Type {
		ALPHABET,
		NUMBER,
		SYMBOL,
		SPACE,
		KANA,
		HANGUL,
	}
	
	private static EnumSet<Type> TYPE_ALL = EnumSet.allOf(Type.class);
	
	private static final char[] HALF_WIDTH_KANA = {
			'｡', '｢', '｣', '､', '･',
			'ｦ', 'ｧ', 'ｨ', 'ｩ', 'ｪ', 'ｫ', 'ｬ', 'ｭ', 'ｮ', 'ｯ', 'ｰ',
			'ｱ', 'ｲ', 'ｳ', 'ｴ', 'ｵ', 'ｶ', 'ｷ', 'ｸ', 'ｹ', 'ｺ',
			'ｻ', 'ｼ', 'ｽ', 'ｾ', 'ｿ', 'ﾀ', 'ﾁ', 'ﾂ', 'ﾃ', 'ﾄ',
			'ﾅ', 'ﾆ', 'ﾇ', 'ﾈ', 'ﾉ', 'ﾊ', 'ﾋ', 'ﾌ',
			'ﾍ', 'ﾎ', 'ﾏ', 'ﾐ', 'ﾑ', 'ﾒ', 'ﾓ', 'ﾔ', 'ﾕ', 'ﾖ',
			'ﾗ', 'ﾘ', 'ﾙ', 'ﾚ', 'ﾛ', 'ﾜ', 'ﾝ'
			};

	private static final char[] FULL_WIDTH_KANA = {
			'。', '「', '」', '、', '・',
			'ヲ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ', 'ャ', 'ュ', 'ョ', 'ッ', 'ー',
			'ア', 'イ', 'ウ', 'エ', 'オ', 'カ', 'キ', 'ク', 'ケ', 'コ',
			'サ', 'シ', 'ス', 'セ', 'ソ', 'タ', 'チ', 'ツ', 'テ', 'ト',
			'ナ', 'ニ', 'ヌ', 'ネ', 'ノ', 'ハ', 'ヒ', 'フ', 'ヘ', 'ホ',
			'マ', 'ミ', 'ム', 'メ', 'モ', 'ヤ', 'ユ', 'ヨ',
			'ラ', 'リ', 'ル', 'レ', 'ロ', 'ワ', 'ン'
			};
	
	
	private CharWidthUtils() {
		// NOP
	}
	
	public static String toHalfWidth(String str) {
		return toHalfWidth(str, TYPE_ALL);
	}
	
	public static String toHalfWidth(String str, EnumSet<Type> typeSet) {
		if (str == null || str.isEmpty()) {
			return str;
		}
		
		int codeOffset = 'Ａ' - 'A';
		
		int len = str.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char c = str.charAt(i);
			
			int ch = -1;
			int nch = -1;
			
			if (ch == -1 && typeSet.contains(Type.ALPHABET)) {
				if ('Ａ' <= c && c <= 'Ｚ') {
					ch = (char)(c - codeOffset);
				} else if ('ａ' <= c && c <= 'ｚ') {
					ch = (char)(c - codeOffset);
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.NUMBER)) {
				if ('０' <= c && c <= '９') {
					ch = (char)(c - codeOffset);
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.SYMBOL)) {
				if ('！' <= c && c <= '／') {
					ch = (char)(c - codeOffset);
				} else if ('：' <= c && c <= '＠') {
					ch = (char)(c - codeOffset);
				} else if ('［' <= c && c <= '｀') {
					ch = (char)(c - codeOffset);
				} else if ('｛' <= c && c <= '～') {
					ch = (char)(c - codeOffset);
				} else if (c == '€') {
					ch = '€';
				} else if (c == '￠') {
					ch = '¢';
				} else if (c == '￡') {
					ch = '£';
				} else if (c == '￣') {
					ch = '¯';
				} else if (c == '￤') {
					ch = '¦';
				} else if (c == '￢') {
					ch = '¬';
				} else if (c == '￥') {
					ch = '¥';
				} else if (c == '￦') {
					ch = '₩';
				} else if (c == '│') {
					ch = '￨';
				} else if (c == '←') {
					ch = '￩';
				} else if (c == '↑') {
					ch = '￪';
				} else if (c == '→') {
					ch = '￫';
				} else if (c == '↓') {
					ch = '￬';
				} else if (c == '■') {
					ch = '￭';
				} else if (c == '○') {
					ch = '￮';
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.SPACE)) {
				if (c == '\u3000') {
					ch = '\u0020';
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.KANA)) {
				int kch = -1;
				int nkch = -1;
				for (int j = 0; j < FULL_WIDTH_KANA.length; j++) {
					if (c == FULL_WIDTH_KANA[j]) {
						kch = HALF_WIDTH_KANA[j];
						break;
					}
				}
				if (kch == -1) {
					switch (c) {
					case 'ガ': kch = 'ｶ'; nkch = 'ﾞ'; break;
					case 'ギ': kch = 'ｷ'; nkch = 'ﾞ'; break;
					case 'グ': kch = 'ｸ'; nkch = 'ﾞ'; break;
					case 'ゲ': kch = 'ｹ'; nkch = 'ﾞ'; break;
					case 'ゴ': kch = 'ｺ'; nkch = 'ﾞ'; break;
					case 'ザ': kch = 'ｻ'; nkch = 'ﾞ'; break;
					case 'ジ': kch = 'ｼ'; nkch = 'ﾞ'; break;
					case 'ズ': kch = 'ｽ'; nkch = 'ﾞ'; break;
					case 'ゼ': kch = 'ｾ'; nkch = 'ﾞ'; break;
					case 'ゾ': kch = 'ｿ'; nkch = 'ﾞ'; break;
					case 'ダ': kch = 'ﾀ'; nkch = 'ﾞ'; break;
					case 'ヂ': kch = 'ﾁ'; nkch = 'ﾞ'; break;
					case 'ヅ': kch = 'ﾂ'; nkch = 'ﾞ'; break;
					case 'デ': kch = 'ﾃ'; nkch = 'ﾞ'; break;
					case 'ド': kch = 'ﾄ'; nkch = 'ﾞ'; break;
					case 'バ': kch = 'ﾊ'; nkch = 'ﾞ'; break;
					case 'ビ': kch = 'ﾋ'; nkch = 'ﾞ'; break;
					case 'ブ': kch = 'ﾌ'; nkch = 'ﾞ'; break;
					case 'ベ': kch = 'ﾍ'; nkch = 'ﾞ'; break;
					case 'ボ': kch = 'ﾎ'; nkch = 'ﾞ'; break;
					case 'ヴ': kch = 'ｳ'; nkch = 'ﾞ'; break;
					case 'パ': kch = 'ﾊ'; nkch = 'ﾟ'; break;
					case 'ピ': kch = 'ﾋ'; nkch = 'ﾟ'; break;
					case 'プ': kch = 'ﾌ'; nkch = 'ﾟ'; break;
					case 'ペ': kch = 'ﾍ'; nkch = 'ﾟ'; break;
					case 'ポ': kch = 'ﾎ'; nkch = 'ﾟ'; break;
					case '゛': kch = 'ﾞ'; break;
					case '゜': kch = 'ﾟ'; break;
					}
				}
				if (kch != -1) {
					ch = (char)kch;
					if (nkch != -1) {
						nch = (char)nkch;
					}
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.HANGUL)) {
				if (c == 'ㅤ') {
					ch = '\uFFA0';
				} else if ('ㄱ' <= c && c <= 'ㅎ') {
					ch = (char)(c - ('ㄱ' - '\uFFA1'));
				} else if ('ㅏ' <= c && c <= 'ㅔ') {
					ch = (char)(c - ('ㅏ' - '\uFFC2'));
				} else if ('ㅕ' <= c && c <= 'ㅚ') {
					ch = (char)(c - ('ㅕ' - '\uFFCA'));
				} else if ('ㅛ' <= c && c <= 'ㅠ') {
					ch = (char)(c - ('ㅛ' - '\uFFD2'));
				} else if ('ㅡ' <= c && c <= 'ㅣ') {
					ch = (char)(c - ('ㅡ' - '\uFFDA'));
				}
			}
			
			if (ch == -1) {
				ch = c;
			}
			
			sb.append((char)ch);
			if (nch != -1) {
				sb.append((char)nch);
			}
		}
		
		return sb.toString();
	}
	
	public static String toFullWidth(String str) {
		return toFullWidth(str, TYPE_ALL);
	}
	
	public static String toFullWidth(String str, EnumSet<Type> typeSet) {
		if (str == null || str.isEmpty()) {
			return str;
		}
		
		int codeOffset = 'Ａ' - 'A';
		
		int len = str.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char c = str.charAt(i);
			char nc = (i + 1 == str.length()) ? 0 : str.charAt(i + 1);
			
			int ch = -1;

			if (ch == -1 && typeSet.contains(Type.ALPHABET)) {
				if ('A' <= c && c <= 'Z') {
					ch = (char)(c + codeOffset);
				} else if ('a' <= c && c <= 'z') {
					ch = (char)(c + codeOffset);
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.NUMBER)) {
				if ('0' <= c && c <= '9') {
					ch = (char)(c + codeOffset);
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.SYMBOL)) {
				if ('!' <= c && c <= '/') {
					ch = (char)(c + codeOffset);
				} else if (':' <= c && c <= '@') {
					ch = (char)(c + codeOffset);
				} else if ('[' <= c && c <= '`') {
					ch = (char)(c + codeOffset);
				} else if ('{' <= c && c <= '~') {
					ch = (char)(c + codeOffset);
				} else if (c == '€') {
					ch = '€';
				} else if (c == '¢') {
					ch = '￠';
				} else if (c == '£') {
					ch = '￡';
				} else if (c == '¯') {
					ch = '￣';
				} else if (c == '¦') {
					ch = '￤';
				} else if (c == '¬') {
					ch = '￢';
				} else if (c == '¥') {
					ch = '￥';
				} else if (c == '₩') {
					ch = '￦';
				} else if (c == '￨') {
					ch = '│';
				} else if (c == '￩') {
					ch = '←';
				} else if (c == '￪') {
					ch = '↑';
				} else if (c == '￫') {
					ch = '→';
				} else if (c == '￬') {
					ch = '↓';
				} else if (c == '￭') {
					ch = '■';
				} else if (c == '￮') {
					ch = '○';
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.SPACE)) {
				if (c == '\u0020') {
					ch = '\u3000';
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.KANA)) {
				int kch = -1;
				if (nc == 'ﾞ') {
					switch (c) {
					case 'ｶ': kch = 'ガ'; break;
					case 'ｷ': kch = 'ギ'; break;
					case 'ｸ': kch = 'グ'; break;
					case 'ｹ': kch = 'ゲ'; break;
					case 'ｺ': kch = 'ゴ'; break;
					case 'ｻ': kch = 'ザ'; break;
					case 'ｼ': kch = 'ジ'; break;
					case 'ｽ': kch = 'ズ'; break;
					case 'ｾ': kch = 'ゼ'; break;
					case 'ｿ': kch = 'ゾ'; break;
					case 'ﾀ': kch = 'ダ'; break;
					case 'ﾁ': kch = 'ヂ'; break;
					case 'ﾂ': kch = 'ヅ'; break;
					case 'ﾃ': kch = 'デ'; break;
					case 'ﾄ': kch = 'ド'; break;
					case 'ﾊ': kch = 'バ'; break;
					case 'ﾋ': kch = 'ビ'; break;
					case 'ﾌ': kch = 'ブ'; break;
					case 'ﾍ': kch = 'ベ'; break;
					case 'ﾎ': kch = 'ボ'; break;
					case 'ｳ': kch = 'ヴ'; break;
					}
					if (kch != -1) {
						i++;
					}
				} else if (nc == 'ﾟ') {
					switch (c) {
					case 'ﾊ': kch = 'パ'; break;
					case 'ﾋ': kch = 'ピ'; break;
					case 'ﾌ': kch = 'プ'; break;
					case 'ﾍ': kch = 'ペ'; break;
					case 'ﾎ': kch = 'ポ'; break;
					}
					if (kch != -1) {
						i++;
					}
				}
				if (kch == -1) {
					for (int j = 0; j < HALF_WIDTH_KANA.length; j++) {
						if (c == HALF_WIDTH_KANA[j]) {
							kch = FULL_WIDTH_KANA[j];
							break;
						}
					}
				}
				if (kch == -1) {
					switch (c) {
					case 'ﾞ': kch = '\u3099'; break;
					case 'ﾟ': kch = '\u309A'; break;
					}
				}
				if (kch != -1) {
					ch = (char)kch;
				}
			}
			
			if (ch == -1 && typeSet.contains(Type.HANGUL)) {
				if (c == '\uFFA0') {
					ch = 'ㅤ';
				} else if ('\uFFA1' <= c && c <= '\uFFBE') {
					ch = (char)(c + ('ㄱ' - '\uFFA1'));
				} else if ('\uFFC2' <= c && c <= '\uFFC7') {
					ch = (char)(c + ('ㅏ' - '\uFFC2'));
				} else if ('\uFFCA' <= c && c <= '\uFFCF') {
					ch = (char)(c + ('ㅕ' - '\uFFCA'));
				} else if ('\uFFD2' <= c && c <= '\uFFD7') {
					ch = (char)(c + ('ㅛ' - '\uFFD2'));
				} else if ('\uFFDA' <= c && c <= '\uFFDC') {
					ch = (char)(c + ('ㅡ' - '\uFFDA'));
				}
			}
			
			if (ch == -1) {
				ch = c;
			}
			
			sb.append((char)ch);
		}
		
		return sb.toString();
	}
}
