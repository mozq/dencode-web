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

import java.text.Normalizer;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.unicode-normalization")
public class StringUnicodeNormalizationDencoder {
	
	private StringUnicodeNormalizationDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrUnicodeNFC(DencodeCondition cond) {
		return encStrUnicodeNFC(cond.value());
	}
	
	@DencoderFunction
	public static String encStrUnicodeNFKC(DencodeCondition cond) {
		return encStrUnicodeNFKC(cond.value());
	}
	
	@DencoderFunction
	public static String decStrUnicodeNFC(DencodeCondition cond) {
		return decStrUnicodeNFC(cond.value());
	}
	
	@DencoderFunction
	public static String decStrUnicodeNFKC(DencodeCondition cond) {
		return decStrUnicodeNFKC(cond.value());
	}
	
	
	private static String encStrUnicodeNFC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFC);
	}
	
	private static String encStrUnicodeNFKC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFKC);
	}
	
	private static String decStrUnicodeNFC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFD);
	}
	
	private static String decStrUnicodeNFKC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFKD);
	}
}
