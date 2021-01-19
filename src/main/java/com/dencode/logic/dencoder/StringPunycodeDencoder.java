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

import java.net.IDN;
import java.util.List;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.punycode")
public class StringPunycodeDencoder {
	
	private StringPunycodeDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrPunycode(DencodeCondition cond) {
		return encStrPunycode(cond.valueAsLines());
	}
	
	@DencoderFunction
	public static String decStrPunycode(DencodeCondition cond) {
		return decStrPunycode(cond.valueAsLines());
	}
	
	
	private static String encStrPunycode(List<String> vals) {
		try {
			return DencodeUtils.dencodeLines(vals, (val) -> IDN.toASCII(val, IDN.ALLOW_UNASSIGNED));
		} catch (IllegalArgumentException e) {
			return null;
		}
	}
	
	private static String decStrPunycode(List<String> vals) {
		return DencodeUtils.dencodeLines(vals, (val) -> IDN.toUnicode(val, IDN.ALLOW_UNASSIGNED));
	}
}
