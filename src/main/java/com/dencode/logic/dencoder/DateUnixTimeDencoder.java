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
import java.util.List;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="date", method="date.unix-time")
public class DateUnixTimeDencoder {
	
	private DateUnixTimeDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encDateUnixTime(DencodeCondition cond) {
		return encDateUnixTime(cond.valueAsDates());
	}
	
	
	private static String encDateUnixTime(List<ZonedDateTime> vals) {
		return DencodeUtils.dencodeLines(vals, (dateVal) -> {
			if (dateVal == null) {
				return null;
			}
			
			try {
				return String.valueOf(dateVal.toInstant().toEpochMilli());
			} catch (ArithmeticException e) {
				return null;
			}
		});
	}
}
