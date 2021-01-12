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

import org.mifmi.commons4j.graphics.color.RGBColor;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="color", method="color.rgb")
public class ColorRGBDencoder {
	
	private ColorRGBDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encColorRGBHex3(DencodeCondition cond) {
		return encColorRGBHex3(cond.valueAsColor());
	}

	@DencoderFunction
	public static String encColorRGBHex6(DencodeCondition cond) {
		return encColorRGBHex6(cond.valueAsColor());
	}

	@DencoderFunction
	public static String encColorRGBFn8(DencodeCondition cond) {
		return encColorRGBFn8(cond.valueAsColor());
	}

	@DencoderFunction
	public static String encColorRGBFn(DencodeCondition cond) {
		return encColorRGBFn(cond.valueAsColor());
	}
	
	
	private static String encColorRGBHex3(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		boolean hasAlpha = (rgb.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		sb.append('#');
		sb.append(Integer.toHexString(Math.round(rgb.getR8() / 17)));
		sb.append(Integer.toHexString(Math.round(rgb.getG8() / 17)));
		sb.append(Integer.toHexString(Math.round(rgb.getB8() / 17)));
		if (hasAlpha) {
			sb.append(Integer.toHexString(Math.round((int) (255.0 * rgb.getA() / 17.0))));
		}
		
		return sb.toString();
	}
	
	private static String encColorRGBHex6(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		boolean hasAlpha = (rgb.getA() != 1.0);

		StringBuilder sb = new StringBuilder();
		sb.append('#');
		
		if (rgb.getR8() <= 0xf) {
			sb.append('0');
		}
		sb.append(Integer.toHexString(rgb.getR8()));
		
		if (rgb.getG8() <= 0xf) {
			sb.append('0');
		}
		sb.append(Integer.toHexString(rgb.getG8()));
		
		if (rgb.getB8() <= 0xf) {
			sb.append('0');
		}
		sb.append(Integer.toHexString(rgb.getB8()));
		
		if (hasAlpha) {
			int a8 = (int) (255.0 * rgb.getA());
			if (a8 <= 0xf) {
				sb.append('0');
			}
			sb.append(Integer.toHexString(a8));
		}
		
		return sb.toString();
	}
	
	private static String encColorRGBFn8(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		boolean hasAlpha = (rgb.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		if (hasAlpha) {
			sb.append("rgba(");
		} else {
			sb.append("rgb(");
		}
		sb.append(rgb.getR8());
		sb.append(", ");
		sb.append(rgb.getG8());
		sb.append(", ");
		sb.append(rgb.getB8());
		if (hasAlpha) {
			sb.append(", ");
			appendRoundString(sb, rgb.getA(), 2, RoundingMode.HALF_UP);
		}
		sb.append(')');
		
		return sb.toString();
	}
	
	private static String encColorRGBFn(RGBColor rgb) {
		if (rgb == null) {
			return null;
		}

		boolean hasAlpha = (rgb.getA() != 1.0);
		
		StringBuilder sb = new StringBuilder();
		if (hasAlpha) {
			sb.append("rgba(");
		} else {
			sb.append("rgb(");
		}
		appendRoundString(sb, rgb.getR() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, rgb.getG() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		sb.append(", ");
		appendRoundString(sb, rgb.getB() * 100, 2, RoundingMode.HALF_UP);
		sb.append('%');
		if (hasAlpha) {
			sb.append(", ");
			appendRoundString(sb, rgb.getA(), 2, RoundingMode.HALF_UP);
		}
		sb.append(')');
		
		return sb.toString();
	}
}
