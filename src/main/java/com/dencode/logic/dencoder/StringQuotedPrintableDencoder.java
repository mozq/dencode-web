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

import java.io.ByteArrayOutputStream;
import java.nio.charset.Charset;
import java.nio.charset.IllegalCharsetNameException;
import java.nio.charset.UnsupportedCharsetException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.quoted-printable", hasEncoder=true, hasDecoder=true, useOe=true, useNl=true)
public class StringQuotedPrintableDencoder {
	
	private static final int MAX_LINE_LENGTH = 76;
	
	private static final Pattern RFC2047_SPACE = Pattern.compile("\\?=\\s+=\\?");
	private static final Pattern RFC2047_QP = Pattern.compile("=\\?(.+?)(?:\\*.+?)?\\?Q\\?(.+?)\\?=", Pattern.CASE_INSENSITIVE); // Also supports RFC 2231
	
	private StringQuotedPrintableDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrQuotedPrintable(DencodeCondition cond) {
		return encStrQuotedPrintable(cond.valueAsBinary());
	}
	
	@DencoderFunction
	public static String decStrQuotedPrintable(DencodeCondition cond) {
		return decStrQuotedPrintable(cond.value(), cond.charset());
	}
	
	
	private static String encStrQuotedPrintable(byte[] binValue) {
		int len = binValue.length;
		
		int lineLen = 0;
		StringBuilder sb = new StringBuilder(len * 3);
		for (int i = 0; i < len; i++) {
			byte b = binValue[i];
			
			boolean lastPrev1 = (i + 2 == len);
			boolean last = (i + 1 == len);
			boolean lastOfLine = last;
			if (!last) {
				byte b1 = binValue[i + 1];
				
				if (lastPrev1 && (b == (byte)'\r' && b1 == (byte)'\n')) {
					// CR + LF + EOF
					last = true;
				} else if (b1 == (byte)'\r' || b1 == (byte)'\n') {
					// ?? + CR or ?? + LF
					lastOfLine = true;
				}
			}
			
			// TODO: Ignore trailing white-spaces
			
			if (((byte)'!' <= b && b <= (byte)'~' && b != (byte)'=')
					|| (!lastOfLine && (b == (byte)' ' || b == (byte)'\t'))
					|| (!last && (b == (byte)'\r' || b == (byte)'\n'))) {
				// Printable (!..~) excludes =
				// SPACE or TAB, excludes last character of line
				// CR or LF, excludes last character
				// ** Passed through white-spaces (SPACE, TAB, CR, LF) other than the end of a line **
				
				lineLen += 1;
				if (MAX_LINE_LENGTH < lineLen || (!last && MAX_LINE_LENGTH == lineLen)) {
					// Soft line-break
					sb.append("=\r\n");
					lineLen = 1;
				}
				if (b == (byte)'\r' || b == (byte)'\n') {
					// Hard line-break
					lineLen = 0;
				}
				
				sb.append((char)b);
			} else {
				// Non-printable
				
				lineLen += 3;
				if (MAX_LINE_LENGTH < lineLen || (!last && MAX_LINE_LENGTH == lineLen)) {
					// Soft line-break
					sb.append("=\r\n");
					lineLen = 3;
				}
				
				int high = (b & 0xF0) >>> 4;
				int low = b & 0x0F;
				
				sb.append('=');
				sb.append(DencodeUtils.numToDigit(high, true));
				sb.append(DencodeUtils.numToDigit(low, true));
			}
		}
		
		return sb.toString();
	}
	
	private static String decStrQuotedPrintable(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		
		if (val.contains("=?") && val.contains("?=")) {
			// RFC 2047
			
			val = RFC2047_SPACE.matcher(val).replaceAll("?==?");
			
			StringBuilder sb = new StringBuilder(val.length());
			
			Matcher m = RFC2047_QP.matcher(val);
			if (!m.find()) {
				return null;
			}
			
			do {
				Charset cs;
				try {
					cs = Charset.forName(m.group(1));
				} catch (IllegalCharsetNameException | UnsupportedCharsetException e) {
					return null;
				}
				
				String v = m.group(2);
				v = v.replace('_', ' ');
				
				String decodedValue = decode(v, cs);
				if (decodedValue == null) {
					return null;
				}
				
				m.appendReplacement(sb, "");
				sb.append(decodedValue);
			} while (m.find());
			m.appendTail(sb);
			
			return sb.toString();
		} else {
			return decode(val, charset);
		}
	}
	
	private static String decode(String val, Charset charset) {
		int idx = val.indexOf('=');
		if (idx == -1) {
			return val;
		}
		
		int len = val.length();
		ByteArrayOutputStream binBuf = new ByteArrayOutputStream(len);
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (ch == '=') {
				int leftChNum = (len - i - 1);
				if (leftChNum == 0) {
					// Last
					continue;
				} else if (leftChNum == 1) {
					char ch1 = val.charAt(++i);
					if (ch1 == '\r' || ch1 == '\n') {
						continue;
					}
					
					return null;
				} else if (leftChNum >= 2) {
					try {
						char ch1 = val.charAt(++i);
						char ch2 = val.charAt(++i);
						
						// Soft line-break
						if (ch1 == '\r' && ch2 == '\n') {
							continue;
						} else if (ch1 == '\r') {
							i--;
							continue;
						} else if (ch1 == '\n') {
							i--;
							continue;
						}
						
						int high = DencodeUtils.hexDigitToNum(ch1);
						int low = DencodeUtils.hexDigitToNum(ch2);
						binBuf.write((byte)((high << 4) | low));
					} catch (IndexOutOfBoundsException | IllegalArgumentException e) {
						return null;
					}
				}
			} else {
				binBuf.write((byte)ch);
			}
		}
		
		return binBuf.toString(charset);
	}
}
