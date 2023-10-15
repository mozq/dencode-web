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

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.SignStyle;
import java.time.temporal.ChronoField;
import java.time.temporal.IsoFields;
import java.util.List;
import java.util.Locale;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="date", method="date.iso8601", hasEncoder=true, hasDecoder=false, useTz=true)
public class DateISO8601Dencoder {
	
	private static final DateTimeFormatter FORMATTER_BASIC = DateTimeFormatter.ofPattern("uuuuMMdd'T'HHmmssXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_BASIC_DOT_MSEC = DateTimeFormatter.ofPattern("uuuuMMdd'T'HHmmss.SSSXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_BASIC_COMMA_MSEC = DateTimeFormatter.ofPattern("uuuuMMdd'T'HHmmss,SSSXX", Locale.US);
	
	private static final DateTimeFormatter FORMATTER_EXT = DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ssXXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_EXT_DOT_MSEC = DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss.SSSXXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_EXT_COMMA_MSEC = DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss,SSSXXX", Locale.US);
	
	private static final DateTimeFormatter FORMATTER_WEEK = new DateTimeFormatterBuilder()
			.appendValue(IsoFields.WEEK_BASED_YEAR, 4, 10, SignStyle.EXCEEDS_PAD)
			.appendLiteral("-W")
			.appendValue(IsoFields.WEEK_OF_WEEK_BASED_YEAR, 2)
			.appendLiteral('-')
			.appendValue(ChronoField.DAY_OF_WEEK, 1)
			.appendLiteral('T')
			.appendPattern("HH:mm:ssXXX")
			.toFormatter(Locale.US);
	private static final DateTimeFormatter FORMATTER_WEEK_DOT_MSEC = new DateTimeFormatterBuilder()
			.appendValue(IsoFields.WEEK_BASED_YEAR, 4, 10, SignStyle.EXCEEDS_PAD)
			.appendLiteral("-W")
			.appendValue(IsoFields.WEEK_OF_WEEK_BASED_YEAR, 2)
			.appendLiteral('-')
			.appendValue(ChronoField.DAY_OF_WEEK, 1)
			.appendLiteral('T')
			.appendPattern("HH:mm:ss.SSSXXX")
			.toFormatter(Locale.US);
	private static final DateTimeFormatter FORMATTER_WEEK_COMMA_MSEC = new DateTimeFormatterBuilder()
			.appendValue(IsoFields.WEEK_BASED_YEAR, 4, 10, SignStyle.EXCEEDS_PAD)
			.appendLiteral("-W")
			.appendValue(IsoFields.WEEK_OF_WEEK_BASED_YEAR, 2)
			.appendLiteral('-')
			.appendValue(ChronoField.DAY_OF_WEEK, 1)
			.appendLiteral('T')
			.appendPattern("HH:mm:ss,SSSXXX")
			.toFormatter(Locale.US);
	
	private static final DateTimeFormatter FORMATTER_ORDINAL = DateTimeFormatter.ofPattern("uuuu-DDD'T'HH:mm:ssXXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_ORDINAL_DOT_MSEC = DateTimeFormatter.ofPattern("uuuu-DDD'T'HH:mm:ss.SSSXXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_ORDINAL_COMMA_MSEC = DateTimeFormatter.ofPattern("uuuu-DDD'T'HH:mm:ss,SSSXXX", Locale.US);
	
	private DateISO8601Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateISO8601(DencodeCondition cond) {
		return encDateISO8601Basic(cond.valueAsDates(),
				DencodeUtils.getOption(cond.options(), "date.iso8601.decimal-separator", DencodeUtils.getOption(cond.options(), "encDateISO8601DecimalMark", ".")));
	}
	
	@DencoderFunction
	public static String encDateISO8601Ext(DencodeCondition cond) {
		return encDateISO8601Ext(cond.valueAsDates(),
				DencodeUtils.getOption(cond.options(), "date.iso8601.decimal-separator", DencodeUtils.getOption(cond.options(), "encDateISO8601ExtDecimalMark", ".")));
	}
	
	@DencoderFunction
	public static String encDateISO8601Week(DencodeCondition cond) {
		return encDateISO8601Week(cond.valueAsDates(),
				DencodeUtils.getOption(cond.options(), "date.iso8601.decimal-separator", DencodeUtils.getOption(cond.options(), "encDateISO8601WeekDecimalMark", ".")));
	}
	
	@DencoderFunction
	public static String encDateISO8601Ordinal(DencodeCondition cond) {
		return encDateISO8601Ordinal(cond.valueAsDates(),
				DencodeUtils.getOption(cond.options(), "date.iso8601.decimal-separator", DencodeUtils.getOption(cond.options(), "encDateISO8601OrdinalDecimalMark", ".")));
	}
	
	
	private static String encDateISO8601Basic(List<ZonedDateTime> vals, String decimalMark) {
		return DencodeUtils.dencodeLines(vals, (dateVal) -> {
			return DencodeUtils.encDate(dateVal, FORMATTER_BASIC, chooseDecimalSeparatorFormatter(decimalMark, FORMATTER_BASIC_DOT_MSEC, FORMATTER_BASIC_COMMA_MSEC));
		});
	}
	
	private static String encDateISO8601Ext(List<ZonedDateTime> vals, String decimalMark) {
		return DencodeUtils.dencodeLines(vals, (dateVal) -> {
			return DencodeUtils.encDate(dateVal, FORMATTER_EXT, chooseDecimalSeparatorFormatter(decimalMark, FORMATTER_EXT_DOT_MSEC, FORMATTER_EXT_COMMA_MSEC));
		});
	}
	
	private static String encDateISO8601Week(List<ZonedDateTime> vals, String decimalMark) {
		return DencodeUtils.dencodeLines(vals, (dateVal) -> {
			return DencodeUtils.encDate(dateVal, FORMATTER_WEEK, chooseDecimalSeparatorFormatter(decimalMark, FORMATTER_WEEK_DOT_MSEC, FORMATTER_WEEK_COMMA_MSEC));
		});
	}
	
	private static String encDateISO8601Ordinal(List<ZonedDateTime> vals, String decimalMark) {
		return DencodeUtils.dencodeLines(vals, (dateVal) -> {
			return DencodeUtils.encDate(dateVal, FORMATTER_ORDINAL, chooseDecimalSeparatorFormatter(decimalMark, FORMATTER_ORDINAL_DOT_MSEC, FORMATTER_ORDINAL_COMMA_MSEC));
		});
	}
	
	private static DateTimeFormatter chooseDecimalSeparatorFormatter(String decimalSeparator, DateTimeFormatter dotFormatter, DateTimeFormatter commaFormatter) {
		return (decimalSeparator.equals(",")) ? commaFormatter : dotFormatter;
	}
}
