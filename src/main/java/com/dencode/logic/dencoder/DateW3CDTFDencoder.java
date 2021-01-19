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

@Dencoder(type="date", method="date.w3cdtf")
public class DateW3CDTFDencoder {
	
	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ssXXX", Locale.US);
	private static final DateTimeFormatter FORMATTER_MSEC = DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm:ss.SSSXXX", Locale.US);
	
	private DateW3CDTFDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateW3CDTF(DencodeCondition cond) {
		return encDateW3CDTF(cond.valueAsDates());
	}
	
	
	private static String encDateW3CDTF(List<ZonedDateTime> vals) {
		return DencodeUtils.dencodeLines(vals, (dateVal) -> {
			return DencodeUtils.encDate(dateVal, FORMATTER, FORMATTER_MSEC);
		});
	}
}
