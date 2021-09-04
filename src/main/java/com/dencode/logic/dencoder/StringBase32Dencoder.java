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

import org.apache.commons.codec.binary.Base32;
import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.base32")
public class StringBase32Dencoder {
	
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
		Base32 base32 = new Base32();
		return base32.encodeAsString(binValue);
	}
	
	private static String decStrBase32(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		
		byte[] bin = val.getBytes(StandardCharsets.US_ASCII);
		
		Base32 base32 = new Base32();
		if (!base32.isInAlphabet(bin, true)) {
			return null;
		}
		
		try {
			byte[] decodedValue = base32.decode(bin);
			return new String(decodedValue, charset);
		} catch (IllegalArgumentException e) {
			return null;
		}
	}
}
