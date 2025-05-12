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
package com.dencode.logic.parser;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.dencode.logic.util.ColorNameUtils;

public class ColorParser {
	
	private static final int COLOR_MAX_LENGTH = 50;
	
	private static final Pattern COLOR_RGB_HEX3_PATTERN = Pattern.compile("^#?([0-9a-f])([0-9a-f])([0-9a-f])([0-9a-f])?$");
	private static final Pattern COLOR_RGB_HEX6_PATTERN = Pattern.compile("^#?([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])?$");
	private static final Pattern COLOR_RGB_COMMA_PATTERN = Pattern.compile("^(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*[,/]\\s*(\\+?[0-9\\.]+%?))?$");
	private static final Pattern COLOR_RGB_FN_PATTERN = Pattern.compile("^rgba?\\s*\\(\\s*(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*[,/]\\s*(\\+?[0-9\\.]+%?))?\\s*\\)$");
	private static final Pattern COLOR_HSL_FN_PATTERN = Pattern.compile("^hsla?\\s*\\(\\s*([\\+\\-]?[0-9\\.]+)(?:deg)?(?:\\s*,\\s*|\\s+)([\\+\\-]?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)([\\+\\-]?[0-9\\.]+%?)(?:\\s*[,/]\\s*(\\+?[0-9\\.]+%?))?\\s*\\)$");
	private static final Pattern COLOR_HSV_FN_PATTERN = Pattern.compile("^hsva?\\s*\\(\\s*([\\+\\-]?[0-9\\.]+)(?:deg)?(?:\\s*,\\s*|\\s+)([\\+\\-]?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)([\\+\\-]?[0-9\\.]+%?)(?:\\s*[,/]\\s*(\\+?[0-9\\.]+%?))?\\s*\\)$");
	private static final Pattern COLOR_HWB_FN_PATTERN = Pattern.compile("^hwba?\\s*\\(\\s*([\\+\\-]?[0-9\\.]+)(?:deg)?(?:\\s*,\\s*|\\s+)([\\+\\-]?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)([\\+\\-]?[0-9\\.]+%?)(?:\\s*[,/]\\s*(\\+?[0-9\\.]+%?))?\\s*\\)$");
	private static final Pattern COLOR_GRAY_FN_PATTERN = Pattern.compile("^graya?\\s*\\(\\s*(\\+?[0-9\\.]+%?)(?:\\s*[,/]\\s*(\\+?[0-9\\.]+%?))?\\s*\\)$");
	private static final Pattern COLOR_CMY_FN_PATTERN = Pattern.compile("^(?:device-)?cmya?\\s*\\(\\s*(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*[,/]\\s*(\\+?[0-9\\.]+%?))?\\s*\\)$");
	private static final Pattern COLOR_CMYK_FN_PATTERN = Pattern.compile("^(?:device-)?cmyka?\\s*\\(\\s*(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*,\\s*|\\s+)(\\+?[0-9\\.]+%?)(?:\\s*[,/]\\s*(\\+?[0-9\\.]+%?))?\\s*\\)$");
	
	private ColorParser() {
		// NOP
	}
	
