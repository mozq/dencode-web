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

import java.util.List;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.snake-case")
public class StringSnakeCaseDencoder {
	
	private StringSnakeCaseDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrUpperSnakeCase(DencodeCondition cond) {
		return encStrSnakeCase(cond.valueAsLines(), true);
	}
	
	@DencoderFunction
	public static String encStrLowerSnakeCase(DencodeCondition cond) {
		return encStrSnakeCase(cond.valueAsLines(), false);
	}
	
	private static String encStrSnakeCase(List<String> vals, boolean upper) {
		return DencodeUtils.dencodeLines(vals, (val) -> StringUtilz.toSnakeCase(val, false, Boolean.valueOf(upper)));
	}
}
