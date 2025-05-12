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

public class JapaneseNumberUtils {
	
	private JapaneseNumberUtils() {
		// NOP
	}
	
	public static String toJPNum(BigDecimal num) {
		return toJPNum(num, false, false, false);
	}
	
	public static String toJPNum(BigDecimal num, boolean showOne, boolean useDaiji, boolean useObsoleteDaiji) {
		useObsoleteDaiji = useDaiji && useObsoleteDaiji;
		
		if (num == null) {
			return null;
		}
		
		StringBuilder sb = new StringBuilder();
		
		if (num.signum() < 0) {
			sb.append("−");
		}
		
		BigInteger numInt = num.toBigInteger();
		
		if (numInt.signum() == 0) {
			sb.append((useDaiji) ? "零" : "〇");
		} else {
			String strInt = numInt.abs().toString();
			
			int len = strInt.length();
				
			boolean hasD1Num = false;
			for (int i = 0; i < len; i++) {
				char c = strInt.charAt(i);
				int d2 = len - i - 1;
				int d1 = d2 % 4;
				
				if (c != '0') {
					switch (c) {
						case '1' -> {
							if (showOne || d1 == 0 || d2 == 0) {
								sb.append((useDaiji) ? ((useObsoleteDaiji) ? '壹' : '壱') : '一');
							}
						}
						case '2' -> sb.append((useDaiji) ? ((useObsoleteDaiji) ? '貳' : '弐') : '二');
						case '3' -> sb.append((useDaiji) ? ((useObsoleteDaiji) ? '參' : '参') : '三');
						case '4' -> sb.append((useDaiji) ? '肆' : '四');
						case '5' -> sb.append((useDaiji) ? '伍' : '五');
						case '6' -> sb.append((useDaiji) ? '陸' : '六');
						case '7' -> sb.append((useDaiji) ? ((useObsoleteDaiji) ? '柒' : '漆') : '七');
						case '8' -> sb.append((useDaiji) ? '捌' : '八');
						case '9' -> sb.append((useDaiji) ? '玖' : '九');
						default -> { assert false; }
					}
					
					switch (d1) {
						case 0 -> {}
						case 1 -> sb.append((useDaiji) ? '拾' : '十');
						case 2 -> sb.append((useDaiji) ? '陌' : '百');
						case 3 -> sb.append((useDaiji) ? '阡' : '千');
						default -> { assert false; }
					}
					
					hasD1Num = true;
				}
				if (d1 == 0 && hasD1Num) {
					switch (d2) {
						case 0 -> {}
						case 4 -> sb.append((useDaiji) ? '萬' : '万');
						case 8 -> sb.append('億');
						case 12 -> sb.append('兆');
						case 16 -> sb.append('京');
						case 20 -> sb.append('垓');
						case 24 -> sb.append("秭");
						case 28 -> sb.append('穣');
						case 32 -> sb.append('溝');
						case 36 -> sb.append('澗');
						case 40 -> sb.append('正');
						case 44 -> sb.append('載');
						case 48 -> sb.append('極');
						case 52 -> sb.append("恒河沙");
						case 56 -> sb.append("阿僧祇");
						case 60 -> sb.append("那由他");
						case 64 -> sb.append("不可思議");
						case 68 -> sb.append("無量大数");
						default -> throw new IllegalArgumentException("Too big number");
					}
				}
				
				if (d1 == 0) {
					hasD1Num = false;
				}
			}
		}
		
		int scale = num.scale();
		if (0 < scale) {
			BigDecimal numDec = num.subtract(new BigDecimal(numInt));
			String strDec = numDec.abs().toString();
			int len = strDec.length();
			
			sb.append("・");
			for (int i = "0.".length(); i < len; i++) {
				char c = strDec.charAt(i);
				
				switch (c) {
					case '0' -> sb.append((useDaiji) ? "零" : "〇");
					case '1' -> sb.append((useDaiji) ? ((useObsoleteDaiji) ? '壹' : '壱') : '一');
					case '2' -> sb.append((useDaiji) ? ((useObsoleteDaiji) ? '貳' : '弐') : '二');
					case '3' -> sb.append((useDaiji) ? ((useObsoleteDaiji) ? '參' : '参') : '三');
					case '4' -> sb.append((useDaiji) ? '肆' : '四');
					case '5' -> sb.append((useDaiji) ? '伍' : '五');
					case '6' -> sb.append((useDaiji) ? '陸' : '六');
					case '7' -> sb.append((useDaiji) ? ((useObsoleteDaiji) ? '柒' : '漆') : '七');
					case '8' -> sb.append((useDaiji) ? '捌' : '八');
					case '9' -> sb.append((useDaiji) ? '玖' : '九');
					default -> throw new IllegalArgumentException("Unsupported character: " + c);
				}
			}
		}
		
		return sb.toString();
	}
	
