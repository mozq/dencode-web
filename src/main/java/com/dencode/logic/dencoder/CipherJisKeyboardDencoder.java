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

@Dencoder(type="cipher", method="cipher.jis-keyboard", hasEncoder=true, hasDecoder=false)
public class CipherJisKeyboardDencoder {
	
	private CipherJisKeyboardDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherJisKeyboard(DencodeCondition cond) {
		return encCipherJisKeyboard(
				cond.value(),
				DencodeUtils.getOption(cond.options(), "cipher.jis-keyboard.mode", "lenient").equals("lenient"),
				true
				);
	}
	
	
	private static String encCipherJisKeyboard(String value, boolean lenient, boolean combineVoicedSoundMark) {
		if (value == null || value.isEmpty()) {
			return value;
		}
		
		int len = value.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = value.charAt(i);
			mapAndAppend(sb, ch, lenient, combineVoicedSoundMark);
		}
		
		return sb.toString();
	}
	
	private static void mapAndAppend(StringBuilder sb, char ch, boolean lenient, boolean combineVoicedSoundMark) {
		switch (ch) {
		case '1': sb.append('ぬ'); break;
		case '2': sb.append('ふ'); break;
		case '3': sb.append('あ'); break;
		case '#': sb.append('ぁ'); break;
		case '4': sb.append('う'); break;
		case '$': sb.append('ぅ'); break;
		case '5': sb.append('え'); break;
		case '%': sb.append('ぇ'); break;
		case '6': sb.append('お'); break;
		case '&': sb.append('ぉ'); break;
		case '7': sb.append('や'); break;
		case '\'': sb.append('ゃ'); break;
		case '8': sb.append('ゆ'); break;
		case '(': sb.append('ゅ'); break;
		case '9': sb.append('よ'); break;
		case ')': sb.append('ょ'); break;
		case '0': sb.append('わ'); break;
		case '-': sb.append('ほ'); break;
		case '^': sb.append('へ'); break;
		case '|': sb.append('ー'); break;
		
		case 'q': sb.append('た'); break;
		case 'w': sb.append('て'); break;
		case 'e': sb.append('い'); break;
		case 'E': sb.append('ぃ'); break;
		case 'r': sb.append('す'); break;
		case 't': sb.append('か'); break;
		case 'y': sb.append('ん'); break;
		case 'u': sb.append('な'); break;
		case 'i': sb.append('に'); break;
		case 'o': sb.append('ら'); break;
		case 'p': sb.append('せ'); break;
		case '@':
			if (combineVoicedSoundMark) {
				DencodeUtils.appendCombinedVoicedSoundMark(sb);
			} else {
				sb.append('゛');
			}
			break;
		case '[':
			if (combineVoicedSoundMark) {
				DencodeUtils.appendCombinedSemiVoicedSoundMark(sb);
			} else {
				sb.append('゜');
			}
			break;
		case '{': sb.append('「'); break;
		
		case 'a': sb.append('ち'); break;
		case 's': sb.append('と'); break;
		case 'd': sb.append('し'); break;
		case 'f': sb.append('は'); break;
		case 'g': sb.append('き'); break;
		case 'h': sb.append('く'); break;
		case 'j': sb.append('ま'); break;
		case 'k': sb.append('の'); break;
		case 'l': sb.append('り'); break;
		case ';': sb.append('れ'); break;
		case ':': sb.append('け'); break;
		case ']': sb.append('む'); break;
		case '}': sb.append('」'); break;
		
		case 'z': sb.append('つ'); break;
		case 'Z': sb.append('っ'); break;
		case 'x': sb.append('さ'); break;
		case 'c': sb.append('そ'); break;
		case 'v': sb.append('ひ'); break;
		case 'b': sb.append('こ'); break;
		case 'n': sb.append('み'); break;
		case 'm': sb.append('も'); break;
		case ',': sb.append('ね'); break;
		case '<': sb.append('、'); break;
		case '.': sb.append('る'); break;
		case '>': sb.append('。'); break;
		case '/': sb.append('め'); break;
		case '?': sb.append('・'); break;
		case '\\': sb.append('ろ'); break;
		
		case 'ぬ': sb.append('1'); break;
		case 'ふ': sb.append('2'); break;
		case 'ぶ': sb.append('2').append('@'); break;
		case 'ぷ': sb.append('2').append('['); break;
		case 'あ': sb.append('3'); break;
		case 'ぁ': sb.append('#'); break;
		case 'う': sb.append('4'); break;
		case 'ゔ': sb.append('4').append('@'); break;
		case 'ぅ': sb.append('$'); break;
		case 'え': sb.append('5'); break;
		case 'ぇ': sb.append('%'); break;
		case 'お': sb.append('6'); break;
		case 'ぉ': sb.append('&'); break;
		case 'や': sb.append('7'); break;
		case 'ゃ': sb.append('\''); break;
		case 'ゆ': sb.append('8'); break;
		case 'ゅ': sb.append('('); break;
		case 'よ': sb.append('9'); break;
		case 'ょ': sb.append(')'); break;
		case 'わ': sb.append('0'); break;
		case 'ほ': sb.append('-'); break;
		case 'ぼ': sb.append('-').append('@'); break;
		case 'ぽ': sb.append('-').append('['); break;
		case 'へ': sb.append('^'); break;
		case 'べ': sb.append('^').append('@'); break;
		case 'ぺ': sb.append('^').append('['); break;
		case 'ー': sb.append('|'); break;
		
		case 'た': sb.append('q'); break;
		case 'だ': sb.append('q').append('@'); break;
		case 'て': sb.append('w'); break;
		case 'で': sb.append('w').append('@'); break;
		case 'い': sb.append('e'); break;
		case 'ぃ': sb.append('E'); break;
		case 'す': sb.append('r'); break;
		case 'ず': sb.append('r').append('@'); break;
		case 'か': sb.append('t'); break;
		case 'が': sb.append('t').append('@'); break;
		case 'ん': sb.append('y'); break;
		case 'な': sb.append('u'); break;
		case 'に': sb.append('i'); break;
		case 'ら': sb.append('o'); break;
		case 'せ': sb.append('p'); break;
		case 'ぜ': sb.append('p').append('@'); break;
		case '゛': // FALLTHRU
		case '\u3099': sb.append('@'); break;
		case '゜': // FALLTHRU
		case '\u309A': sb.append('['); break;
		case '「': sb.append('{'); break;
		
		case 'ち': sb.append('a'); break;
		case 'ぢ': sb.append('a').append('@'); break;
		case 'と': sb.append('s'); break;
		case 'ど': sb.append('s').append('@'); break;
		case 'し': sb.append('d'); break;
		case 'じ': sb.append('d').append('@'); break;
		case 'は': sb.append('f'); break;
		case 'ば': sb.append('f').append('@'); break;
		case 'ぱ': sb.append('f').append('['); break;
		case 'き': sb.append('g'); break;
		case 'ぎ': sb.append('g').append('@'); break;
		case 'く': sb.append('h'); break;
		case 'ぐ': sb.append('h').append('@'); break;
		case 'ま': sb.append('j'); break;
		case 'の': sb.append('k'); break;
		case 'り': sb.append('l'); break;
		case 'れ': sb.append(';'); break;
		case 'け': sb.append(':'); break;
		case 'げ': sb.append(':').append('@'); break;
		case 'む': sb.append(']'); break;
		case '」': sb.append('}'); break;
		
		case 'つ': sb.append('z'); break;
		case 'づ': sb.append('z').append('@'); break;
		case 'っ': sb.append('Z'); break;
		case 'さ': sb.append('x'); break;
		case 'ざ': sb.append('x').append('@'); break;
		case 'そ': sb.append('c'); break;
		case 'ぞ': sb.append('c').append('@'); break;
		case 'ひ': sb.append('v'); break;
		case 'び': sb.append('v').append('@'); break;
		case 'ぴ': sb.append('v').append('['); break;
		case 'こ': sb.append('b'); break;
		case 'ご': sb.append('b').append('@'); break;
		case 'み': sb.append('n'); break;
		case 'も': sb.append('m'); break;
		case 'ね': sb.append(','); break;
		case '、': sb.append('<'); break;
		case 'る': sb.append('.'); break;
		case '。': sb.append('>'); break;
		case 'め': sb.append('/'); break;
		case '・': sb.append('?'); break;
		case 'ろ': sb.append('\\'); break;
		
		default:
			if (lenient) {
				switch (ch) {
				case 'Q': sb.append('た'); break;
				case 'W': sb.append('て'); break;
				case 'R': sb.append('す'); break;
				case 'T': sb.append('か'); break;
				case 'Y': sb.append('ん'); break;
				case 'U': sb.append('な'); break;
				case 'I': sb.append('に'); break;
				case 'O': sb.append('ら'); break;
				case 'P': sb.append('せ'); break;
				
				case 'A': sb.append('ち'); break;
				case 'S': sb.append('と'); break;
				case 'D': sb.append('し'); break;
				case 'F': sb.append('は'); break;
				case 'G': sb.append('き'); break;
				case 'H': sb.append('く'); break;
				case 'J': sb.append('ま'); break;
				case 'K': sb.append('の'); break;
				case 'L': sb.append('り'); break;
				
				case 'X': sb.append('さ'); break;
				case 'C': sb.append('そ'); break;
				case 'V': sb.append('ひ'); break;
				case 'B': sb.append('こ'); break;
				case 'N': sb.append('み'); break;
				case 'M': sb.append('も'); break;
				
				case 'ヌ': sb.append('1'); break;
				case 'フ': sb.append('2'); break;
				case 'ブ': sb.append('2').append('@'); break;
				case 'プ': sb.append('2').append('['); break;
				case 'ア': sb.append('3'); break;
				case 'ァ': sb.append('#'); break;
				case 'ウ': sb.append('4'); break;
				case 'ヴ': sb.append('4').append('@'); break;
				case 'ゥ': sb.append('$'); break;
				case 'エ': sb.append('5'); break;
				case 'ェ': sb.append('%'); break;
				case 'オ': sb.append('6'); break;
				case 'ォ': sb.append('&'); break;
				case 'ヤ': sb.append('7'); break;
				case 'ャ': sb.append('\''); break;
				case 'ユ': sb.append('8'); break;
				case 'ュ': sb.append('('); break;
				case 'ヨ': sb.append('9'); break;
				case 'ョ': sb.append(')'); break;
				case 'ワ': sb.append('0'); break;
				case 'ホ': sb.append('-'); break;
				case 'ボ': sb.append('-').append('@'); break;
				case 'ポ': sb.append('-').append('['); break;
				case 'ヘ': sb.append('^'); break;
				case 'ベ': sb.append('^').append('@'); break;
				case 'ペ': sb.append('^').append('['); break;
				
				case 'タ': sb.append('q'); break;
				case 'ダ': sb.append('q').append('@'); break;
				case 'テ': sb.append('w'); break;
				case 'デ': sb.append('w').append('@'); break;
				case 'イ': sb.append('e'); break;
				case 'ィ': sb.append('E'); break;
				case 'ス': sb.append('r'); break;
				case 'ズ': sb.append('r').append('@'); break;
				case 'カ': sb.append('t'); break;
				case 'ガ': sb.append('t').append('@'); break;
				case 'ン': sb.append('y'); break;
				case 'ナ': sb.append('u'); break;
				case 'ニ': sb.append('i'); break;
				case 'ラ': sb.append('o'); break;
				case 'セ': sb.append('p'); break;
				case 'ゼ': sb.append('p').append('@'); break;
				
				case 'チ': sb.append('a'); break;
				case 'ヂ': sb.append('a').append('@'); break;
				case 'ト': sb.append('s'); break;
				case 'ド': sb.append('s').append('@'); break;
				case 'シ': sb.append('d'); break;
				case 'ジ': sb.append('d').append('@'); break;
				case 'ハ': sb.append('f'); break;
				case 'バ': sb.append('f').append('@'); break;
				case 'パ': sb.append('f').append('['); break;
				case 'キ': sb.append('g'); break;
				case 'ギ': sb.append('g').append('@'); break;
				case 'ク': sb.append('h'); break;
				case 'グ': sb.append('h').append('@'); break;
				case 'マ': sb.append('j'); break;
				case 'ノ': sb.append('k'); break;
				case 'リ': sb.append('l'); break;
				case 'レ': sb.append(';'); break;
				case 'ケ': sb.append(':'); break;
				case 'ゲ': sb.append(':').append('@'); break;
				case 'ム': sb.append(']'); break;
				
				case 'ツ': sb.append('z'); break;
				case 'ヅ': sb.append('z').append('@'); break;
				case 'ッ': sb.append('Z'); break;
				case 'サ': sb.append('x'); break;
				case 'ザ': sb.append('x').append('@'); break;
				case 'ソ': sb.append('c'); break;
				case 'ゾ': sb.append('c').append('@'); break;
				case 'ヒ': sb.append('v'); break;
				case 'ビ': sb.append('v').append('@'); break;
				case 'ピ': sb.append('v').append('['); break;
				case 'コ': sb.append('b'); break;
				case 'ゴ': sb.append('b').append('@'); break;
				case 'ミ': sb.append('n'); break;
				case 'モ': sb.append('m'); break;
				case 'ネ': sb.append(','); break;
				case 'ル': sb.append('.'); break;
				case 'メ': sb.append('/'); break;
				case 'ロ': sb.append('\\'); break;
				default: sb.append(ch); break;
				}
			} else {
				sb.append(ch);
			}
		}
	}
}
