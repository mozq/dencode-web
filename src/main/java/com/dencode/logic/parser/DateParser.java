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

import java.math.BigDecimal;
import java.time.DateTimeException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.time.MonthDay;
import java.time.OffsetDateTime;
import java.time.OffsetTime;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.chrono.JapaneseChronology;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoField;
import java.time.temporal.TemporalAccessor;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.mifmi.commons4j.util.DateUtilz;
import org.mifmi.commons4j.util.StringUtilz;

public class DateParser {
	
	private static final int DATE_MAX_LENGTH = 50;
	
	private static final DateTimeFormatter DATE_FORMATTER_DATE_TIME_SEPARATOR = new DateTimeFormatterBuilder().appendPattern("['T']['t'][' ']['　']").toFormatter();
	private static final DateTimeFormatter DATE_FORMATTER_ZONE_SEPARATOR = new DateTimeFormatterBuilder().appendPattern("[','][' ']").toFormatter();
	
	// "[X][Z]['['VV']']"
	private static final DateTimeFormatter DATE_FORMATTER_ZONE = new DateTimeFormatterBuilder()
			.optionalStart().appendZoneOrOffsetId().optionalEnd() // +HH:MM, America/New_York, UTC, UTC+HH:MM
			.optionalStart().appendPattern("Z").optionalEnd() // +HHMM
			.optionalStart().appendLiteral('[').appendZoneRegionId().appendLiteral(']').optionalEnd() // [America/New_York]
			.toFormatter(Locale.ENGLISH);
	
	// "[[' ']X['['VV']']]"
	private static final DateTimeFormatter DATE_FORMATTER_OPTION_ZONE = new DateTimeFormatterBuilder()
			.optionalStart()
			.appendOptional(DATE_FORMATTER_ZONE_SEPARATOR)
			.append(DATE_FORMATTER_ZONE)
			.optionalEnd()
			.toFormatter(Locale.ENGLISH);
	
	// u-MMM-d / EEE MMM d u
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_DATE_YMMMD = new DateTimeFormatterBuilder()
			.parseCaseInsensitive()
			.optionalStart().appendPattern("uuuu['-']['/']['.'][','][' ']MMMM['-']['/']['.'][','][' ']d['st']['nd']['rd']['th']").optionalEnd()
			.optionalStart().appendPattern("uuuu['-']['/']['.'][','][' ']MMM['-']['/']['.'][','][' ']d['st']['nd']['rd']['th']").optionalEnd()
			.optionalStart().appendPattern("[EEE[','][' ']]MMMM['-']['/']['.'][','][' ']d['st']['nd']['rd']['th'][['-']['/']['.'][','][' ']uuuu]").optionalEnd()
			.optionalStart().appendPattern("[EEE[','][' ']]MMM['-']['/']['.'][','][' ']d['st']['nd']['rd']['th'][['-']['/']['.'][','][' ']uuuu]").optionalEnd()
			.optionalStart().appendPattern("[EEE[','][' ']]d['st']['nd']['rd']['th']['-']['/']['.'][','][' ']MMMM[['-']['/']['.'][','][' ']uuuu]").optionalEnd()
			.optionalStart().appendPattern("[EEE[','][' ']]d['st']['nd']['rd']['th']['-']['/']['.'][','][' ']MMM[['-']['/']['.'][','][' ']uuuu]").optionalEnd()
			.parseCaseSensitive()
			.toFormatter(Locale.ENGLISH);
	
	// ISO Basic
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_DATE_TIME_ISO_BASIC = new DateTimeFormatterBuilder()
			.appendPattern("uuuuMMdd")
			.append(DATE_FORMATTER_DATE_TIME_SEPARATOR)
			.appendPattern("HH[mm[ss[['.'][',']")
			.appendFraction(ChronoField.NANO_OF_SECOND, 0, 9, false)
			.appendPattern("]]]")
			.toFormatter(Locale.ENGLISH);
	
	// ISO Week / Ordinal
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_DATE_ISO = new DateTimeFormatterBuilder()
			.optionalStart().append(DateTimeFormatter.ISO_WEEK_DATE).optionalEnd()
			.optionalStart().append(DateTimeFormatter.ISO_ORDINAL_DATE).optionalEnd()
			.toFormatter(Locale.ENGLISH);
	
	// "u-M[-d]"
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_DATE_YMD = new DateTimeFormatterBuilder()
			//.appendValue(ChronoField.YEAR, 4, 10, SignStyle.EXCEEDS_PAD)
			.optionalStart().appendPattern("uuuu'-'M['-'d]").optionalEnd()
			.optionalStart().appendPattern("uuuu'/'M['/'d]").optionalEnd()
			.optionalStart().appendPattern("uuuu'.'M['.'d]").optionalEnd()
			.toFormatter(Locale.ENGLISH);
	
