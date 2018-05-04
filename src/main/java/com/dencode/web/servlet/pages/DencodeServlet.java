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
package com.dencode.web.servlet.pages;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.CRC32;

import javax.servlet.annotation.WebServlet;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.codec.net.QuotedPrintableCodec;
import org.apache.commons.codec.net.URLCodec;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.text.WordUtils;
import org.mifmi.commons4j.graphics.color.CMYColor;
import org.mifmi.commons4j.graphics.color.CMYKColor;
import org.mifmi.commons4j.graphics.color.HSLColor;
import org.mifmi.commons4j.graphics.color.HSVColor;
import org.mifmi.commons4j.graphics.color.HWBColor;
import org.mifmi.commons4j.graphics.color.RGBColor;
import org.mifmi.commons4j.util.DateUtilz;
import org.mifmi.commons4j.util.NumberUtilz;
import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.web.model.DencodeModel;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/dencode")
public class DencodeServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;

	private static final char PROGRAM_STRING_ESCAPE_CHAR = '\\';
	private static final char[] PROGRAM_STRING_TARGET_CHARS = {'\0', '\u0007', '\b', '\t', '\n', '\u000B', '\f', '\r', '\"', '\''};
	private static final char[] PROGRAM_STRING_ESCAPED_CHARS = {'0', 'a', 'b', 't', 'n', 'v', 'f', 'r', '\"', '\''};
	
	private static final String[] DATE_PARSE_PATTERNS = {
		"EEE MMM dd HH:mm:ss z yyyy",
		"EEE MMM dd HH:mm:ss yyyy",
		"EEE, dd MMM yyy HH:mm:ss zzz",
		"EEE, dd MMM yyy HH:mm zzz",
		"EEE, dd MMM yyy HH:mm:ss",
		"EEE, dd MMM yyy HH:mm",
		"dd MMM yyy HH:mm:ss zzz",
		"dd MMM yyy HH:mm zzz",
		"dd MMM yyy HH:mm:ss",
		"dd MMM yyy HH:mm",
		"yyyy-MM-dd'T'HH:mm:ss.SSSXXX",
		"yyyy-MM-dd'T'HH:mm:ss,SSSXXX",
		"yyyy-MM-dd'T'HH:mm:ssXXX",
		"yyyy-MM-dd'T'HH:mmXXX",
		"yyyy-MM-dd'T'HHXXX",
		"yyyy-MM-dd'T'HH:mm:ss.SSSZ",
		"yyyy-MM-dd'T'HH:mm:ss,SSSZ",
		"yyyy-MM-dd'T'HH:mm:ssZ",
		"yyyy-MM-dd'T'HH:mmZ",
		"yyyy-MM-dd'T'HHZ",
		"yyyy-MM-dd'T'HH:mm:ss.SSS",
		"yyyy-MM-dd'T'HH:mm:ss,SSS",
		"yyyy-MM-dd'T'HH:mm:ss",
		"yyyy-MM-dd'T'HH:mm",
		"yyyy-MM-dd'T'HH",
		"yyyy-MM-dd HH:mm:ss.SSSXXX",
		"yyyy-MM-dd HH:mm:ss,SSSXXX",
		"yyyy-MM-dd HH:mm:ssXXX",
		"yyyy-MM-dd HH:mmXXX",
		"yyyy-MM-dd HHXXX",
		"yyyy-MM-dd HH:mm:ss.SSSZ",
		"yyyy-MM-dd HH:mm:ss,SSSZ",
		"yyyy-MM-dd HH:mm:ssZ",
		"yyyy-MM-dd HH:mmZ",
		"yyyy-MM-dd HHZ",
		"yyyy-MM-dd HH:mm:ss.SSS",
		"yyyy-MM-dd HH:mm:ss,SSS",
		"yyyy-MM-dd HH:mm:ss",
		"yyyy-MM-dd HH:mm",
		"yyyy-MM-dd HH",
		"yyyy/MM/dd HH:mm:ss.SSSXXX",
		"yyyy/MM/dd HH:mm:ss,SSSXXX",
		"yyyy/MM/dd HH:mm:ssXXX",
		"yyyy/MM/dd HH:mmXXX",
		"yyyy/MM/dd HHXXX",
		"yyyy/MM/dd HH:mm:ss.SSSZ",
		"yyyy/MM/dd HH:mm:ss,SSSZ",
		"yyyy/MM/dd HH:mm:ssZ",
		"yyyy/MM/dd HH:mmZ",
		"yyyy/MM/dd HHZ",
		"yyyy/MM/dd HH:mm:ss.SSS",
		"yyyy/MM/dd HH:mm:ss,SSS",
		"yyyy/MM/dd HH:mm:ss",
		"yyyy/MM/dd HH:mm",
		"yyyy/MM/dd HH",
		"yyyy-MM-dd",
		"yyyy-MM",
		"yyyy/MM/dd",
		"yyyy/MM",
		"YYYY-'W'ww-u",
		"HH:mm:ss.SSSXXX",
		"HH:mm:ss,SSSXXX",
		"HH:mm:ssXXX",
		"HH:mmXXX",
		"HHXXX",
		"HH:mm:ss.SSSZ",
		"HH:mm:ss,SSSZ",
		"HH:mm:ssZ",
		"HH:mmZ",
		"HHZ",
		"HH:mm:ss.SSS",
		"HH:mm:ss,SSS",
		"HH:mm:ss",
		"HH:mm",
	};
	
	private static final String[] DATE_PARSE_PATTERNS_JP = {
		"GGGGyyyy年MM月dd日HH時mm分ss秒",
		"GGGGyyyy年MM月dd日HH時mm分",
		"GGGGyyyy年MM月dd日HH時",
		"GGGGyyyy年MM月dd日",
		"GGGGyyyy年MM月",
		"GGGGyyyy年",
		"Gyyyy年MM月dd日HH時mm分ss秒",
		"Gyyyy年MM月dd日HH時mm分",
		"Gyyyy年MM月dd日HH時",
		"Gyyyy年MM月dd日",
		"Gyyyy年MM月",
		"Gyyyy年",
		"yyyy年MM月dd日HH時mm分ss秒",
		"yyyy年MM月dd日HH時mm分",
		"yyyy年MM月dd日HH時",
		"yyyy年MM月dd日",
		"yyyy年MM月",
		"yyyy年",
		"GGGGyyyy.MM.dd",
		"GGGGyyyy.MM",
		"GGGGyyyy",
		"Gyyyy.MM.dd",
		"Gyyyy",
		"HH時mm分ss秒",
		"HH時mm分",
		"HH時",
	};
	
	private static final Locale LOCALE_JP = new Locale("ja", "JP", "JP");

	private static final Pattern COLOR_RGB_HEX3_PATTERN = Pattern.compile("^#?([0-9a-f])([0-9a-f])([0-9a-f])([0-9a-f])?$");
	private static final Pattern COLOR_RGB_HEX6_PATTERN = Pattern.compile("^#?([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])?$");
	private static final Pattern COLOR_RGB_COMMA_PATTERN = Pattern.compile("^((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)(?:\\s*,\\s*(\\+?[0-9\\.]+))?$");
	private static final Pattern COLOR_RGB_FN_PATTERN = Pattern.compile("^rgba?\\s*\\(\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)(?:\\s*,\\s*(\\+?[0-9\\.]+))?\\s*\\)$");
	private static final Pattern COLOR_HSL_FN_PATTERN = Pattern.compile("^hsla?\\s*\\(\\s*((?:\\+|\\-)?[0-9\\.]+)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)(?:\\s*,\\s*(\\+?[0-9\\.]+))?\\s*\\)$");
	private static final Pattern COLOR_HSV_FN_PATTERN = Pattern.compile("^hsva?\\s*\\(\\s*((?:\\+|\\-)?[0-9\\.]+)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)(?:\\s*,\\s*(\\+?[0-9\\.]+))?\\s*\\)$");
	private static final Pattern COLOR_HWB_FN_PATTERN = Pattern.compile("^hwba?\\s*\\(\\s*((?:\\+|\\-)?[0-9\\.]+)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)(?:\\s*,\\s*(\\+?[0-9\\.]+))?\\s*\\)$");
	private static final Pattern COLOR_GRAY_FN_PATTERN = Pattern.compile("^graya?\\s*\\(\\s*((?:\\+|\\-)?[0-9\\.]+%?)(?:\\s*,\\s*(\\+?[0-9\\.]+))?\\s*\\)$");
	private static final Pattern COLOR_CMY_FN_PATTERN = Pattern.compile("^cmya?\\s*\\(\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)(?:\\s*,\\s*(\\+?[0-9\\.]+))?\\s*\\)$");
	private static final Pattern COLOR_CMYK_FN_PATTERN = Pattern.compile("^cmyka?\\s*\\(\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)\\s*,\\s*((?:\\+|\\-)?[0-9\\.]+%?)(?:\\s*,\\s*(\\+?[0-9\\.]+))?\\s*\\)$");
	
	
	@Override
	protected void doPost() throws Exception {
		String type = reqres().param("t", "all");
		String method = reqres().param("m", "all");
		String val = reqres().param("v", "");
		String oe = reqres().param("oe", "utf8");
		String nl = reqres().param("nl", "crlf");
		String tz = reqres().param("tz", "UTC");
		
		int textLengthDiff = 0;
		if (nl.equals("lf")) {
			val = val.replace("\r\n", "\n").replace("\r", "\n");
		} else if (nl.equals("cr")) {
			val = val.replace("\r\n", "\r").replace("\n", "\r");
		} else {
			// crlf
			val = val.replace("\r\n", "\n").replace("\r", "\n");
			for (int i = 0; i < val.length(); i++) {
				char c = val.charAt(i);
				if (c == '\n') {
					textLengthDiff--;
				}
			}
			val = val.replace("\n", "\r\n");
		}
		
		TimeZone timeZone = TimeZone.getTimeZone(tz);
		
		String charset = toCharset(oe);
		byte[] binValue;
		try {
			binValue = val.getBytes(charset);
		} catch (UnsupportedEncodingException e) {
			responseAsJson(500, null);
			return;
		}
		
		RGBColor rgb = parseColor(val);
		
		DencodeModel dencode = new DencodeModel();
		dencode.setTextLength(getTextLength(val) + textLengthDiff);
		dencode.setTextByteLength(binValue.length);
		if (type.equals("all") || type.equals("string")) {
			boolean all = (method.equals("all") || method.equals("string.all"));
			
			if (all || method.equals("string.bin")) dencode.setEncBin(encBin(binValue));
			if (all || method.equals("string.hex")) dencode.setEncHex(encHex(binValue));
			if (all || method.equals("string.htmlEscape")) dencode.setEncHTMLEscape(encHTMLEscape(val));
			if (all || method.equals("string.urlEncoding")) dencode.setEncURLEncoding(encURLEncoding(val, charset));
			if (all || method.equals("string.base64")) dencode.setEncBase64Encoding(encBase64Encoding(binValue));
			if (all || method.equals("string.quotedPrintable")) dencode.setEncQuotedPrintable(encQuotedPrintable(val, charset));
			if (all || method.equals("string.unicodeEscape")) dencode.setEncUnicodeEscape(encUnicodeEscape(val));
			if (all || method.equals("string.programString")) dencode.setEncProgramString(encProgramString(val));
			if (all || method.equals("string.characterWidth")) dencode.setEncHalfWidth(encHalfWidth(val));
			if (all || method.equals("string.characterWidth")) dencode.setEncFullWidth(encFullWidth(val));
			if (all || method.equals("string.letterCase")) dencode.setEncUpperCase(encUpperCase(val));
			if (all || method.equals("string.letterCase")) dencode.setEncLowerCase(encLowerCase(val));
			if (all || method.equals("string.letterCase")) dencode.setEncSwapCase(encSwapCase(val));
			if (all || method.equals("string.letterCase")) dencode.setEncCapitalize(encCapitalize(val));
			if (all || method.equals("string.textInitials")) dencode.setEncInitials(encInitials(val));
			if (all || method.equals("string.textReverse")) dencode.setEncReverse(encReverse(val));
			if (all || method.equals("string.camelCase")) dencode.setEncUpperCamelCase(encCamelCase(val, true));
			if (all || method.equals("string.camelCase")) dencode.setEncLowerCamelCase(encCamelCase(val, false));
			if (all || method.equals("string.snakeCase")) dencode.setEncUpperSnakeCase(encSnakeCase(val, true));
			if (all || method.equals("string.snakeCase")) dencode.setEncLowerSnakeCase(encSnakeCase(val, false));
			if (all || method.equals("string.chainCase")) dencode.setEncUpperChainCase(encChainCase(val, true));
			if (all || method.equals("string.chainCase")) dencode.setEncLowerChainCase(encChainCase(val, false));
			if (all || method.equals("string.unicodeNormalization")) dencode.setEncUnicodeNFC(encUnicodeNFC(val));
			if (all || method.equals("string.unicodeNormalization")) dencode.setEncUnicodeNFKC(encUnicodeNFKC(val));
			
			if (all || method.equals("string.bin")) dencode.setDecBin(decBin(val, charset));
			if (all || method.equals("string.hex")) dencode.setDecHex(decHex(val, charset));
			if (all || method.equals("string.htmlEscape")) dencode.setDecHTMLEscape(decHTMLEscape(val));
			if (all || method.equals("string.urlEncoding")) dencode.setDecURLEncoding(decURLEncoding(val, charset));
			if (all || method.equals("string.base64")) dencode.setDecBase64Encoding(decBase64Encoding(val, charset));
			if (all || method.equals("string.quotedPrintable")) dencode.setDecQuotedPrintable(decQuotedPrintable(val, charset));
			if (all || method.equals("string.unicodeEscape")) dencode.setDecUnicodeEscape(decUnicodeEscape(val));
			if (all || method.equals("string.programString")) dencode.setDecProgramString(decProgramString(val));
			if (all || method.equals("string.unicodeNormalization")) dencode.setDecUnicodeNFC(decUnicodeNFC(val));
			if (all || method.equals("string.unicodeNormalization")) dencode.setDecUnicodeNFKC(decUnicodeNFKC(val));
		}
		if (type.equals("all") || type.equals("number")) {
			boolean all = (method.equals("all") || method.equals("number.all"));
			
			if (all || method.equals("number.bin")) dencode.setEncNumBin(encNumBin(val));
			if (all || method.equals("number.oct")) dencode.setEncNumOct(encNumOct(val));
			if (all || method.equals("number.hex")) dencode.setEncNumHex(encNumHex(val));
			if (all || method.equals("number.japanese")) dencode.setEncNumJP(encNumJP(val));
			if (all || method.equals("number.japanese")) dencode.setEncNumJPDaiji(encNumJPDaiji(val));

			if (all || method.equals("number.bin")) dencode.setDecNumBin(decNumBin(val));
			if (all || method.equals("number.oct")) dencode.setDecNumOct(decNumOct(val));
			if (all || method.equals("number.hex")) dencode.setDecNumHex(decNumHex(val));
			if (all || method.equals("number.japanese")) dencode.setDecNumJP(decNumJP(val));
		}
		if (type.equals("all") || type.equals("date")) {
			boolean all = (method.equals("all") || method.equals("date.all"));
			
			if (all || method.equals("date.unixTime")) dencode.setEncDateUnixTime(encDateUnixTime(val, timeZone));
			if (all || method.equals("date.iso8601")) dencode.setEncDateISO8601(encDateISO8601(val, timeZone));
			if (all || method.equals("date.rfc2822")) dencode.setEncDateRFC2822(encDateRFC2822(val, timeZone));
			if (all || method.equals("date.ctime")) dencode.setEncDateCTime(encDateCTime(val, timeZone));
		}
		if (type.equals("all") || type.equals("color")) {
			boolean all = (method.equals("all") || method.equals("color.all"));
			
			if (all || method.equals("color.name")) dencode.setEncColorName(encColorName(rgb));
			if (all || method.equals("color.rgb")) dencode.setEncColorRGBHex3(encColorRGBHex3(rgb));
			/*if (all || method.equals("color.rgb"))*/ dencode.setEncColorRGBHex6(encColorRGBHex6(rgb)); // always use to background-color
			if (all || method.equals("color.rgb")) dencode.setEncColorRGBFn8(encColorRGBFn8(rgb));
			if (all || method.equals("color.rgb")) dencode.setEncColorRGBFn(encColorRGBFn(rgb));
			if (all || method.equals("color.hsl")) dencode.setEncColorHSLFn(encColorHSLFn(rgb));
			if (all || method.equals("color.hsv")) dencode.setEncColorHSVFn(encColorHSVFn(rgb));
			if (all || method.equals("color.cmy")) dencode.setEncColorCMYFn(encColorCMYFn(rgb));
			if (all || method.equals("color.cmyk")) dencode.setEncColorCMYKFn(encColorCMYKFn(rgb));
		}
		if (type.equals("all") || type.equals("hash")) {
			boolean all = (method.equals("all") || method.equals("hash.all"));
			
			if (all || method.equals("hash.md2")) dencode.setEncMD2(hash(binValue, "MD2"));
			if (all || method.equals("hash.md5")) dencode.setEncMD5(hash(binValue, "MD5"));
			if (all || method.equals("hash.sha1")) dencode.setEncSHA1(hash(binValue, "SHA-1"));
			if (all || method.equals("hash.sha256")) dencode.setEncSHA256(hash(binValue, "SHA-256"));
			if (all || method.equals("hash.sha384")) dencode.setEncSHA384(hash(binValue, "SHA-384"));
			if (all || method.equals("hash.sha512")) dencode.setEncSHA512(hash(binValue, "SHA-512"));
			if (all || method.equals("hash.crc32")) dencode.setEncCRC32(encCRC32(binValue));
		}
		
		responseAsJson(dencode);
	}

	private static String toCharset(String oe) {
		if (oe == null) {
			return "UTF-8";
		}
		if (oe.equals("utf8")) {
			return "UTF-8";
		} else if (oe.equals("utf16")) {
			return "UTF-16BE";
		} else if (oe.equals("utf32")) {
			return "UTF-32BE";
		} else if (oe.equals("eucjp")) {
			return "EUC-JP";
		} else if (oe.equals("sjis")) {
			return "MS932";
		} else if (oe.equals("iso2022jp")) {
			return "ISO-2022-JP";
		} else if (oe.equals("iso88591")) {
			return "ISO-8859-1";
		} else if (oe.equals("iso88592")) {
			return "ISO-8859-2";
		} else if (oe.equals("iso88594")) {
			return "ISO-8859-4";
		} else if (oe.equals("iso88595")) {
			return "ISO-8859-5";
		} else if (oe.equals("iso88596")) {
			return "ISO-8859-6";
		} else if (oe.equals("iso88597")) {
			return "ISO-8859-7";
		} else if (oe.equals("iso88598")) {
			return "ISO-8859-8";
		} else if (oe.equals("iso88599")) {
			return "ISO-8859-9";
		} else if (oe.equals("iso885913")) {
			return "ISO-8859-13";
		} else if (oe.equals("iso885915")) {
			return "ISO-8859-15";
		} else if (oe.equals("cp874")) {
			return "x-IBM874";
		} else if (oe.equals("cp1250")) {
			return "windows-1250";
		} else if (oe.equals("cp1251")) {
			return "windows-1251";
		} else if (oe.equals("cp1253")) {
			return "windows-1253";
		} else if (oe.equals("cp1254")) {
			return "windows-1254";
		} else if (oe.equals("cp1255")) {
			return "windows-1255";
		} else if (oe.equals("cp1256")) {
			return "windows-1256";
		} else if (oe.equals("cp1257")) {
			return "windows-1257";
		} else if (oe.equals("cp1258")) {
			return "windows-1258";
		} else if (oe.equals("koi8r")) {
			return "KOI8-R";
		} else if (oe.equals("koi8u")) {
			return "KOI8-U";
		} else if (oe.equals("big5hkscs")) {
			return "Big5-HKSCS";
		} else if (oe.equals("euccn")) {
			return "GB2312";
		} else if (oe.equals("gb18030")) {
			return "GB18030";
		} else if (oe.equals("euckr")) {
			return "EUC-KR";
		} else if (oe.equals("tis620")) {
			return "TIS-620";
		} else {
			return "UTF-8";
		}
	}

	private static int getTextLength(String val) {
		if (val == null || val.isEmpty()) {
			return 0;
		}

		return val.codePointCount(0, val.length());
	}
	
	private static String encHTMLEscape(String val) {
		return StringEscapeUtils.escapeXml(val);
	}
	
	private static String encURLEncoding(String val, String charset) {
		URLCodec urlCodec = new URLCodec();
		try {
			String encodedURL = urlCodec.encode(val, charset);
			if (encodedURL.indexOf('+') != -1) {
				encodedURL = encodedURL.replace("+", "%20");
			}
			return encodedURL;
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	private static String encBase64Encoding(byte[] binValue) {
		Base64 base64 = new Base64(76);
		return base64.encodeAsString(binValue);
	}
	
	private static String encQuotedPrintable(String val, String charset) {
		try {
			QuotedPrintableCodec quotedPrintableCodec = new QuotedPrintableCodec();
			return quotedPrintableCodec.encode(val, charset);
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	private static String encProgramString(String val) {
		if (val == null) {
			return null;
		}
		return "\"" + StringUtilz.escape(
				val,
				PROGRAM_STRING_ESCAPE_CHAR,
				PROGRAM_STRING_TARGET_CHARS,
				PROGRAM_STRING_ESCAPED_CHARS
				)
				+ "\"";
	}
	
	private static String encUnicodeEscape(String val) {
		if (val == null) {
			return null;
		}
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len * 6);
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (Character.isHighSurrogate(ch) && (i + 1 != len)) {
				char lowCh = val.charAt(++i);
				
				int codePoint = Character.toCodePoint(ch, lowCh);
				String codePointHexStr = Integer.toHexString(codePoint);
				
				sb.append("\\U");
				StringUtilz.paddingLeft(sb, codePointHexStr, 8, '0');
			} else {
				String chHexStr = Integer.toHexString((int)ch);
				
				sb.append("\\u");
				StringUtilz.paddingLeft(sb, chHexStr, 4, '0');
			}
		}
		
		return sb.toString();
	}
	
	private static String encBin(byte[] binValue) {
		return toBinString(binValue);
	}
	
	private static String encHex(byte[] binValue) {
		return toHexString(binValue);
	}
	
	private static String encHalfWidth(String val) {
		return StringUtilz.toHalfWidth(val, true, true, true, true, true, true);
	}
	
	private static String encFullWidth(String val) {
		return StringUtilz.toFullWidth(val, true, true, true, true, true, true);
	}
	
	private static String encUpperCase(String val) {
		return StringUtils.upperCase(val);
	}
	
	private static String encLowerCase(String val) {
		return StringUtils.lowerCase(val);
	}
	
	private static String encSwapCase(String val) {
		return WordUtils.swapCase(val);
	}
	
	private static String encCapitalize(String val) {
		return WordUtils.capitalizeFully(val);
	}
	
	private static String encInitials(String val) {
		return WordUtils.initials(val);
	}
	
	private static String encReverse(String val) {
		return StringUtils.reverse(val);
	}
	
	private static String encCamelCase(String val, boolean firstCapital) {
		return StringUtilz.toCamelCase(val, firstCapital);
	}
	
	private static String encSnakeCase(String val, boolean upper) {
		return StringUtilz.toSnakeCase(val, false, Boolean.valueOf(upper));
	}
	
	private static String encChainCase(String val, boolean upper) {
		return StringUtilz.toChainCase(val, false, Boolean.valueOf(upper));
	}
	
	private static String encUnicodeNFC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFC);
	}
	
	private static String encUnicodeNFKC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFKC);
	}

	private static String encNumBin(String val) {
		return encNum(val, 2);
	}

	private static String encNumOct(String val) {
		return encNum(val, 8);
	}
	
	private static String encNumHex(String val) {
		return encNum(val, 16);
	}
	
	private static String encNum(String val, int radix) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		try {
			String[] vals = val.split(" ", -1);
			for (int i = 0; i < vals.length; i++) {
				if (vals[i].isEmpty()) {
					continue;
				}
				BigInteger bigInt = parseNum(vals[i]);
				if (bigInt == null) {
					return null;
				}
				vals[i] = bigInt.toString(radix);
			}
			return StringUtilz.join(" ", (Object[])vals);
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	private static String encNumJP(String val) {
		BigInteger bigInt = parseNum(val);
		if (bigInt == null) {
			return null;
		}
		return NumberUtilz.toJPNum(bigInt, false, false, false);
	}
	
	private static String encNumJPDaiji(String val) {
		BigInteger bigInt = parseNum(val);
		if (bigInt == null) {
			return null;
		}
		return NumberUtilz.toJPNum(bigInt, false, true, false);
	}
	
	private static BigInteger parseNum(String val) {
		val = StringUtilz.toHalfWidth(val, true, true, true, true, false, false);
		val = val.replace(",", "");
		try {
			return new BigInteger(val);
		} catch (NumberFormatException e) {
			return NumberUtilz.parseJPNum(val);
		}
	}

	private static String encDateUnixTime(String val, TimeZone timeZone) {
		Date dateVal = parseDate(val, timeZone);
		if (dateVal == null) {
			return null;
		}
		return String.valueOf(dateVal.getTime());
	}

	private static String encDateISO8601(String val, TimeZone timeZone) {
		Date dateVal = parseDate(val, timeZone);
		if (dateVal == null) {
			return null;
		}
		
		long time = dateVal.getTime();
		long millisOfSec = time - ((time / 1000) * 1000);
		DateFormat dateFormat = new SimpleDateFormat((millisOfSec == 0) ? "yyyy-MM-dd'T'HH:mm:ssXXX" : "yyyy-MM-dd'T'HH:mm:ss,SSSXXX");
		dateFormat.setTimeZone(timeZone);
		return dateFormat.format(dateVal);
	}

	private static String encDateRFC2822(String val, TimeZone timeZone) {
		Date dateVal = parseDate(val, timeZone);
		if (dateVal == null) {
			return null;
		}
		if (timeZone.getID().equals("UTC")) {
			timeZone = TimeZone.getTimeZone("GMT");
		}
		DateFormat dateFormat = new SimpleDateFormat("EEE, dd MMM yyy HH:mm:ss zzz", Locale.US);
		dateFormat.setTimeZone(timeZone);
		return dateFormat.format(dateVal);
	}

	private static String encDateCTime(String val, TimeZone timeZone) {
		Date dateVal = parseDate(val, timeZone);
		if (dateVal == null) {
			return null;
		}
		if (timeZone.getID().equals("UTC")) {
			timeZone = TimeZone.getTimeZone("GMT");
		}
		DateFormat dateFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.US);
		dateFormat.setTimeZone(timeZone);
		return dateFormat.format(dateVal);
	}
	
	private static Date parseDate(String val, TimeZone timeZone) {
		val = StringUtilz.toHalfWidth(val, true, true, true, true, false, false);
		try {
			return new Date(Long.parseLong(val));
		} catch (NumberFormatException e) {
			Date date = DateUtilz.parseDate(val, true, timeZone, Locale.US, DATE_PARSE_PATTERNS);
			if (date == null) {
				date = DateUtilz.parseDate(val, true, timeZone, LOCALE_JP, DATE_PARSE_PATTERNS_JP);
			}
			return date;
		}
	}
	
	private static String encColorName(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}
		
		return RGBColor.getName(rgb);
	}
	
	private static String encColorRGBHex3(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		boolean hasAlpha = (rgb.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		sb.append('#');
		sb.append(Integer.toHexString(Math.round(rgb.getR8() / 17)));
		sb.append(Integer.toHexString(Math.round(rgb.getG8() / 17)));
		sb.append(Integer.toHexString(Math.round(rgb.getB8() / 17)));
		if (hasAlpha) {
			sb.append(Integer.toHexString(Math.round((int) (255.0 * rgb.getA() / 17.0))));
		}
		
		return sb.toString();
	}
	
	private static String encColorRGBHex6(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		boolean hasAlpha = (rgb.getA() != 1.0);

		StringBuilder sb = new StringBuilder();
		sb.append('#');
		
		if (rgb.getR8() <= 0xf) {
			sb.append('0');
		}
		sb.append(Integer.toHexString(rgb.getR8()));
		
		if (rgb.getG8() <= 0xf) {
			sb.append('0');
		}
		sb.append(Integer.toHexString(rgb.getG8()));
		
		if (rgb.getB8() <= 0xf) {
			sb.append('0');
		}
		sb.append(Integer.toHexString(rgb.getB8()));
		
		if (hasAlpha) {
			int a8 = (int) (255.0 * rgb.getA());
			if (a8 <= 0xf) {
				sb.append('0');
			}
			sb.append(Integer.toHexString(a8));
		}
		
		return sb.toString();
	}
	
	private static String encColorRGBFn8(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		boolean hasAlpha = (rgb.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		if (hasAlpha) {
			sb.append("rgba(");
		} else {
			sb.append("rgb(");
		}
		sb.append(rgb.getR8());
		sb.append(", ");
		sb.append(rgb.getG8());
		sb.append(", ");
		sb.append(rgb.getB8());
		if (hasAlpha) {
			sb.append(", ");
			appendRoundString(sb, rgb.getA(), 2, RoundingMode.HALF_UP);
		}
		sb.append(')');
		
		return sb.toString();
	}
	
	private static String encColorRGBFn(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		boolean hasAlpha = (rgb.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		if (hasAlpha) {
			sb.append("rgba(");
		} else {
			sb.append("rgb(");
		}
		appendRoundString(sb, rgb.getR() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, rgb.getG() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, rgb.getB() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		if (hasAlpha) {
			sb.append(", ");
			appendRoundString(sb, rgb.getA(), 2, RoundingMode.HALF_UP);
		}
		sb.append(')');
		
		return sb.toString();
	}
	
	private static String encColorHSLFn(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		HSLColor hsl = rgb.toHSL();
		boolean hasAlpha = (hsl.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		if (hasAlpha) {
			sb.append("hsla(");
		} else {
			sb.append("hsl(");
		}
		appendRoundString(sb, hsl.getH(), 2, RoundingMode.HALF_UP);
		sb.append(", ");
		appendRoundString(sb, hsl.getS() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, hsl.getL() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		if (hasAlpha) {
			sb.append(", ");
			appendRoundString(sb, hsl.getA(), 2, RoundingMode.HALF_UP);
		}
		sb.append(')');
		
		return sb.toString();
	}
	
	private static String encColorHSVFn(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		HSVColor hsv = rgb.toHSV();
		boolean hasAlpha = (hsv.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		if (hasAlpha) {
			sb.append("hsva(");
		} else {
			sb.append("hsv(");
		}
		appendRoundString(sb, hsv.getH(), 2, RoundingMode.HALF_UP);
		sb.append(", ");
		appendRoundString(sb, hsv.getS() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, hsv.getV() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		if (hasAlpha) {
			sb.append(", ");
			appendRoundString(sb, hsv.getA(), 2, RoundingMode.HALF_UP);
		}
		sb.append(')');
		
		return sb.toString();
	}
	
	private static String encColorCMYFn(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		CMYColor cmy = rgb.toCMY();
		boolean hasAlpha = (cmy.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		if (hasAlpha) {
			sb.append("cmya(");
		} else {
			sb.append("cmy(");
		}
		appendRoundString(sb, cmy.getC() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, cmy.getM() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, cmy.getY() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		if (hasAlpha) {
			sb.append(", ");
			appendRoundString(sb, rgb.getA(), 2, RoundingMode.HALF_UP);
		}
		sb.append(')');
		
		return sb.toString();
	}
	
	private static String encColorCMYKFn(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		CMYKColor cmyk = rgb.toCMYK();
		boolean hasAlpha = (cmyk.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		if (hasAlpha) {
			sb.append("cmyka(");
		} else {
			sb.append("cmyk(");
		}
		appendRoundString(sb, cmyk.getC() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, cmyk.getM() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, cmyk.getY() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, cmyk.getK() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		if (hasAlpha) {
			sb.append(", ");
			appendRoundString(sb, rgb.getA(), 2, RoundingMode.HALF_UP);
		}
		sb.append(')');
		
		return sb.toString();
	}
	
	private static RGBColor parseColor(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		if (50 < val.length()) {
			return null;
		}
		
		String lv = val.trim().toLowerCase();
		
		RGBColor namedColor = RGBColor.fromName(lv);
		if (namedColor != null) {
			return namedColor;
		}
		
		try {
			if (lv.startsWith("rgb")) {
				Matcher rgbFnMatcher = COLOR_RGB_FN_PATTERN.matcher(lv);
				if (rgbFnMatcher.matches()) {
					double r = parseToRate(rgbFnMatcher.group(1), 255.0);
					double g = parseToRate(rgbFnMatcher.group(2), 255.0);
					double b = parseToRate(rgbFnMatcher.group(3), 255.0);
					double a = parseToRate(rgbFnMatcher.group(4), 1.0, 1.0);
					
					r = Math.min(Math.max(r, 0.0), 1.0);
					g = Math.min(Math.max(g, 0.0), 1.0);
					b = Math.min(Math.max(b, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new RGBColor(r, g, b, a);
				}
			} else if (lv.startsWith("hsl")) {
				Matcher hslFnMatcher = COLOR_HSL_FN_PATTERN.matcher(lv);
				if (hslFnMatcher.matches()) {
					double h = Double.parseDouble(hslFnMatcher.group(1));
					double s = parseToRate(hslFnMatcher.group(2), 1.0);
					double l = parseToRate(hslFnMatcher.group(3), 1.0);
					double a = parseToRate(hslFnMatcher.group(4), 1.0, 1.0);
					
					h = Math.min(Math.max(h, 0.0), 360.0);
					s = Math.min(Math.max(s, 0.0), 1.0);
					l = Math.min(Math.max(l, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new HSLColor(h, s, l, a).toRGB();
				}
			} else if (lv.startsWith("hsv")) {
				Matcher hsvFnMatcher = COLOR_HSV_FN_PATTERN.matcher(lv);
				if (hsvFnMatcher.matches()) {
					double h = Double.parseDouble(hsvFnMatcher.group(1));
					double s = parseToRate(hsvFnMatcher.group(2), 1.0);
					double v = parseToRate(hsvFnMatcher.group(3), 1.0);
					double a = parseToRate(hsvFnMatcher.group(4), 1.0, 1.0);
					
					h = Math.min(Math.max(h, 0.0), 360.0);
					s = Math.min(Math.max(s, 0.0), 1.0);
					v = Math.min(Math.max(v, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new HSVColor(h, s, v, a).toRGB();
				}
			} else if (lv.startsWith("hwb")) {
				Matcher hwbFnMatcher = COLOR_HWB_FN_PATTERN.matcher(lv);
				if (hwbFnMatcher.matches()) {
					double h = Double.parseDouble(hwbFnMatcher.group(1));
					double w = parseToRate(hwbFnMatcher.group(2), 1.0);
					double b = parseToRate(hwbFnMatcher.group(3), 1.0);
					double a = parseToRate(hwbFnMatcher.group(4), 1.0, 1.0);
					
					h = Math.min(Math.max(h, 0.0), 360.0);
					w = Math.min(Math.max(w, 0.0), 1.0);
					b = Math.min(Math.max(b, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new HWBColor(h, w, b, a).toRGB();
				}
			} else if (lv.startsWith("gray")) {
				Matcher grayFnMatcher = COLOR_GRAY_FN_PATTERN.matcher(lv);
				if (grayFnMatcher.matches()) {
					double g = parseToRate(grayFnMatcher.group(1), 255.0);
					double a = parseToRate(grayFnMatcher.group(2), 1.0, 1.0);
					
					g = Math.min(Math.max(g, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new RGBColor(g, g, g, a);
				}
			} else if (lv.startsWith("cmyk")) {
				Matcher cmykFnMatcher = COLOR_CMYK_FN_PATTERN.matcher(lv);
				if (cmykFnMatcher.matches()) {
					double c = parseToRate(cmykFnMatcher.group(1), 1.0);
					double m = parseToRate(cmykFnMatcher.group(2), 1.0);
					double y = parseToRate(cmykFnMatcher.group(3), 1.0);
					double k = parseToRate(cmykFnMatcher.group(4), 1.0);
					double a = parseToRate(cmykFnMatcher.group(5), 1.0, 1.0);
					
					c = Math.min(Math.max(c, 0.0), 1.0);
					m = Math.min(Math.max(m, 0.0), 1.0);
					y = Math.min(Math.max(y, 0.0), 1.0);
					k = Math.min(Math.max(k, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new CMYKColor(c, m, y, k, a).toRGB();
				}
			} else if (lv.startsWith("cmy")) {
				Matcher cmyFnMatcher = COLOR_CMY_FN_PATTERN.matcher(lv);
				if (cmyFnMatcher.matches()) {
					double c = parseToRate(cmyFnMatcher.group(1), 1.0);
					double m = parseToRate(cmyFnMatcher.group(2), 1.0);
					double y = parseToRate(cmyFnMatcher.group(3), 1.0);
					double a = parseToRate(cmyFnMatcher.group(4), 1.0, 1.0);

					c = Math.min(Math.max(c, 0.0), 1.0);
					m = Math.min(Math.max(m, 0.0), 1.0);
					y = Math.min(Math.max(y, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);

					return new CMYColor(c, m, y, a).toRGB();
				}
			} else {
				Matcher rgbHex6Matcher= COLOR_RGB_HEX6_PATTERN.matcher(lv);
				if (rgbHex6Matcher.matches()) {
					int r = Integer.parseInt(rgbHex6Matcher.group(1), 16);
					int g = Integer.parseInt(rgbHex6Matcher.group(2), 16);
					int b = Integer.parseInt(rgbHex6Matcher.group(3), 16);
					double a;
					if (rgbHex6Matcher.group(4) != null) {
						a = ((double) Integer.parseInt(rgbHex6Matcher.group(4), 16)) / 255.0;
					} else {
						a = 1.0;
					}
					
					return RGBColor.fromRGB8(r, g, b, a);
				}
	
				Matcher rgbHex3Matcher = COLOR_RGB_HEX3_PATTERN.matcher(lv);
				if (rgbHex3Matcher.matches()) {
					int r = Integer.parseInt(rgbHex3Matcher.group(1), 16);
					int g = Integer.parseInt(rgbHex3Matcher.group(2), 16);
					int b = Integer.parseInt(rgbHex3Matcher.group(3), 16);
					
					r = (r << 4) | r;
					g = (g << 4) | g;
					b = (b << 4) | b;

					double a;
					if (rgbHex3Matcher.group(4) != null) {
						int a8 = Integer.parseInt(rgbHex3Matcher.group(4), 16);
						a8 = (a8 << 4) | a8;
						a = ((double) a8) / 255.0;
					} else {
						a = 1.0;
					}
					
					return RGBColor.fromRGB8(r, g, b, a);
				}
	
				Matcher rgbCommaMatcher = COLOR_RGB_COMMA_PATTERN.matcher(lv);
				if (rgbCommaMatcher.matches()) {
					double r = parseToRate(rgbCommaMatcher.group(1), 255.0);
					double g = parseToRate(rgbCommaMatcher.group(2), 255.0);
					double b = parseToRate(rgbCommaMatcher.group(3), 255.0);
					double a = parseToRate(rgbCommaMatcher.group(4), 1.0, 1.0);

					r = Math.min(Math.max(r, 0.0), 1.0);
					g = Math.min(Math.max(g, 0.0), 1.0);
					b = Math.min(Math.max(b, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new RGBColor(r, g, b, a);
				}
				
			}
		} catch (NumberFormatException e) {
			return null;
		}
		
		return null;
	}

	private static double parseToRate(String val, double base) {
		return parseToRate(val, base, 0.0);
	}
	private static double parseToRate(String val, double base, double defaultVal) {
		if (val == null) {
			return defaultVal;
		}
		
		if (val.endsWith("%")) {
			// percentage
			String v = val.substring(0, val.length() - 1);
			return Double.parseDouble(v) / 100.0;
		} else {
			double d = Double.parseDouble(val);
			if (d < 1.0 || (d == 1.0 && val.indexOf('.') != -1)) {
				// rate
				return Double.parseDouble(val);
			} else {
				// value
				return Double.parseDouble(val) / base;
			}
		}
	}
	
	private static String hash(byte[] binValue, String algo) {
		try {
			MessageDigest messageDigest = MessageDigest.getInstance(algo);
			byte[] digest = messageDigest.digest(binValue);
			return Hex.encodeHexString(digest);
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
	}
	
	private static String encCRC32(byte[] binValue) {
		CRC32 crc = new CRC32();
		crc.update(binValue, 0, binValue.length);
		return Long.toHexString(crc.getValue());
	}
	
	
	private static String decBin(String val, String charset) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		try {
			if (val.indexOf(' ') == -1) {
				val = val.replace("\r", "");
				val = val.replace("\n", "");
				int len = val.length();
				int binLen = 0;
				byte[] binValue = new byte[len / 8 + 1];
				for (int i = 0; i < val.length(); ) {
					int lastIdx = Math.min(i + 8, len);
					String v = val.substring(i, lastIdx);
					byte b = (byte)Integer.parseInt(v, 2);
					binValue[binLen] = b;
					binLen++;
					i = lastIdx;
				}
				return new String(binValue, 0, binLen, charset);
			} else {
				val = val.replace('\r', ' ');
				val = val.replace('\n', ' ');
				String[] vals = val.split(" ", -1);
				int valsLen = vals.length;
				
				boolean is4bit = true;
				for (String v : vals) {
					if (4 < v.length()) {
						is4bit = false;
						break;
					}
				}
				
				if (is4bit) {
					int binLen = 0;
					byte[] binValue = new byte[valsLen / 2 + 1];
					for (int i = 0; i < valsLen; i++) {
						String v = vals[i];
						if (v.isEmpty()) {
							continue;
						}
						int high = Integer.parseInt(v, 2);
						
						i++;
						int low = 0;
						if (i < valsLen) {
							String v2 = vals[i];
							if (!v2.isEmpty()) {
								low = Integer.parseInt(v2, 2);
							}
						}
						
						byte b = (byte)((high << 4) | low);
						binValue[binLen++] = b;
					}
					return new String(binValue, 0, binLen, charset);
				} else {
					int binLen = 0;
					byte[] binValue = new byte[valsLen];
					for (int i = 0; i < valsLen; i++) {
						byte b = (byte)Integer.parseInt(vals[i], 2);
						binValue[binLen++] = b;
					}
					return new String(binValue, 0, binLen, charset);
				}
			}
		} catch (NumberFormatException e) {
			return null;
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	private static String decHex(String val, String charset) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		try {
			if (val.indexOf(' ') == -1) {
				val = val.replace("\r", "");
				val = val.replace("\n", "");
				int len = val.length();
				int binLen = 0;
				byte[] binValue = new byte[len / 2 + 1];
				for (int i = 0; i < val.length(); ) {
					int lastIdx = Math.min(i + 2, len);
					String v = val.substring(i, lastIdx);
					byte b = (byte)Integer.parseInt(v, 16);
					binValue[binLen++] = b;
					i = lastIdx;
				}
				return new String(binValue, 0, binLen, charset);
			} else {
				val = val.replace('\r', ' ');
				val = val.replace('\n', ' ');
				String[] vals = val.split(" ", -1);
				int valsLen = vals.length;

				int binLen = 0;
				byte[] binValue = new byte[valsLen];
				for (int i = 0; i < valsLen; i++) {
					String v = vals[i];
					if (v.isEmpty()) {
						continue;
					}
					byte b = (byte)Integer.parseInt(v, 16);
					binValue[binLen] = b;
					binLen++;
				}
				return new String(binValue, 0, binLen, charset);
			}
		} catch (NumberFormatException e) {
			return null;
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	private static String decHTMLEscape(String val) {
		String v = (val == null) ? null : val.replace("&apos;", "'");
		return StringEscapeUtils.unescapeHtml4(v);
	}
	
	private static String decURLEncoding(String val, String charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		URLCodec urlCodec = new URLCodec();
		try {
			return urlCodec.decode(val, charset);
		} catch (UnsupportedEncodingException e) {
			return null;
		} catch (DecoderException e) {
			return null;
		}
	}
	
	private static String decBase64Encoding(String val, String charset) {
		if (!Base64.isBase64(val)) {
			return null;
		}
		try {
			byte[] decodedValue = Base64.decodeBase64(val);
			return new String(decodedValue, charset);
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	private static String decQuotedPrintable(String val, String charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		try {
			QuotedPrintableCodec quotedPrintableCodec = new QuotedPrintableCodec();
			return quotedPrintableCodec.decode(val, charset);
		} catch (DecoderException e) {
			return null;
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}
	
	private static String decUnicodeEscape(String val) {
		if (val == null) {
			return null;
		}
		return StringUtilz.unescape(
				val,
				'\\',
				null,
				null,
				true
				);
	}
	
	private static String decProgramString(String val) {
		if (val == null || val.length() < 2) {
			return null;
		}
		if (!(val.charAt(0) == '\"' && val.charAt(val.length() - 1) == '\"')) {
			if (!(val.charAt(0) == '\'' && val.charAt(val.length() - 1) == '\'')) {
				return null;
			}
		}
		val = val.substring(1, val.length() - 1);
		return StringUtilz.unescape(
				val,
				PROGRAM_STRING_ESCAPE_CHAR,
				PROGRAM_STRING_TARGET_CHARS,
				PROGRAM_STRING_ESCAPED_CHARS,
				true
				);
	}
	
	private static String decUnicodeNFC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFD);
	}
	
	private static String decUnicodeNFKC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFKD);
	}

	private static String decNumBin(String val) {
		return decNum(val, 2);
	}

	private static String decNumOct(String val) {
		return decNum(val, 8);
	}
	
	private static String decNumHex(String val) {
		return decNum(val, 16);
	}
	
	private static String decNum(String val, int radix) {
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
	
	private static String decNumJP(String val) {
		BigInteger bigInt = NumberUtilz.parseJPNum(val);
		if (bigInt == null) {
			return null;
		}
		return bigInt.toString(10);
	}
	
	private static String toBinString(byte[] binary) {
		if (binary == null) {
			return null;
		}
		if (binary.length == 0) {
			return "";
		}
		
		int len = binary.length;
		
		StringBuilder sb = new StringBuilder(len * 9);
		for (int i = 0; i < len; i++) {
			byte b = binary[i];

			if (i != 0) {
				sb.append(' ');
			}
			sb.append(((b & 0x80) == 0) ? '0' : '1');
			sb.append(((b & 0x40) == 0) ? '0' : '1');
			sb.append(((b & 0x20) == 0) ? '0' : '1');
			sb.append(((b & 0x10) == 0) ? '0' : '1');
			sb.append(((b & 0x8) == 0) ? '0' : '1');
			sb.append(((b & 0x4) == 0) ? '0' : '1');
			sb.append(((b & 0x2) == 0) ? '0' : '1');
			sb.append(((b & 0x1) == 0) ? '0' : '1');
		}
		return sb.toString();
	}
	
	private static String toHexString(byte[] binary) {
		if (binary == null) {
			return null;
		}
		if (binary.length == 0) {
			return "";
		}
		
		int len = binary.length;
		
		StringBuilder sb = new StringBuilder(len * 3);
		for (int i = 0; i < len; i++) {
			byte b = binary[i];
			
			if (i != 0) {
				sb.append(' ');
			}
			int high = ((b >>> 4) & 0xF);
			int low = (b & 0xF);
			if (high < 10) {
				sb.append((char)('0' + high));
			} else {
				sb.append((char)('A' + (high - 10)));
			}
			if (low < 10) {
				sb.append((char)('0' + low));
			} else {
				sb.append((char)('A' + (low - 10)));
			}
		}
		return sb.toString();
	}
	
	private static void appendRoundString(StringBuilder sb, double d, int scale, RoundingMode roundingMode) {
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
}
