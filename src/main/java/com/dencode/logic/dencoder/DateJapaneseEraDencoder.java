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

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="date", method="date.japanese-era")
public class DateJapaneseEraDencoder {
	
	private static final Locale LOCALE_JP = Locale.forLanguageTag("ja-JP-u-ca-japanese");
	
	private DateJapaneseEraDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateJapaneseEra(DencodeCondition cond) {
		return encDateJapaneseEra(cond.valueAsDate(), cond.timeZone());
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
}
