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

import java.util.Arrays;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="cipher", method="cipher.vigenere", hasEncoder=true, hasDecoder=true)
public class CipherVigenereDencoder {
	
	private static final int[] BLANK_KEY_INDEXES = new int[0];
	
	private CipherVigenereDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherVigenere(DencodeCondition cond) {
		return encCipherVigenere(cond.value(),
				DencodeUtils.getOption(cond.options(), "encCipherVigenereKey", ""));
	}
	
	@DencoderFunction
	public static String decCipherVigenere(DencodeCondition cond) {
		return decCipherVigenere(cond.value(),
				DencodeUtils.getOption(cond.options(), "decCipherVigenereKey", ""));
	}
	
	private static String encCipherVigenere(String val, String key) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int[] keyIndexes = keyToIndexes(key);
		if (keyIndexes.length == 0) {
			return val;
		}
		
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0, ki = 0; i < len; i++) {
			char ch = val.charAt(i);
			int keyIndex = keyIndexes[ki];
			
			boolean encoded = true;
			if ('A' <= ch && ch <= 'Z') {
				// Half-width Latin upper alphabets
				ch = enc(ch, 'A', keyIndex, 26);
			} else if ('a' <= ch && ch <= 'z') {
				// Half-width Latin lower alphabets
				ch = enc(ch, 'a', keyIndex, 26);
			} else if ('Ａ' <= ch && ch <= 'Ｚ') {
				// Full-width Latin upper alphabets
				ch = enc(ch, 'Ａ', keyIndex, 26);
			} else if ('ａ' <= ch && ch <= 'ｚ') {
				// Full-width Latin lower alphabets
				ch = enc(ch, 'ａ', keyIndex, 26);
			} else {
				// Others
				encoded = false;
			}
			
			sb.append(ch);
			
			if (encoded) {
				ki++;
				if (keyIndexes.length <= ki) {
					ki = 0;
				}
			}
		}
		
		return sb.toString();
	}
	
	private static String decCipherVigenere(String val, String key) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int[] keyIndexes = keyToIndexes(key);
		if (keyIndexes.length == 0) {
			return val;
		}
		
		int len = val.length();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0, ki = 0; i < len; i++) {
			char ch = val.charAt(i);
			int keyIndex = keyIndexes[ki];
			
			boolean decoded = true;
			if ('A' <= ch && ch <= 'Z') {
				// Half-width Latin upper alphabets
				ch = dec(ch, 'A', keyIndex, 26);
			} else if ('a' <= ch && ch <= 'z') {
				// Half-width Latin lower alphabets
				ch = dec(ch, 'a', keyIndex, 26);
			} else if ('Ａ' <= ch && ch <= 'Ｚ') {
				// Full-width Latin upper alphabets
				ch = dec(ch, 'Ａ', keyIndex, 26);
			} else if ('ａ' <= ch && ch <= 'ｚ') {
				// Full-width Latin lower alphabets
				ch = dec(ch, 'ａ', keyIndex, 26);
			} else {
				// Others
				decoded = false;
			}
			
			sb.append(ch);
			
			if (decoded) {
				ki++;
				if (keyIndexes.length <= ki) {
					ki = 0;
				}
			}
		}
		
		return sb.toString();
	}
	
	private static char enc(char ch, char baseCh, int keyIndex, int m) {
		int x = ch - baseCh;
		
		int n = (x + keyIndex) % m;
		if (n < 0) {
			n += m;
		}
		
		return (char)(baseCh + n);
	}
	
	private static char dec(char ch, char baseCh, int keyIndex, int m) {
		int x = ch - baseCh;
		
		int n = (x - keyIndex) % m;
		if (n < 0) {
			n += m;
		}
		
		return (char)(baseCh + n);
	}
	
	private static int[] keyToIndexes(String key) {
		if (key == null || key.isEmpty()) {
			return BLANK_KEY_INDEXES;
		}
		
		int keyLen = key.length();
		int[] indexes = new int[keyLen];
		int indexLen = 0;
		boolean hasIndex = false;
		for (int i = 0; i < keyLen; i++) {
			char ch = key.charAt(i);
			
			int index;
			if ('A' <= ch && ch <= 'Z') {
				// Half-width Latin upper alphabets
				index = ch - 'A';
			} else if ('a' <= ch && ch <= 'z') {
				// Half-width Latin lower alphabets
				index = ch - 'a';
			} else if ('Ａ' <= ch && ch <= 'Ｚ') {
				// Full-width Latin upper alphabets
				index = ch - 'Ａ';
			} else if ('ａ' <= ch && ch <= 'ｚ') {
				// Full-width Latin lower alphabets
				index = ch - 'ａ';
			} else {
				continue;
			}
			
			indexes[indexLen++] = index;
			hasIndex |= (index != 0);
		}
		
		if (!hasIndex) {
			return BLANK_KEY_INDEXES;
		}
		
		if (indexLen < keyLen) {
			// Resize array
			indexes = Arrays.copyOf(indexes, indexLen);
		}
		
		return indexes;
	}
}
