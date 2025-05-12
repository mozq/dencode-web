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

import java.util.List;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.text-initials", hasEncoder=true, hasDecoder=false)
public class StringTextInitialsDencoder {
	
	private StringTextInitialsDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrInitials(DencodeCondition cond) {
		return encStrInitials(cond.valueAsLines());
	}
	
	
	private static String encStrInitials(List<String> vals) {
		return DencodeUtils.dencodeLines(vals, (val) -> initials(val));
	}
	
	private static String initials(String str) {
		if (str == null || str.isEmpty()) {
			return str;
		}
		
		boolean first = true;
		int len = str.length();
		StringBuilder sb = new StringBuilder(len / 2 + 1);
		for (int i = 0; i < len; ) {
			int cp = str.codePointAt(i);
			
			boolean nextFirst = Character.isWhitespace(cp);

			if (first && !nextFirst) {
				sb.appendCodePoint(cp);
			}
			
			first = nextFirst;
			i += Character.charCount(cp);
		}
		
		return sb.toString();
	}
}
