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
package com.dencode.logic.parser;

import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;
import java.util.regex.Pattern;

import org.mifmi.commons4j.util.DateUtilz;
import org.mifmi.commons4j.util.StringUtilz;

public class DateParser {
	
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
	
	private DateParser() {
		// NOP
	}
	
	public static Date parseDate(String val, TimeZone timeZone) {
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
}
