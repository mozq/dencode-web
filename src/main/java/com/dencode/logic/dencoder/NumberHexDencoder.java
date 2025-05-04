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

import java.math.BigDecimal;
import java.util.List;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;
import com.dencode.logic.parser.NumberParser;

@Dencoder(type="number", method="number.hex", hasEncoder=true, hasDecoder=true)
public class NumberHexDencoder {
	
	private static final int DEC_RADIX = 10;
	private static final int DEC_MAX_SCALE = 100;
	
	private static final int ENC_RADIX = 16;
	private static final int ENC_MAX_SCALE = DencodeUtils.digitsOf(DEC_MAX_SCALE, ENC_RADIX);
	
	private static final int MAX_REPETEND_COUNT = 3;
	
	private NumberHexDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encNumHex(DencodeCondition cond) {
		return encNumHex(cond.valueAsNumbers(), cond.valueAsLines());
	}
	
	@DencoderFunction
	public static String decNumHex(DencodeCondition cond) {
		return decNumHex(cond.valueAsLines());
	}
	
	
	private static String encNumHex(List<BigDecimal> vals, List<String> strVals) {
		return DencodeUtils.dencodeLines(vals, strVals, (bigDec, strVal) -> {
			return DencodeUtils.numToString(bigDec, NumberParser.isTruncatedDecimal(strVal), ENC_RADIX, ENC_MAX_SCALE, MAX_REPETEND_COUNT);
		});
	}
	
	private static String decNumHex(List<String> vals) {
		return DencodeUtils.dencodeLines(vals, (val) -> {
			BigDecimal bigDec = NumberParser.parseN(val, ENC_RADIX);
			return DencodeUtils.numToString(bigDec, NumberParser.isTruncatedDecimal(val), DEC_RADIX, DEC_MAX_SCALE, MAX_REPETEND_COUNT);
		});
	}
}