	// "u'年'[M'月'[d'日']]"
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_DATE_YMD_JP = new DateTimeFormatterBuilder()
			//.appendValue(ChronoField.YEAR, 4, 10, SignStyle.EXCEEDS_PAD)
			.appendPattern("uuuu'年'[M'月'[d'日']]")
			.toFormatter(Locale.JAPAN)
			.withChronology(JapaneseChronology.INSTANCE);
	
	// "Gy'年'[M'月'[d'日']]"
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_DATE_GYMD_JP_DEFAULT = new DateTimeFormatterBuilder()
			.optionalStart().appendPattern("[GGGGG][GGGG][GGG]y'年'[M'月'[d'日']]").optionalEnd()
			.optionalStart().appendPattern("[GGGGG][GGGG][GGG]y['.'M['.'d]]").optionalEnd()
			.toFormatter(Locale.JAPAN); // before Meiji 6 support
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_DATE_GYMD_JP = new DateTimeFormatterBuilder()
			.optionalStart().appendPattern("[GGGGG][GGGG][GGG]y'年'[M'月'[d'日']]").optionalEnd()
			.optionalStart().appendPattern("[GGGGG][GGGG][GGG]y['.'M['.'d]]").optionalEnd()
			.toFormatter(Locale.JAPAN)
			.withChronology(JapaneseChronology.INSTANCE);
	
	// "H[:m[:s[.n]]]"
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_TIME_HMS = new DateTimeFormatterBuilder()
			.appendPattern("H[:m[:s[[.][,]")
			.appendFraction(ChronoField.NANO_OF_SECOND, 0, 9, false)
			.appendPattern("]]]")
			.toFormatter(Locale.ENGLISH);
	
	// "H'時'[m'分'[s[.n]'秒']]"
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_TIME_HMS_JP = new DateTimeFormatterBuilder()
			.appendPattern("H'時'[m'分'[s[[.][,]")
			.appendFraction(ChronoField.NANO_OF_SECOND, 0, 9, false)
			.appendPattern("]'秒']]")
			.toFormatter(Locale.JAPAN)
			.withChronology(JapaneseChronology.INSTANCE);
	
	// "h[:m[:s[.n]]]a"
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_TIME_HMS_AMPM = new DateTimeFormatterBuilder()
			.appendPattern("h[:m[:s[[.][,]")
			.appendFraction(ChronoField.NANO_OF_SECOND, 0, 9, false)
			.appendPattern("]]]")
			.appendPattern("[,][ ]")
			.parseCaseInsensitive()
			.appendPattern("a")
			.parseCaseSensitive()
			.toFormatter(Locale.ENGLISH);
	
	// "ah'時'[m'分'[s[.n]'秒']]"
	private static final DateTimeFormatter DATE_FORMATTER_LOCAL_TIME_HMS_AMPM_JP = new DateTimeFormatterBuilder()
			.optionalStart()
			.parseCaseInsensitive()
			.appendPattern("a")
			.parseCaseSensitive()
			.appendPattern("[,][' ']h'時'[m'分'[s[[.][,]")
			.appendFraction(ChronoField.NANO_OF_SECOND, 0, 9, false)
			.appendPattern("]'秒']]")
			.optionalEnd()
			.optionalStart()
			.appendPattern("ah'時'[m'分'[s[[.][,]")
			.appendFraction(ChronoField.NANO_OF_SECOND, 0, 9, false)
			.appendPattern("]'秒']][,][' ']")
			.parseCaseInsensitive()
			.appendPattern("a")
			.parseCaseSensitive()
			.optionalEnd()
			.toFormatter(Locale.JAPAN)
			.withChronology(JapaneseChronology.INSTANCE);
	
