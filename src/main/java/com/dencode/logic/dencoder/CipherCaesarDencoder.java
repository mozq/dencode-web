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

import java.text.Normalizer;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="cipher", method="cipher.caesar", hasEncoder=true, hasDecoder=true)
public class CipherCaesarDencoder {

	private static final char[] CYRILLIC_I_CHARS = new char[] { 'И', 'и' };
	private static final char CYRILLIC_BREVE_CHAR = '\u0306';
	private static final String[] CYRILLIC_I_BREVE = new String[] { "И\u0306", "и\u0306" };
	private static final String[] CYRILLIC_SHORT_I = new String[] { "Й", "й" };
	
	
	private CipherCaesarDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherCaesar(DencodeCondition cond) {
		return encCipherCaesar(
				cond.value(),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.caesar.shift", -3)
				);
	}
	
	@DencoderFunction
	public static String decCipherCaesar(DencodeCondition cond) {
		return decCipherCaesar(
				cond.value(),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.caesar.shift", -3)
				);
	}
	
	
	private static String encCipherCaesar(String val, int shift) {
		return dencCipherCaesar(val, shift);
	}
	
	private static String decCipherCaesar(String val, int shift) {
		return dencCipherCaesar(val, -shift);
	}
	
	private static String dencCipherCaesar(String val, int shift) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		if (shift == 0) {
			return val;
		}
		
		int shiftLatin = shift % 26;
		if (shiftLatin < 0) {
			shiftLatin += 26;
		}
		
		int shiftCyrillic = shift % 32;
		if (shiftCyrillic < 0) {
			shiftCyrillic += 32;
		}
		
		int shiftJapanese = shift % 84;
		if (shiftJapanese < 0) {
			shiftJapanese += 84;
		}
		
		val = Normalizer.normalize(val, Normalizer.Form.NFD);
		
		// for diacritical mark support
		int idxBrave = val.indexOf(CYRILLIC_BREVE_CHAR);
		if (idxBrave != -1) {
			if (StringUtilz.indexOf(val, CYRILLIC_I_CHARS, idxBrave - 1) != -1) {
				// Breve (U+0306) of 'Й' and 'й' is not a diacritical mark
				val = StringUtilz.replaceAll(val, CYRILLIC_I_BREVE, CYRILLIC_SHORT_I);
			}
		}
		
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if ('A' <= ch && ch <= 'Z') {
				// Half-width Latin upper alphabets
				ch = (char)((ch - 'A' + shiftLatin) % 26 + 'A');
			} else if ('a' <= ch && ch <= 'z') {
				// Half-width Latin lower alphabets
				ch = (char)((ch - 'a' + shiftLatin) % 26 + 'a');
			} else if ('Ａ' <= ch && ch <= 'Ｚ') {
				// Full-width Latin upper alphabets
				ch = (char)((ch - 'Ａ' + shiftLatin) % 26 + 'Ａ');
			} else if ('ａ' <= ch && ch <= 'ｚ') {
				// Full-width Latin lower alphabets
				ch = (char)((ch - 'ａ' + shiftLatin) % 26 + 'ａ');
			} else if ('А' <= ch && ch <= 'Я') {
				// Cyrillic upper alphabets
				ch = (char)((ch - 'А' + shiftCyrillic) % 32 + 'А');
			} else if ('а' <= ch && ch <= 'я') {
				// Cyrillic lower alphabets
				ch = (char)((ch - 'а' + shiftCyrillic) % 32 + 'а');
			}
			
			sb.append(ch);
		}
		val = Normalizer.normalize(sb.toString(), Normalizer.Form.NFC);
		
		len = val.length();
		sb.setLength(0);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if ('ぁ' <= ch && ch <= 'ゔ') {
				// Japanese Hiragana
				ch = (char)((ch - 'ぁ' + shiftJapanese) % 84 + 'ぁ');
			} else if ('ァ' <= ch && ch <= 'ヴ') {
				// Japanese Katakana
				ch = (char)((ch - 'ァ' + shiftJapanese) % 84 + 'ァ');
			}
			
			sb.append(ch);
		}
		val = sb.toString();
		
		return val;
	}
}
