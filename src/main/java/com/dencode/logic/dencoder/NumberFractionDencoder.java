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
import java.math.BigInteger;
import java.util.List;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;
import com.dencode.logic.parser.NumberParser;

@Dencoder(type="number", method="number.fraction", hasEncoder=true, hasDecoder=false)
public class NumberFractionDencoder {
	
	private NumberFractionDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encNumFraction(DencodeCondition cond) {
		return encNumFraction(cond.valueAsNumbers(), cond.valueAsLines());
	}
	
	
	private static String encNumFraction(List<BigDecimal> vals, List<String> strVals) {
		return DencodeUtils.dencodeLines(vals, strVals, (bigDec, strVal) -> {
			if (bigDec == null) {
				return null;
			}
			
			BigDecimal strippedNum = bigDec.stripTrailingZeros();
			if (strippedNum.scale() <= 0) {
				// Has no decimal part
				// (Integer part only)
				return strippedNum.toPlainString() + "/1";
			}
			
			// n/d
			BigInteger[] fraction = NumberParser.parseFraction(strVal, 10);
			if (fraction == null) {
				// n.nnn
				fraction = NumberParser.toFraction(bigDec, NumberParser.isTruncatedDecimal(strVal));
				if (fraction == null) {
					return null;
				}
			}
			
			fraction = NumberParser.reduceFraction(fraction);
			
			BigInteger n = fraction[0];
			BigInteger d = fraction[1];
			
			if (d.signum() == 0) {
				return null;
			}
			
			if (d.signum() == -1) {
				// n/-d to -n/d
				n = n.negate();
				d = d.abs();
			}
			
			return n.toString() + "/" + d.toString();
		});
	}
}