	private static final DateTimeFormatter[] DATE_FORMATTERS = {
			// Date time
			new DateTimeFormatterBuilder()
				.append(DATE_FORMATTER_LOCAL_DATE_YMMMD)
				.append(DATE_FORMATTER_DATE_TIME_SEPARATOR)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.appendPattern("[[','][' ']uuuu]")
				.toFormatter(Locale.ENGLISH),
			new DateTimeFormatterBuilder()
				.append(DATE_FORMATTER_LOCAL_DATE_TIME_ISO_BASIC)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.toFormatter(Locale.ENGLISH),
			new DateTimeFormatterBuilder()
				.append(DATE_FORMATTER_LOCAL_DATE_ISO)
				.append(DATE_FORMATTER_DATE_TIME_SEPARATOR)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.toFormatter(Locale.ENGLISH),
			new DateTimeFormatterBuilder()
				.append(DATE_FORMATTER_LOCAL_DATE_YMD)
				.append(DATE_FORMATTER_DATE_TIME_SEPARATOR)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_AMPM)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.toFormatter(Locale.ENGLISH),
			new DateTimeFormatterBuilder()
				.append(DATE_FORMATTER_LOCAL_DATE_GYMD_JP)
				.append(DATE_FORMATTER_DATE_TIME_SEPARATOR)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_AMPM_JP)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_JP)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_AMPM)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.toFormatter(Locale.JAPAN)
				.withChronology(JapaneseChronology.INSTANCE),
			new DateTimeFormatterBuilder()
				.append(DATE_FORMATTER_LOCAL_DATE_GYMD_JP_DEFAULT)
				.append(DATE_FORMATTER_DATE_TIME_SEPARATOR)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_AMPM_JP)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_JP)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_AMPM)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.toFormatter(Locale.JAPAN),
			new DateTimeFormatterBuilder()
				.append(DATE_FORMATTER_LOCAL_DATE_YMD_JP)
				.append(DATE_FORMATTER_DATE_TIME_SEPARATOR)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_AMPM_JP)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_JP)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.toFormatter(Locale.JAPAN)
				.withChronology(JapaneseChronology.INSTANCE),
			// Date
			DATE_FORMATTER_LOCAL_DATE_YMMMD,
			DATE_FORMATTER_LOCAL_DATE_ISO,
			DATE_FORMATTER_LOCAL_DATE_YMD,
			DATE_FORMATTER_LOCAL_DATE_YMD_JP,
			// Time
			new DateTimeFormatterBuilder()
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_AMPM)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.toFormatter(Locale.ENGLISH),
			new DateTimeFormatterBuilder()
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_AMPM_JP)
				.appendOptional(DATE_FORMATTER_LOCAL_TIME_HMS_JP)
				.append(DATE_FORMATTER_OPTION_ZONE)
				.toFormatter(Locale.JAPAN)
				.withChronology(JapaneseChronology.INSTANCE),
	};
	
	private static final Pattern DATE_ZONE_SHORT_NAME_PATTERN = Pattern.compile("[A-Z]{3}");
	
	private DateParser() {
		// NOP
	}

	public static ZonedDateTime parseDateAsZonedDateTime(String val, ZoneId zone) {

		if (val == null || val.isEmpty()) {
			return null;
		}
		
		if (DATE_MAX_LENGTH < val.length()) {
			return null;
		}
		
		if (val.equalsIgnoreCase("now")) {
			return ZonedDateTime.now(zone);
		}
		
		String strDate = StringUtilz.toHalfWidth(val, true, true, true, true, false, false);
		
		try {
			// Parse as UNIX time
			BigDecimal epochSec = new BigDecimal(strDate);
			long epochSecPart = epochSec.longValue();
			long epochNanosecPart = (epochSec.scale() <= 0) ? 0L : epochSec.subtract(new BigDecimal(epochSecPart)).movePointRight(9).longValue();
			return ZonedDateTime.ofInstant(Instant.ofEpochSecond(epochSecPart, epochNanosecPart), zone);
		} catch (NumberFormatException | DateTimeException e) {
			// THRU
		}
		
		strDate = strDate.replace("元年", "1年");
		Matcher matcher = DATE_ZONE_SHORT_NAME_PATTERN.matcher(strDate);
		if (matcher.find()) {
			StringBuffer sb = new StringBuffer(strDate.length() * 2);
			do {
				String shortZoneId = matcher.group(0);
				String zoneOffset;
				if (shortZoneId.equals("GMT") || shortZoneId.equals("UTC")) {
					zoneOffset = "Z";
				} else {
					zoneOffset = ZoneId.SHORT_IDS.get(shortZoneId);
					if (zoneOffset == null) {
						zoneOffset = shortZoneId;
					}
				}
				matcher.appendReplacement(sb, zoneOffset);
			} while (matcher.find());
			matcher.appendTail(sb);
			strDate = sb.toString();
		}
		
		try {
			return parseDateAsZonedDateTime(strDate, DATE_FORMATTERS, zone, zone, 1970, Month.JANUARY, 1);
		} catch (Exception e) {
			// THRU
		}
		
		return null;
	}
	
	private static ZonedDateTime parseDateAsZonedDateTime(String date, DateTimeFormatter[] formatters, ZoneId zone, ZoneId defaultZone, int defaultYear, Month defaultMonth, int defaultDay) {
		DateTimeParseException exception = null;
		
		for (DateTimeFormatter formatter : formatters) {
			try {
				TemporalAccessor temporal = formatter.parseBest(date, ZonedDateTime::from, OffsetDateTime::from, LocalDateTime::from, LocalDate::from, OffsetTime::from, LocalTime::from, YearMonth::from, MonthDay::from);
				Instant instant = DateUtilz.toInstant(temporal, defaultZone, defaultYear, defaultMonth, defaultDay);
				ZonedDateTime zdt = ZonedDateTime.ofInstant(instant, zone);
				return zdt;
			} catch (DateTimeParseException e) {
				exception = e;
			}
		}
		
		if (exception != null) {
			throw exception;
		}
		
		return null;
	}
}
