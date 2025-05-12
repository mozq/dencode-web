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
package com.dencode.logic.util;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

public class ColorNameUtils {
	
	private static class RGB {
		public int rgb;
		public double r, g, b;
		public RGB(int rgb) {
			this.rgb = rgb;
			this.r = ((double)((rgb & 0x00ff0000) >> 16)) / 255.0;
			this.g = ((double)((rgb & 0x0000ff00) >> 8)) / 255.0;
			this.b = ((double)((rgb & 0x000000ff))) / 255.0;
		}
	}

	private static final Map<String, String> SYNONYM_NAME_MAP = new HashMap<>() {
		private static final long serialVersionUID = 1L;
		{
			put("cyan", "aqua");
			put("magenta", "fuchsia");
			put("darkgrey", "darkgray");
			put("darkslategrey", "darkslategray");
			put("dimgrey", "dimgray");
			put("lightgrey", "lightgray");
			put("lightslategrey", "lightslategray");
			put("grey", "gray");
			put("slategrey", "slategray");
		}
	};
	
	private static final Map<String, RGB> NAME_COLOR_MAP = new HashMap<>() {
		private static final long serialVersionUID = 1L;
		{
			put("black", new RGB(0x000000));
			put("silver", new RGB(0xc0c0c0));
			put("gray", new RGB(0x808080));
			put("white", new RGB(0xffffff));
			put("maroon", new RGB(0x800000));
			put("red", new RGB(0xff0000));
			put("purple", new RGB(0x800080));
			put("fuchsia", new RGB(0xff00ff));
			put("green", new RGB(0x008000));
			put("lime", new RGB(0x00ff00));
			put("olive", new RGB(0x808000));
			put("yellow", new RGB(0xffff00));
			put("navy", new RGB(0x000080));
			put("blue", new RGB(0x0000ff));
			put("teal", new RGB(0x008080));
			put("aqua", new RGB(0x00ffff));
			put("aliceblue", new RGB(0xf0f8ff));
			put("antiquewhite", new RGB(0xfaebd7));
			put("aqua", new RGB(0x00ffff));
			put("aquamarine", new RGB(0x7fffd4));
			put("azure", new RGB(0xf0ffff));
			put("beige", new RGB(0xf5f5dc));
			put("bisque", new RGB(0xffe4c4));
			put("black", new RGB(0x000000));
			put("blanchedalmond", new RGB(0xffebcd));
			put("blue", new RGB(0x0000ff));
			put("blueviolet", new RGB(0x8a2be2));
			put("brown", new RGB(0xa52a2a));
			put("burlywood", new RGB(0xdeb887));
			put("cadetblue", new RGB(0x5f9ea0));
			put("chartreuse", new RGB(0x7fff00));
			put("chocolate", new RGB(0xd2691e));
			put("coral", new RGB(0xff7f50));
			put("cornflowerblue", new RGB(0x6495ed));
			put("cornsilk", new RGB(0xfff8dc));
			put("crimson", new RGB(0xdc143c));
			put("darkblue", new RGB(0x00008b));
			put("darkcyan", new RGB(0x008b8b));
			put("darkgoldenrod", new RGB(0xb8860b));
			put("darkgray", new RGB(0xa9a9a9));
			put("darkgreen", new RGB(0x006400));
			put("darkkhaki", new RGB(0xbdb76b));
			put("darkmagenta", new RGB(0x8b008b));
			put("darkolivegreen", new RGB(0x556b2f));
			put("darkorange", new RGB(0xff8c00));
			put("darkorchid", new RGB(0x9932cc));
			put("darkred", new RGB(0x8b0000));
			put("darksalmon", new RGB(0xe9967a));
			put("darkseagreen", new RGB(0x8fbc8f));
			put("darkslateblue", new RGB(0x483d8b));
			put("darkslategray", new RGB(0x2f4f4f));
			put("darkturquoise", new RGB(0x00ced1));
			put("darkviolet", new RGB(0x9400d3));
			put("deeppink", new RGB(0xff1493));
			put("deepskyblue", new RGB(0x00bfff));
			put("dimgray", new RGB(0x696969));
			put("dodgerblue", new RGB(0x1e90ff));
			put("firebrick", new RGB(0xb22222));
			put("floralwhite", new RGB(0xfffaf0));
			put("forestgreen", new RGB(0x228b22));
			put("fuchsia", new RGB(0xff00ff));
			put("gainsboro", new RGB(0xdcdcdc));
			put("ghostwhite", new RGB(0xf8f8ff));
			put("gold", new RGB(0xffd700));
			put("goldenrod", new RGB(0xdaa520));
			put("gray", new RGB(0x808080));
			put("green", new RGB(0x008000));
			put("greenyellow", new RGB(0xadff2f));
			put("honeydew", new RGB(0xf0fff0));
			put("hotpink", new RGB(0xff69b4));
			put("indianred", new RGB(0xcd5c5c));
			put("indigo", new RGB(0x4b0082));
			put("ivory", new RGB(0xfffff0));
			put("khaki", new RGB(0xf0e68c));
			put("lavender", new RGB(0xe6e6fa));
			put("lavenderblush", new RGB(0xfff0f5));
			put("lawngreen", new RGB(0x7cfc00));
			put("lemonchiffon", new RGB(0xfffacd));
			put("lightblue", new RGB(0xadd8e6));
			put("lightcoral", new RGB(0xf08080));
			put("lightcyan", new RGB(0xe0ffff));
			put("lightgoldenrodyellow", new RGB(0xfafad2));
			put("lightgray", new RGB(0xd3d3d3));
			put("lightgreen", new RGB(0x90ee90));
			put("lightpink", new RGB(0xffb6c1));
			put("lightsalmon", new RGB(0xffa07a));
			put("lightseagreen", new RGB(0x20b2aa));
			put("lightskyblue", new RGB(0x87cefa));
			put("lightslategray", new RGB(0x778899));
			put("lightsteelblue", new RGB(0xb0c4de));
			put("lightyellow", new RGB(0xffffe0));
			put("lime", new RGB(0x00ff00));
			put("limegreen", new RGB(0x32cd32));
			put("linen", new RGB(0xfaf0e6));
			put("maroon", new RGB(0x800000));
			put("mediumaquamarine", new RGB(0x66cdaa));
			put("mediumblue", new RGB(0x0000cd));
			put("mediumorchid", new RGB(0xba55d3));
			put("mediumpurple", new RGB(0x9370db));
			put("mediumseagreen", new RGB(0x3cb371));
			put("mediumslateblue", new RGB(0x7b68ee));
			put("mediumspringgreen", new RGB(0x00fa9a));
			put("mediumturquoise", new RGB(0x48d1cc));
			put("mediumvioletred", new RGB(0xc71585));
			put("midnightblue", new RGB(0x191970));
			put("mintcream", new RGB(0xf5fffa));
			put("mistyrose", new RGB(0xffe4e1));
			put("moccasin", new RGB(0xffe4b5));
			put("navajowhite", new RGB(0xffdead));
			put("navy", new RGB(0x000080));
			put("oldlace", new RGB(0xfdf5e6));
			put("olive", new RGB(0x808000));
			put("olivedrab", new RGB(0x6b8e23));
			put("orange", new RGB(0xffa500));
			put("orangered", new RGB(0xff4500));
			put("orchid", new RGB(0xda70d6));
			put("palegoldenrod", new RGB(0xeee8aa));
			put("palegreen", new RGB(0x98fb98));
			put("paleturquoise", new RGB(0xafeeee));
			put("palevioletred", new RGB(0xdb7093));
			put("papayawhip", new RGB(0xffefd5));
			put("peachpuff", new RGB(0xffdab9));
			put("peru", new RGB(0xcd853f));
			put("pink", new RGB(0xffc0cb));
			put("plum", new RGB(0xdda0dd));
			put("powderblue", new RGB(0xb0e0e6));
			put("purple", new RGB(0x800080));
			put("red", new RGB(0xff0000));
			put("rosybrown", new RGB(0xbc8f8f));
			put("royalblue", new RGB(0x4169e1));
			put("saddlebrown", new RGB(0x8b4513));
			put("salmon", new RGB(0xfa8072));
			put("sandybrown", new RGB(0xf4a460));
			put("seagreen", new RGB(0x2e8b57));
			put("seashell", new RGB(0xfff5ee));
			put("sienna", new RGB(0xa0522d));
			put("silver", new RGB(0xc0c0c0));
			put("skyblue", new RGB(0x87ceeb));
			put("slateblue", new RGB(0x6a5acd));
			put("slategray", new RGB(0x708090));
			put("snow", new RGB(0xfffafa));
			put("springgreen", new RGB(0x00ff7f));
			put("steelblue", new RGB(0x4682b4));
			put("tan", new RGB(0xd2b48c));
			put("teal", new RGB(0x008080));
			put("thistle", new RGB(0xd8bfd8));
			put("tomato", new RGB(0xff6347));
			put("turquoise", new RGB(0x40e0d0));
			put("violet", new RGB(0xee82ee));
			put("wheat", new RGB(0xf5deb3));
			put("white", new RGB(0xffffff));
			put("whitesmoke", new RGB(0xf5f5f5));
			put("yellow", new RGB(0xffff00));
			put("yellowgreen", new RGB(0x9acd32));
		}
	};
	
	private static final Map<Integer, String> COLOR_NAME_MAP = NAME_COLOR_MAP.entrySet().stream()
			.collect(Collectors.toMap(el -> el.getValue().rgb, Map.Entry::getKey));
	
	
	private ColorNameUtils() {
		// NOP
	}
	
	public static double[] toRGBA(String name) {
		if (name == null) {
			return null;
		}
		
		String n = SYNONYM_NAME_MAP.getOrDefault(name, name);
		RGB rgb = NAME_COLOR_MAP.get(n);
		if (rgb == null) {
			return null;
		}
		
		return new double[] {rgb.r, rgb.g, rgb.b, 1.0};
	}
	
	public static String toName(double[] rgba) {
		if (rgba == null) {
			return null;
		}
		
		int r8 = (int)(rgba[0] * 255);
		int g8 = (int)(rgba[1] * 255);
		int b8 = (int)(rgba[2] * 255);
		
		int rgb = (r8 << 16) | (g8 << 8) | b8;
		
		String name = COLOR_NAME_MAP.get(rgb);
		
		return name;
	}
}
