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

import org.mifmi.commons4j.web.util.HTMLUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.html-escape")
public class StringHTMLEscapeDencoder {
	
	private StringHTMLEscapeDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrHTMLEscape(DencodeCondition cond) {
		return encStrHTMLEscape(cond.value());
	}
	
	@DencoderFunction
	public static String encStrHTMLEscapeFully(DencodeCondition cond) {
		return encStrHTMLEscapeFully(cond.value());
	}
	
	@DencoderFunction
	public static String decStrHTMLEscape(DencodeCondition cond) {
		return decStrHTMLEscape(cond.value());
	}
	
	
	private static String encStrHTMLEscape(String val) {
		return HTMLUtilz.escapeBasicHTML(val);
	}
	
	private static String encStrHTMLEscapeFully(String val) {
		return HTMLUtilz.escapeHTML5Fully(val);
	}
	
	private static String decStrHTMLEscape(String val) {
		return HTMLUtilz.unescapeHTML5(val);
	}
}
