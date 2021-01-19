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

import java.util.List;
import java.util.function.Function;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="number", method="number.oct")
public class NumberOctDencoder {
	
	private NumberOctDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encNumOct(DencodeCondition cond) {
		return encNumOct(cond.valueAsParsedLines((val) -> DencodeUtils.encNum(val, 8)));
	}
	
	@DencoderFunction
	public static String decNumOct(DencodeCondition cond) {
		return decNumOct(cond.valueAsParsedLines((val) -> DencodeUtils.decNum(val, 8)));
	}
	
	
	private static String encNumOct(List<String> vals) {
		return DencodeUtils.dencodeLines(vals, Function.identity());
	}
	
	private static String decNumOct(List<String> vals) {
		return DencodeUtils.dencodeLines(vals, Function.identity());
	}
}
