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

import org.mifmi.commons4j.util.NumberUtilz;
import org.mifmi.commons4j.util.exception.NumberParseException;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="number", method="number.english")
public class NumberEnglishDencoder {
	
	private NumberEnglishDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encNumEnShortScale(DencodeCondition cond) {
		return encNumEnShortScale(cond.valueAsNumbers(), false);
	}
	
	@DencoderFunction
	public static String encNumEnShortScaleFraction(DencodeCondition cond) {
		return encNumEnShortScale(cond.valueAsNumbers(), true);
	}
	
	@DencoderFunction
	public static String decNumEnShortScale(DencodeCondition cond) {
		return decNumEnShortScale(cond.valueAsLines());
	}
	
	
	private static String encNumEnShortScale(List<BigDecimal> vals, boolean fractionDec) {
		return DencodeUtils.dencodeLines(vals, (bigDec) -> {
			if (bigDec == null) {
				return null;
			}
			
			try {
				return NumberUtilz.toEnNumShortScale(bigDec, fractionDec);
			} catch (NumberParseException e) {
				return null;
			}
		});
	}
	
	private static String decNumEnShortScale(List<String> vals) {
		return DencodeUtils.dencodeLines(vals, (val) -> {
			BigDecimal bigDec;
			try {
				bigDec = NumberUtilz.parseEnNumShortScale(val);
			} catch (NumberParseException e) {
				return null;
			}
			
			if (bigDec == null) {
				return null;
			}
			return bigDec.toPlainString();
		});
	}
}
