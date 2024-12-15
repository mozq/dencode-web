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

import org.mifmi.commons4j.util.StringUtilz;

public class DencodeUtils {
	
	private static final Integer INT_ONE = Integer.valueOf(1);
	
	private static final Pattern DATA_SIZE_PATTERN = Pattern.compile("^([0-9]+)(b|B)$");
	
	private static final char[] N_ARY_DIGITS_UPPER = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
	private static final char[] N_ARY_DIGITS_LOWER = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
	
	
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
	
	protected static int getOptionAsInt(Map<String, String> options, String key, int defaultValue, int defaultEmptyValue) {
		String value = options.get(key);
		
		if (value == null) {
			return defaultValue;
		}
		
		if (value.isEmpty()) {
			return defaultEmptyValue;
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
		
		BigInteger radixBI = BigInteger.valueOf(radix);
		BigDecimal radixBD = BigDecimal.valueOf(radix);
		
		boolean negative = (bigDec.signum() < 0);
		if (negative) {
			bigDec = bigDec.abs();
		}
		
		StringBuilder sb = new StringBuilder();
		boolean upperCase = false;
		
		// Integer part
		BigInteger intPart;
		try {
			intPart = bigDec.toBigInteger();
		} catch (ArithmeticException e) {
			return null;
		}
		
		BigInteger ip = intPart;
		do {
			BigInteger[] dr = ip.divideAndRemainder(radixBI);
			ip = dr[0];
			int reminder = dr[1].intValue();
			sb.append(numToDigit(reminder, upperCase));
		} while (ip.signum() != 0);
		sb.reverse();
		
		// Sign
		if (negative) {
			sb.insert(0, '-');
		}
		
		if (bigDec.scale() <= 0) {
			// Integer
			return sb.toString();
		}
		
		// Decimal part
		sb.append('.');
		BigDecimal decPart = bigDec.subtract(new BigDecimal(intPart));
		
		if (decPart.signum() == 0) {
			sb.append('0');
		} else {
			BigDecimal dp = decPart;
			HashMap<BigDecimal, Integer> recurringCountMap = (0 < decimalMaxRecurringCount) ? new HashMap<BigDecimal, Integer>() : null;
			for (int i = 0; i < decimalMaxDigits; i++) {
				dp = dp.multiply(radixBD);
				
				if (recurringCountMap != null) {
					// Check recurring decimal
					
					Integer n = recurringCountMap.get(dp);
					if (n == null) {
						recurringCountMap.put(dp, INT_ONE);
					} else if (n.intValue() < decimalMaxRecurringCount) {
						recurringCountMap.put(dp, Integer.valueOf(n.intValue() + 1));
					} else {
						// Over the max recurring count
						break;
					}
				}
				
				BigInteger ipBI = dp.toBigInteger();
				int ipN = ipBI.intValue();
				sb.append(numToDigit(ipN, upperCase));
				
				dp = dp.subtract(BigDecimal.valueOf(ipN));
				if (dp.signum() == 0) {
					break;
				}
			}
			
			if (dp.signum() != 0) {
				sb.append("...");
			}
		}
		
		return sb.toString();
	}
	
	protected static char numToDigit(int n, boolean upperCase) {
		if (n < 0 || N_ARY_DIGITS_UPPER.length <= n) {
			throw new IllegalArgumentException("Unsupported number: " + n);
		}
		return (upperCase) ? N_ARY_DIGITS_UPPER[n] : N_ARY_DIGITS_LOWER[n];
	}
	
	protected static int hexDigitToNum(char ch) {
		if ('0' <= ch && ch <= '9') {
			return ch - '0';
		} else if ('A' <= ch && ch <= 'F') {
			return 10 + (ch - 'A');
		} else if ('a' <= ch && ch <= 'f') {
			return 10 + (ch - 'a');
		} else {
			throw new IllegalArgumentException("Unsupported digit: " + ch);
		}
	}
	
	protected static int digitToNum(char ch) {
		if ('0' <= ch && ch <= '9') {
			return ch - '0';
		} else if ('A' <= ch && ch <= 'Z') {
			return 10 + (ch - 'A');
		} else if ('a' <= ch && ch <= 'z') {
			return 10 + (ch - 'a');
		} else {
			throw new IllegalArgumentException("Unsupported digit: " + ch);
		}
	}
	
	protected static String binaryToHexString(byte[] bin, boolean upperCase) {
		int len = bin.length;
		
		StringBuilder sb = new StringBuilder(len * 2);
		for (byte b : bin) {
			int high = (b >>> 4) & 0x0F;
			int low = b & 0x0F;
			sb.append(numToDigit(high, upperCase));
			sb.append(numToDigit(low, upperCase));
		}
		
		return sb.toString();
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
		boolean upperCase = false;
		try {
			MessageDigest messageDigest = MessageDigest.getInstance(algo);
			byte[] digest = messageDigest.digest(binValue);
			return binaryToHexString(digest, upperCase);
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
	}
	
	protected static void appendCombinedVoicedSoundMark(StringBuilder sb) {
		if (sb.length() == 0) {
			sb.append('゛');
			return;
		}
		
		char ch = sb.charAt(sb.length() - 1);
		
		char newCh = switch (ch) {
		case 'か' -> 'が';
		case 'き' -> 'ぎ';
		case 'く' -> 'ぐ';
		case 'け' -> 'げ';
		case 'こ' -> 'ご';
		case 'さ' -> 'ざ';
		case 'し' -> 'じ';
		case 'す' -> 'ず';
		case 'せ' -> 'ぜ';
		case 'そ' -> 'ぞ';
		case 'た' -> 'だ';
		case 'ち' -> 'ぢ';
		case 'つ' -> 'づ';
		case 'て' -> 'で';
		case 'と' -> 'ど';
		case 'は' -> 'ば';
		case 'ひ' -> 'び';
		case 'ふ' -> 'ぶ';
		case 'へ' -> 'べ';
		case 'ほ' -> 'ぼ';
		case 'う' -> 'ゔ';
		case 'カ' -> 'ガ';
		case 'キ' -> 'ギ';
		case 'ク' -> 'グ';
		case 'ケ' -> 'ゲ';
		case 'コ' -> 'ゴ';
		case 'サ' -> 'ザ';
		case 'シ' -> 'ジ';
		case 'ス' -> 'ズ';
		case 'セ' -> 'ゼ';
		case 'ソ' -> 'ゾ';
		case 'タ' -> 'ダ';
		case 'チ' -> 'ヂ';
		case 'ツ' -> 'ヅ';
		case 'テ' -> 'デ';
		case 'ト' -> 'ド';
		case 'ハ' -> 'バ';
		case 'ヒ' -> 'ビ';
		case 'フ' -> 'ブ';
		case 'ヘ' -> 'ベ';
		case 'ホ' -> 'ボ';
		case 'ウ' -> 'ヴ';
		default -> ch;
		};
		
		if (newCh == ch) {
			sb.append('゛');
		} else {
			sb.setCharAt(sb.length() - 1, newCh);
		}
	}
	
	 protected static void appendCombinedSemiVoicedSoundMark(StringBuilder sb) {
		if (sb.length() == 0) {
			sb.append('゜');
			return;
		}
		
		char ch = sb.charAt(sb.length() - 1);
		
		char newCh = switch (ch) {
		case 'は' -> 'ぱ';
		case 'ひ' -> 'ぴ';
		case 'ふ' -> 'ぷ';
		case 'へ' -> 'ぺ';
		case 'ほ' -> 'ぽ';
		case 'ハ' -> 'パ';
		case 'ヒ' -> 'ピ';
		case 'フ' -> 'プ';
		case 'ヘ' -> 'ペ';
		case 'ホ' -> 'ポ';
		default -> ch;
		};
		
		if (newCh == ch) {
			sb.append('゜');
		} else {
			sb.setCharAt(sb.length() - 1, newCh);
		}
	}
}
