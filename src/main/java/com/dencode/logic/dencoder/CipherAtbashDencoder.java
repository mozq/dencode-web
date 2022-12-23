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

@Dencoder(type="cipher", method="cipher.atbash")
public class CipherAtbashDencoder {
	private static final String HEBREW_ALPHABETS = "אבגדהוזחטיכלמנסעפצקרשת";
	
	private CipherAtbashDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherAtbash(DencodeCondition cond) {
		return dencCipherAtbash(cond.value());
	}
	
	private static String dencCipherAtbash(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if ('א' <= ch && ch <= 'ת') {
				// Hebrew alphabets
				int idx = HEBREW_ALPHABETS.indexOf(ch);
				if (idx != -1) {
					ch = HEBREW_ALPHABETS.charAt(HEBREW_ALPHABETS.length() - 1 - idx);
				} else {
					// NOP
				}
			} else if ('A' <= ch && ch <= 'Z') {
				// Half-width Latin upper alphabets
				ch = (char)('Z' - (ch - 'A'));
			} else if ('a' <= ch && ch <= 'z') {
				// Half-width Latin lower alphabets
				ch = (char)('z' - (ch - 'a'));
			} else if ('Ａ' <= ch && ch <= 'Ｚ') {
				// Full-width Latin upper alphabets
				ch = (char)('Ｚ' - (ch - 'Ａ'));
			} else if ('ａ' <= ch && ch <= 'ｚ') {
				// Full-width Latin lower alphabets
				ch = (char)('ｚ' - (ch - 'ａ'));
			} else if ('ぁ' <= ch && ch <= 'ゔ') {
				// Full-width Japanese Hiragana
				ch = (char)('ゔ' - (ch - 'ぁ'));
			} else if ('ァ' <= ch && ch <= 'ヴ') {
				// Full-width Japanese Katakana
				ch = (char)('ヴ' - (ch - 'ァ'));
			} else if ('А' <= ch && ch <= 'Я') {
				// Cyrillic upper alphabets
				ch = (char)('Я' - (ch - 'А'));
			} else if ('а' <= ch && ch <= 'я') {
				// Cyrillic lower alphabets
				ch = (char)('я' - (ch - 'а'));
			} else {
				// Others
				// NOP
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
}
