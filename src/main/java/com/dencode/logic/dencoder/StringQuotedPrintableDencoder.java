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
import java.nio.charset.IllegalCharsetNameException;
import java.nio.charset.StandardCharsets;
import java.nio.charset.UnsupportedCharsetException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.net.QuotedPrintableCodec;
import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.quoted-printable")
public class StringQuotedPrintableDencoder {
	
	private static final Pattern RFC2047_SPACE = Pattern.compile("\\?=\\s+=\\?");
	private static final Pattern RFC2047_QP = Pattern.compile("=\\?(.+?)\\?Q\\?(.+?)\\?=", Pattern.CASE_INSENSITIVE);
	
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
		boolean strict = (3 <= binValue.length);
		QuotedPrintableCodec quotedPrintableCodec = new QuotedPrintableCodec(strict);
		return new String(quotedPrintableCodec.encode(binValue), StandardCharsets.US_ASCII);
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

				QuotedPrintableCodec quotedPrintableCodec = new QuotedPrintableCodec();
				try {
					v = quotedPrintableCodec.decode(v, cs);
				} catch (DecoderException e) {
					return null;
				}
				v = v.replace('_', ' ');
				
				m.appendReplacement(sb, v);
			} while (m.find());
			m.appendTail(sb);
			
			return sb.toString();
		} else {
			QuotedPrintableCodec quotedPrintableCodec = new QuotedPrintableCodec();
			try {
				return quotedPrintableCodec.decode(val, charset);
			} catch (DecoderException e) {
				return null;
			}
		}
	}
}
