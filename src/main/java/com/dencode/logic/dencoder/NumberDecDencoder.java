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

@Dencoder(type="number", method="number.dec")
public class NumberDecDencoder {
	
	private NumberDecDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encNumDec(DencodeCondition cond) {
		return encNumDec(cond.valueAsNumbers());
	}
	
	@DencoderFunction
	public static String decNumDec(DencodeCondition cond) {
		return decNumDec(cond.valueAsLines());
	}
	
	
	private static String encNumDec(List<BigDecimal> vals) {
		return DencodeUtils.dencodeLines(vals, (bigDec) -> {
			if (bigDec == null) {
				return null;
			}
			
			return bigDec.toPlainString();
		});
	}
	
	private static String decNumDec(List<String> vals) {
		return DencodeUtils.dencodeLines(vals, (val) -> {
			BigDecimal bigDec = NumberParser.parseDec(val);
			
			if (bigDec == null) {
				return null;
			}
			
			return bigDec.toPlainString();
		});
	}
}
