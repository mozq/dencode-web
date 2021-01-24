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
import java.math.BigInteger;

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
		
		BigDecimal num;
		
		// Hex Format
		if (3 <= val.length() && val.startsWith("0x")) {
			try {
				num = new BigDecimal(new BigInteger(val.substring(2), 16));
			} catch (NumberFormatException e) {
				num = null;
			}
			if (num != null) {
				return num;
			}
		}
		
		// Standard Decimal Format
		try {
			num = new BigDecimal(val);
		} catch (NumberFormatException e) {
			num = null;
		}
		if (num != null) {
			return num;
		}
		
		// English Format
		try {
			num = NumberUtilz.parseEnNumShortScale(val);
		} catch (NumberParseException e1) {
			num = null;
		}
		if (num != null) {
			return num;
		}
		
		// Japanese Format
		try {
			num = NumberUtilz.parseJPNum(val);
		} catch (NumberParseException e1) {
			num = null;
		}
		if (num != null) {
			return num;
		}
		
		return null;
	}
}
