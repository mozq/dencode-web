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

import static com.dencode.logic.util.CharWidthUtils.Type.ALPHABET;
import static com.dencode.logic.util.CharWidthUtils.Type.NUMBER;
import static com.dencode.logic.util.CharWidthUtils.Type.SPACE;
import static com.dencode.logic.util.CharWidthUtils.Type.SYMBOL;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.EnumSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.dencode.logic.util.CharWidthUtils;
import com.dencode.logic.util.EnglishNumberUtils;
import com.dencode.logic.util.JapaneseNumberUtils;
import com.ezylang.evalex.Expression;
import com.ezylang.evalex.config.ExpressionConfiguration;

public class NumberParser {
	
	protected static class RepeatingInfo {
		public static final RepeatingInfo NO_MATCHED = new RepeatingInfo(0, -1, 0, 0, 0);
		
		private int count; public int count() { return this.count; }
		private int startIndex; public int startIndex() { return this.startIndex; }
		private int repetendLength; public int repetendLength() { return this.repetendLength; }
		private int oddRepetendLength; public int oddRepetendLength() { return this.oddRepetendLength; }
		private int roundingDifference; public int roundingDifference() { return this.roundingDifference; }
		
		public RepeatingInfo(int count, int startIndex, int repetendLength, int oddRepetendLength, int roundingDifference) {
			this.count = count;
			this.startIndex = startIndex;
			this.repetendLength = repetendLength;
			this.oddRepetendLength = oddRepetendLength;
			this.roundingDifference = roundingDifference;
		}
	}
	
	
	private static final int DEFAULT_SCALE = 160;
	private static final RoundingMode DEFAULT_ROUNDING_MODE = RoundingMode.DOWN;
	
	private static final ExpressionConfiguration EXP_CONF = ExpressionConfiguration.builder()
			.mathContext(new MathContext(1000, DEFAULT_ROUNDING_MODE))
			.stripTrailingZeros(false)
			.build();
	
	private static final Pattern NUM_DEC_PATTERN_DOT_COMMA = Pattern.compile("[+-]?(?:(?:[0-9]{1,3}(?:\\.[0-9]{3}){2,})|(?:[0-9]{1,3}(?:\\.[0-9]{3})+\\,[0-9]*)|(?:[0-9]{4,}\\,.+)|(?:.+\\,[0-9]{1,2})|(?:.+\\,[0-9]{4,}))");
	
	private static final Pattern FRACTION_PATTERN = Pattern.compile("\\s?([\\+\\-]?[0-9A-Za-z\\.]+)\\s?/\\s?([\\+\\-]?[0-9A-Za-z\\.]+)\\s?");
	
	private static final String TRUNCATED_DECIMAL_SUFFIX = "...";
	
	
	private NumberParser() {
		// NOP
	}
	
	public static BigDecimal parse(String val) {
		return parse(val, DEFAULT_SCALE, DEFAULT_ROUNDING_MODE);
	}
	
	private static BigDecimal parse(String val, int scale, RoundingMode roundingMode) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		val = CharWidthUtils.toHalfWidth(val, EnumSet.of(ALPHABET, NUMBER, SYMBOL, SPACE));
		val = val.trim();
		
		if (val.isEmpty()) {
			return null;
		}
		
		BigDecimal num;
		
		// Decimal Format
		num = parseDec(val, scale, roundingMode);
		
		// N-ary Format (0b, 0o and 0x)
		if (num == null) {
			if (val.startsWith("0") || val.startsWith("+0") || val.startsWith("-0")) {
				int cIdx = (val.startsWith("0")) ? 1 : 2;
				if (cIdx < val.length()) {
					char ch = val.charAt(cIdx);
					if (ch == 'b' || ch == 'B') {
						// Bin Format
						num = parseN(val, 2, scale, roundingMode);
					} else if (ch == 'o' || ch == 'O') {
						// Oct Format
						num = parseN(val, 8, scale, roundingMode);
					} else if (ch == 'x' || ch == 'X') {
						// Hex Format
						num = parseN(val, 16, scale, roundingMode);
					}
				}
			}
		}
		
		// English Format
		if (num == null) {
			num = parseEnNumShortScale(val);
		}
		
		// Japanese Format
		if (num == null) {
			num = parseJPNum(val);
		}
		
		if (isTruncatedDecimal(val)) {
			num = increasePrecision(num, scale, roundingMode);
		}
		
