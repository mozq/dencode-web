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
package com.dencode.logic.util;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EnglishNumberUtils {
	public static enum DecimalNotation {
		POINT,
		FRACTION,
	}
	
	public static enum System {
		CONWAY_WECHSLER,
		CW4EN,
	}
	
	public static enum Scale {
		SHORT_SCALE,
		LONG_SCALE,
	}
	
	private static final Pattern EN_NUM_DECIMAL_POINT_PATTERN = Pattern.compile("(.+)\\s+point\\s+(.+)");
	private static final Pattern EN_NUM_DECIMAL_AND_PATTERN = Pattern.compile("(.+)\\s+and\\s+([0-9]+)\\s*/\\s*([0-9]+)");
	private static final Pattern EN_NUM_MULTI_ILLI_PATTERN = Pattern.compile("(.+?)lli(on$|ard$)?");
	private static final Pattern EN_NUM_MULTI_ILLI_PART_PATTERN = Pattern.compile("(ni|mi|bi|tri|quadri|quinti|sexti|septi|octi|noni|un|duo|tre(?!centi)(?:s)?|quattuor|quin(?:qua)?|se(?:s(?!centi)|x)?|septe(?:n|m)?|octo|nove(?:n|m)?)?(deci|viginti|trigint(?:a|i)|quadragint(?:a|i)|quinquagint(?:a|i)|sexagint(?:a|i)|septuagint(?:a|i)|octogint(?:a|i)|nonagint(?:a|i))?(centi|ducenti|trecenti|quadringenti|quingenti|sescenti|septingenti|octingenti|nongenti)?");
	
	
	private EnglishNumberUtils() {
		// NOP
	}
	
	public static String toEnNum(BigDecimal num, DecimalNotation decimalNotation, System system) {
		if (num == null) {
			return null;
		}

		return toEnNum(num, decimalNotation, system, Scale.SHORT_SCALE, false);
	}
	
	public static String toEnNum(BigDecimal num, DecimalNotation decimalNotation, System system, Scale scale, boolean useIlliard) {
		if (num == null) {
			return null;
		}
		
		boolean longScale = (scale == Scale.LONG_SCALE);
		
		StringBuilder sb = new StringBuilder();
		
		boolean negative = (num.signum() < 0);
		if (negative) {
			sb.append("Negative ");
		}
		
		BigInteger numInt;
		try {
			numInt = num.toBigInteger();
		} catch (ArithmeticException e) {
			return null;
		}
		
		if (numInt.signum() == 0) {
			sb.append("Zero ");
		} else {
			String strInt = numInt.abs().toString();
			
			int len = strInt.length();
			boolean hasD1Num = false;
			for (int i = 0; i < len; i++) {
				char c = strInt.charAt(i);
				int d2 = len - i - 1;
				int d1 = d2 % 3;
				
				if (c != '0') {
					if (d1 == 1) {
						char cn = (i < len) ? strInt.charAt(i + 1) : '\0';
						switch (c) {
							case '1' -> {
								switch (cn) {
									case '0' -> sb.append("Ten ");
									case '1' -> sb.append("Eleven ");
									case '2' -> sb.append("Twelve ");
									case '3' -> sb.append("Thirteen ");
									case '4' -> sb.append("Fourteen ");
									case '5' -> sb.append("Fifteen ");
									case '6' -> sb.append("Sixteen ");
									case '7' -> sb.append("Seventeen ");
									case '8' -> sb.append("Eighteen ");
									case '9' -> sb.append("Nineteen ");
									default -> throw new IllegalArgumentException("Unsupported character: " + c);
								}
								
								i++;
								
								d2--;
								d1 = d2 % 3;
							}
							case '2' -> sb.append("Twenty").append((cn == '0') ? ' ' : '-');
							case '3' -> sb.append("Thirty").append((cn == '0') ? ' ' : '-');
							case '4' -> sb.append("Forty").append((cn == '0') ? ' ' : '-');
							case '5' -> sb.append("Fifty").append((cn == '0') ? ' ' : '-');
							case '6' -> sb.append("Sixty").append((cn == '0') ? ' ' : '-');
							case '7' -> sb.append("Seventy").append((cn == '0') ? ' ' : '-');
							case '8' -> sb.append("Eighty").append((cn == '0') ? ' ' : '-');
							case '9' -> sb.append("Ninety").append((cn == '0') ? ' ' : '-');
							default -> throw new IllegalArgumentException("Unsupported character: " + c);
						}
					} else { // d1 = 0 or 2
						switch (c) {
							case '1' -> sb.append("One ");
							case '2' -> sb.append("Two ");
							case '3' -> sb.append("Three ");
							case '4' -> sb.append("Four ");
							case '5' -> sb.append("Five ");
							case '6' -> sb.append("Six ");
							case '7' -> sb.append("Seven ");
							case '8' -> sb.append("Eight ");
							case '9' -> sb.append("Nine ");
							default -> throw new IllegalArgumentException("Unsupported character: " + c);
						}
					}

					if (d1 == 2) {
						sb.append("Hundred ");
					}
					
					hasD1Num = true;
				}
				
				if (hasD1Num) {
					if (d1 == 0) {
						
						if (d2 == 0) {
							// NOP
						} else if (d2 == 3) {
							sb.append("Thousand ");
							hasD1Num = false;
						} else {
							int n = (longScale) ? d2 / 6 : d2 / 3 - 1;
							boolean illiardDigit = (longScale && d2 % 6 == 3);
							
							if (illiardDigit && !useIlliard) {
								sb.append("Thousand ");
								
								hasD1Num = true;
							} else {
								appendIlli(sb, n, system, illiardDigit && useIlliard);
								sb.append(' ');
								
								hasD1Num = false;
							}
						}
					}
				}
			}
		}
		
		int decScale = num.scale();
		if (0 < decScale) {
			BigInteger numDec = num.subtract(new BigDecimal(numInt)).unscaledValue();
			String strDec = numDec.abs().toString();
			
			if (decimalNotation == DecimalNotation.FRACTION) {
				sb.append("and ").append(strDec).append("/1");
				appendRepeat(sb, "0", decScale);
			} else {
				sb.append("point ");
				appendRepeat(sb, "Zero ", decScale - strDec.length());
				for (int i = 0; i < strDec.length(); i++) {
					char c = strDec.charAt(i);
					
					switch (c) {
						case '0' -> sb.append("Zero ");
						case '1' -> sb.append("One ");
						case '2' -> sb.append("Two ");
						case '3' -> sb.append("Three ");
						case '4' -> sb.append("Four ");
						case '5' -> sb.append("Five ");
						case '6' -> sb.append("Six ");
						case '7' -> sb.append("Seven ");
						case '8' -> sb.append("Eight ");
						case '9' -> sb.append("Nine ");
						default -> throw new IllegalArgumentException("Unsupported character: " + c);
					}
				}
			}
		}
		
		if (0 < sb.length() && sb.charAt(sb.length() - 1) == ' ') {
			// Strip last whitespace
			sb.setLength(sb.length() - 1);
		}
		
		return sb.toString();
	}
	
	private static void appendIlli(StringBuilder sb, int n, System system, boolean illiard) {
		assert (0 < n);
		
		int startIdx = sb.length();
		
		if (n <= 999) {
			appendIlliPart(sb, n, system);
		} else {
			// 1000 <= n
			StringBuilder subSB = new StringBuilder();
			int num = n;
			do {
				int numUnder999 = num % 1000;
				subSB.setLength(0);
				appendIlliPart(subSB, numUnder999, system);
				
				sb.insert(startIdx, subSB);
				
				num = num / 1000;
			} while (num != 0);
		}
		
		// Capitalize
		sb.setCharAt(startIdx, Character.toUpperCase(sb.charAt(startIdx)));
		
		sb.append((illiard) ? "ard" : "on");
	}
	
	private static void appendIlliPart(StringBuilder sb, int n, System system) {
		assert (0 <= n && n < 1000);
		
		int n1 = n % 10;
		
		if (n < 10) {
			switch (n1) {
				case 0 -> sb.append("n"); // for over n=1000 only
				case 1 -> sb.append("m");
				case 2 -> sb.append("b");
				case 3 -> sb.append("tr");
				case 4 -> sb.append("quadr");
				case 5 -> sb.append("quint");
				case 6 -> sb.append("sext");
				case 7 -> sb.append("sept");
				case 8 -> sb.append("oct");
				case 9 -> sb.append("non");
				default -> { assert false; }
			}
		} else {
			int n2 = (n / 10) % 10;
			int n3 = (n / 100);
			
			if (system == System.CONWAY_WECHSLER) {
				// Conway-Wechsler system
				
				switch (n1) {
					case 0 -> {}
					case 1 -> sb.append("un");
					case 2 -> sb.append("duo");
					case 3 -> {
						sb.append("tre");
						if (n2 == 0) {
							if (3 <= n3 && n3 <= 5) {
								sb.append('s');
							} else if (n3 == 1 || n3 == 8) {
								// x -> s
								sb.append('s');
							}
						} else {
							if (2 <= n2 && n2 <= 5) {
								sb.append('s');
							} else if (n2 == 8) {
								// x -> s
								sb.append('s');
							}
						}
					}
					case 4 -> sb.append("quattuor");
					case 5 -> sb.append("quin"); // The original Conway-Wechsler system specifies "quinqua" for 5, not "quin".
					case 6 -> {
						sb.append("se");
						if (n2 == 0) {
							if (3 <= n3 && n3 <= 5) {
								sb.append('s');
							} else if (n3 == 1 || n3 == 8) {
								sb.append('x');
							}
						} else {
							if (2 <= n2 && n2 <= 5) {
								sb.append('s');
							} else if (n2 == 8) {
								sb.append('x');
							}
						}
					}
					case 7 -> {
						sb.append("septe");
						if (n2 == 0) {
							if (1 <= n3 && n3 <= 7) {
								sb.append('n');
							} else if (n3 == 8) {
								sb.append('m');
							}
						} else {
							if (n2 == 1 || (3 <= n2 && n2 <= 7)) {
								sb.append('n');
							} else if (n2 == 2 || n2 == 8) {
								sb.append('m');
							}
						}
					}
					case 8 -> sb.append("octo");
					case 9 -> {
						sb.append("nove");
						if (n2 == 0) {
							if (1 <= n3 && n3 <= 7) {
								sb.append('n');
							} else if (n3 == 8) {
								sb.append('m');
							}
						} else {
							if (n2 == 1 || (3 <= n2 && n2 <= 7)) {
								sb.append('n');
							} else if (n2 == 2 || n2 == 8) {
								sb.append('m');
							}
						}
					}
					default -> { assert false; }
				}
			} else {
				// Default system; CW4EN system (Conway-Wechsler for English system)
				
				switch (n1) {
					case 0 -> {}
					case 1 -> sb.append("un");
					case 2 -> sb.append("duo");
					case 3 -> {
						sb.append("tre");
						if (n2 == 0) {
							if (n3 == 1) {
								// n = 103 (Tre[s]centillion)
								sb.append('s');
							}
						}
					}
					case 4 -> sb.append("quattuor");
					case 5 -> sb.append("quin");
					case 6 -> sb.append("sex");
					case 7 -> sb.append("septen");
					case 8 -> sb.append("octo");
					case 9 -> sb.append("novem");
					default -> { assert false; }
				}
			}
			
			switch (n2) {
				case 0 -> {}
				case 1 -> sb.append((n3 == 0) ? "dec" : "deci");
				case 2 -> sb.append((n3 == 0) ? "vigint" : "viginti");
				case 3 -> sb.append((n3 == 0) ? "trigint" : "triginta");
				case 4 -> sb.append((n3 == 0) ? "quadragint" : "quadraginta");
				case 5 -> sb.append((n3 == 0) ? "quinquagint" : "quinquaginta");
				case 6 -> sb.append((n3 == 0) ? "sexagint" : "sexaginta");
				case 7 -> sb.append((n3 == 0) ? "septuagint" : "septuaginta");
				case 8 -> sb.append((n3 == 0) ? "octogint" : "octoginta");
				case 9 -> sb.append((n3 == 0) ? "nonagint" : "nonaginta");
				default -> { assert false; }
			}
			
			switch (n3) {
				case 0 -> {}
				case 1 -> sb.append("cent");
				case 2 -> sb.append("ducent");
				case 3 -> sb.append("trecent");
				case 4 -> sb.append("quadringent");
				case 5 -> sb.append("quingent");
				case 6 -> sb.append("sescent");
				case 7 -> sb.append("septingent");
				case 8 -> sb.append("octingent");
				case 9 -> sb.append("nongent");
				default -> { assert false; }
			}
		}
		
		sb.append("illi");
	}
	
	
	public static BigDecimal parseEnNum(String enNum) {
		return parseEnNum(enNum, Scale.SHORT_SCALE);
	}
	
	public static BigDecimal parseEnNum(String enNum, Scale scale) {
		if (enNum == null) {
			return null;
		}
		
		if (enNum.isEmpty()) {
			throw new IllegalArgumentException("Invalid value: " + enNum);
		}
		
		boolean longScale = (scale == Scale.LONG_SCALE);
		
		boolean negative = false;
		String uEnNum = enNum.toLowerCase().trim();
		if (uEnNum.startsWith("negative ")) {
			negative = true;
			uEnNum = uEnNum.substring("negative ".length());
		} else if (uEnNum.startsWith("minus ")) {
			negative = true;
			uEnNum = uEnNum.substring("minus ".length());
		} else if (uEnNum.startsWith("-")) {
			negative = true;
			uEnNum = uEnNum.substring("-".length());
		}
		
		uEnNum = uEnNum.trim();
		if (uEnNum.isEmpty()) {
			throw new IllegalArgumentException("Invalid format: " + enNum);
		}
		
		BigDecimal num = null;
		
		Matcher matcherDecPoint = EN_NUM_DECIMAL_POINT_PATTERN.matcher(uEnNum);
		if (matcherDecPoint.matches()) {
			// Decimal : xxx point xxx
			String iNumStr = matcherDecPoint.group(1);
			String dNumStr = matcherDecPoint.group(2);
			
			BigDecimal iNum = parseEnNumIntPart(iNumStr, longScale);
			BigDecimal dNum = parseEnNumDecPart(dNumStr, longScale);

			num = iNum.add(dNum);
		} else {
			// Decimal : xxx and xx/xxx
			Matcher matcherDecAnd = EN_NUM_DECIMAL_AND_PATTERN.matcher(uEnNum);
			if (matcherDecAnd.matches()) {
				String iNumStr = matcherDecAnd.group(1);
				String dnNumStr = matcherDecAnd.group(2);
				String ddNumStr = matcherDecAnd.group(3);
				
				BigDecimal iNum = parseEnNumIntPart(iNumStr, longScale);
				int dNumScale = ddNumStr.length() - 1;
				BigDecimal dNum = new BigDecimal(dnNumStr).divide(new BigDecimal(ddNumStr), dNumScale, RoundingMode.HALF_UP);

				num = iNum.add(dNum);
			} else {
				// Integer
				num = parseEnNumIntPart(uEnNum, longScale);
			}
		}
		
		if (num != null) {
			if (negative) {
				num = num.negate();
			}
		}
		
		return num;
	}
	
	private static BigDecimal parseEnNumIntPart(String uEnNum, boolean longScale) {
		return parseEnNumPart(uEnNum, false, longScale);
	}
	
	private static BigDecimal parseEnNumDecPart(String uEnNum, boolean longScale) {
		return parseEnNumPart(uEnNum, true, longScale);
	}
	
	private static BigDecimal parseEnNumPart(String uEnNum, boolean asDecimalPart, boolean longScale) {
		if (uEnNum == null) {
			return null;
		}
		
		uEnNum = uEnNum.replace(",", "");
		
		BigDecimal num = BigDecimal.ZERO;
		BigDecimal n = BigDecimal.ZERO;
		BigDecimal n2 = BigDecimal.ZERO;
		int d = -1;
		int zeros = 0;
		int prevZeros = 0;
		int zeroPrefixCount = 0;
		
		String[] tokens = uEnNum.split("\\s+|\\-|\\s+and\\s+");
		for (int i = 0; i < tokens.length; i++) {
			String token = tokens[i];
			
			if (token.isEmpty()) {
				continue;
			}
			
			prevZeros = zeros;
			zeros = 0;
			
			boolean parsed = false;
			char c0 = token.charAt(0);
			if ('0' <= c0 && c0 <= '9') {
				try {
					n = add(n, new BigDecimal(token), true);
					parsed = true;
				} catch (Exception e) {
					// NOP
				}
			}
			
			if (!parsed) {
				switch (token) {
					case "zero" -> {
						n = add(n, 0, (prevZeros < 1));
						if (n.signum() == 0) {
							zeroPrefixCount++;
						}
					}
					case "one" -> n = add(n, 1L, (prevZeros < 1));
					case "two" -> n = add(n, 2L, (prevZeros < 1));
					case "three" -> n = add(n, 3L, (prevZeros < 1));
					case "four" -> n = add(n, 4L, (prevZeros < 1));
					case "five" -> n = add(n, 5L, (prevZeros < 1));
					case "six" -> n = add(n, 6L, (prevZeros < 1));
					case "seven" -> n = add(n, 7L, (prevZeros < 1));
					case "eight" -> n = add(n, 8L, (prevZeros < 1));
					case "nine" -> n = add(n, 9L, (prevZeros < 1));
					case "ten" -> n = add(n, 10L, (prevZeros < 1));
					case "eleven" -> n = add(n, 11L, (prevZeros < 2));
					case "twelve" -> n = add(n, 12L, (prevZeros < 2));
					case "thirteen" -> n = add(n, 13L, (prevZeros < 2));
					case "fourteen" -> n = add(n, 14L, (prevZeros < 2));
					case "fifteen" -> n = add(n, 15L, (prevZeros < 2));
					case "sixteen" -> n = add(n, 16L, (prevZeros < 2));
					case "seventeen" -> n = add(n, 17L, (prevZeros < 2));
					case "eighteen" -> n = add(n, 18L, (prevZeros < 2));
					case "nineteen" -> n = add(n, 19L, (prevZeros < 2));
					case "twenty" -> { n = add(n, 20L, (prevZeros < 2)); zeros = 1; }
					case "thirty" -> { n = add(n, 30L, (prevZeros < 2)); zeros = 1; }
					case "forty" -> { n = add(n, 40L, (prevZeros < 2)); zeros = 1; }
					case "fifty" -> { n = add(n, 50L, (prevZeros < 2)); zeros = 1; }
					case "sixty" -> { n = add(n, 60L, (prevZeros < 2)); zeros = 1; }
					case "seventy" -> { n = add(n, 70L, (prevZeros < 2)); zeros = 1; }
					case "eighty" -> { n = add(n, 80L, (prevZeros < 2)); zeros = 1; }
					case "ninety" -> { n = add(n, 90L, (prevZeros < 2)); zeros = 1; }
					case "hundred" -> { n = n.scaleByPowerOfTen(2); zeros = 2; }
					case "thousand" -> { n2 = n.scaleByPowerOfTen(3); n = BigDecimal.ZERO; }
					default -> {
						d = illionToDigit(token, longScale);
						if (d < 0) {
							d = illiardToDigit(token, longScale);
							if (d < 0) {
								throw new IllegalArgumentException("Unsupported word: " + token);
							}
						}
						
						num = num.add(n2.add(n).scaleByPowerOfTen(d));
						
						n = BigDecimal.ZERO;
						n2 = BigDecimal.ZERO;
						d = -1;
					}
				}
			}
		}
		num = num.add(n2).add(n);
		
		if (asDecimalPart) {
			int scale = ((0 < zeroPrefixCount && num.signum() == 0) ? zeroPrefixCount : zeroPrefixCount + num.precision() - num.scale());
			num = num.scaleByPowerOfTen(-scale);
		}
		
		return num;
	}
	
	private static int illionToDigit(String illion, boolean longScale) {
		int n = illiToN(illion, false);
		if (n < 0) {
			return -1;
		}
		
		if (longScale) {
			return 6 * n;
		} else {
			return 3 * n + 3;
		}
	}
	
	private static int illiardToDigit(String illiard, boolean longScale) {
		if (longScale) {
			int n = illiToN(illiard, true);
			if (n < 0) {
				return -1;
			}
			
			return 6 * n + 3;
		} else {
			// Unsupported
			return -1;
		}
	}
	
	private static int illiToN(String illi, boolean illiard) {
		Matcher m = EN_NUM_MULTI_ILLI_PATTERN.matcher(illi);
		if (!m.find()) {
			return -1;
		}
		
		int n = 0;
		String suffix = null;
		do {
			String d = m.group(1);
			suffix = m.group(2);
			
			n *= 1000;
			
			Matcher mp = EN_NUM_MULTI_ILLI_PART_PATTERN.matcher(d);
			if (!mp.matches()) {
				return -1;
			}
			
			String d1 = mp.group(1);
			String d2 = mp.group(2);
			String d3 = mp.group(3);
			
			if (d1 != null) {
				if (d2 == null && d3 == null) {
					// n < 10
					switch (d1) {
						case "ni" -> { if (n == 0) return -1; }
						case "mi" -> n += 1;
						case "bi" -> n += 2;
						case "tri" -> n += 3;
						case "quadri" -> n += 4;
						case "quinti" -> n += 5;
						case "sexti" -> n += 6;
						case "septi" -> n += 7;
						case "octi" -> n += 8;
						case "noni" -> n += 9;
						default -> { assert false : "Unsuppoorted -illion/-illiard: " + illi + " (" + d1 + ")"; }
					}
				} else {
					// 10 <= n
					switch (d1) {
						case "un" -> n += 1;
						case "duo" -> n += 2;
						case "tre", "tres" -> n += 3;
						case "quattuor" -> n += 4;
						case "quin", "quinqua" -> n += 5;
						case "se", "ses", "sex" -> n += 6;
						case "septe", "septen", "septem" -> n += 7;
						case "octo" -> n += 8;
						case "nove", "noven", "novem" -> n += 9;
						default -> { assert false : "Unsuppoorted -illion/-illiard: " + illi + " (" + d1 + ")"; }
					}
				}
			}
			
			if (d2 != null) {
				switch (d2) {
					case "deci" -> n += 10;
					case "viginti" -> n += 20;
					case "triginta", "triginti" -> n += 30;
					case "quadraginta", "quadraginti" -> n += 40;
					case "quinquaginta", "quinquaginti" -> n += 50;
					case "sexaginta", "sexaginti" -> n += 60;
					case "septuaginta", "septuaginti" -> n += 70;
					case "octoginta", "octoginti" -> n += 80;
					case "nonaginta", "nonaginti" -> n += 90;
					default -> { assert false : "Unsuppoorted -illion/-illiard: " + illi + " (" + d2 + ")"; }
				}
			}
			
			if (d3 != null) {
				switch (d3) {
					case "centi" -> n += 100;
					case "ducenti" -> n += 200;
					case "trecenti" -> n += 300;
					case "quadringenti" -> n += 400;
					case "quingenti" -> n += 500;
					case "sescenti" -> n += 600;
					case "septingenti" -> n += 700;
					case "octingenti" -> n += 800;
					case "nongenti" -> n += 900;
					default -> { assert false : "Unsuppoorted -illion/-illiard: " + illi + " (" + d3 + ")"; }
				}
			}
			
			if (suffix != null) {
				if (illiard && suffix.equals("on")) {
					return -1;
				} else if (!illiard && suffix.equals("ard")) {
					return -1;
				}
			}
		} while (m.find());
		
		if (suffix == null) {
			return -1;
		}
		
		return n;
	}
	
	private static BigDecimal add(BigDecimal baseNum, long num, boolean asDigit) {
		return add(baseNum, BigDecimal.valueOf(num), asDigit);
	}
	
	private static BigDecimal add(BigDecimal baseNum, BigDecimal num, boolean asDigit) {
		if (baseNum == null || baseNum.signum() == 0) {
			return num;
		}
		
		if (asDigit) {
			return addAsDigits(baseNum, num);
		} else {
			return baseNum.add(num);
		}
	}
	
	private static BigDecimal addAsDigits(BigDecimal baseNum, BigDecimal num) {
		if (baseNum == null || baseNum.signum() == 0) {
			return num;
		}
		
		int intLen = num.precision() - num.scale();
		if (1 <= baseNum.scale()) {
			// Decimal
			// e.g. 12.3 + 4.5 = 12.345
			int baseDecLen = Math.max(baseNum.scale(), 0);
			return baseNum.add(num.scaleByPowerOfTen(-baseDecLen - intLen));
		} else {
			// Integer
			// e.g. 123 + 4.5 = 1234.5
			return baseNum.scaleByPowerOfTen(intLen).add(num);
		}
	}
	
	private static void appendRepeat(StringBuilder sb, String str, int count) {
		for (int i = 0; i < count; i++) {
			sb.append(str);
		}
	}
}
