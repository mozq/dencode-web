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

import static com.dencode.logic.dencoder.DencodeUtils.appendRoundString;

import java.math.RoundingMode;
import java.util.List;

import org.mifmi.commons4j.graphics.color.CMYKColor;
import org.mifmi.commons4j.graphics.color.RGBColor;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="color", method="color.cmyk")
public class ColorCMYKDencoder {
	
	private ColorCMYKDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encColorCMYKFn(DencodeCondition cond) {
		return encColorCMYKFn(cond.valueAsColors());
	}
	
	
	private static String encColorCMYKFn(List<RGBColor> vals) {
		return DencodeUtils.dencodeLines(vals, (rgb) -> {
			if (rgb == null) {
				return null;
			}
			
			CMYKColor cmyk = rgb.toCMYK();
			boolean hasAlpha = (cmyk.getA() != 1.0);
			
			StringBuilder sb = new StringBuilder();
			if (hasAlpha) {
				sb.append("cmyka(");
			} else {
				sb.append("cmyk(");
			}
			appendRoundString(sb, cmyk.getC() * 100, 2, RoundingMode.HALF_UP);
			sb.append('%');
			sb.append(", ");
			appendRoundString(sb, cmyk.getM() * 100, 2, RoundingMode.HALF_UP);
			sb.append('%');
			sb.append(", ");
			appendRoundString(sb, cmyk.getY() * 100, 2, RoundingMode.HALF_UP);
			sb.append('%');
			sb.append(", ");
			appendRoundString(sb, cmyk.getK() * 100, 2, RoundingMode.HALF_UP);
			sb.append('%');
			if (hasAlpha) {
				sb.append(", ");
				appendRoundString(sb, rgb.getA(), 2, RoundingMode.HALF_UP);
			}
			sb.append(')');
			
			return sb.toString();
		});
	}
}
