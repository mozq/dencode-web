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
import java.io.IOException;
import java.nio.charset.Charset;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.url-encoding", hasEncoder=true, hasDecoder=true, useOe=true, useNl=true)
public class StringURLEncodingDencoder {
	
	private static final char[] DECODING_SYMBOLS = {'%', '+'};
	
	private StringURLEncodingDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrURLEncoding(DencodeCondition cond) {
		return encStrURLEncoding(
				cond.valueAsBinary(),
				DencodeUtils.getOption(cond.options(), "string.url-encoding.space", "").equals("form")
				);
	}
	
	@DencoderFunction
	public static String decStrURLEncoding(DencodeCondition cond) {
		return decStrURLEncoding(cond.value(), cond.charset());
	}
	
	
	private static String encStrURLEncoding(byte[] binValue,  boolean formSpace) {
		StringBuilder sb = new StringBuilder(binValue.length * 3);
		
		for (byte b : binValue) {
			if (((byte)'A' <= b && b <= (byte)'Z')
					|| ((byte)'a' <= b && b <= (byte)'z')
					|| ((byte)'0' <= b && b <= (byte)'9')
					|| b == (byte)'-'
					|| b == (byte)'.'
					|| b == (byte)'_'
					|| b == (byte)'~'
					) {
				// RFC 3986 - 2.3. Unreserved Characters
				// unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
				sb.append((char)b);
			} else if (formSpace && b == (byte)' ') {
				sb.append('+');
			} else {
				int high = (b & 0xF0) >>> 4;
				int low = b & 0x0F;
				sb.append('%');
				sb.append(DencodeUtils.numToHexDigit(high, true));
				sb.append(DencodeUtils.numToHexDigit(low, true));
			}
		}
		
		return sb.toString();
	}
	
	private static String decStrURLEncoding(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		
		int sidx = StringUtilz.indexOf(val, DECODING_SYMBOLS);
		if (sidx == -1) {
			return val;
		}
		
		int len = val.length();
		ByteArrayOutputStream binBuf = new ByteArrayOutputStream(len);
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (ch == '%') {
				try {
					int high = DencodeUtils.hexDigitToNum(val.charAt(++i));
					int low = DencodeUtils.hexDigitToNum(val.charAt(++i));
					binBuf.write((byte)((high << 4) | low));
				} catch (IndexOutOfBoundsException | IllegalArgumentException e) {
					return null;
				}
			} else if (ch == '+') {
				try {
					binBuf.write(" ".getBytes(charset));
				} catch (IOException e) {
					return null;
				}
			} else {
				binBuf.write((byte)ch);
			}
		}
		
		return binBuf.toString(charset);
	}
}