	public static double[] parseColor(String val) {
		if (val == null || val.isEmpty()) {
			return null;
		}
		
		if (COLOR_MAX_LENGTH < val.length()) {
			return null;
		}
		
		String lv = val.trim().toLowerCase();
		
		double[] namedColor = ColorNameUtils.toRGBA(lv);
		if (namedColor != null) {
			return namedColor;
		}
		
		try {
			if (lv.startsWith("rgb")) {
				Matcher rgbFnMatcher = COLOR_RGB_FN_PATTERN.matcher(lv);
				if (rgbFnMatcher.matches()) {
					double r = parseToRate(rgbFnMatcher.group(1), 255.0);
					double g = parseToRate(rgbFnMatcher.group(2), 255.0);
					double b = parseToRate(rgbFnMatcher.group(3), 255.0);
					double a = parseToRate(rgbFnMatcher.group(4), 1.0, 1.0);
					
					r = Math.min(Math.max(r, 0.0), 1.0);
					g = Math.min(Math.max(g, 0.0), 1.0);
					b = Math.min(Math.max(b, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new double[] {r, g, b, a};
				}
			} else if (lv.startsWith("hsl")) {
				Matcher hslFnMatcher = COLOR_HSL_FN_PATTERN.matcher(lv);
				if (hslFnMatcher.matches()) {
					double h = Double.parseDouble(hslFnMatcher.group(1));
					double s = parseToRate(hslFnMatcher.group(2), 1.0);
					double l = parseToRate(hslFnMatcher.group(3), 1.0);
					double a = parseToRate(hslFnMatcher.group(4), 1.0, 1.0);
					
					h = Math.min(Math.max(h, 0.0), 360.0);
					s = Math.min(Math.max(s, 0.0), 1.0);
					l = Math.min(Math.max(l, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return fromHSL(h, s, l, a);
				}
			} else if (lv.startsWith("hsv")) {
				Matcher hsvFnMatcher = COLOR_HSV_FN_PATTERN.matcher(lv);
				if (hsvFnMatcher.matches()) {
					double h = Double.parseDouble(hsvFnMatcher.group(1));
					double s = parseToRate(hsvFnMatcher.group(2), 1.0);
					double v = parseToRate(hsvFnMatcher.group(3), 1.0);
					double a = parseToRate(hsvFnMatcher.group(4), 1.0, 1.0);
					
					h = Math.min(Math.max(h, 0.0), 360.0);
					s = Math.min(Math.max(s, 0.0), 1.0);
					v = Math.min(Math.max(v, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return fromHSV(h, s, v, a);
				}
			} else if (lv.startsWith("hwb")) {
				Matcher hwbFnMatcher = COLOR_HWB_FN_PATTERN.matcher(lv);
				if (hwbFnMatcher.matches()) {
					double h = Double.parseDouble(hwbFnMatcher.group(1));
					double w = parseToRate(hwbFnMatcher.group(2), 1.0);
					double b = parseToRate(hwbFnMatcher.group(3), 1.0);
					double a = parseToRate(hwbFnMatcher.group(4), 1.0, 1.0);
					
					h = Math.min(Math.max(h, 0.0), 360.0);
					w = Math.min(Math.max(w, 0.0), 1.0);
					b = Math.min(Math.max(b, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return fromHWB(h, w, b, a);
				}
			} else if (lv.startsWith("gray")) {
				Matcher grayFnMatcher = COLOR_GRAY_FN_PATTERN.matcher(lv);
				if (grayFnMatcher.matches()) {
					double g = parseToRate(grayFnMatcher.group(1), 255.0);
					double a = parseToRate(grayFnMatcher.group(2), 1.0, 1.0);
					
					g = Math.min(Math.max(g, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new double[] {g, g, g, a};
				}
			} else if (lv.startsWith("cmyk") || lv.startsWith("device-cmyk")) {
				Matcher cmykFnMatcher = COLOR_CMYK_FN_PATTERN.matcher(lv);
				if (cmykFnMatcher.matches()) {
					double c = parseToRate(cmykFnMatcher.group(1), 1.0);
					double m = parseToRate(cmykFnMatcher.group(2), 1.0);
					double y = parseToRate(cmykFnMatcher.group(3), 1.0);
					double k = parseToRate(cmykFnMatcher.group(4), 1.0);
					double a = parseToRate(cmykFnMatcher.group(5), 1.0, 1.0);
					
					c = Math.min(Math.max(c, 0.0), 1.0);
					m = Math.min(Math.max(m, 0.0), 1.0);
					y = Math.min(Math.max(y, 0.0), 1.0);
					k = Math.min(Math.max(k, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return fromCMYK(c, m, y, k, a);
				}
			} else if (lv.startsWith("cmy") || lv.startsWith("device-cmy")) {
				Matcher cmyFnMatcher = COLOR_CMY_FN_PATTERN.matcher(lv);
				if (cmyFnMatcher.matches()) {
					double c = parseToRate(cmyFnMatcher.group(1), 1.0);
					double m = parseToRate(cmyFnMatcher.group(2), 1.0);
					double y = parseToRate(cmyFnMatcher.group(3), 1.0);
					double a = parseToRate(cmyFnMatcher.group(4), 1.0, 1.0);

					c = Math.min(Math.max(c, 0.0), 1.0);
					m = Math.min(Math.max(m, 0.0), 1.0);
					y = Math.min(Math.max(y, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);

					return fromCMY(c, m, y, a);
				}
			} else {
				Matcher rgbHex6Matcher= COLOR_RGB_HEX6_PATTERN.matcher(lv);
				if (rgbHex6Matcher.matches()) {
					int r = Integer.parseInt(rgbHex6Matcher.group(1), 16);
					int g = Integer.parseInt(rgbHex6Matcher.group(2), 16);
					int b = Integer.parseInt(rgbHex6Matcher.group(3), 16);
					double a;
					if (rgbHex6Matcher.group(4) != null) {
						a = ((double) Integer.parseInt(rgbHex6Matcher.group(4), 16)) / 255.0;
					} else {
						a = 1.0;
					}
					
					return new double[] {
							((double) r) / 255.0,
							((double) g) / 255.0,
							((double) b) / 255.0,
							a
							};
				}
	
				Matcher rgbHex3Matcher = COLOR_RGB_HEX3_PATTERN.matcher(lv);
				if (rgbHex3Matcher.matches()) {
					int r = Integer.parseInt(rgbHex3Matcher.group(1), 16);
					int g = Integer.parseInt(rgbHex3Matcher.group(2), 16);
					int b = Integer.parseInt(rgbHex3Matcher.group(3), 16);
					
					r = (r << 4) | r;
					g = (g << 4) | g;
					b = (b << 4) | b;

					double a;
					if (rgbHex3Matcher.group(4) != null) {
						int a8 = Integer.parseInt(rgbHex3Matcher.group(4), 16);
						a8 = (a8 << 4) | a8;
						a = ((double) a8) / 255.0;
					} else {
						a = 1.0;
					}
					
					return new double[] {
							((double) r) / 255.0,
							((double) g) / 255.0,
							((double) b) / 255.0,
							a
							};
				}
	
				Matcher rgbCommaMatcher = COLOR_RGB_COMMA_PATTERN.matcher(lv);
				if (rgbCommaMatcher.matches()) {
					double r = parseToRate(rgbCommaMatcher.group(1), 255.0);
					double g = parseToRate(rgbCommaMatcher.group(2), 255.0);
					double b = parseToRate(rgbCommaMatcher.group(3), 255.0);
					double a = parseToRate(rgbCommaMatcher.group(4), 1.0, 1.0);

					r = Math.min(Math.max(r, 0.0), 1.0);
					g = Math.min(Math.max(g, 0.0), 1.0);
					b = Math.min(Math.max(b, 0.0), 1.0);
					a = Math.min(Math.max(a, 0.0), 1.0);
					
					return new double[] {r, g, b, a};
				}
				
			}
		} catch (NumberFormatException e) {
			return null;
		}
		
		return null;
	}
	
	private static double parseToRate(String val, double base) {
		return parseToRate(val, base, 0.0);
	}
	
	private static double parseToRate(String val, double base, double defaultVal) {
		if (val == null) {
			return defaultVal;
		}
		
		if (val.endsWith("%")) {
			// percentage
			String v = val.substring(0, val.length() - 1);
			return Double.parseDouble(v) / 100.0;
		} else {
			double d = Double.parseDouble(val);
			if (d < 1.0 || (d == 1.0 && val.indexOf('.') != -1)) {
				// rate
				return Double.parseDouble(val);
			} else {
				// value
				return Double.parseDouble(val) / base;
			}
		}
	}
	
	private static double[] fromHSL(double h, double s, double l, double a) {
		double q;
		if (l <= 0.5) {
			q = l * (1.0 + s);
		} else {
			q = l + s - l * s;
		}
		double p = 2.0 * l - q;
		
		double r = hue2rgb(q, p, h + 120.0);
		double g = hue2rgb(q, p, h);
		double b = hue2rgb(q, p, h - 120.0);
		
		return new double[] {r, g, b, a};
	}
	
	private static double hue2rgb(double p, double q, double hue) {
		hue = (hue + 180.0) % 360.0;
		if (hue < 60.0) {
			return p + (q - p) * hue / 60.0;
		} else if (hue < 180.0) {
			return q;
		} else if (hue < 240.0) {
			return p + (q - p) * (240.0 - hue) / 60.0;
		} else {
			return p;
		}
	}
	
	private static double[] fromHSV(double h, double s, double v, double a) {
		double hue = h % 360.0;
		if (hue < 0) {
			hue += 360.0;
		}
		
		int i = (int) (hue / 60.0);
		double f = hue / 60.0 - (double) i;
		double p = v * (1 - s);
		double q = v * (1 - f * s);
		double t = v * (1 - (1 - f) * s);
		
		return switch (i) {
			case 0 -> new double[] {v, t, p, a};
			case 1 -> new double[] {q, v, p, a};
			case 2 -> new double[] {p, v, t, a};
			case 3 -> new double[] {p, q, v, a};
			case 4 -> new double[] {t, p, v, a};
			case 5 -> new double[] {v, p, q, a};
			default -> throw new IllegalStateException();
		};
	}
	
	private static double[] fromHWB(double h, double w, double b, double a) {
		double hue = h % 360.0;
		if (hue < 0.0) {
			hue += 360.0;
		}
		
		double d = 1.0 - w - b;
		d = Math.min(d, 0.0);
		
		double[] rgba = fromHSL(hue, 1.0, 0.5, a);
		rgba[0] = rgba[0] * d + w; // R
		rgba[1] = rgba[1] * d + w; // G
		rgba[2] = rgba[2] * d + w; // B
		
		return rgba;
	}
	
	private static double[] fromCMYK(double c, double m, double y, double k, double a) {
		double r = 1.0 - Math.min(1.0, c + k);
		double g = 1.0 - Math.min(1.0, m + k);
		double b = 1.0 - Math.min(1.0, y + k);
		
		return new double[] {r, g, b, a};
	}
	
	private static double[] fromCMY(double c, double m, double y, double a) {
		double r = 1.0 - c;
		double g = 1.0 - m;
		double b = 1.0 - y;
		
		return new double[] {r, g, b, a};
	}
}
