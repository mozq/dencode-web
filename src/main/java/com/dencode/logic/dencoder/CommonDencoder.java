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

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="*", method="*")
public class CommonDencoder {
	
	private CommonDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static int textLength(DencodeCondition cond) {
		return getTextLength(cond.value());
	}
	
	@DencoderFunction
	public static int textByteLength(DencodeCondition cond) {
		return getTextByteLength(cond.valueAsBinary());
	}
	
	
	private static int getTextLength(String val) {
		if (val == null || val.isEmpty()) {
			return 0;
		}

		return val.codePointCount(0, val.length());
	}
	
	private static int getTextByteLength(byte[] binValue) {
		return binValue.length;
	}
}
