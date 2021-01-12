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

@Dencoder(type="number", method="number.bin")
public class NumberBinDencoder {
	
	private NumberBinDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encNumBin(DencodeCondition cond) {
		return encNumBin(cond.value());
	}
	
	@DencoderFunction
	public static String decNumBin(DencodeCondition cond) {
		return decNumBin(cond.value());
	}
	
	
	private static String encNumBin(String val) {
		return DencodeUtils.encNum(val, 2);
	}
	
	private static String decNumBin(String val) {
		return DencodeUtils.decNum(val, 2);
	}
}