	public static BigDecimal parseJPNum(String jpNum) {
		if (jpNum == null) {
			return null;
		}
		
		if (jpNum.isEmpty()) {
			throw new IllegalArgumentException("Invalid value: " + jpNum);
		}
		
		int len = jpNum.length();
		
		boolean negative = false;
		int startIdx = 0;
		if (jpNum.startsWith("−")) {
			negative = true;
			startIdx = 1;
			
			if (len == 1) {
				throw new IllegalArgumentException("Invalid format: " + jpNum);
			}
		}
		
		BigDecimal num = BigDecimal.ZERO;
		BigDecimal n = BigDecimal.ZERO;
		BigDecimal n1 = null;
		int d1 = -1;
		int d2 = -1;
		int prevD1 = -1;
		int prevD2 = -1;
		boolean decimalPart = false;
		for (int i = startIdx; i < len; i++) {
			char c = jpNum.charAt(i);
			switch (c) {
				case '0', '０', '〇', '零' -> n1 = addAsDigits(n1, 0L, decimalPart);
				case '1', '１', '一', '壱', '壹', '弌' -> n1 = addAsDigits(n1, 1L, decimalPart);
				case '2', '２', '二', '弐', '貳', '弍', '贰' -> n1 = addAsDigits(n1, 2L, decimalPart); // Chinese: '贰'
				case '3', '３', '三', '参', '參', '弎', '叁', '叄' -> n1 = addAsDigits(n1, 3L, decimalPart); // Chinese: '叁', '叄'
				case '4', '４', '四', '肆', '亖' -> n1 = addAsDigits(n1, 4L, decimalPart);
				case '5', '５', '五', '伍' -> n1 = addAsDigits(n1, 5L, decimalPart);
				case '6', '６', '六', '陸', '陆' -> n1 = addAsDigits(n1, 6L, decimalPart); // Chinese: '陆'
				case '7', '７', '七', '漆', '柒', '質' -> n1 = addAsDigits(n1, 7L, decimalPart);
				case '8', '８', '八', '捌' -> n1 = addAsDigits(n1, 8L, decimalPart);
				case '9', '９', '九', '玖' -> n1 = addAsDigits(n1, 9L, decimalPart);
				case '十', '拾', '什' -> d1 = 1;
				case '廿', '念' -> { // Chinese: '念'
					if (n1 != null) {
						throw new IllegalArgumentException("Invalid format around '" + c + "'");
					}
					n1 = BigDecimal.valueOf(2L);
					d1 = 1;
				}
				case '卅', '丗' -> {
					if (n1 != null) {
						throw new IllegalArgumentException("Invalid format around '" + c + "'");
					}
					n1 = BigDecimal.valueOf(3L);
					d1 = 1;
				}
				case '百', '佰', '陌' -> d1 = 2;
				case '千', '仟', '阡' -> d1 = 3;
				case '万', '萬' -> d2 = 4;
				case '億' -> d2 = 8;
				case '兆' -> d2 = 12;
				case '京' -> d2 = 16;
				case '垓' -> d2 = 20;
				case '杼', '秭' -> d2 = 24;
				case '穣' -> d2 = 28;
				case '溝' -> d2 = 32;
				case '澗' -> d2 = 36;
				case '正' -> d2 = 40;
				case '載' -> d2 = 44;
				case '極' -> d2 = 48;
				case '･', '.', '・', '．' -> decimalPart = true;
				default -> {
					if (jpNum.startsWith("恒河沙", i)) {
						d2 = 52;
						i += 2;
					} else if (jpNum.startsWith("阿僧祇", i)) {
						d2 = 56;
						i += 2;
					} else if (jpNum.startsWith("那由他", i) || jpNum.startsWith("那由多", i)) {
						d2 = 60;
						i += 2;
					} else if (jpNum.startsWith("不可思議", i)) {
						d2 = 64;
						i += 3;
					} else if (jpNum.startsWith("無量大数", i)) {
						d2 = 68;
						i += 3;
					} else {
						throw new IllegalArgumentException("Unsupported character: " + c);
					}
				}
			}
			
			boolean isLast = (i + 1 == len);
			
			if (isLast) {
				if (d2 == -1) {
					d2 = 0;
					
					if (d1 == -1) {
						d1 = 0;
					}
				}
			}

			if (prevD1 != -1 && prevD1 < d1) {
				throw new IllegalArgumentException("Invalid format: " + jpNum);
			}
			prevD1 = d1;

			if (prevD2 != -1 && prevD2 < d2) {
				throw new IllegalArgumentException("Invalid format: " + jpNum);
			}
			prevD2 = d2;
			
			
			if (d1 != -1) {
				if (n1 == null) {
					n1 = BigDecimal.ONE;
				}
				
				if (d1 == 0) {
					n = n.add(n1);
				} else {
					n = n.add(n1.scaleByPowerOfTen(d1));
				}
				
				n1 = null;
				d1 = -1;
				decimalPart = false;
			}
			
			if (d2 != -1) {
				if (d1 == -1 && n1 != null) {
					n = n.add(n1);
				}
				
				if (d2 == 0) {
					num = num.add(n);
				} else {
					num = num.add(n.scaleByPowerOfTen(d2));
				}
				
				n = BigDecimal.ZERO;
				n1 = null;
				d1 = -1;
				d2 = -1;
				prevD1 = -1;
				decimalPart = false;
			}
		}
		
		if (negative) {
			num = num.negate();
		}
		
		return num;
	}
	
	private static BigDecimal addAsDigits(BigDecimal baseNum, long num, boolean decimalPart) {
		BigDecimal n = BigDecimal.valueOf(num);
		int intLen = n.precision() - n.scale();
		
		if (baseNum == null) {
			return (decimalPart) ? n.scaleByPowerOfTen(-intLen) : n;
		}
		
		if (decimalPart) {
			int baseDecLen = Math.max(baseNum.scale(), 0);
			return baseNum.add(n.scaleByPowerOfTen(-baseDecLen - intLen));
		} else {
			return baseNum.scaleByPowerOfTen(intLen).add(n);
		}
	}
}
