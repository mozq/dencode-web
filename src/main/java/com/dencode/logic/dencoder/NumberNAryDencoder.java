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
import java.util.regex.Pattern;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;
import com.dencode.logic.parser.NumberParser;

@Dencoder(type="number", method="number.n-ary", hasEncoder=true, hasDecoder=true)
public class NumberNAryDencoder {
	
	private static final int DEC_RADIX = 10;
	private static final int DEC_MAX_SCALE = 100;
	
	private static final int MAX_REPETEND_COUNT = 3;
	
	private static final Pattern PARSABLE_NUM_PATTERN = Pattern.compile("[\\+\\-]?[0-9A-Za-z\\.]+");
	
	private NumberNAryDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encNumNAry(DencodeCondition cond) {
		return encNumNAry(
				cond.valueAsNumbers(),
				cond.valueAsLines(),
				DencodeUtils.getOptionAsInt(cond.options(), "number.n-ary.radix", 32, 32)
				);
	}
	
	@DencoderFunction
	public static String decNumNAry(DencodeCondition cond) {
		return decNumNAry(
				cond.valueAsLines(),
				DencodeUtils.getOptionAsInt(cond.options(), "number.n-ary.radix", 32, 32)
				);
	}
	
	
	private static String encNumNAry(List<BigDecimal> vals, List<String> strVals, int radix) {
		return DencodeUtils.dencodeLines(vals, strVals, (bigDec, strVal) -> {
			return DencodeUtils.numToString(bigDec, NumberParser.isTruncatedDecimal(strVal), radix, DEC_MAX_SCALE, MAX_REPETEND_COUNT);
		});
	}
	
	private static String decNumNAry(List<String> vals, int radix) {
		return DencodeUtils.dencodeLines(vals, (val) -> {
			BigDecimal bigDec = NumberParser.parseN(val, radix);
			if (bigDec == null) {
				if (val != null && !val.isEmpty() && PARSABLE_NUM_PATTERN.matcher(val).matches()) {
					// If the value is parsable as N-ary numbers,
					// returns an empty value so the radix options can be changed.
					return "";
				} else {
					return null;
				}
			}
			
			int maxScale = DencodeUtils.digitsOf(DEC_MAX_SCALE, radix);
			return DencodeUtils.numToString(bigDec, NumberParser.isTruncatedDecimal(val), DEC_RADIX, maxScale, MAX_REPETEND_COUNT);
		});
	}
}
