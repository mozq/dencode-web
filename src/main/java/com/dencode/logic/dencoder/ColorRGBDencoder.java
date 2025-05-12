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

@Dencoder(type="color", method="color.rgb", hasEncoder=true, hasDecoder=false)
public class ColorRGBDencoder {
	
	private ColorRGBDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encColorRGBHex(DencodeCondition cond) {
		return encColorRGBHex(cond.valueAsColors());
	}
	
	@DencoderFunction
	public static String encColorRGBFn(DencodeCondition cond) {
		return encColorRGBFn(
				cond.valueAsColors(),
				DencodeUtils.getOption(cond.options(), "color.rgb.notation", "percentage")
				);
	}
	
	
	private static String encColorRGBHex(List<double[]> vals) {
		return DencodeUtils.dencodeLines(vals, (rgba) -> {
			if (rgba == null) {
				return null;
			}
			
			double r = rgba[0];
			double g = rgba[1];
			double b = rgba[2];
			double a = rgba[3];
			
			int r8 = (int)(r * 255.0);
			int g8 = (int)(g * 255.0);
			int b8 = (int)(b * 255.0);
			int a8 = (int)(a * 255.0);
			
			boolean hasAlpha = (Double.compare(a, 1.0) != 0);
			
			StringBuilder sb = new StringBuilder();
			sb.append('#');
			
			if (r8 <= 0xf) {
				sb.append('0');
			}
			sb.append(Integer.toHexString(r8));
			
			if (g8 <= 0xf) {
				sb.append('0');
			}
			sb.append(Integer.toHexString(g8));
			
			if (b8 <= 0xf) {
				sb.append('0');
			}
			sb.append(Integer.toHexString(b8));
			
			if (hasAlpha) {
				if (a8 <= 0xf) {
					sb.append('0');
				}
				sb.append(Integer.toHexString(a8));
			}
			
			return sb.toString();
		});
	}
	
	private static String encColorRGBFn(List<double[]> vals, String notation) {
		return DencodeUtils.dencodeLines(vals, (rgba) -> {
			if (rgba == null) {
				return null;
			}
			
			double r = rgba[0];
			double g = rgba[1];
			double b = rgba[2];
			double a = rgba[3];
			
			boolean hasAlpha = (Double.compare(a, 1.0) != 0);
			
			StringBuilder sb = new StringBuilder();
			sb.append("rgb(");
			
			if (notation.equals("number")) {
				// number
				appendRoundString(sb, r * 255.0, 0, RoundingMode.HALF_UP);
				sb.append(' ');
				appendRoundString(sb, g * 255.0, 0, RoundingMode.HALF_UP);
				sb.append(' ');
				appendRoundString(sb, b * 255.0, 0, RoundingMode.HALF_UP);
			} else {
				// percentage
				appendRoundString(sb, r * 100.0, 2, RoundingMode.HALF_UP);
				sb.append('%');
				sb.append(' ');
				appendRoundString(sb, g * 100.0, 2, RoundingMode.HALF_UP);
				sb.append('%');
				sb.append(' ');
				appendRoundString(sb, b * 100.0, 2, RoundingMode.HALF_UP);
				sb.append('%');
			}
			
			if (hasAlpha) {
				sb.append(" / ");
				appendRoundString(sb, a, 2, RoundingMode.HALF_UP);
			}
			sb.append(')');
			
			return sb.toString();
		});
	}
}
