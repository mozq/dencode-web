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
import java.util.List;
import java.util.Locale;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="date", method="date.ctime", hasEncoder=true, hasDecoder=false, useTz=true)
public class DateCTimeDencoder {
	
	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss uuuu", Locale.US);
	
	private DateCTimeDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateCTime(DencodeCondition cond) {
		return encDateCTime(cond.valueAsDates());
	}
	
	
	private static String encDateCTime(List<ZonedDateTime> vals) {
		return DencodeUtils.dencodeLines(vals, (dateVal) -> {
			if (dateVal == null) {
				return null;
			}
			
			return FORMATTER.format(dateVal);
		});
	}
}
