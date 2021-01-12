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

import java.util.Locale;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.letter-case")
public class StringLetterCaseDencoder {
	
	private StringLetterCaseDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrUpperCase(DencodeCondition cond) {
		return encStrUpperCase(cond.value());
	}
	
	@DencoderFunction
	public static String encStrLowerCase(DencodeCondition cond) {
		return encStrLowerCase(cond.value());
	}
	
	@DencoderFunction
	public static String encStrSwapCase(DencodeCondition cond) {
		return encStrSwapCase(cond.value());
	}
	
	@DencoderFunction
	public static String encStrCapitalize(DencodeCondition cond) {
		return encStrCapitalize(cond.value());
	}
	
	
	private static String encStrUpperCase(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		return val.toUpperCase(Locale.US);
	}
	
	private static String encStrLowerCase(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		return val.toLowerCase(Locale.US);
	}
	
	private static String encStrSwapCase(String val) {
		return StringUtilz.swapCase(val);
	}
	
	private static String encStrCapitalize(String val) {
		return StringUtilz.capitalize(val, true);
	}
}
