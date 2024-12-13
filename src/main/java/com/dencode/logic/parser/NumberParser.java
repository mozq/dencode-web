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

import com.ezylang.evalex.Expression;

public class NumberParser {
	
	private static final Pattern NUM_DEC_PATTERN_DOT_COMMA = Pattern.compile("[+-]?(?:(?:[0-9]{1,3}(?:\\.[0-9]{3}){2,})|(?:[0-9]{1,3}(?:\\.[0-9]{3})+\\,[0-9]*)|(?:[0-9]{4,}\\,.+)|(?:.+\\,[0-9]{1,2})|(?:.+\\,[0-9]{4,}))");
	
	private NumberParser() {
		// NOP
	}
	
	public static BigDecimal parse(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		val = StringUtilz.toHalfWidth(val, true, true, true, true, false, false);
		val = val.trim();
		
		if (val.isEmpty()) {
			return null;
		}
		
		BigDecimal num;
		
		// Decimal Format
		num = parseDec(val);
		if (num != null) {
			return num;
		}
		
		// N-ary Format (0b, 0o and 0x)
		if (val.startsWith("0") || val.startsWith("+0") || val.startsWith("-0")) {
			int cIdx = (val.startsWith("0")) ? 1 : 2;
			if (cIdx < val.length()) {
				char ch = val.charAt(cIdx);
				if (ch == 'b' || ch == 'B') {
					// Bin Format
					num = parseBin(val);
				} else if (ch == 'o' || ch == 'O') {
					// Oct Format
					num = parseOct(val);
				} else if (ch == 'x' || ch == 'X') {
					// Hex Format
					num = parseHex(val);
				}
			}
			
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
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		String sanitizedVal;
		if (NUM_DEC_PATTERN_DOT_COMMA.matcher(val).matches()) {
			// 0.000.000,0 -> 0000000.0
			sanitizedVal = val.replace(".", "").replace(",", ".");
		} else {
			// 0,000,000.0 -> 0000000.0
			sanitizedVal = val.replace(",", "");
		}
		
		try {
			return new BigDecimal(sanitizedVal);
		} catch (NumberFormatException e) {
			// Parse as expression
			try {
				Expression exp = new Expression(val);
				return exp.evaluate().getNumberValue();
			} catch (Exception e1) {
				return null;
			}
		}
	}
	
	public static BigDecimal parseBin(String val) {
		return parse(val, 2);
	}
	
	public static BigDecimal parseOct(String val) {
		return parse(val, 8);
	}
	
	public static BigDecimal parseHex(String val) {
		return parse(val, 16);
	}

	private static BigDecimal parse(String val, int radix) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		if (val.startsWith("0") || val.startsWith("+0") || val.startsWith("-0")) {
			int cIdx = (val.startsWith("0")) ? 1 : 2;
			if (cIdx < val.length()) {
				char ch = val.charAt(cIdx);
				if ((radix == 2 && (ch == 'b' || ch == 'B'))
						|| (radix == 8 && (ch == 'o' || ch == 'O'))
						|| (radix == 16 && (ch == 'x' || ch == 'X'))
						) {
					// Remove N-ary prefix (0b, 0o or 0x), if the radix equals 2, 8 or 16
					if (val.startsWith("-")) {
						// Negative value
						val = "-" + val.substring(cIdx + 1);
					} else {
						// Positive value
						val = val.substring(cIdx + 1);
					}
				}
			}
		}
		
		if (val.endsWith("...")) {
			// Remove "..." suffix
			val = val.substring(0, val.length() - 3);
		}
		
		if (val.isEmpty()) {
			return null;
		}
		
		int decMarkIdx = val.indexOf('.');
		if (decMarkIdx == -1) {
			try {
				return new BigDecimal(new BigInteger(val, radix));
			} catch (NumberFormatException e) {
				return null;
			}
		} else {
			int decPartLen = val.length() - decMarkIdx - 1;

			boolean negative;
			BigDecimal intPart;
			try {
				String intPartStr = val.substring(0, decMarkIdx);
				if (intPartStr.isEmpty() || intPartStr.equals("+") || intPartStr.equals("-")) {
					intPart = BigDecimal.ZERO;
				} else {
					intPart = new BigDecimal(new BigInteger(intPartStr, radix));
				}
				
				negative = (intPartStr.startsWith("-") || intPart.signum() < 0); // if -0 then signum() == 0, so store the sign
			} catch (NumberFormatException e) {
				return null;
			}
			if (decPartLen == 0) {
				return intPart;
			}
			
			BigDecimal decPart;
			try {
				decPart = new BigDecimal(new BigInteger(val.substring(decMarkIdx + 1), radix));
			} catch (NumberFormatException e) {
				return null;
			}
			if (decPart.signum() == 0) {
				return intPart.setScale(1);
			}
			
			decPart = decPart.divide(BigDecimal.valueOf(radix).pow(decPartLen));
			
			if (negative) {
				return intPart.subtract(decPart);
			} else {
				return intPart.add(decPart);
			}
		}
	}
	
	public static BigDecimal parseEnNumShortScale(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		try {
			return NumberUtilz.parseEnNumShortScale(val);
		} catch (NumberParseException | ArithmeticException e) {
			return null;
		}
	}
	
	public static BigDecimal parseJPNum(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		try {
			return NumberUtilz.parseJPNum(val);
		} catch (NumberParseException | ArithmeticException e) {
			return null;
		}
	}
}
