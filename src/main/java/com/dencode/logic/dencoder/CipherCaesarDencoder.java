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

@Dencoder(type="cipher", method="cipher.caesar")
public class CipherCaesarDencoder {
	
	private static final String[] CIPHER_CAESAR_CYRILLIC_I_BREVE = new String[] { "И\u0306", "и\u0306" };
	private static final String[] CIPHER_CAESAR_CYRILLIC_SHORT_I = new String[] { "Й", "й" };
	
	
	private CipherCaesarDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherCaesar(DencodeCondition cond) {
		return encCipherCaesar(cond.value(), cond.option().getEncCipherCaesarShift());
	}
	
	@DencoderFunction
	public static String decCipherCaesar(DencodeCondition cond) {
		return decCipherCaesar(cond.value(), cond.option().getDecCipherCaesarShift());
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
		
		// for diacritical mark support
		val = Normalizer.normalize(val, Normalizer.Form.NFD);
		int idxBrave = val.indexOf('\u0306');
		if (idxBrave != -1) {
			// Breve (U+0306) of 'Й' and 'й' is not a diacritical mark
			val = StringUtilz.replaceAll(val, CIPHER_CAESAR_CYRILLIC_I_BREVE, CIPHER_CAESAR_CYRILLIC_SHORT_I);
		}
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if ('A' <= ch && ch <= 'Z') {
				// Latin upper alphabets
				ch = (char)((ch - 'A' + shiftLatin) % 26 + 'A');
			} else if ('a' <= ch && ch <= 'z') {
				// Latin lower alphabets
				ch = (char)((ch - 'a' + shiftLatin) % 26 + 'a');
			} else if ('А' <= ch && ch <= 'Я') {
				// Cyrillic upper alphabets
				ch = (char)((ch - 'А' + shiftCyrillic) % 32 + 'А');
			} else if ('а' <= ch && ch <= 'я') {
				// Cyrillic lower alphabets
				ch = (char)((ch - 'а' + shiftCyrillic) % 32 + 'а');
			}
			
			sb.append(ch);
		}
		
		return Normalizer.normalize(sb.toString(), Normalizer.Form.NFC);
	}
}
