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

@Dencoder(type="cipher", method="cipher.affine", hasEncoder=true, hasDecoder=true)
public class CipherAffineDencoder {
	
	private CipherAffineDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherAffine(DencodeCondition cond) {
		return encCipherAffine(cond.value(),
				DencodeUtils.getOptionAsInt(cond.options(), "encCipherAffineA", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "encCipherAffineB", 0));
	}
	
	@DencoderFunction
	public static String decCipherAffine(DencodeCondition cond) {
		return decCipherAffine(cond.value(),
				DencodeUtils.getOptionAsInt(cond.options(), "decCipherAffineA", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "decCipherAffineB", 0));
	}
	
	private static String encCipherAffine(String val, int a, int b) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		if (a == 1 && b == 0) {
			return val;
		}
		
		boolean coprime26 = isCoprime(a, 26);
		boolean coprime32 = isCoprime(a, 32);
		boolean coprime84 = isCoprime(a, 84);
		
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if ('A' <= ch && ch <= 'Z') {
				// Half-width Latin upper alphabets
				ch = (coprime26) ? enc(ch, 'A', a, b, 26) : ch;
			} else if ('a' <= ch && ch <= 'z') {
				// Half-width Latin lower alphabets
				ch = (coprime26) ? enc(ch, 'a', a, b, 26) : ch;
			} else if ('Ａ' <= ch && ch <= 'Ｚ') {
				// Full-width Latin upper alphabets
				ch = (coprime26) ? enc(ch, 'Ａ', a, b, 26) : ch;
			} else if ('ａ' <= ch && ch <= 'ｚ') {
				// Full-width Latin lower alphabets
				ch = (coprime26) ? enc(ch, 'ａ', a, b, 26) : ch;
			} else if ('ぁ' <= ch && ch <= 'ゔ') {
				// Full-width Japanese Hiragana
				ch = (coprime84) ? enc(ch, 'ぁ', a, b, 84) : ch;
			} else if ('ァ' <= ch && ch <= 'ヴ') {
				// Full-width Japanese Katakana
				ch = (coprime84) ? enc(ch, 'ァ', a, b, 84) : ch;
			} else if ('А' <= ch && ch <= 'Я') {
				// Cyrillic upper alphabets
				ch = (coprime32) ? enc(ch, 'А', a, b, 32) : ch;
			} else if ('а' <= ch && ch <= 'я') {
				// Cyrillic lower alphabets
				ch = (coprime32) ? enc(ch, 'а', a, b, 32) : ch;
			} else {
				// Others
				// NOP
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
	
	private static String decCipherAffine(String val, int a, int b) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		if (a == 1 && b == 0) {
			return val;
		}
		
		int modInv26 = modInv(a, 26);
		int modInv32 = modInv(a, 32);
		int modInv84 = modInv(a, 84);
		
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if ('A' <= ch && ch <= 'Z') {
				// Half-width Latin upper alphabets
				ch = (modInv26 == 0) ? ch : dec(ch, 'A', a, b, 26, modInv26);
			} else if ('a' <= ch && ch <= 'z') {
				// Half-width Latin lower alphabets
				ch = (modInv26 == 0) ? ch : dec(ch, 'a', a, b, 26, modInv26);
			} else if ('Ａ' <= ch && ch <= 'Ｚ') {
				// Full-width Latin upper alphabets
				ch = (modInv26 == 0) ? ch : dec(ch, 'Ａ', a, b, 26, modInv26);
			} else if ('ａ' <= ch && ch <= 'ｚ') {
				// Full-width Latin lower alphabets
				ch = (modInv26 == 0) ? ch : dec(ch, 'ａ', a, b, 26, modInv26);
			} else if ('ぁ' <= ch && ch <= 'ゔ') {
				// Full-width Japanese Hiragana
				ch = (modInv84 == 0) ? ch : dec(ch, 'ぁ', a, b, 84, modInv84);
			} else if ('ァ' <= ch && ch <= 'ヴ') {
				// Full-width Japanese Katakana
				ch = (modInv84 == 0) ? ch : dec(ch, 'ァ', a, b, 84, modInv84);
			} else if ('А' <= ch && ch <= 'Я') {
				// Cyrillic upper alphabets
				ch = (modInv32 == 0) ? ch : dec(ch, 'А', a, b, 32, modInv32);
			} else if ('а' <= ch && ch <= 'я') {
				// Cyrillic lower alphabets
				ch = (modInv32 == 0) ? ch : dec(ch, 'а', a, b, 32, modInv32);
			} else {
				// Others
				// NOP
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
	
	private static char enc(char ch, char baseCh, int a, int b, int m) {
		int x = ch - baseCh;
		
		int n = (a * x + b) % m;
		if (n < 0) {
			n += m;
		}
		
		return (char)(baseCh + n);
	}
	
	private static char dec(char ch, char baseCh, int a, int b, int m, int modInv) {
		int x = ch - baseCh;
		
		int n = (modInv * (x - b)) % m;
		if (n < 0) {
			n += m;
		}
		
		return (char)(baseCh + n);
	}
	
	private static int modInv(int a, int m) {
		a %= m;
		
		boolean sign = (a < 0);
		if (sign) {
			a = -a;
		}
		
		if (!isCoprime(a, m)) {
			return 0;
		}
		
		for (int x = 1; x < m; x++) {
			if ((a * x) % m == 1) {
				return (sign) ? -x : x;
			}
		}
		
		return 0;
	}
	
	private static int gcd(int a, int b) {
		return (b == 0) ? a : gcd(b, a % b);
	}
	
	private static boolean isCoprime(int a, int b) {
		int gcd = gcd(a, b);
		return (gcd == 1 || gcd == -1);
	}
}
