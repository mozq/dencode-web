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
import java.nio.charset.IllegalCharsetNameException;
import java.nio.charset.UnsupportedCharsetException;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.base64", hasEncoder=true, hasDecoder=true, useOe=true, useNl=true)
public class StringBase64Dencoder {
	
	private static final int[] BASE64_BITS = {
			// 62nd = '+', 63rd = '/' : RFC 4648 Base64, RFC 2045
			// 62nd = '-', 63rd = '_' : RFC 4648 Base64url
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 000:
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 010:
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 020:
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, // 030:
			-1, -1, -1, 62, -1, 62, -1, 63, 52, 53, // 040:                '+',      '-',      '/', '0', '1',
			54, 55, 56, 57, 58, 59, 60, 61, -1, -1, // 050: '2', '3', '4', '5', '6', '7', '8', '9',
			-1, -1, -1, -1, -1,  0,  1,  2,  3,  4, // 060:                          'A', 'B', 'C', 'D', 'E',
			 5,  6,  7,  8,  9, 10, 11, 12, 13, 14, // 070: 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
			15, 16, 17, 18, 19, 20, 21, 22, 23, 24, // 080: 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
			25, -1, -1, -1, -1, 63, -1, 26, 27, 28, // 090: 'Z',                     '_',      'a', 'b', 'c',
			29, 30, 31, 32, 33, 34, 35, 36, 37, 38, // 100: 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
			39, 40, 41, 42, 43, 44, 45, 46, 47, 48, // 110: 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
			49, 50, 51, -1, -1, -1, -1, -1,         // 120: 'x', 'y', 'z',
			};
	
	private static final byte[] LINE_SEPARATOR = {'\r', '\n'};
	
	private static final Pattern RFC2047_SPACE = Pattern.compile("\\?=\\s+=\\?");
	private static final Pattern RFC2047_BASE64 = Pattern.compile("=\\?(.+?)(?:\\*.+?)?\\?B\\?(.+?)\\?=", Pattern.CASE_INSENSITIVE); // Also supports RFC 2231
	
	private StringBase64Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrBase64(DencodeCondition cond) {
		return encStrBase64(cond.valueAsBinary(),
				DencodeUtils.getOptionAsInt(cond.options(), "encStrBase64LineBreakEach", 0, 0));
	}
	
	@DencoderFunction
	public static String decStrBase64(DencodeCondition cond) {
		return decStrBase64(cond.value(), cond.charset());
	}
	
	
	private static String encStrBase64(byte[] binValue, int lineBreakEach) {
		Encoder base64Encoder = (lineBreakEach == 0) ? Base64.getEncoder() : Base64.getMimeEncoder(lineBreakEach, LINE_SEPARATOR);
		return base64Encoder.encodeToString(binValue);
	}
	
	private static String decStrBase64(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		
		if (val.contains("=?") && val.contains("?=")) {
			// RFC 2047
			
			val = RFC2047_SPACE.matcher(val).replaceAll("?==?");
			
			StringBuilder sb = new StringBuilder(val.length());
			
			Matcher m = RFC2047_BASE64.matcher(val);
			if (!m.find()) {
				return null;
			}
			
			do {
				Charset cs;
				try {
					cs = Charset.forName(m.group(1));
				} catch (IllegalCharsetNameException | UnsupportedCharsetException e) {
					return null;
				}
				
				String v = m.group(2);
				
				String decodedValue = decode(v, cs);
				if (decodedValue == null) {
					return null;
				}
				
				m.appendReplacement(sb, "");
				sb.append(decodedValue);
			} while (m.find());
			m.appendTail(sb);
			
			return sb.toString();
		} else {
			return decode(val, charset);
		}
	}
	
	private static String decode(String val, Charset charset) {
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
			
			int bits = BASE64_BITS[ch];
			if (bits == -1) {
				// Unsupported code
				return null;
			}
			
			bitsBuf = (bitsBuf << 6) | bits;
			bitCount += 6;
			
			if (8 <= bitCount) {
				byte b = (byte)((bitsBuf >>> (bitCount - 8)) & 0b11111111);
				binBuf.write(b);
				bitCount -= 8;
			}
		}
		
		return binBuf.toString(charset);
	}
}
