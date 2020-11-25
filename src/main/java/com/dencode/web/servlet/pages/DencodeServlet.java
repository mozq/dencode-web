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

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.net.IDN;
import java.nio.charset.Charset;
import java.nio.charset.IllegalCharsetNameException;
import java.nio.charset.StandardCharsets;
import java.nio.charset.UnsupportedCharsetException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.CRC32;

import javax.servlet.annotation.WebServlet;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base32;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.codec.net.QuotedPrintableCodec;
import org.apache.commons.codec.net.URLCodec;
import org.mifmi.commons4j.graphics.color.CMYColor;
import org.mifmi.commons4j.graphics.color.CMYKColor;
import org.mifmi.commons4j.graphics.color.HSLColor;
import org.mifmi.commons4j.graphics.color.HSVColor;
import org.mifmi.commons4j.graphics.color.HWBColor;
import org.mifmi.commons4j.graphics.color.RGBColor;
import org.mifmi.commons4j.util.DateUtilz;
import org.mifmi.commons4j.util.NumberUtilz;
import org.mifmi.commons4j.util.StringUtilz;
import org.mifmi.commons4j.util.exception.NumberParseException;
import org.mifmi.commons4j.web.util.HTMLUtilz;

import com.dencode.web.logic.CommonLogic;
import com.dencode.web.model.DencodeModel;
import com.dencode.web.servlet.AbstractDencodeHttpServlet;

