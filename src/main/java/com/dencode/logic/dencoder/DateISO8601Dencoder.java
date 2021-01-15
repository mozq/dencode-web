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
import java.util.Locale;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="date", method="date.iso8601")
public class DateISO8601Dencoder {
	
	private static final DateTimeFormatter FORMATTER_BASIC = DateTimeFormatter.ofPattern("uuuuMMdd'T'HHmmssXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_BASIC_MSEC = DateTimeFormatter.ofPattern("uuuuMMdd'T'HHmmss,SSSXX", Locale.US);
	
	private static final DateTimeFormatter FORMATTER_EXT = DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ssXXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_EXT_MSEC = DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss,SSSXXX", Locale.US);
	
	private static final DateTimeFormatter FORMATTER_WEEK = new DateTimeFormatterBuilder()
			.appendValue(IsoFields.WEEK_BASED_YEAR, 4, 10, SignStyle.EXCEEDS_PAD)
			.appendLiteral("-W")
			.appendValue(IsoFields.WEEK_OF_WEEK_BASED_YEAR, 2)
			.appendLiteral('-')
			.appendValue(ChronoField.DAY_OF_WEEK, 1)
			.appendLiteral('T')
			.appendPattern("HH:mm:ssXXX")
			.toFormatter(Locale.US);
	private static final DateTimeFormatter FORMATTER_WEEK_MSEC = new DateTimeFormatterBuilder()
			.appendValue(IsoFields.WEEK_BASED_YEAR, 4, 10, SignStyle.EXCEEDS_PAD)
			.appendLiteral("-W")
			.appendValue(IsoFields.WEEK_OF_WEEK_BASED_YEAR, 2)
			.appendLiteral('-')
			.appendValue(ChronoField.DAY_OF_WEEK, 1)
			.appendLiteral('T')
			.appendPattern("HH:mm:ss,SSSXXX")
			.toFormatter(Locale.US);
	
	private static final DateTimeFormatter FORMATTER_ORDINAL = DateTimeFormatter.ofPattern("uuuu-DDD'T'HH:mm:ssXXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_ORDINAL_MSEC = DateTimeFormatter.ofPattern("uuuu-DDD'T'HH:mm:ss,SSSXXX", Locale.US);
	
	private DateISO8601Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateISO8601(DencodeCondition cond) {
		return encDateISO8601Basic(cond.valueAsDate());
	}
	
	@DencoderFunction
	public static String encDateISO8601Ext(DencodeCondition cond) {
		return encDateISO8601Ext(cond.valueAsDate());
	}
	
	@DencoderFunction
	public static String encDateISO8601Week(DencodeCondition cond) {
		return encDateISO8601Week(cond.valueAsDate());
	}
	
	@DencoderFunction
	public static String encDateISO8601Ordinal(DencodeCondition cond) {
		return encDateISO8601Ordinal(cond.valueAsDate());
	}
	
	
	private static String encDateISO8601Basic(ZonedDateTime dateVal) {
		return DencodeUtils.encDate(dateVal, FORMATTER_BASIC, FORMATTER_BASIC_MSEC);
	}
	
	private static String encDateISO8601Ext(ZonedDateTime dateVal) {
		return DencodeUtils.encDate(dateVal, FORMATTER_EXT, FORMATTER_EXT_MSEC);
	}
	
	private static String encDateISO8601Week(ZonedDateTime dateVal) {
		return DencodeUtils.encDate(dateVal, FORMATTER_WEEK, FORMATTER_WEEK_MSEC);
	}
	
	private static String encDateISO8601Ordinal(ZonedDateTime dateVal) {
		return DencodeUtils.encDate(dateVal, FORMATTER_ORDINAL, FORMATTER_ORDINAL_MSEC);
	}
}
