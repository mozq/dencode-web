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

import java.util.Arrays;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.line-unique")
public class StringLineUniqueDencoder {
	
	private StringLineUniqueDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrLineUnique(DencodeCondition cond) {
		return encStrLineUnique(cond.valueAsLines(), cond.lineBreak());
	}
	
	
	private static String encStrLineUnique(String[] varLines, String lineBreak) {
		Object[] objLines = Arrays.stream(varLines).distinct().toArray();
		
		return StringUtilz.join(lineBreak, objLines);
	}
}
