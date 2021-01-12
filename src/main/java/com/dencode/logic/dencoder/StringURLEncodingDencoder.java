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
import java.nio.charset.StandardCharsets;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.net.URLCodec;
import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.url-encoding")
public class StringURLEncodingDencoder {
	
	private StringURLEncodingDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrURLEncoding(DencodeCondition cond) {
		return encStrURLEncoding(cond.valueAsBinary());
	}
	
	@DencoderFunction
	public static String decStrURLEncoding(DencodeCondition cond) {
		return decStrURLEncoding(cond.value(), cond.charset());
	}
	
	
	private static String encStrURLEncoding(byte[] binValue) {
		URLCodec urlCodec = new URLCodec();
		String encodedURL = new String(urlCodec.encode(binValue), StandardCharsets.US_ASCII);
		if (encodedURL.indexOf('+') != -1) {
			encodedURL = encodedURL.replace("+", "%20");
		}
		return encodedURL;
	}
	
	private static String decStrURLEncoding(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		
		byte[] bin = val.getBytes(StandardCharsets.US_ASCII);
		
		URLCodec urlCodec = new URLCodec();
		try {
			byte[] decodedValue = urlCodec.decode(bin);
			return new String(decodedValue, charset);
		} catch (DecoderException e) {
			return null;
		}
	}
}
