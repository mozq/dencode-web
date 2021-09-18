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

import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.ascii85")
public class StringAscii85Dencoder {
	private static int BASE_N = 85;
	private static int BASE_N_P2 = BASE_N * BASE_N;
	private static int BASE_N_P3 = BASE_N_P2 * BASE_N;
	private static int BASE_N_P4 = BASE_N_P3 * BASE_N;
	
	private static final char[] ENCODE_TABLE = {
			'!', '\"', '#', '$', '%', '&', '\'', '(', ')', '*',
			'+', ',', '-', '.', '/', '0', '1', '2', '3', '4',
			'5', '6', '7', '8', '9', ':', ';', '<', '=', '>',
			'?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
			'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
			'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\\',
			']', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f',
			'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
			'q', 'r', 's', 't', 'u'
			};
	private static final char[] ENCODE_TABLE_Z85 = {
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
			'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
			'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D',
			'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
			'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
			'Y', 'Z', '.', '-', ':', '+', '=', '^', '!', '/',
			'*', '?', '&', '<', '>', '(', ')', '[', ']', '{',
			'}', '@', '%', '$', '#'
			};
	
	private static final int[] DECODE_TABLE = new int['u' + 1];
	private static final int[] DECODE_TABLE_Z85 = new int['}' + 1];
	static {
		Arrays.fill(DECODE_TABLE, -1);
		Arrays.fill(DECODE_TABLE_Z85, -1);
		for (int i = 0; i < BASE_N; i++) {
			DECODE_TABLE[(int)ENCODE_TABLE[i]] = i;
			DECODE_TABLE_Z85[(int)ENCODE_TABLE_Z85[i]] = i;
		}
	}
	
	private static final int RAW_CHUNK_SIZE = 4;
	private static final int ENCODED_CHUNK_SIZE = 5;
	
	private static final Pattern BTOA_TRAILER_SIZE_PATTERN = Pattern.compile("xbtoa End N ([0-9]+)");
	
	private StringAscii85Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrAscii85(DencodeCondition cond) {
		String variant = cond.options().getOrDefault("encStrAscii85Variant", "adobe");
		switch (variant) {
		case "btoa":
			return encodeAscii85(
					cond.valueAsBinary(),
					ENCODE_TABLE,
					true,
					true,
					true,
					cond.lineBreak(),
					78,
					false,
					"xbtoa Begin" + cond.lineBreak(),
					buildBTOASuffix(cond.valueAsBinary(), cond.lineBreak())
					);
		case "adobe":
			return encodeAscii85(
					cond.valueAsBinary(),
					ENCODE_TABLE,
					true,
					false,
					false,
					cond.lineBreak(),
					80,
					true,
					"<~",
					"~>"
					);
		case "z85": // FALLTHRU
		default:
			return encodeAscii85(
					cond.valueAsBinary(),
					ENCODE_TABLE_Z85,
					false,
					false,
					false,
					null,
					-1,
					false,
					null,
					null
					);
		}
	}
	
	@DencoderFunction
	public static String decStrAscii85(DencodeCondition cond) {
		String val = cond.value();
		
		if (val.contains("xbtoa")) {
			// btoa
			int size = -1;
			Matcher sizeMatcher = BTOA_TRAILER_SIZE_PATTERN.matcher(val);
			if (sizeMatcher.find()) {
				size = Integer.parseInt(sizeMatcher.group(1));
			}
			val = val.replaceAll("(?:^xbtoa.*? Begin\\r?\\n)|(?:\\r?\\nxbtoa End.*$)|\\s|\\r|\\n", "");
			return toString(decodeAscii85(val, DECODE_TABLE, ENCODE_TABLE, true, true, true, size), cond.charset());
		} else if (val.contains("<~")) {
			// Adobe
			val = val.replaceAll("(?:^<~)|(?:~>$)|\\s|\\r|\\n", "");
			return toString(decodeAscii85(val, DECODE_TABLE, ENCODE_TABLE, true, false, false, -1), cond.charset());
		} else {
			// Z85
			return toString(decodeAscii85(cond.value(), DECODE_TABLE_Z85, ENCODE_TABLE_Z85, false, false, false, -1), cond.charset());
		}
	}
	
