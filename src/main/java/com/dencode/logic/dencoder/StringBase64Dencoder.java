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

import java.nio.charset.Charset;
import java.nio.charset.IllegalCharsetNameException;
import java.nio.charset.StandardCharsets;
import java.nio.charset.UnsupportedCharsetException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.binary.Base64;
import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.base64")
public class StringBase64Dencoder {
	
	private static final Pattern RFC2047_SPACE = Pattern.compile("\\?=\\s+=\\?");
	private static final Pattern RFC2047_BASE64 = Pattern.compile("=\\?(.+?)\\?B\\?(.+?)\\?=", Pattern.CASE_INSENSITIVE);
	
	private StringBase64Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrBase64Encoding(DencodeCondition cond) {
		return encStrBase64Encoding(cond.valueAsBinary(),
				DencodeUtils.getOption(cond.options(), "encStrBase64LineBreakEach", ""));
	}
	
	@DencoderFunction
	public static String decStrBase64Encoding(DencodeCondition cond) {
		return decStrBase64Encoding(cond.value(), cond.charset());
	}
	
	
	private static String encStrBase64Encoding(byte[] binValue, String encStrBase64LineBreakEach) {
		int lineLength = 0;
		if (encStrBase64LineBreakEach != null && !encStrBase64LineBreakEach.isEmpty()) {
			try {
				lineLength = Integer.parseInt(encStrBase64LineBreakEach);
			} catch (NumberFormatException e) {
				// NOP
			}
		}
		
		Base64 base64 = new Base64(lineLength);
		return base64.encodeAsString(binValue);
	}
	
	private static String decStrBase64Encoding(String val, Charset charset) {
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
				
				Base64 base64 = new Base64();
				try {
					byte[] decodedValue = base64.decode(v.getBytes(StandardCharsets.US_ASCII));
					v = new String(decodedValue, cs);
				} catch (IllegalArgumentException e) {
					return null;
				}
				
				m.appendReplacement(sb, "");
				sb.append(v);
			} while (m.find());
			m.appendTail(sb);
			
			return sb.toString();
		} else {
			Base64 base64 = new Base64();
			try {
				byte[] decodedValue = base64.decode(val.getBytes(StandardCharsets.US_ASCII));
				return new String(decodedValue, charset);
			} catch (IllegalArgumentException e) {
				return null;
			}
		}
	}
}
