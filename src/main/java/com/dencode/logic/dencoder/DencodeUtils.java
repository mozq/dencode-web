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
import java.math.RoundingMode;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.binary.Hex;
import org.mifmi.commons4j.util.NumberUtilz;
import org.mifmi.commons4j.util.StringUtilz;

public class DencodeUtils {
	
	private static final BigDecimal TWO = BigDecimal.valueOf(2);
	
	private static final Pattern DATA_SIZE_PATTERN = Pattern.compile("^([0-9]+)(b|B)$");
	
	
	private DencodeUtils() {
		// NOP
	}
	
	
	protected static <T, R> List<R> dencodeEach(List<T> vals, Function<T, R> func) {
		if (vals == null) {
			return null;
		}
		
		List<R> dencVals = new ArrayList<R>(vals.size());
		for (T val : vals) {
			R dencVal;
			if (val == null) {
				dencVal = null;
			} else {
				dencVal = func.apply(val);
				if (dencVal == null) {
					return null;
				}
			}
			dencVals.add(dencVal);
		}
		return dencVals;
	}
	
	protected static <T> String dencodeLines(List<T> vals, Function<T, String> func) {
		return dencodeLines(vals, func, "\n");
	}
	
	protected static <T> String dencodeLines(List<T> vals, Function<T, String> func, String separator) {
		if (vals == null) {
			return null;
		}
		
		List<String> dencVals = dencodeEach(vals, func);
		if (dencVals == null) {
			return null;
		}
		
		return StringUtilz.join(separator, dencVals);
	}
	
	protected static String getOption(Map<String, String> options, String key, String defaultValue) {
		String value = options.get(key);
		
		if (value == null) {
			return defaultValue;
		}
		
		return value;
	}
	
	protected static int getOptionAsInt(Map<String, String> options, String key, int defaultValue) {
		String value = options.get(key);
		
		if (value == null) {
			return defaultValue;
		}
		
		try {
			return Integer.parseInt(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	
	protected static int parseDataSizeAsBit(String size) {
		if (size == null || size.isEmpty()) {
			return -1;
		}
		
		Matcher matcher = DATA_SIZE_PATTERN.matcher(size);
		if (matcher.matches()) {
			int n = Integer.parseInt(matcher.group(1));
			String unit = matcher.group(2);
			
			switch (unit) {
				case "b": return n;
				case "B": return n * 8;
			}
			
			return -1;
		}
		
		return -1;
	}
	
	protected static int parseDataSizeAsByte(String size) {
		int bit = parseDataSizeAsBit(size);
		return  (bit + 7) / 8; // Round UP
	}
	
	protected static void appendRoundString(StringBuilder sb, double d, int scale, RoundingMode roundingMode) {
		int i = (int) d;
		if (d == (double) i) {
			sb.append(i);
		} else {
			BigDecimal bd = BigDecimal.valueOf(d).setScale(scale, roundingMode);
			double d2 = bd.doubleValue();
			int i2 = (int) d2;
			if (d2 == (double) i2) {
				sb.append(i2);
			} else {
				sb.append(d2);
			}
		}
	}
	
	protected static String encNum(BigDecimal bigDec, int radix, int decimalMaxDigits, int decimalMaxRecurringCount) {
		if (bigDec == null) {
			return null;
		}
		
		BigInteger intPart = bigDec.toBigInteger();
		String intPartStr = intPart.toString(radix);
		int decPartLen = NumberUtilz.digitLengthDecimalPart(bigDec);
		
		if (decPartLen == 0) {
			// Integer
			return intPartStr;
		} else {
			// Decimal
			BigDecimal decPart = NumberUtilz.getDecimalPart(bigDec);
			
			if (decPart.signum() == 0) {
				return intPartStr + ".0";
			}
			
			int bitsPer;
			switch (radix) {
			case 2: bitsPer = 1; break;
			case 8: bitsPer = 3; break;
			case 16: bitsPer = 4; break;
			default: throw new IllegalArgumentException("Unsupported radix. radix: " + radix);
			}
			
			int decimalMaxBits = decimalMaxDigits * bitsPer;

			StringBuilder sb = new StringBuilder(intPartStr.length() + decimalMaxDigits + 5); // 5 is length of "-", "." and "..."
			if (intPart.signum() == 0 && decPart.signum() < 0) {
				sb.append('-');
			}
			sb.append(intPartStr);
			sb.append('.');
			
			BigDecimal d = decPart.abs();
			HashMap<BigDecimal, Integer> recurringCountMap = (0 < decimalMaxRecurringCount) ? new HashMap<BigDecimal, Integer>(decimalMaxBits) : null;
			boolean recurringBreak = false;
			for (int i = 0, bits = 0, bitsIdx = 1; i < decimalMaxBits; i++, bits <<= 1, bitsIdx++) {
				d = d.multiply(TWO);
				
				if (recurringCountMap != null) {
					// Check recurring decimal
					
					Integer n = recurringCountMap.get(d);
					if (n == null) {
						recurringCountMap.put(d, Integer.valueOf(1));
					} else if (n.intValue() < decimalMaxRecurringCount) {
						recurringCountMap.put(d, Integer.valueOf(n.intValue() + 1));
					} else {
						// Over the max recurring count
						recurringBreak = true;
					}
				}
				
				if (d.compareTo(BigDecimal.ONE) >= 0) {
					bits |= 1;
					d = NumberUtilz.getDecimalPart(d);
					
					if (d.signum() == 0) {
						// Last digit
						
						// Output stacked bits
						bits <<= (bitsPer - bitsIdx);
						appendDigit(sb, bits);
						
						break;
					}
				}
				
				if (bitsIdx == bitsPer) {
					// Output bits
					appendDigit(sb, bits);
					
					bits = 0;
					bitsIdx = 0;
					
					if (recurringBreak) {
						break;
					}
				}
			}
			
			if (d.signum() != 0) {
				sb.append("...");
			}
			
			return sb.toString();
		}
	}
	
	private static void appendDigit(StringBuilder sb, int n) {
		switch (n) {
		case 0: sb.append('0'); break;
		case 1: sb.append('1'); break;
		case 2: sb.append('2'); break;
		case 3: sb.append('3'); break;
		case 4: sb.append('4'); break;
		case 5: sb.append('5'); break;
		case 6: sb.append('6'); break;
		case 7: sb.append('7'); break;
		case 8: sb.append('8'); break;
		case 9: sb.append('9'); break;
		case 10: sb.append('a'); break;
		case 11: sb.append('b'); break;
		case 12: sb.append('c'); break;
		case 13: sb.append('d'); break;
		case 14: sb.append('e'); break;
		case 15: sb.append('f'); break;
		default: assert false : "n=" + n;
		}
	}
	
	protected static String encDate(ZonedDateTime dateVal, DateTimeFormatter formatter, DateTimeFormatter formatterWithMsec) {
		if (dateVal == null) {
			return null;
		}
		
		if (dateVal.getNano() == 0) {
			return formatter.format(dateVal);
		} else {
			return formatterWithMsec.format(dateVal);
		}
	}
	
	protected static String encHash(byte[] binValue, String algo) {
		try {
			MessageDigest messageDigest = MessageDigest.getInstance(algo);
			byte[] digest = messageDigest.digest(binValue);
			return Hex.encodeHexString(digest);
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
	}
}