	private static String encodeAscii85(byte[] binValue, char[] encodeTable, boolean compressZeros, boolean compressSpaces, boolean pad, String lineBreak, int lineBreakPer, boolean lineBreakWithPrefix, String prefix, String suffix) {
		int len = binValue.length;
		int cf = len / RAW_CHUNK_SIZE;
		int bufLen = (cf + 1) * ENCODED_CHUNK_SIZE;
		
		int additionalLen = 0;
		boolean enableLineBreak = lineBreak != null && 0 < lineBreakPer;
		if (enableLineBreak) {
			additionalLen += lineBreak.length() * (bufLen / lineBreakPer);
		}
		if (prefix != null) {
			additionalLen += prefix.length();
		}
		if (suffix != null) {
			additionalLen += suffix.length();
		}
		
		int dl = 0;
		StringBuilder sb = new StringBuilder(bufLen + additionalLen);
		if (prefix != null) {
			sb.append(prefix);
			if (lineBreakWithPrefix) {
				dl += prefix.length();
			}
		}
		
		for (int i = 0; i < len; ) {
			long n = 0L;
			int cnt = 1;
			for (int j = 0; j < RAW_CHUNK_SIZE; j++) {
				n = n << 8;
				if (i < len) {
					n |= binValue[i++] & 0xFFL;
					cnt++;
				}
			}
			
			if (pad) {
				cnt = ENCODED_CHUNK_SIZE;
			}
			
			if (compressZeros && n == 0x00000000L && cnt == ENCODED_CHUNK_SIZE) {
				if (enableLineBreak && dl != 0 && dl % lineBreakPer == 0) {
					sb.append(lineBreak);
				}
				sb.append('z');
				dl++;
			} else if (compressSpaces && n == 0x20202020L) {
				if (enableLineBreak && dl != 0 && dl % lineBreakPer == 0) {
					sb.append(lineBreak);
				}
				sb.append('y');
				dl++;
			} else {
				long nn = n;
				if (1 <= cnt) {
					if (enableLineBreak && dl != 0 && dl % lineBreakPer == 0) {
						sb.append(lineBreak);
					}
					int n1 = (int)(nn / BASE_N_P4);
					sb.append(encodeTable[n1]);
					dl++;
				}
				if (2 <= cnt) {
					if (enableLineBreak && dl != 0 && dl % lineBreakPer == 0) {
						sb.append(lineBreak);
					}
					nn %= BASE_N_P4;
					int n2 = (int)(nn / BASE_N_P3);
					sb.append(encodeTable[n2]);
					dl++;
				}
				if (3 <= cnt) {
					if (enableLineBreak && dl != 0 && dl % lineBreakPer == 0) {
						sb.append(lineBreak);
					}
					nn %= BASE_N_P3;
					int n3 = (int)(nn / BASE_N_P2);
					sb.append(encodeTable[n3]);
					dl++;
				}
				if (4 <= cnt) {
					if (enableLineBreak && dl != 0 && dl % lineBreakPer == 0) {
						sb.append(lineBreak);
					}
					nn %= BASE_N_P2;
					int n4 = (int)(nn / BASE_N);
					sb.append(encodeTable[n4]);
					dl++;
				}
				if (5 <= cnt) {
					if (enableLineBreak && dl != 0 && dl % lineBreakPer == 0) {
						sb.append(lineBreak);
					}
					nn %= BASE_N;
					int n5 = (int)nn;
					sb.append(encodeTable[n5]);
					dl++;
				}
			}
		}
		
		if (suffix != null) {
			sb.append(suffix);
		}
		
		return sb.toString();
	}
	
