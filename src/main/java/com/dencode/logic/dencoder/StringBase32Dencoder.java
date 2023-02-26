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

import java.io.ByteArrayOutputStream;
import java.nio.charset.Charset;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.base32")
public class StringBase32Dencoder {
	
	private static final char[] BASE32_DIGITS = {
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
			'U', 'V', 'W', 'X', 'Y', 'Z', '2', '3', '4', '5',
			'6', '7'
			};
	
	private static final int[] BASE32_BITS = {
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 000:
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 010:
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 020:
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 030:
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 040:
			26, 27, 28, 29, 30, 31, -1, -1, -1, -1, // 050: '2', '3', '4', '5', '6', '7',
			-1, -1, -1, -1, -1,  0,  1,  2,  3,  4, // 060:                          'A', 'B', 'C', 'D', 'E',
			 5,  6,  7,  8,  9, 10, 11, 12, 13, 14, // 070: 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
			15, 16, 17, 18, 19, 20, 21, 22, 23, 24, // 080: 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
			25, -1, -1, -1, -1, -1, -1,  0,  1,  2, // 090: 'Z',                               'a', 'b', 'c',
			 3,  4,  5,  6,  7,  8,  9, 10, 11, 12, // 100: 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
			13, 14, 15, 16, 17, 18, 19, 20, 21, 22, // 110: 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
			23, 24, 25, -1, -1, -1, -1, -1,         // 120: 'x', 'y', 'z',
			};
	
	private StringBase32Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrBase32(DencodeCondition cond) {
		return encStrBase32(cond.valueAsBinary());
	}
	
	@DencoderFunction
	public static String decStrBase32(DencodeCondition cond) {
		return decStrBase32(cond.value(), cond.charset());
	}
	

	private static String encStrBase32(byte[] binValue) {
		int len = binValue.length;
		
		if (len == 0) {
			return "";
		}
		
		StringBuilder sb = new StringBuilder(len * 2);
		int bitsBuf = 0;
		int bitCount = 0;
		for (int i = 0; i < len; i++) {
			int b = binValue[i] & 0b11111111;
			
			bitsBuf = (bitsBuf << 8) | b;
			bitCount += 8;
			
			while (5 <= bitCount) {
				int bits = (bitsBuf >>> (bitCount - 5)) & 0b11111;
				sb.append(BASE32_DIGITS[bits]);
				bitCount -= 5;
			}
		}
		
		if (bitCount != 0) {
			int bits = (bitsBuf << (5 - bitCount)) & 0b11111;
			sb.append(BASE32_DIGITS[bits]);
		}
		
		// Padding
		int pad = (8 - (sb.length() % 8)) % 8;
		for (int i = 0; i < pad; i++) {
			sb.append('=');
		}
		
		return sb.toString();
	}
	
	private static String decStrBase32(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}

		int len = val.length();

		// Ignore trailing padding and white-spaces
		for (int i = len - 1; 0 <= i; i--) {
			char ch = val.charAt(i);
			if (ch != '=' && ch != ' ' && ch != '\t' && ch != '\r' && ch != '\n') {
				len = i + 1;
				break;
			}
		}
		
		ByteArrayOutputStream binBuf = new ByteArrayOutputStream(len);
		int bitsBuf = 0;
		int bitCount = 0;
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (ch == ' ' || ch == '\t' || ch == '\r' || ch == '\n') {
				// Ignore white-spaces
				continue;
			}
			
			int bits = BASE32_BITS[ch];
			if (bits == -1) {
				// Unsupported code
				return null;
			}
			
			bitsBuf = (bitsBuf << 5) | bits;
			bitCount += 5;
			
			if (8 <= bitCount) {
				byte b = (byte)((bitsBuf >>> (bitCount - 8)) & 0b11111111);
				binBuf.write(b);
				bitCount -= 8;
			}
		}
		
		return binBuf.toString(charset);
	}
}
