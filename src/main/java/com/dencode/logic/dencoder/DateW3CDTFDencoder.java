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
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="date", method="date.w3cdtf")
public class DateW3CDTFDencoder {
	
	private DateW3CDTFDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateW3CDTF(DencodeCondition cond) {
		return encDateW3CDTF(cond.valueAsDate(), cond.timeZone());
	}
	
	
	private static String encDateW3CDTF(Date dateVal, TimeZone timeZone) {
		return encDateISO8601(dateVal, "yyyy-MM-dd'T'HH:mm:ssXXX", "yyyy-MM-dd'T'HH:mm:ss.SSSXXX", timeZone);
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
}
