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

import org.mifmi.commons4j.graphics.color.RGBColor;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="color", method="color.name")
public class ColorNameDencoder {
	
	private ColorNameDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encColorName(DencodeCondition cond) {
		return encColorName(cond.valueAsColor());
	}
	
	
	private static String encColorName(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}
		
		return RGBColor.getName(rgb);
	}
}
