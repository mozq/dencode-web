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
import java.util.regex.Pattern;

import org.mifmi.commons4j.util.NumberUtilz;
import org.mifmi.commons4j.util.StringUtilz;
import org.mifmi.commons4j.util.exception.NumberParseException;

public class NumberParser {
	
	private static final Pattern NUM_DEC_PATTERN_DOT_COMMA = Pattern.compile("[+-]?(?:(?:[0-9]{1,3}(?:\\.[0-9]{3}){2,})|(?:[0-9]{1,3}(?:\\.[0-9]{3})+\\,[0-9]*)|(?:[0-9]{4,}\\,.+)|(?:.+\\,[0-9]{1,2})|(?:.+\\,[0-9]{4,}))");
	
	private NumberParser() {
		// NOP
	}
	
	public static BigDecimal parseNumDec(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		val = StringUtilz.toHalfWidth(val, true, true, true, true, false, false);
		val = val.trim();
		
		BigDecimal num;
		
		// Decimal Format
		num = parseDec(val);
		if (num != null) {
			return num;
		}
		
		// Hex Format
		if (3 <= val.length() && val.startsWith("0x")) {
			num = parseHex(val);
			if (num != null) {
				return num;
			}
		}
		
		// English Format
		num = parseEnNumShortScale(val);
		if (num != null) {
			return num;
		}
		
		// Japanese Format
		num = parseJPNum(val);
		if (num != null) {
			return num;
		}
		
		return null;
	}
	
	public static BigDecimal parseDec(String val) {
		
		if (NUM_DEC_PATTERN_DOT_COMMA.matcher(val).matches()) {
			// 0.000.000,0 -> 0000000.0
			val = val.replace(".", "").replace(",", ".");
		} else {
			// 0,000,000.0 -> 0000000.0
			val = val.replace(",", "");
		}
		
		try {
			return new BigDecimal(val);
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	public static BigDecimal parseBin(String val) {
		try {
			return new BigDecimal(new BigInteger(val, 2));
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	public static BigDecimal parseOct(String val) {
		try {
			return new BigDecimal(new BigInteger(val, 8));
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	public static BigDecimal parseHex(String val) {
		if (3 <= val.length() && val.startsWith("0x")) {
			// Remove hex prefix
			val = val.substring(2);
		}
		
		try {
			return new BigDecimal(new BigInteger(val, 16));
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	public static BigDecimal parseEnNumShortScale(String val) {
		try {
			return NumberUtilz.parseEnNumShortScale(val);
		} catch (NumberParseException e1) {
			return null;
		}
	}
	
	public static BigDecimal parseJPNum(String val) {
		try {
			return NumberUtilz.parseJPNum(val);
		} catch (NumberParseException e1) {
			return null;
		}
	}
}
