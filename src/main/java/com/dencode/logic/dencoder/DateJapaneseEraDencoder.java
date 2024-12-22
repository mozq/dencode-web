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

import java.time.DateTimeException;
import java.time.ZonedDateTime;
import java.time.chrono.JapaneseChronology;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="date", method="date.japanese-era", hasEncoder=true, hasDecoder=false, useTz=true)
public class DateJapaneseEraDencoder {
	
	private static final DateTimeFormatter FORMATTER_JA = DateTimeFormatter.ofPattern("GGGGy年MM月dd日HH時mm分ss秒 z", Locale.JAPAN).withChronology(JapaneseChronology.INSTANCE);
	private static final DateTimeFormatter FORMATTER_JA_MSEC = DateTimeFormatter.ofPattern("GGGGy年MM月dd日HH時mm分ss.SSS秒 z", Locale.JAPAN).withChronology(JapaneseChronology.INSTANCE);
	private static final DateTimeFormatter FORMATTER_JA_MICROSEC = DateTimeFormatter.ofPattern("GGGGy年MM月dd日HH時mm分ss.SSSSSS秒 z", Locale.JAPAN).withChronology(JapaneseChronology.INSTANCE);
	private static final DateTimeFormatter FORMATTER_JA_NSEC = DateTimeFormatter.ofPattern("GGGGy年MM月dd日HH時mm分ss.SSSSSSSSS秒 z", Locale.JAPAN).withChronology(JapaneseChronology.INSTANCE);

	private static final DateTimeFormatter FORMATTER_DEFAULT = DateTimeFormatter.ofPattern("GGGGy年MM月dd日HH時mm分ss秒 z", Locale.JAPAN);
	private static final DateTimeFormatter FORMATTER_DEFAULT_MSEC = DateTimeFormatter.ofPattern("GGGGy年MM月dd日HH時mm分ss.SSS秒 z", Locale.JAPAN);
	private static final DateTimeFormatter FORMATTER_DEFAULT_MICROSEC = DateTimeFormatter.ofPattern("GGGGy年MM月dd日HH時mm分ss.SSSSSS秒 z", Locale.JAPAN);
	private static final DateTimeFormatter FORMATTER_DEFAULT_NSEC = DateTimeFormatter.ofPattern("GGGGy年MM月dd日HH時mm分ss.SSSSSSSSS秒 z", Locale.JAPAN);
	
	private DateJapaneseEraDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateJapaneseEra(DencodeCondition cond) {
		return encDateJapaneseEra(cond.valueAsDates());
	}
	
	
	private static String encDateJapaneseEra(List<ZonedDateTime> vals) {
		return DencodeUtils.dencodeLines(vals, (dateVal) -> {
			if (dateVal == null) {
				return null;
			}
			
			String strDate = null;
			try {
				strDate = DencodeUtils.encDate(dateVal, FORMATTER_JA, FORMATTER_JA_MSEC, FORMATTER_JA_MICROSEC, FORMATTER_JA_NSEC);
			} catch (DateTimeException e) {
				// before Meiji 6 support
				strDate = DencodeUtils.encDate(dateVal, FORMATTER_DEFAULT, FORMATTER_DEFAULT_MSEC, FORMATTER_DEFAULT_MICROSEC, FORMATTER_DEFAULT_NSEC);
			}
			
			if (strDate != null) {
				strDate = strDate.replaceAll("([^0-9])1年", "$1元年");
			}
			
			return strDate;
		});
	}
}