	private static byte[] decodeAscii85(String val, int[] decodeTable, char[] encodeTable, boolean compressZeros, boolean compressSpaces, boolean padded, int size) {
		int len = val.length();
		int cz = 0;
		if (compressZeros || compressSpaces) {
			cz = (int)val.chars().filter(ch -> ch == 'z' || ch == 'y').count();
		}
		int cf = ((len - cz) / ENCODED_CHUNK_SIZE) + cz;
		int cp = (len - cz) % ENCODED_CHUNK_SIZE;
		
		if (cp == 1) {
			// Illegal chunk size
			return null;
		}
		
		int bufLen = (0 <= size) ? size :
				(cf * RAW_CHUNK_SIZE) + ((cp == 0) ? 0 : cp - (ENCODED_CHUNK_SIZE - RAW_CHUNK_SIZE));
		
		byte[] buf = new byte[bufLen];
		int bufIdx = 0;
		
		for (int i = 0; i < len; ) {
			long n = 0;
			int cnt = -(ENCODED_CHUNK_SIZE - RAW_CHUNK_SIZE);
			boolean lastChunk = (len <= i + ENCODED_CHUNK_SIZE + 1);
			for (int j = 0; j < ENCODED_CHUNK_SIZE; j++) {
				boolean hasBits = (i < len);
				
				char ch = (hasBits) ? val.charAt(i++) : encodeTable[encodeTable.length - 1];
				
				if (decodeTable.length <= ch) {
					if (j != 0) {
						// Unsupported value
						return null;
					}
					
					if (compressZeros && ch == 'z') {
						n = 0x00000000L;
						cnt = RAW_CHUNK_SIZE;
						break;
					} else if (compressSpaces && ch == 'y') {
						n = 0x20202020L;
						cnt = RAW_CHUNK_SIZE;
						break;
					} else {
						// Unsupported value
						return null;
					}
				}
				
				int nx = decodeTable[ch];
				if (nx < 0) {
					// Unsupported value
					return null;
				}
				
				n = (n * BASE_N) + nx;
				if (hasBits) {
					cnt++;
				}
			}

			byte b1 = (byte)((n >> 24) & 0xFFL);
			byte b2 = (byte)((n >> 16) & 0xFFL);
			byte b3 = (byte)((n >> 8) & 0xFFL);
			byte b4 = (byte)(n & 0xFFL);
			
			if (lastChunk && padded && size < 0) {
				// trim last zeros
				if (b4 == 0) {
					if (b3 == 0) {
						if (b2 == 0) {
							cnt--;
						}
						cnt--;
					}
					cnt--;
				}
			}
			
			if ((1 <= cnt) && (bufIdx < bufLen)) {
				buf[bufIdx++] = b1;
			}
			if ((2 <= cnt) && (bufIdx < bufLen)) {
				buf[bufIdx++] = b2;
			}
			if ((3 <= cnt) && (bufIdx < bufLen)) {
				buf[bufIdx++] = b3;
			}
			if ((4 <= cnt) && (bufIdx < bufLen)) {
				buf[bufIdx++] = b4;
			}
		}
		
		if (bufLen != bufIdx) {
			byte[] buf2 = new byte[bufIdx];
			System.arraycopy(buf, 0, buf2, 0, bufIdx);
			buf = buf2;
		}
		
		return buf;
	}
	private static String buildBTOASuffix(byte[] x, String lineBreak) {
		int eor = 0;
		int sum = 0;
		int rot = 0;
		
		for (int i = 0; i < x.length; i++) {
			int c = 0xFF & x[i];
			
			eor ^= c;
			sum += c;
			sum++;
			if ((rot & 0x80000000) != 0) {
				rot <<= 1;
				rot++;
			} else {
				rot <<= 1;
			}
			rot += c;
		}
		
		return String.format("%sxbtoa End N %d %x E %x S %x R %x%s", lineBreak, x.length, x.length, eor, sum, rot, lineBreak);
	}
	
	private static String toString(byte[] val, Charset charset) {
		if (val == null) {
			return null;
		}
		
		return new String(val, charset);
	}
}
