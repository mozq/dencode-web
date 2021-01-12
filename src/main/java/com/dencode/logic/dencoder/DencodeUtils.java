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
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.binary.Hex;
import org.mifmi.commons4j.util.NumberUtilz;
import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.parser.NumberParser;

public class DencodeUtils {
	
	private static final Pattern DATA_SIZE_PATTERN = Pattern.compile("^([0-9]+)(b|B)$");
	
	
	private DencodeUtils() {
		// NOP
	}
	
	
	protected static String[] dencodeEach(String[] vals, Function<String, String> func) {
		String[] dencVals = new String[vals.length];
		for (int i = 0; i < vals.length; i++) {
			String dencVal = func.apply(vals[i]);
			if (dencVal == null) {
				return null;
			}
			dencVals[i] = dencVal;
		}
		return dencVals;
	}
	
	protected static String dencodeEach(String[] vals, Function<String, String> func, String separator) {
		String[] dencVals = dencodeEach(vals, func);
		if (dencVals == null) {
			return null;
		}
		return StringUtilz.join(separator, (Object[])dencVals);
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
	
	protected static String encNum(String val, int radix) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		try {
			String[] vals = val.split(" ", -1);
			for (int i = 0; i < vals.length; i++) {
				if (vals[i].isEmpty()) {
					continue;
				}
				BigDecimal bigDec = NumberParser.parseNumDec(vals[i]);
				if (bigDec == null) {
					return null;
				}
				
				if (NumberUtilz.digitLengthDecimalPart(bigDec) != 0) {
					// Decimal
					return null;
				}
				
				vals[i] = bigDec.toBigInteger().toString(radix);
			}
			return StringUtilz.join(" ", (Object[])vals);
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	protected static String decNum(String val, int radix) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		try {
			String[] vals = val.split(" ", -1);
			for (int i = 0; i < vals.length; i++) {
				if (vals[i].isEmpty()) {
					continue;
				}
				BigInteger bigInt = new BigInteger(vals[i], radix);
				vals[i] = bigInt.toString(10);
			}
			return StringUtilz.join(" ", (Object[])vals);
		} catch (NumberFormatException e) {
			return null;
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
