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

@Dencoder(type="date", method="date.rfc2822")
public class DateRFC2822Dencoder {
	
	private DateRFC2822Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateRFC2822(DencodeCondition cond) {
		return encDateRFC2822(cond.valueAsDate(), cond.timeZone());
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
}
