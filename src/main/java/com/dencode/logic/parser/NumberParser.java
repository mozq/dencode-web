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
package com.dencode.logic.parser;

import java.math.BigDecimal;

import org.mifmi.commons4j.util.NumberUtilz;
import org.mifmi.commons4j.util.StringUtilz;
import org.mifmi.commons4j.util.exception.NumberParseException;

public class NumberParser {
	
	private NumberParser() {
		// NOP
	}
	
	public static BigDecimal parseNumDec(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		val = StringUtilz.toHalfWidth(val, true, true, true, true, false, false);
		val = val.replace(",", "");
		try {
			// Standard Format
			return new BigDecimal(val);
		} catch (NumberFormatException e) {
			BigDecimal enNum;
			try {
				// English Format
				enNum = NumberUtilz.parseEnNumShortScale(val);
			} catch (NumberParseException e1) {
				enNum = null;
			}
			
			if (enNum != null) {
				return enNum;
			}
			
			// Japanese Format
			try {
				return NumberUtilz.parseJPNum(val);
			} catch (NumberParseException e1) {
				return null;
			}
		}
	}
}