		return num;
	}

	public static BigDecimal parseDec(String val) {
		return parseDec(val, DEFAULT_SCALE, DEFAULT_ROUNDING_MODE);
	}
	
	private static BigDecimal parseDec(String val, int scale, RoundingMode roundingMode) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		String strNum;
		if (NUM_DEC_PATTERN_DOT_COMMA.matcher(val).matches()) {
			// 0.000.000,0 -> 0000000.0
			strNum = val.replace(".", "").replace(",", ".");
		} else {
			// 0,000,000.0 -> 0000000.0
			strNum = val.replace(",", "");
		}
		
		BigDecimal bigDec = parseN(strNum, 10, scale, roundingMode);
		if (bigDec == null) {
			// Parse as expression
			try {
				String strNum2 = removeTruncatedDecimalSuffix(strNum);
				Expression exp = new Expression(strNum2, EXP_CONF);
				bigDec = exp.evaluate().getNumberValue();
				
				if (scale < bigDec.scale()) {
					bigDec = bigDec.setScale(scale, roundingMode);
				}
			} catch (Exception e1) {
				bigDec = null;
			}
		}
		
		return bigDec;
	}
	
	public static BigDecimal parseN(String val, int radix) {
		return parseN(val, radix, DEFAULT_SCALE, DEFAULT_ROUNDING_MODE);
	}
	
	private static BigDecimal parseN(String val, int radix, int scale, RoundingMode roundingMode) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		BigInteger[] fraction = parseFraction(val, radix);
		if (fraction != null) {
			BigInteger n = fraction[0];
			BigInteger d = fraction[1];
			
			return divide(new BigDecimal(n), new BigDecimal(d), scale, roundingMode);
		}
		
		String strNum = val;
		
		int prefixIdx = 0;
		int suffixIdx = strNum.length();
		boolean negative = false;
		
		if (strNum.startsWith("+")) {
			prefixIdx += 1;
		} else if (strNum.startsWith("-")) {
			prefixIdx += 1;
			negative = true;
		}
		
		if ((radix == 2 && (strNum.startsWith("0b", prefixIdx) || strNum.startsWith("0B", prefixIdx)))
				|| (radix == 8 && (strNum.startsWith("0o", prefixIdx) || strNum.startsWith("0O", prefixIdx)))
				|| (radix == 16 && (strNum.startsWith("0x", prefixIdx) || strNum.startsWith("0X", prefixIdx)))
				) {
			prefixIdx += 2;
		}
		
		boolean truncatedDecimal = strNum.endsWith(TRUNCATED_DECIMAL_SUFFIX);
		if (truncatedDecimal) {
			suffixIdx -= TRUNCATED_DECIMAL_SUFFIX.length();
		}
		
		BigDecimal bigDec;
		
		int decMarkIdx = strNum.indexOf('.', prefixIdx, suffixIdx);
		if (decMarkIdx == -1) {
			// Integer
			String intPartStr = strNum.substring(prefixIdx, suffixIdx);
			try {
				bigDec = new BigDecimal(new BigInteger(intPartStr, radix));
			} catch (NumberFormatException e) {
				return null;
			}
		} else {
			// Decimal
			String intPartStr = strNum.substring(prefixIdx, decMarkIdx);
			String decPartStr = strNum.substring(decMarkIdx + 1, suffixIdx);
			String unscaledDigits = intPartStr + decPartStr;
			int decPartLen = decPartStr.length();
			
			if (truncatedDecimal) {
				BigInteger[] decFraction = toFraction(unscaledDigits, radix, negative, decPartLen, truncatedDecimal);
				if (decFraction != null) {
					BigInteger n = decFraction[0];
					BigInteger d = decFraction[1];
					
					return divide(new BigDecimal(n), new BigDecimal(d), scale, roundingMode);
				}
			}
			
			if (radix == 10) {
				try {
					bigDec = new BigDecimal(new BigInteger(unscaledDigits), decPartLen);
				} catch (NumberFormatException e) {
					return null;
				}
			} else {
				// radix != 10
				try {
					bigDec = new BigDecimal(new BigInteger(unscaledDigits, radix));
				} catch (NumberFormatException e) {
					return null;
				}
				
				if (0 < decPartLen) {
					if (bigDec.signum() != 0) {
						bigDec = divide(bigDec, BigDecimal.valueOf(radix).pow(decPartLen), scale, roundingMode);
					}
					if (bigDec.scale() == 0) {
						bigDec = bigDec.setScale(1);
					}
				}
			}
		}
		
		if (negative) {
			bigDec = bigDec.negate();
		}
		
		return bigDec;
	}
	
	private static BigDecimal divide(BigDecimal dividend, BigDecimal divisor, int scale, RoundingMode roundingMode) {
		try {
			return dividend.divide(divisor, MathContext.UNLIMITED);
		} catch (ArithmeticException e) {
			return dividend.divide(divisor, scale, roundingMode);
		}
	}
	
	public static BigDecimal parseEnNumShortScale(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		try {
			return EnglishNumberUtils.parseEnNum(val);
		} catch (IllegalArgumentException | ArithmeticException e) {
			return null;
		}
	}
	
	public static BigDecimal parseJPNum(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		try {
			return JapaneseNumberUtils.parseJPNum(val);
		} catch (IllegalArgumentException | ArithmeticException e) {
			return null;
		}
	}
	
	public static BigInteger[] parseFraction(String val, int radix) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		Matcher m = FRACTION_PATTERN.matcher(val);
		if (!m.matches()) {
			return null;
		}
		
		BigDecimal dn = parseN(m.group(1), radix);
		BigDecimal dd = parseN(m.group(2), radix);
		if (dn == null || dd == null) {
			return null;
		}
		if (dd.signum() == 0) {
			return null;
		}
		
		int maxScale = Math.max(dn.scale(), dd.scale());
		
		BigInteger n = dn.movePointRight(maxScale).toBigIntegerExact();
		BigInteger d = dd.movePointRight(maxScale).toBigIntegerExact();
		
		return new BigInteger[]{n, d};
	}
	
	public static BigInteger[] toFraction(BigDecimal bigDec, boolean truncatedDecimal) {
		if (bigDec == null) {
			return null;
		}
		
		int scale = bigDec.scale();
		if (scale <= 0) {
			// Has no decimal part
			// (Integer part only)
			return new BigInteger[] {bigDec.toBigInteger(), BigInteger.ONE};
		}
		
		BigInteger unscaledNum = bigDec.unscaledValue();
		String unscaledDigits = unscaledNum.abs().toString();
		boolean negative = (bigDec.signum() < 0);
		
		return toFraction(unscaledDigits, 10, negative, scale, truncatedDecimal);
	}
	
	private static BigInteger[] toFraction(String unscaledDigits, int radix, boolean negative, int scale, boolean truncatedDecimal) {
		if (unscaledDigits == null || unscaledDigits.isEmpty()) {
			return null;
		}
		
		if (scale <= 0) {
			// Has no decimal part
			// (Integer part only)
			try {
				return new BigInteger[] {
						new BigInteger(unscaledDigits + repeat('0', -scale), radix),
						BigInteger.ONE
						};
			} catch (NumberFormatException e) {
				return null;
			}
		}
		
		BigInteger n;
		BigInteger d;
		
		try {
			if (truncatedDecimal) {
				RepeatingInfo rep = analyzeRepeatingDecimal(unscaledDigits);
				
				if (1 <= rep.count()) {
					// Repeating decimal
					
					int zeros = scale - unscaledDigits.length() + rep.startIndex();
					
					// Repeating part
					String repetend = unscaledDigits.substring(rep.startIndex(), rep.startIndex() + rep.repetendLength());
					n = new BigInteger(repetend + repeat('0', -zeros), radix);
					d = new BigInteger(repeat(Character.forDigit(radix - 1, radix), rep.repetendLength()) + repeat('0', zeros), radix);
					
					if (1 <= rep.startIndex()) {
						// Non-repeating part
						String nonRepetend = unscaledDigits.substring(0, rep.startIndex());
						BigInteger n2 = new BigInteger(nonRepetend + repeat('0', -zeros), radix);
						BigInteger d2 = new BigInteger("1" + repeat('0', zeros), radix);
						
						// n/d + n2/d2
						n = n.multiply(d2).add(n2.multiply(d));
						d = d.multiply(d2);
					}
				} else {
					// Non-repeating decimal (Truncated rational number)
					n = new BigInteger(unscaledDigits, radix);
					d = BigInteger.valueOf(radix).pow(scale);
				}
			} else {
				// Terminating decimal
				n = new BigInteger(unscaledDigits, radix);
				d = BigInteger.valueOf(radix).pow(scale);
			}
		} catch (NumberFormatException e) {
			return null;
		}
		
		if (negative) {
			n = n.negate();
		}
		
		return new BigInteger[] {n, d};
	}
	
	public static BigInteger[] reduceFraction(BigInteger[] fraction) {
		if (fraction == null) {
			return null;
		}
		
		BigInteger n = fraction[0];
		BigInteger d = fraction[1];
		
		if (d.signum() == 0 || d.compareTo(BigInteger.ONE) == 0) {
			// d == 0 or 1
			return fraction;
		}
		
		BigInteger gcd = n.gcd(d);
		if (gcd.compareTo(BigInteger.ONE) == 0) {
			return fraction;
		}
		
		n = n.divide(gcd);
		d = d.divide(gcd);
		
		return new BigInteger[] {n, d};
	}

	protected static RepeatingInfo analyzeRepeatingDecimal(String digits) {
		return analyzeRepeatingDecimal(digits, 0, digits.length());
	}
	
	protected static RepeatingInfo analyzeRepeatingDecimal(String digits, int beginIdx, int endIdx) {
		if (digits.length() < endIdx) {
			endIdx = digits.length();
		}
		
		int lastDigitIdx = endIdx - 1;
		
		for (int startIdx = beginIdx; startIdx < endIdx; startIdx++) {
			char digit = digits.charAt(startIdx);
			
			int repeatIdx = startIdx;
			NEXT_MATCH: while ((repeatIdx = digits.indexOf(digit, repeatIdx + 1)) != -1) {
				int repetendLen = repeatIdx - startIdx;
				
				int repeatingCount = (endIdx - repeatIdx) / repetendLen;
				if (repeatingCount == 0) {
					break;
				}
				
				int oddRepetendLen = (endIdx - repeatIdx) % repetendLen;
				if (oddRepetendLen != 0) {
					repeatingCount++;
				}
				
				int roundingDiff = 0;
				for (int i = 0; i < repetendLen; i++) {
					// Compare each digits in the repetend
					
					char ch1 = digits.charAt(startIdx + i);
					
					for (int ri = repeatIdx + i; ri < endIdx; ri += repetendLen) {
						// Check all repetends
						char ch2 = digits.charAt(ri);
						if (ch1 != ch2) {
							if (ri == lastDigitIdx) {
								// The last digit may be rounded
								// So ignore it and return the difference
								roundingDiff = digitToNum(ch2) - digitToNum(ch1);
							} else {
								continue NEXT_MATCH;
							}
						}
					}
				}
				
				return new RepeatingInfo(repeatingCount, startIdx, repetendLen, oddRepetendLen, roundingDiff);
			}
		}
		
		// Non-repeating decimal
		return RepeatingInfo.NO_MATCHED;
	}
	
	private static BigDecimal increasePrecision(BigDecimal bigDec, int scale, RoundingMode roundingMode) {
		if (bigDec == null) {
			return null;
		}
		
		if (bigDec.scale() <= 0) {
			return bigDec;
		}
		
		BigInteger[] fraction = toFraction(bigDec, true);
		if (fraction == null) {
			return bigDec;
		}
		
		BigInteger n = fraction[0];
		BigInteger d = fraction[1];
		if (d.compareTo(BigInteger.ONE) == 0) {
			return bigDec;
		}
		
		return divide(new BigDecimal(n), new BigDecimal(d), scale, roundingMode);
	}
	
	public static String truncateRepeatingDecimal(String strNum, int maxRepetendCount) {
		if (strNum == null) {
			return null;
		}
		
		int endIdx = strNum.length();
		if (strNum.endsWith(TRUNCATED_DECIMAL_SUFFIX)) {
			endIdx -= TRUNCATED_DECIMAL_SUFFIX.length();
		}
		
		int decPointIdx = strNum.indexOf('.', 0, endIdx);
		if (decPointIdx == -1) {
			return strNum;
		}
		
		RepeatingInfo rep = analyzeRepeatingDecimal(strNum, decPointIdx + 1, endIdx);
		if (rep.count() < maxRepetendCount) {
			return strNum;
		}
		
		// Repeating decimal
		strNum = strNum.substring(0, rep.startIndex() + (rep.repetendLength() * maxRepetendCount));
		strNum = toTruncatedDecimal(strNum);
		
		return strNum;
	}
	
	public static boolean isTruncatedDecimal(String strNum) {
		if (strNum == null) {
			return false;
		}
		
		return strNum.endsWith(TRUNCATED_DECIMAL_SUFFIX);
	}
	
	public static String toTruncatedDecimal(String strNum) {
		if (strNum == null) {
			return null;
		}
		
		if (isTruncatedDecimal(strNum)) {
			return strNum;
		}
		
		if (strNum.indexOf('.') == -1) {
			return strNum;
		}
		
		return strNum + TRUNCATED_DECIMAL_SUFFIX;
	}
	
	private static String removeTruncatedDecimalSuffix(String strNum) {
		if (strNum.endsWith(TRUNCATED_DECIMAL_SUFFIX)) {
			// Remove "..." suffix
			return strNum.substring(0, strNum.length() - TRUNCATED_DECIMAL_SUFFIX.length());
		}
		
		return strNum;
	}
	
	private static int digitToNum(char ch) {
		int num = Character.digit(ch, Character.MAX_RADIX);
		if (num == -1) {
			num = 0;
		}
		return num;
	}
	
	private static String repeat(char ch, int len) {
		if (len <= 0) {
			return "";
		}
		
		return new StringBuilder(len).repeat(ch, len).toString();
	}
}
