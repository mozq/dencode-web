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

@Dencoder(type="cipher", method="cipher.rot18")
public class CipherROT18Dencoder {
	
	private CipherROT18Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherROT18(DencodeCondition cond) {
		return dencCipherROT18(cond.value());
	}
	
	@DencoderFunction
	public static String decCipherROT18(DencodeCondition cond) {
		return dencCipherROT18(cond.value());
	}
	
	
	private static String dencCipherROT18(String val) {
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
			} else if ('0' <= ch && ch <= '4') {
				// Half-width numbers
				ch += 5;
			} else if ('5' <= ch && ch <= '9') {
				// Half-width numbers
				ch -= 5;
			} else if (('Ａ' <= ch && ch <= 'Ｍ') || ('ａ' <= ch && ch <= 'ｍ')) {
				// Full-width Latin alphabets
				ch += 13;
			} else if (('Ｎ' <= ch && ch <= 'Ｚ') || ('ｎ' <= ch && ch <= 'ｚ')) {
				// Full-width Latin alphabets
				ch -= 13;
			} else if ('０' <= ch && ch <= '４') {
				// Full-width numbers
				ch += 5;
			} else if ('５' <= ch && ch <= '９') {
				// Full-width numbers
				ch -= 5;
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
}