@WebServlet("/dencode")
public class DencodeServlet extends AbstractDencodeHttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Pattern DATA_SIZE_PATTERN = Pattern.compile("^([0-9]+)(b|B)$");
	
	private static final Pattern RFC2047_SPACE = Pattern.compile("\\?=\\s+=\\?");
	private static final Pattern RFC2047_QP = Pattern.compile("=\\?(.+?)\\?Q\\?(.+?)\\?=", Pattern.CASE_INSENSITIVE);
	private static final Pattern RFC2047_BASE64 = Pattern.compile("=\\?(.+?)\\?B\\?(.+?)\\?=", Pattern.CASE_INSENSITIVE);
	
	private static final char PROGRAM_STRING_ESCAPE_CHAR = '\\';
	private static final char[] PROGRAM_STRING_TARGET_CHARS = {'\0', '\u0007', '\b', '\t', '\n', '\u000B', '\f', '\r', '\"', '\''};
	private static final char[] PROGRAM_STRING_ESCAPED_CHARS = {'0', 'a', 'b', 't', 'n', 'v', 'f', 'r', '\"', '\''};

	private static final int DATE_MAX_LENGTH = 50;
	
	private static final Pattern DATE_ISO8601_ORDINAL_PATTERN = Pattern.compile("^[0-9]{4}-[0-9]{3}$");
	private static final String DATE_ISO8601_ORDINAL_PARSE_PATTERN = "yyyy-DDD";
	
	private static final String[] DATE_PARSE_PATTERNS = {
		"EEE MMM dd HH:mm:ss z yyyy",
		"EEE MMM dd HH:mm:ss yyyy",
		"EEE MMM dd HH:mm z yyyy",
		"EEE MMM dd HH:mm yyyy",
		"MMM dd HH:mm:ss z yyyy",
		"MMM dd HH:mm:ss yyyy",
		"MMM dd HH:mm z yyyy",
		"MMM dd HH:mm yyyy",
		"EEE, dd MMM yyyy HH:mm:ss zzz",
		"EEE, dd MMM yyyy HH:mm zzz",
		"EEE, dd MMM yyyy HH:mm:ss",
		"EEE, dd MMM yyyy HH:mm",
		"dd MMM yyyy HH:mm:ss zzz",
		"dd MMM yyyy HH:mm zzz",
		"dd MMM yyyy HH:mm:ss",
		"dd MMM yyyy HH:mm",
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
		"YYYY-'W'ww-u'T'HH:mm:ss.SSSXXX",
		"YYYY-'W'ww-u'T'HH:mm:ss,SSSXXX",
		"YYYY-'W'ww-u'T'HH:mm:ssXXX",
		"YYYY-'W'ww-u'T'HH:mmXXX",
		"YYYY-'W'ww-u'T'HHXXX",
		"YYYY-'W'ww-u'T'HH:mm:ss.SSSZ",
		"YYYY-'W'ww-u'T'HH:mm:ss,SSSZ",
		"YYYY-'W'ww-u'T'HH:mm:ssZ",
		"YYYY-'W'ww-u'T'HH:mmZ",
		"YYYY-'W'ww-u'T'HHZ",
		"YYYY-'W'ww-u'T'HH:mm:ss.SSS",
		"YYYY-'W'ww-u'T'HH:mm:ss,SSS",
		"YYYY-'W'ww-u'T'HH:mm:ss",
		"YYYY-'W'ww-u'T'HH:mm",
		"YYYY-'W'ww-u'T'HH",
		"yyyy-DDD'T'HH:mm:ss.SSSXXX",
		"yyyy-DDD'T'HH:mm:ss,SSSXXX",
		"yyyy-DDD'T'HH:mm:ssXXX",
		"yyyy-DDD'T'HH:mmXXX",
		"yyyy-DDD'T'HHXXX",
		"yyyy-DDD'T'HH:mm:ss.SSSZ",
		"yyyy-DDD'T'HH:mm:ss,SSSZ",
		"yyyy-DDD'T'HH:mm:ssZ",
		"yyyy-DDD'T'HH:mmZ",
		"yyyy-DDD'T'HHZ",
		"yyyy-DDD'T'HH:mm:ss.SSS",
		"yyyy-DDD'T'HH:mm:ss,SSS",
		"yyyy-DDD'T'HH:mm:ss",
		"yyyy-DDD'T'HH:mm",
		"yyyy-DDD'T'HH",
		"yyyyMMdd'T'HHmmssSSSXXX",
		"yyyyMMdd'T'HHmmssXXX",
		"yyyyMMdd'T'HHmmXXX",
		"yyyyMMdd'T'HHXXX",
		"yyyyMMdd'T'HHmmssSSSZ",
		"yyyyMMdd'T'HHmmssZ",
		"yyyyMMdd'T'HHmmZ",
		"yyyyMMdd'T'HHZ",
		"yyyyMMdd'T'HHmmssSSS",
		"yyyyMMdd'T'HHmmss",
		"yyyyMMdd'T'HHmm",
		"yyyyMMdd'T'HH",
		"YYYY'W'wwu'T'HHmmssSSSXXX",
		"YYYY'W'wwu'T'HHmmssXXX",
		"YYYY'W'wwu'T'HHmmXXX",
		"YYYY'W'wwu'T'HHXXX",
		"YYYY'W'wwu'T'HHmmssSSSZ",
		"YYYY'W'wwu'T'HHmmssZ",
		"YYYY'W'wwu'T'HHmmZ",
		"YYYY'W'wwu'T'HHZ",
		"YYYY'W'wwu'T'HHmmssSSS",
		"YYYY'W'wwu'T'HHmmss",
		"YYYY'W'wwu'T'HHmm",
		"YYYY'W'wwu'T'HH",
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
		"yyyy年MM月dd日HH時mm分ss.SSS秒 Z",
		"yyyy年MM月dd日HH時mm分ss秒 Z",
		"yyyy年MM月dd日HH時mm分 Z",
		"yyyy年MM月dd日HH時 Z",
		"yyyy年MM月dd日HH時mm分ss.SSS秒",
		"yyyy年MM月dd日HH時mm分ss秒",
		"yyyy年MM月dd日HH時mm分",
		"yyyy年MM月dd日HH時",
		"EEE, MMM dd, yyyy",
		"EEE, MMM dd yyyy",
		"EEE MMM dd, yyyy",
		"EEE MMM dd yyyy",
		"MMM dd, yyyy",
		"MMM dd yyyy",
		"MMM-dd-yyyy",
		"EEE, dd MMM, yyyy",
		"EEE, dd MMM yyyy",
		"EEE dd MMM, yyyy",
		"EEE dd MMM yyyy",
		"dd MMM, yyyy",
		"dd MMM yyyy",
		"dd-MMM-yyyy",
		"MMM, yyyy",
		"MMM yyyy",
		"MMM-yyyy",
		"yyyy-MMM-dd",
		"yyyy-MM-dd",
		"yyyy-MM",
		"yyyy/MM/dd",
		"yyyy/MM",
		"yyyy.MM.dd",
		"yyyy.MM",
		"YYYY-'W'ww-u",
		"YYYY'W'wwu",
		"yyyy年MM月dd日",
		"yyyy年MM月",
		"yyyy年",
		"hh:mm:ss.SSS a, XXX",
		"hh:mm:ss,SSS a, XXX",
		"hh:mm:ss a, XXX",
		"hh:mm a, XXX",
		"hh a, XXX",
		"hh:mm:ss.SSS a, Z",
		"hh:mm:ss,SSS a, Z",
		"hh:mm:ss a, Z",
		"hh:mm a, Z",
		"hh a, Z",
		"hh:mm:ss.SSS a",
		"hh:mm:ss,SSS a",
		"hh:mm:ss a",
		"hh:mm a",
		"hh:mm:ss.SSSa, XXX",
		"hh:mm:ss,SSSa, XXX",
		"hh:mm:ssa, XXX",
		"hh:mma, XXX",
		"hha, XXX",
		"hh:mm:ss.SSSa, Z",
		"hh:mm:ss,SSSa, Z",
		"hh:mm:ssa, Z",
		"hh:mma, Z",
		"hha, Z",
		"hh:mm:ss.SSSa",
		"hh:mm:ss,SSSa",
		"hh:mm:ssa",
		"hh:mma",
		"hha",
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
		"HH時mm分ss秒",
		"HH時mm分",
		"HH時",
	};
	
	private static final String[] DATE_PARSE_PATTERNS_JP = {
		"GGGGy年MM月dd日HH時mm分ss.SSS秒 Z",
		"GGGGy年MM月dd日HH時mm分ss秒 Z",
		"GGGGy年MM月dd日HH時mm分 Z",
		"GGGGy年MM月dd日HH時 Z",
		"GGGGy年MM月dd日HH時mm分ss.SSS秒",
		"GGGGy年MM月dd日HH時mm分ss秒",
		"GGGGy年MM月dd日HH時mm分",
		"GGGGy年MM月dd日HH時",
		"GGGGy年MM月dd日",
		"GGGGy年MM月",
		"GGGGy年",
	};
	
	private static final Locale LOCALE_JP = Locale.forLanguageTag("ja-JP-u-ca-japanese");
	
	private static final int COLOR_MAX_LENGTH = 50;
	
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
		String oe = CommonLogic.mapShortCharsetName(reqres().param("oe", "UTF-8"));
		String nl = reqres().param("nl", "crlf");
		String tz = reqres().param("tz", "UTC");
		
		String encStrBinSeparatorEach = reqres().param("encStrBinSeparatorEach", "");
		String encStrHexSeparatorEach = reqres().param("encStrHexSeparatorEach", "");
		String encStrHexCase = reqres().param("encStrHexCase", "lower");
		String encStrBase64LineBreakEach = reqres().param("encStrBase64LineBreakEach", "");
		String encStrUnicodeEscapeSurrogatePairFormat = reqres().param("encStrUnicodeEscapeSurrogatePairFormat", "");
		int encCipherCaesarShift = reqres().paramAsInt("encCipherCaesarShift", 0);
		int decCipherCaesarShift = reqres().paramAsInt("decCipherCaesarShift", 0);
		int encCipherScytaleKey = reqres().paramAsInt("encCipherScytaleKey", 2);
		int decCipherScytaleKey = reqres().paramAsInt("decCipherScytaleKey", 2);
		int encCipherRailFenceKey = reqres().paramAsInt("encCipherRailFenceKey", 2);
		int decCipherRailFenceKey = reqres().paramAsInt("decCipherRailFenceKey", 2);
		
		String[] valLines = StringUtilz.split(val, new String[] {"\r\n", "\r", "\n"});
		
		String lineBreak;
		int textLengthDiff = 0;
		if (nl.equals("lf")) {
			lineBreak = "\n";
		} else if (nl.equals("cr")) {
			lineBreak = "\r";
		} else {
			// crlf
			lineBreak = "\r\n";
			textLengthDiff = (valLines.length == 0) ? 0 : -(valLines.length - 1);
		}
		if (1 < valLines.length) {
			val = StringUtilz.join(lineBreak, (Object[])valLines);
		}
		
		TimeZone timeZone = TimeZone.getTimeZone(tz);
		
		Charset charset = Charset.forName(toCharsetName(oe));
		
		byte[] binValue = val.getBytes(charset);
		
		DencodeModel dencode = new DencodeModel();
		dencode.setTextLength(getTextLength(val) + textLengthDiff);
		dencode.setTextByteLength(binValue.length);
		if (type.equals("all") || type.equals("string")) {
			boolean all = (method.equals("all") || method.equals("string.all"));
			
			if (all || method.equals("string.bin")) dencode.setEncStrBin(encStrBin(binValue, encStrBinSeparatorEach));
			if (all || method.equals("string.hex")) dencode.setEncStrHex(encStrHex(binValue, encStrHexSeparatorEach, encStrHexCase));
			if (all || method.equals("string.html-escape")) dencode.setEncStrHTMLEscape(encStrHTMLEscape(val));
			if (all || method.equals("string.html-escape")) dencode.setEncStrHTMLEscapeFully(encStrHTMLEscapeFully(val));
			if (all || method.equals("string.url-encoding")) dencode.setEncStrURLEncoding(encStrURLEncoding(binValue));
			if (all || method.equals("string.punycode")) dencode.setEncStrPunycode(encStrPunycode(valLines));
			if (all || method.equals("string.base32")) dencode.setEncStrBase32Encoding(encStrBase32Encoding(binValue));
			if (all || method.equals("string.base64")) dencode.setEncStrBase64Encoding(encStrBase64Encoding(binValue, encStrBase64LineBreakEach));
			if (all || method.equals("string.quoted-printable")) dencode.setEncStrQuotedPrintable(encStrQuotedPrintable(binValue));
			if (all || method.equals("string.unicode-escape")) dencode.setEncStrUnicodeEscape(encStrUnicodeEscape(val, encStrUnicodeEscapeSurrogatePairFormat));
			if (all || method.equals("string.program-string")) dencode.setEncStrProgramString(encStrProgramString(val));
			if (all || method.equals("string.character-width")) dencode.setEncStrHalfWidth(encStrHalfWidth(val));
			if (all || method.equals("string.character-width")) dencode.setEncStrFullWidth(encStrFullWidth(val));
			if (all || method.equals("string.letter-case")) dencode.setEncStrUpperCase(encStrUpperCase(val));
			if (all || method.equals("string.letter-case")) dencode.setEncStrLowerCase(encStrLowerCase(val));
			if (all || method.equals("string.letter-case")) dencode.setEncStrSwapCase(encStrSwapCase(val));
			if (all || method.equals("string.letter-case")) dencode.setEncStrCapitalize(encStrCapitalize(val));
			if (all || method.equals("string.text-initials")) dencode.setEncStrInitials(encStrInitials(val));
			if (all || method.equals("string.text-reverse")) dencode.setEncStrReverse(encStrReverse(val));
			if (all || method.equals("string.naming-convention") || method.equals("string.camel-case")) dencode.setEncStrUpperCamelCase(encStrCamelCase(val, true));
			if (all || method.equals("string.naming-convention") || method.equals("string.camel-case")) dencode.setEncStrLowerCamelCase(encStrCamelCase(val, false));
			if (all || method.equals("string.naming-convention") || method.equals("string.snake-case")) dencode.setEncStrUpperSnakeCase(encStrSnakeCase(val, true));
			if (all || method.equals("string.naming-convention") || method.equals("string.snake-case")) dencode.setEncStrLowerSnakeCase(encStrSnakeCase(val, false));
			if (all || method.equals("string.naming-convention") || method.equals("string.kebab-case")) dencode.setEncStrUpperKebabCase(encStrKebabCase(val, true));
			if (all || method.equals("string.naming-convention") || method.equals("string.kebab-case")) dencode.setEncStrLowerKebabCase(encStrKebabCase(val, false));
			if (all || method.equals("string.unicode-normalization")) dencode.setEncStrUnicodeNFC(encStrUnicodeNFC(val));
			if (all || method.equals("string.unicode-normalization")) dencode.setEncStrUnicodeNFKC(encStrUnicodeNFKC(val));
			if (all || method.equals("string.line-sort")) dencode.setEncStrLineSortAsc(encStrLineSortAsc(valLines, lineBreak));
			if (all || method.equals("string.line-sort")) dencode.setEncStrLineSortDesc(encStrLineSortDesc(valLines, lineBreak));
			if (all || method.equals("string.line-sort")) dencode.setEncStrLineSortReverse(encStrLineSortReverse(valLines, lineBreak));
			if (all || method.equals("string.line-unique")) dencode.setEncStrLineUnique(encStrLineUnique(valLines, lineBreak));
			
			if (all || method.equals("string.bin")) dencode.setDecStrBin(decStrBin(val, charset));
			if (all || method.equals("string.hex")) dencode.setDecStrHex(decStrHex(val, charset));
			if (all || method.equals("string.html-escape")) dencode.setDecStrHTMLEscape(decStrHTMLEscape(val));
			if (all || method.equals("string.url-encoding")) dencode.setDecStrURLEncoding(decStrURLEncoding(val, charset));
			if (all || method.equals("string.punycode")) dencode.setDecStrPunycode(decStrPunycode(valLines));
			if (all || method.equals("string.base32")) dencode.setDecStrBase32Encoding(decStrBase32Encoding(val, charset));
			if (all || method.equals("string.base64")) dencode.setDecStrBase64Encoding(decStrBase64Encoding(val, charset));
			if (all || method.equals("string.quoted-printable")) dencode.setDecStrQuotedPrintable(decStrQuotedPrintable(val, charset));
			if (all || method.equals("string.unicode-escape")) dencode.setDecStrUnicodeEscape(decStrUnicodeEscape(val));
			if (all || method.equals("string.program-string")) dencode.setDecStrProgramString(decStrProgramString(val));
			if (all || method.equals("string.unicode-normalization")) dencode.setDecStrUnicodeNFC(decStrUnicodeNFC(val));
			if (all || method.equals("string.unicode-normalization")) dencode.setDecStrUnicodeNFKC(decStrUnicodeNFKC(val));
		}
		if (type.equals("all") || type.equals("number")) {
			boolean all = (method.equals("all") || method.equals("number.all"));
			
			BigDecimal bigDec = parseNumDec(val);
			
			if (all || method.equals("number.bin")) dencode.setEncNumBin(encNumBin(val));
			if (all || method.equals("number.oct")) dencode.setEncNumOct(encNumOct(val));
			if (all || method.equals("number.hex")) dencode.setEncNumHex(encNumHex(val));
			if (all || method.equals("number.english")) dencode.setEncNumEnShortScale(encNumEnShortScale(bigDec, false));
			if (all || method.equals("number.english")) dencode.setEncNumEnShortScaleFraction(encNumEnShortScale(bigDec, true));
			if (all || method.equals("number.japanese")) dencode.setEncNumJP(encNumJP(bigDec));
			if (all || method.equals("number.japanese")) dencode.setEncNumJPDaiji(encNumJPDaiji(bigDec));
			
			if (all || method.equals("number.bin")) dencode.setDecNumBin(decNumBin(val));
			if (all || method.equals("number.oct")) dencode.setDecNumOct(decNumOct(val));
			if (all || method.equals("number.hex")) dencode.setDecNumHex(decNumHex(val));
			if (all || method.equals("number.english")) dencode.setDecNumEnShortScale(decNumEnShortScale(val));
			if (all || method.equals("number.japanese")) dencode.setDecNumJP(decNumJP(val));
		}
		if (type.equals("all") || type.equals("date")) {
			boolean all = (method.equals("all") || method.equals("date.all"));
			
			Date dateVal = parseDate(val, timeZone);
			
			if (all || method.equals("date.unix-time")) dencode.setEncDateUnixTime(encDateUnixTime(dateVal, timeZone));
			if (all || method.equals("date.w3cdtf")) dencode.setEncDateW3CDTF(encDateW3CDTF(dateVal, timeZone));
			if (all || method.equals("date.iso8601")) dencode.setEncDateISO8601(encDateISO8601Basic(dateVal, timeZone));
			if (all || method.equals("date.iso8601")) dencode.setEncDateISO8601Ext(encDateISO8601Ext(dateVal, timeZone));
			if (all || method.equals("date.iso8601")) dencode.setEncDateISO8601Week(encDateISO8601Week(dateVal, timeZone));
			if (all || method.equals("date.iso8601")) dencode.setEncDateISO8601Ordinal(encDateISO8601Ordinal(dateVal, timeZone));
			if (all || method.equals("date.rfc2822")) dencode.setEncDateRFC2822(encDateRFC2822(dateVal, timeZone));
			if (all || method.equals("date.ctime")) dencode.setEncDateCTime(encDateCTime(dateVal, timeZone));
			if (all || method.equals("date.japanese-era")) dencode.setEncDateJapaneseEra(encDateJapaneseEra(dateVal, timeZone));
		}
		if (type.equals("all") || type.equals("color")) {
			boolean all = (method.equals("all") || method.equals("color.all"));
			
			RGBColor rgb = parseColor(val);
			
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
		if (type.equals("all") || type.equals("cipher")) {
			boolean all = (method.equals("all") || method.equals("cipher.all"));

			String valLf = StringUtilz.join("\n", (Object[])valLines);
			
			if (all || method.equals("cipher.caesar")) dencode.setEncCipherCaesar(encCipherCaesar(val, encCipherCaesarShift));
			if (all || method.equals("cipher.rot13")) dencode.setEncCipherROT13(dencCipherROT13(val));
			if (all || method.equals("cipher.rot18")) dencode.setEncCipherROT18(dencCipherROT18(val));
			if (all || method.equals("cipher.rot47")) dencode.setEncCipherROT47(dencCipherROT47(val));
			if (all || method.equals("cipher.scytale")) dencode.setEncCipherScytale(encCipherScytale(valLf, encCipherScytaleKey));
			if (all || method.equals("cipher.rail-fence")) dencode.setEncCipherRailFence(encCipherRailFence(valLf, encCipherRailFenceKey));
			
			if (all || method.equals("cipher.caesar")) dencode.setDecCipherCaesar(decCipherCaesar(val, decCipherCaesarShift));
			if (all || method.equals("cipher.rot13")) dencode.setDecCipherROT13(dencode.getEncCipherROT13());
			if (all || method.equals("cipher.rot18")) dencode.setDecCipherROT18(dencode.getEncCipherROT18());
			if (all || method.equals("cipher.rot47")) dencode.setDecCipherROT47(dencode.getEncCipherROT47());
			if (all || method.equals("cipher.scytale")) dencode.setDecCipherScytale(decCipherScytale(valLf, decCipherScytaleKey));
			if (all || method.equals("cipher.rail-fence")) dencode.setDecCipherRailFence(decCipherRailFence(valLf, decCipherRailFenceKey));
		}
		if (type.equals("all") || type.equals("hash")) {
			boolean all = (method.equals("all") || method.equals("hash.all"));
			
			if (all || method.equals("hash.md2")) dencode.setEncHashMD2(hash(binValue, "MD2"));
			if (all || method.equals("hash.md5")) dencode.setEncHashMD5(hash(binValue, "MD5"));
			if (all || method.equals("hash.sha1")) dencode.setEncHashSHA1(hash(binValue, "SHA-1"));
			if (all || method.equals("hash.sha256")) dencode.setEncHashSHA256(hash(binValue, "SHA-256"));
			if (all || method.equals("hash.sha384")) dencode.setEncHashSHA384(hash(binValue, "SHA-384"));
			if (all || method.equals("hash.sha512")) dencode.setEncHashSHA512(hash(binValue, "SHA-512"));
			if (all || method.equals("hash.crc32")) dencode.setEncHashCRC32(encHashCRC32(binValue));
		}
		
		responseAsJson(dencode);
	}

	private static String toCharsetName(String oe) {
		if (oe == null || oe.isEmpty()) {
			return "UTF-8";
		}
		
		switch (oe) {
			case "Shift_JIS": return "windows-31j";
			case "windows-874": return "x-windows-874";
		}
		
		if (!Charset.isSupported(oe)) {
			return "UTF-8";
		}
		
		return oe;
	}

	private static int getTextLength(String val) {
		if (val == null || val.isEmpty()) {
			return 0;
		}

		return val.codePointCount(0, val.length());
	}
	
	private static String encStrHTMLEscape(String val) {
		return HTMLUtilz.escapeBasicHTML(val);
	}
	
	private static String encStrHTMLEscapeFully(String val) {
		return HTMLUtilz.escapeHTML5Fully(val);
	}
	
	private static String encStrURLEncoding(byte[] binValue) {
		URLCodec urlCodec = new URLCodec();
		String encodedURL = new String(urlCodec.encode(binValue), StandardCharsets.US_ASCII);
		if (encodedURL.indexOf('+') != -1) {
			encodedURL = encodedURL.replace("+", "%20");
		}
		return encodedURL;
	}
	
	private static String encStrPunycode(String[] vals) {
		try {
			String[] decVals = new String[vals.length];
			for (int i = 0; i < vals.length; i++) {
				decVals[i] = IDN.toASCII(vals[i], IDN.ALLOW_UNASSIGNED);
			}
			return StringUtilz.join("\r\n", (Object[])decVals);
		} catch (IllegalArgumentException e) {
			return null;
		}
	}
	
	private static String encStrBase32Encoding(byte[] binValue) {
		Base32 base32 = new Base32();
		return base32.encodeAsString(binValue);
	}
	
	private static String encStrBase64Encoding(byte[] binValue, String encStrBase64LineBreakEach) {
		int lineLength = 0;
		if (encStrBase64LineBreakEach != null && !encStrBase64LineBreakEach.isEmpty()) {
			try {
				lineLength = Integer.parseInt(encStrBase64LineBreakEach);
			} catch (NumberFormatException e) {
				// NOP
			}
		}
		
		Base64 base64 = new Base64(lineLength);
		return base64.encodeAsString(binValue);
	}
	
	private static String encStrQuotedPrintable(byte[] binValue) {
		boolean strict = (3 <= binValue.length);
		QuotedPrintableCodec quotedPrintableCodec = new QuotedPrintableCodec(strict);
		return new String(quotedPrintableCodec.encode(binValue), StandardCharsets.US_ASCII);
	}
	
	private static String encStrProgramString(String val) {
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
	
	private static String toUnicodeEscapeSpPattern(String spFormat) {
		switch (spFormat) {
			case "ubcp": return "\\u{%x}"; // for Swift, JS(ES6+), PHP, Ruby
			case "Ucp": return "\\U%08x"; // for C, Python
			default: return null; // for Java, JS(ES5)
		}
	}
	
	private static String encStrUnicodeEscape(String val, String spFormatType) {
		if (val == null) {
			return null;
		}
		
		String spPattern = toUnicodeEscapeSpPattern(spFormatType);
		
		boolean supportSurrogatePair = (spPattern != null && !spPattern.isEmpty());
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len * 6);
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (supportSurrogatePair && Character.isHighSurrogate(ch) && (i + 1 != len)) {
				// Surrogate Pair
				
				char lowCh = val.charAt(++i);
				
				int codePoint = Character.toCodePoint(ch, lowCh);
				
				sb.append(String.format(spPattern, codePoint));
			} else {
				String chHexStr = Integer.toHexString((int)ch);
				
				sb.append("\\u");
				StringUtilz.paddingLeft(sb, chHexStr, 4, '0');
			}
		}
		
		return sb.toString();
	}
	
	private static String encStrBin(byte[] binValue, String separatorEach) {
		return toBinString(binValue, separatorEach);
	}
	
	private static String encStrHex(byte[] binValue, String separatorEach, String hexCase) {
		return toHexString(binValue, separatorEach, hexCase.equals("upper"));
	}
	
	private static String encStrHalfWidth(String val) {
		return StringUtilz.toHalfWidth(val, true, true, true, true, true, true);
	}
	
	private static String encStrFullWidth(String val) {
		return StringUtilz.toFullWidth(val, true, true, true, true, true, true);
	}
	
	private static String encStrUpperCase(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		return val.toUpperCase(Locale.US);
	}
	
	private static String encStrLowerCase(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		return val.toLowerCase(Locale.US);
	}
	
	private static String encStrSwapCase(String val) {
		return StringUtilz.swapCase(val);
	}
	
	private static String encStrCapitalize(String val) {
		return StringUtilz.capitalize(val, true);
	}
	
	private static String encStrInitials(String val) {
		return StringUtilz.initials(val);
	}
	
	private static String encStrReverse(String val) {
		if (val == null || val.length() <= 1) {
			return val;
		}
		
		return new StringBuilder(val).reverse().toString();
	}
	
	private static String encStrCamelCase(String val, boolean firstCapital) {
		return StringUtilz.toCamelCase(val, firstCapital);
	}
	
	private static String encStrSnakeCase(String val, boolean upper) {
		return StringUtilz.toSnakeCase(val, false, Boolean.valueOf(upper));
	}
	
	private static String encStrKebabCase(String val, boolean upper) {
		return StringUtilz.toChainCase(val, false, Boolean.valueOf(upper));
	}
	
	private static String encStrUnicodeNFC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFC);
	}
	
	private static String encStrUnicodeNFKC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFKC);
	}
	
	private static String encStrLineSortAsc(String[] varLines, String lineBreak) {
		String[] lines = Arrays.copyOf(varLines, varLines.length);
		
		Arrays.sort(lines, new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o1.compareTo(o2);
			}
		});
		
		return StringUtilz.join(lineBreak, (Object[])lines);
	}
	
	private static String encStrLineSortDesc(String[] varLines, String lineBreak) {
		String[] lines = Arrays.copyOf(varLines, varLines.length);
		
		Arrays.sort(lines, new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o2.compareTo(o1);
			}
		});
		
		return StringUtilz.join(lineBreak, (Object[])lines);
	}
	
	private static String encStrLineSortReverse(String[] varLines, String lineBreak) {
		String[] lines = Arrays.copyOf(varLines, varLines.length);
		
		List<String> lineList = Arrays.asList(lines);
		Collections.reverse(lineList);
		
		return StringUtilz.join(lineBreak, lineList);
	}
	
	private static String encStrLineUnique(String[] varLines, String lineBreak) {
		Object[] objLines = Arrays.stream(varLines).distinct().toArray();
		
		return StringUtilz.join(lineBreak, objLines);
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
				BigDecimal bigDec = parseNumDec(vals[i]);
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
	
	private static String encNumEnShortScale(BigDecimal bigDec, boolean fractionDec) {
		if (bigDec == null) {
			return null;
		}
		
		try {
			return NumberUtilz.toEnNumShortScale(bigDec, fractionDec);
		} catch (NumberParseException e) {
			return null;
		}
	}
	
	private static String encNumJP(BigDecimal bigDec) {
		if (bigDec == null) {
			return null;
		}
		
		try {
			return NumberUtilz.toJPNum(bigDec, false, false, false);
		} catch (NumberParseException e) {
			return null;
		}
	}
	
	private static String encNumJPDaiji(BigDecimal bigDec) {
		if (bigDec == null) {
			return null;
		}
		
		try {
			return NumberUtilz.toJPNum(bigDec, true, true, false);
		} catch (NumberParseException e) {
			return null;
		}
	}
	
	private static BigDecimal parseNumDec(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		val = StringUtilz.toHalfWidth(val, true, true, true, true, false, false);
		val = val.replace(",", "");
		try {
			// Standard Format
			return new BigDecimal(val);
		} catch (NumberFormatException e) {
			BigDecimal enNum;
			try {
				// English Format
				enNum = NumberUtilz.parseEnNumShortScale(val);
			} catch (NumberParseException e1) {
				enNum = null;
			}
			
			if (enNum != null) {
				return enNum;
			}
			
			// Japanese Format
			try {
				return NumberUtilz.parseJPNum(val);
			} catch (NumberParseException e1) {
				return null;
			}
		}
	}

	private static String encDateUnixTime(Date dateVal, TimeZone timeZone) {
		if (dateVal == null) {
			return null;
		}
		
		return String.valueOf(dateVal.getTime());
	}

	private static String encDateW3CDTF(Date dateVal, TimeZone timeZone) {
		return encDateISO8601(dateVal, "yyyy-MM-dd'T'HH:mm:ssXXX", "yyyy-MM-dd'T'HH:mm:ss.SSSXXX", timeZone);
	}

	private static String encDateISO8601Basic(Date dateVal, TimeZone timeZone) {
		return encDateISO8601(dateVal, "yyyyMMdd'T'HHmmssXX", "yyyyMMdd'T'HHmmss,SSSXX", timeZone);
	}

	private static String encDateISO8601Ext(Date dateVal, TimeZone timeZone) {
		return encDateISO8601(dateVal, "yyyy-MM-dd'T'HH:mm:ssXXX", "yyyy-MM-dd'T'HH:mm:ss,SSSXXX", timeZone);
	}

	private static String encDateISO8601Week(Date dateVal, TimeZone timeZone) {
		return encDateISO8601(dateVal, "YYYY-'W'ww-u'T'HH:mm:ssXXX", "YYYY-'W'ww-u'T'HH:mm:ss,SSSXXX", timeZone);
	}

	private static String encDateISO8601Ordinal(Date dateVal, TimeZone timeZone) {
		return encDateISO8601(dateVal, "yyyy-DDD'T'HH:mm:ssXXX", "yyyy-DDD'T'HH:mm:ss,SSSXXX", timeZone);
	}

	private static String encDateISO8601(Date dateVal, String pattern, String patternWithMsec, TimeZone timeZone) {
		if (dateVal == null) {
			return null;
		}
		
		long time = dateVal.getTime();
		long millisOfSec = time - ((time / 1000) * 1000);
		
		String formatPattern = (millisOfSec == 0) ? pattern : patternWithMsec;
		
		Calendar calendar = Calendar.getInstance(timeZone);
		calendar.setMinimalDaysInFirstWeek(4);
		calendar.setFirstDayOfWeek(Calendar.MONDAY);
		
		DateFormat dateFormat = new SimpleDateFormat(formatPattern, Locale.US);
		dateFormat.setCalendar(calendar);
		
		return dateFormat.format(dateVal);
	}

	private static String encDateRFC2822(Date dateVal, TimeZone timeZone) {
		if (dateVal == null) {
			return null;
		}
		
		if (timeZone.getID().equals("UTC")) {
			timeZone = TimeZone.getTimeZone("GMT");
		}
		DateFormat dateFormat = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.US);
		dateFormat.setTimeZone(timeZone);
		return dateFormat.format(dateVal);
	}

	private static String encDateCTime(Date dateVal, TimeZone timeZone) {
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

	private static String encDateJapaneseEra(Date dateVal, TimeZone timeZone) {
		if (dateVal == null) {
			return null;
		}
		
		long time = dateVal.getTime();
		long millisOfSec = time - ((time / 1000) * 1000);
		
		String formatPattern = (millisOfSec == 0) ? "GGGGy年MM月dd日HH時mm分ss秒 z" : "GGGGy年MM月dd日HH時mm分ss.SSS秒 z";
		
		DateFormat dateFormat = new SimpleDateFormat(formatPattern, LOCALE_JP);
		dateFormat.setTimeZone(timeZone);
		return dateFormat.format(dateVal).replaceAll("([^0-9])1年", "$1元年");
	}
	
	private static Date parseDate(String val, TimeZone timeZone) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		if (DATE_MAX_LENGTH < val.length()) {
			return null;
		}
		
		if (val.equalsIgnoreCase("now")) {
			return new Date();
		}
		
		val = StringUtilz.toHalfWidth(val, true, true, true, true, false, false);
		try {
			return new Date(Long.parseLong(val));
		} catch (NumberFormatException e) {
			Calendar calendar = Calendar.getInstance(timeZone);
			calendar.setMinimalDaysInFirstWeek(4);
			calendar.setFirstDayOfWeek(Calendar.MONDAY);
			calendar.setLenient(false);
			
			Date date = null;
			
			if (DATE_ISO8601_ORDINAL_PATTERN.matcher(val).matches()) {
				date = DateUtilz.parseDate(val, calendar, Locale.US, DATE_ISO8601_ORDINAL_PARSE_PATTERN);
			}
			if (date == null) {
				date = DateUtilz.parseDate(val, calendar, Locale.US, DATE_PARSE_PATTERNS);
				if (date == null) {
					date = DateUtilz.parseDate(val, true, timeZone, LOCALE_JP, DATE_PARSE_PATTERNS_JP);
				}
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
		
		if (COLOR_MAX_LENGTH < val.length()) {
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
	
	private static String encCipherCaesar(String val, int shift) {
		return dencCipherCaesar(val, shift);
	}
	
	private static String decCipherCaesar(String val, int shift) {
		return dencCipherCaesar(val, -shift);
	}
	
	private static String dencCipherCaesar(String val, int shift) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		if (shift == 0) {
			return val;
		}
		
		shift = shift % 26;
		if (shift < 0) {
			shift += 26;
		}
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if ('A' <= ch && ch <= 'Z') {
				ch = (char)((ch - 'A' + shift) % 26 + 'A');
			} else if ('a' <= ch && ch <= 'z') {
				ch = (char)((ch - 'a' + shift) % 26 + 'a');
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
	
	private static String dencCipherROT13(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (('A' <= ch && ch <= 'M') || ('a' <= ch && ch <= 'm')) {
				ch += 13;
			} else if (('N' <= ch && ch <= 'Z') || ('n' <= ch && ch <= 'z')) {
				ch -= 13;
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
	
	private static String dencCipherROT18(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (('A' <= ch && ch <= 'M') || ('a' <= ch && ch <= 'm')) {
				ch += 13;
			} else if (('N' <= ch && ch <= 'Z') || ('n' <= ch && ch <= 'z')) {
				ch -= 13;
			} else if ('0' <= ch && ch <= '4') {
				ch += 5;
			} else if ('5' <= ch && ch <= '9') {
				ch -= 5;
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
	
	private static String dencCipherROT47(String val) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int len = val.length();
		
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if ('!' <= ch && ch <= '~') {
				ch = (char)((ch - '!' + 47) % 94 + '!');
			}
			
			sb.append(ch);
		}
		
		return sb.toString();
	}
	
	private static String encCipherScytale(String val, int key) {
		if (val == null || val.length() <= key) {
			return val;
		}
		
		StringBuilder sb = new StringBuilder(val.length());
		
		int[] cps = val.codePoints().toArray();
		int len = cps.length;
		int maxX = key;
		for (int x = 0; x < maxX; x++) {
			for (int idx = x; idx < len; idx = idx + maxX) {
				int cp = cps[idx];
				sb.appendCodePoint(cp);
			}
		}
		
		return sb.toString();
	}
	
	private static String encCipherRailFence(String val, int key) {
		if (val == null || val.length() <= key) {
			return val;
		}
		
		StringBuilder sb = new StringBuilder(val.length());
		
		int[] cps = val.codePoints().toArray();
		int len = cps.length;
		int maxY = key;
		int cycleX = maxY * 2 - 2;
		
		for (int yi = 0; yi < maxY; yi++) {
			for (int xi = yi; xi < len; xi += cycleX) {
				sb.appendCodePoint(cps[xi]);
				
				if (yi != 0 && (yi + 1) != maxY) {
					int nxi = xi + (cycleX - (2 * yi));
					if (nxi < len) {
						sb.appendCodePoint(cps[nxi]);
					}
				}
			}
		}
		
		return sb.toString();
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
	
	private static String encHashCRC32(byte[] binValue) {
		CRC32 crc = new CRC32();
		crc.update(binValue, 0, binValue.length);
		return Long.toHexString(crc.getValue());
	}
	
	
	private static String decStrBin(String val, Charset charset) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		val = val.replaceAll("\\s", "");
		
		try {
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
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	private static String decStrHex(String val, Charset charset) {
		if (val == null || val.isEmpty()) {
			return null;
		}

		val = val.replaceAll("\\s", "");
		
		try {
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
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	private static String decStrHTMLEscape(String val) {
		return HTMLUtilz.unescapeHTML5(val);
	}
	
	private static String decStrURLEncoding(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		
		byte[] bin = val.getBytes(StandardCharsets.US_ASCII);
		
		URLCodec urlCodec = new URLCodec();
		try {
			byte[] decodedValue = urlCodec.decode(bin);
			return new String(decodedValue, charset);
		} catch (DecoderException e) {
			return null;
		}
	}
	
	private static String decStrPunycode(String[] vals) {
		String[] decVals = new String[vals.length];
		for (int i = 0; i < vals.length; i++) {
			decVals[i] = IDN.toUnicode(vals[i], IDN.ALLOW_UNASSIGNED);
		}
		return StringUtilz.join("\r\n", (Object[])decVals);
	}
	
	private static String decStrBase32Encoding(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		
		byte[] bin = val.getBytes(StandardCharsets.US_ASCII);
		
		Base32 base32 = new Base32();
		if (!base32.isInAlphabet(bin, true)) {
			return null;
		}
		
		try {
			byte[] decodedValue = base32.decode(bin);
			return new String(decodedValue, charset);
		} catch (IllegalArgumentException e) {
			return null;
		}
	}
	
	private static String decStrBase64Encoding(String val, Charset charset) {
		if (!StringUtilz.isASCII(val)) {
			return null;
		}
		
		if (val.contains("=?") && val.contains("?=")) {
			// RFC 2047
			
			val = RFC2047_SPACE.matcher(val).replaceAll("?==?");
			
			StringBuilder sb = new StringBuilder(val.length());
			
			Matcher m = RFC2047_BASE64.matcher(val);
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
				
				Base64 base64 = new Base64();
				try {
					byte[] decodedValue = base64.decode(v.getBytes(StandardCharsets.US_ASCII));
					v = new String(decodedValue, cs);
				} catch (IllegalArgumentException e) {
					return null;
				}
				
				m.appendReplacement(sb, v);
			} while (m.find());
			m.appendTail(sb);
			
			return sb.toString();
		} else {
			Base64 base64 = new Base64();
			try {
				byte[] decodedValue = base64.decode(val.getBytes(StandardCharsets.US_ASCII));
				return new String(decodedValue, charset);
			} catch (IllegalArgumentException e) {
				return null;
			}
		}
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
	
	private static String decStrUnicodeEscape(String val) {
		if (val == null) {
			return null;
		}
		
		try {
			return StringUtilz.unescape(
					val,
					'\\',
					null,
					null,
					true
					);
		} catch (Exception e) {
			return null;
		}
	}
	
	private static String decStrProgramString(String val) {
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
	
	private static String decStrUnicodeNFC(String val) {
		return Normalizer.normalize(val, Normalizer.Form.NFD);
	}
	
	private static String decStrUnicodeNFKC(String val) {
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
	
	private static String decNumEnShortScale(String val) {
		BigDecimal bigDec;
		try {
			bigDec = NumberUtilz.parseEnNumShortScale(val);
		} catch (NumberParseException e) {
			return null;
		}
		
		if (bigDec == null) {
			return null;
		}
		return bigDec.toPlainString();
	}
	
	private static String decNumJP(String val) {
		BigDecimal bigDec;
		try {
			bigDec = NumberUtilz.parseJPNum(val);
		} catch (NumberParseException e) {
			return null;
		}
		
		if (bigDec == null) {
			return null;
		}
		return bigDec.toPlainString();
	}
	
	private static String toBinString(byte[] binary, String separatorEach) {
		if (binary == null) {
			return null;
		}
		if (binary.length == 0) {
			return "";
		}
		
		int separatorEachBit = parseDataSizeAsBit(separatorEach);
		int separatorEachByte = (separatorEachBit + 7) / 8; // Round UP
		
		int len = binary.length;
		
		StringBuilder sb = new StringBuilder(len * 10);
		for (int i = 0; i < len; i++) {
			byte b = binary[i];
			
			if (i != 0 && 0 < separatorEachByte && (i % separatorEachByte) == 0) {
				sb.append(' ');
			}
			
			sb.append(((b & 0x80) == 0) ? '0' : '1');
			sb.append(((b & 0x40) == 0) ? '0' : '1');
			sb.append(((b & 0x20) == 0) ? '0' : '1');
			sb.append(((b & 0x10) == 0) ? '0' : '1');
			if (separatorEachBit == 4) {
				sb.append(' ');
			}
			sb.append(((b & 0x8) == 0) ? '0' : '1');
			sb.append(((b & 0x4) == 0) ? '0' : '1');
			sb.append(((b & 0x2) == 0) ? '0' : '1');
			sb.append(((b & 0x1) == 0) ? '0' : '1');
		}
		return sb.toString();
	}
	
	private static String toHexString(byte[] binary, String separatorEach, boolean upperCase) {
		if (binary == null) {
			return null;
		}
		if (binary.length == 0) {
			return "";
		}
		
		int separatorEachByte = parseDataSizeAsByte(separatorEach);
		
		int len = binary.length;
		
		char baseCharA = (upperCase) ? 'A' : 'a';
		
		StringBuilder sb = new StringBuilder(len * 3);
		for (int i = 0; i < len; i++) {
			byte b = binary[i];
			
			if (i != 0 && 0 < separatorEachByte && (i % separatorEachByte) == 0) {
				sb.append(' ');
			}
			int high = ((b >>> 4) & 0xF);
			int low = (b & 0xF);
			if (high < 10) {
				sb.append((char)('0' + high));
			} else {
				sb.append((char)(baseCharA + (high - 10)));
			}
			if (low < 10) {
				sb.append((char)('0' + low));
			} else {
				sb.append((char)(baseCharA + (low - 10)));
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
	
	private static int parseDataSizeAsBit(String size) {
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

	private static int parseDataSizeAsByte(String size) {
		int bit = parseDataSizeAsBit(size);
		return  (bit + 7) / 8; // Round UP
	}
	
	private static String decCipherScytale(String val, int key) {
		if (val == null || val.length() <= key) {
			return val;
		}
		
		StringBuilder sb = new StringBuilder(val.length());
		
		int[] cps = val.codePoints().toArray();
		int len = cps.length;
		int maxY = (int)Math.ceil(((double)len) / key);
		int maxX = Math.min(key, (int)Math.ceil(((double)len) / maxY));
		int minX = len % maxX;
		minX = (minX == 0) ? maxX : minX;
		for (int y = 1; y <= maxY; y++) {
			boolean isBottom = (y == maxY);
			
			for (int x = 1; x <= maxX; x++) {
				int offset = 0;
				if (minX < x) {
					if (isBottom) {
						break;
					}
					
					offset -= (x - minX - 1);
				}
				
				int idx = (maxY * (x - 1)) + y - 1 + offset;
				
				int cp = cps[idx];
				sb.appendCodePoint(cp);
			}
		}
		
		return sb.toString();
	}
	
	private static String decCipherRailFence(String val, int key) {
		if (val == null || val.length() <= key) {
			return val;
		}
		
		int[] cps = val.codePoints().toArray();
		int len = cps.length;
		int maxY = key;
		int cycleX = maxY * 2 - 2;
		int[] newCPs = new int[len];
		
		int idx = 0;
		for (int yi = 0; yi < maxY; yi++) {
			for (int xi = yi; xi < len; xi += cycleX) {
				newCPs[xi] = cps[idx++];
				
				if (yi != 0 && (yi + 1) != maxY) {
					int nxi = xi + (cycleX - (2 * yi));
					if (nxi < len) {
						newCPs[nxi] = cps[idx++];
					}
				}
			}
		}
		
		return new String(newCPs, 0, len);
	}
}
