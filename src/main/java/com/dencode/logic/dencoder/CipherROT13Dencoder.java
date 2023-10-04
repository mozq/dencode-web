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

@Dencoder(type="cipher", method="cipher.rot13", hasEncoder=true, hasDecoder=true)
public class CipherROT13Dencoder {
	
	private CipherROT13Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherROT13(DencodeCondition cond) {
		return dencCipherROT13(cond.value());
	}
	
	@DencoderFunction
	public static String decCipherROT13(DencodeCondition cond) {
		return dencCipherROT13(cond.value());
	}
	
	
	private static String dencCipherROT13(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (('A' <= ch && ch <= 'M') || ('a' <= ch && ch <= 'm')) {
				// Half-width Latin alphabets
				ch += 13;
			} else if (('N' <= ch && ch <= 'Z') || ('n' <= ch && ch <= 'z')) {
				// Half-width Latin alphabets
				ch -= 13;
			} else if (('Ａ' <= ch && ch <= 'Ｍ') || ('ａ' <= ch && ch <= 'ｍ')) {
				// Full-width Latin alphabets
				ch += 13;
			} else if (('Ｎ' <= ch && ch <= 'Ｚ') || ('ｎ' <= ch && ch <= 'ｚ')) {
				// Full-width Latin alphabets
				ch -= 13;
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
}
