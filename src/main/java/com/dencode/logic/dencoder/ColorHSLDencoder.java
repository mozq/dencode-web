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

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="color", method="color.hsl", hasEncoder=true, hasDecoder=false)
public class ColorHSLDencoder {
	
	private ColorHSLDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encColorHSLFn(DencodeCondition cond) {
		return encColorHSLFn(cond.valueAsColors());
	}
	
	
	private static String encColorHSLFn(List<double[]> vals) {
		return DencodeUtils.dencodeLines(vals, (rgba) -> {
			if (rgba == null) {
				return null;
			}
			
			double r = rgba[0];
			double g = rgba[1];
			double b = rgba[2];
			double a = rgba[3];
			
			double max = Math.max(Math.max(r, g), b);
			double min = Math.min(Math.min(r, g), b);
			
			double h;
			double s;
			double l = (max + min) / 2.0;

			if (max == min) {
				h = 0.0;
				s = 0.0;
			} else {
				double d = max - min;
				if (r == max) {
					// between yellow & magenta
					h = (g - b) / d + ((g < b) ? 6.0 : 0.0);
				} else if (g == max) {
					h = (b - r) / d + 2.0;
				} else {
					h = (r - g) / d + 4.0;
				}
				h *= 60.0; // degrees

				if (h < 0.0) {
					h += 360.0;
				}
				
				if (0.5 < l) {
					s = d / (2.0 - d);
				} else {
					s = d / (max + min);
				}
			}
			
			boolean hasAlpha = (Double.compare(a, 1.0) != 0);
			
			StringBuilder sb = new StringBuilder();
			sb.append("hsl(");
			appendRoundString(sb, h, 2, RoundingMode.HALF_UP);
			sb.append(' ');
			appendRoundString(sb, s * 100, 2, RoundingMode.HALF_UP);
			sb.append('%');
			sb.append(' ');
			appendRoundString(sb, l * 100, 2, RoundingMode.HALF_UP);
			sb.append('%');
			if (hasAlpha) {
				sb.append(" / ");
				appendRoundString(sb, a, 2, RoundingMode.HALF_UP);
			}
			sb.append(')');
			
			return sb.toString();
		});
	}
}
