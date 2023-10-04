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

import org.mifmi.commons4j.graphics.color.HSVColor;
import org.mifmi.commons4j.graphics.color.RGBColor;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="color", method="color.hsv", hasEncoder=true, hasDecoder=false)
public class ColorHSVDencoder {
	
	private ColorHSVDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encColorHSVFn(DencodeCondition cond) {
		return encColorHSVFn(cond.valueAsColors());
	}
	
	
	private static String encColorHSVFn(List<RGBColor> vals) {
		return DencodeUtils.dencodeLines(vals, (rgb) -> {
			if (rgb == null) {
				return null;
			}
			
			HSVColor hsv = rgb.toHSV();
			boolean hasAlpha = (Double.compare(hsv.getA(), 1.0) != 0);
			
			StringBuilder sb = new StringBuilder();
			sb.append("hsv(");
			appendRoundString(sb, hsv.getH(), 2, RoundingMode.HALF_UP);
			sb.append(' ');
			appendRoundString(sb, hsv.getS() * 100, 2, RoundingMode.HALF_UP);
			sb.append('%');
			sb.append(' ');
			appendRoundString(sb, hsv.getV() * 100, 2, RoundingMode.HALF_UP);
			sb.append('%');
			if (hasAlpha) {
				sb.append(" / ");
				appendRoundString(sb, hsv.getA(), 2, RoundingMode.HALF_UP);
			}
			sb.append(')');
			
			return sb.toString();
		});
	}
}
