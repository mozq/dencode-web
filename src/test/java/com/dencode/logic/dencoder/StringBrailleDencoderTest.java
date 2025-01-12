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

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;

import org.junit.jupiter.api.Test;

import com.dencode.logic.model.DencodeCondition;

public class StringBrailleDencoderTest {
	
	@Test
	public void testUEB1() {
		// Blank
		testDencoder("", "ueb1", "");
		
		// Letters
		testDencoder("a", "ueb1", "⠁");
		testDencoder("A", "ueb1", "⠠⠁");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "ueb1", "⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵");
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "ueb1", "⠠⠠⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵");
		
		// Letters & Whitespace
		testDencoder(" abcdefg hijklmnop   qrstuv wxyz ", "ueb1", "⠀⠁⠃⠉⠙⠑⠋⠛⠀⠓⠊⠚⠅⠇⠍⠝⠕⠏⠀⠀⠀⠟⠗⠎⠞⠥⠧⠀⠺⠭⠽⠵⠀");
		testDencoder(" ABCDEFG HIJKLMNOP   QRSTUV WXYZ ", "ueb1", "⠀⠠⠠⠠⠁⠃⠉⠙⠑⠋⠛⠀⠓⠊⠚⠅⠇⠍⠝⠕⠏⠀⠀⠀⠟⠗⠎⠞⠥⠧⠀⠺⠭⠽⠵⠀⠠⠄");
		
		// Numbers
		testDencoder("1234567890", "ueb1", "⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚");
		testDencoder("1,234,567,890", "ueb1", "⠼⠁⠂⠃⠉⠙⠂⠑⠋⠛⠂⠓⠊⠚");
		testDencoder("1 234 567 890", "ueb1", "⠼⠁⠐⠃⠉⠙⠐⠑⠋⠛⠐⠓⠊⠚"); // U+2007 Numeric space
		testDencoder("12345.67890", "ueb1", "⠼⠁⠃⠉⠙⠑⠲⠋⠛⠓⠊⠚");
		testDencoder("abc1234567890abc", "ueb1", "⠁⠃⠉⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠰⠁⠃⠉");
		testDencoder("abc 1234567890 abc", "ueb1", "⠁⠃⠉⠀⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠀⠁⠃⠉");
		testDencoder("ABC1234567890ABC", "ueb1", "⠠⠠⠁⠃⠉⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠠⠠⠁⠃⠉");
		testDencoder("ABC 1234567890 ABC", "ueb1", "⠠⠠⠠⠁⠃⠉⠀⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠀⠁⠃⠉⠠⠄");
		testDencoder("2012/01/23", "ueb1", "⠼⠃⠚⠁⠃⠸⠌⠼⠚⠁⠸⠌⠼⠃⠉");
		testDencoder("2012-01-23", "ueb1", "⠼⠃⠚⠁⠃⠤⠼⠚⠁⠤⠼⠃⠉");
		testDencoder("100g", "ueb1", "⠼⠁⠚⠚⠰⠛");
		testDencoder("'90's", "ueb1", "⠄⠼⠊⠚⠄⠎");
		testDencoder("-20%", "ueb1", "⠤⠼⠃⠚⠨⠴"); // Hyphen
		testDencoder("−20%", "ueb1", "⠐⠤⠼⠃⠚⠨⠴"); // U+2212 Minus sign
		
		// Symbols - ASCII
		testDencoder("!\"#$%&'()*+,-./", "ueb1", "⠖⠠⠶⠸⠹⠈⠎⠨⠴⠈⠯⠄⠐⠣⠐⠜⠐⠔⠐⠖⠂⠤⠲⠸⠌"); // ASCII 0x2x
		testDencoder(":;<=>?", "ueb1", "⠒⠆⠈⠣⠐⠶⠈⠜⠦"); // ASCII 0x3x
		testDencoder("@", "ueb1", "⠈⠁"); //0x4x
		testDencoder("[\\]^_", "ueb1", "⠨⠣⠸⠡⠨⠜⠈⠢⠨⠤"); // ASCII 0x5x
		testDencoder("`", "ueb1", "⠘⠡"); // ASCII 0x6x
		testDencoder("{|}~", "ueb1", "⠸⠣⠸⠳⠸⠜⠈⠔"); // ASCII 0x7x
		
		// Symbols - Non-ASCII
		testDencoder("£₣¢€$₦¥", "ueb1", "⠈⠇⠈⠋⠈⠉⠈⠑⠈⠎⠈⠝⠈⠽");
		testDencoder("®©´`™°♀♂¶§", "ueb1", "⠘⠗⠘⠉⠘⠌⠘⠡⠘⠞⠘⠚⠘⠭⠘⠽⠘⠏⠘⠎");
		testDencoder("•", "ueb1", "⠸⠲");
		testDencoder("〃×÷*−", "ueb1", "⠐⠂⠐⠦⠐⠌⠐⠔⠐⠤");
		testDencoder("†‡", "ueb1", "⠈⠠⠹⠈⠠⠻");
		testDencoder("¡¿", "ueb1", "⠘⠰⠖⠘⠰⠦");
		
		// Quotation marks and brackets
		testDencoder("\"Hello, world?\"", "ueb1", "⠦⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠴"); // Non-specific quotation
		testDencoder("“Hello, world?”", "ueb1", "⠘⠦⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠘⠴"); // U+201C, U+201D
		testDencoder("'Hello, world?'", "ueb1", "⠄⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠄"); // This is an apostrophe, not quotation marks
		testDencoder("‘Hello, world?’", "ueb1", "⠠⠦⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠴"); // U+2018, U+2019
		testDencoder("<Hello, world?>", "ueb1", "⠈⠣⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠈⠜");
		testDencoder("{Hello, world?}", "ueb1", "⠸⠣⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠸⠜");
		testDencoder("[Hello, world?]", "ueb1", "⠨⠣⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠨⠜");
		testDencoder("(Hello, world?)", "ueb1", "⠐⠣⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠐⠜");
		
		testDencoder("Abc \"HELLO, WORLD?\" Abc", "ueb1", "⠠⠁⠃⠉⠀⠦⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠴⠀⠠⠁⠃⠉"); // Non-specific quotation
		testDencoder("Abc “HELLO, WORLD?” Abc", "ueb1", "⠠⠁⠃⠉⠀⠘⠦⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠘⠴⠀⠠⠁⠃⠉"); // U+201C, U+201D
		testDencoder("Abc 'HELLO, WORLD?' Abc", "ueb1", "⠠⠁⠃⠉⠀⠄⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠄⠀⠁⠠⠄⠃⠉"); // This is an apostrophe, not quotation marks
		testDencoder("Abc ‘HELLO, WORLD?’ Abc", "ueb1", "⠠⠁⠃⠉⠀⠠⠦⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠠⠴⠀⠠⠁⠃⠉"); // U+2018, U+2019
		testDencoder("Abc <HELLO, WORLD?> Abc", "ueb1", "⠠⠁⠃⠉⠀⠈⠣⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠈⠜⠀⠠⠁⠃⠉");
		testDencoder("Abc {HELLO, WORLD?} Abc", "ueb1", "⠠⠁⠃⠉⠀⠸⠣⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠸⠜⠀⠠⠁⠃⠉");
		testDencoder("Abc [HELLO, WORLD?] Abc", "ueb1", "⠠⠁⠃⠉⠀⠨⠣⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠨⠜⠀⠠⠁⠃⠉");
		testDencoder("Abc (HELLO, WORLD?) Abc", "ueb1", "⠠⠁⠃⠉⠀⠐⠣⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠐⠜⠀⠠⠁⠃⠉");
		
		// Dash
		testDencoder("a - z", "ueb1", "⠁⠀⠤⠀⠵"); // Hyphen
		testDencoder("a -- z", "ueb1", "⠁⠀⠤⠤⠀⠵"); // Hyphen x 2
		testDencoder("a — z", "ueb1", "⠁⠀⠠⠤⠀⠵"); // Em Dash
		testDencoder("a —— z", "ueb1", "⠁⠀⠐⠠⠤⠀⠵"); // Em Dash x 2 ( Long Dash)
		
		// Case
		testDencoder("B&B", "ueb1", "⠠⠃⠈⠯⠠⠃");
		testDencoder("STOP!", "ueb1", "⠠⠠⠎⠞⠕⠏⠖");
		testDencoder("ABCs", "ueb1", "⠠⠠⠁⠃⠉⠠⠄⠎");
		testDencoder("BOB'S CAFE", "ueb1", "⠠⠠⠠⠃⠕⠃⠄⠎⠀⠉⠁⠋⠑⠠⠄");
		testDencoder("BOB's CAFE", "ueb1", "⠠⠠⠃⠕⠃⠄⠎⠀⠠⠠⠉⠁⠋⠑");
		testDencoder("MERRY-GO-ROUND", "ueb1", "⠠⠠⠍⠑⠗⠗⠽⠤⠠⠠⠛⠕⠤⠠⠠⠗⠕⠥⠝⠙");
		testDencoder("CAUTION: 10 MPH LIMIT", "ueb1", "⠠⠠⠠⠉⠁⠥⠞⠊⠕⠝⠒⠀⠼⠁⠚⠀⠍⠏⠓⠀⠇⠊⠍⠊⠞⠠⠄");
		testDencoder("PUT THE \"GIVE\" IN THANKSGIVING", "ueb1", "⠠⠠⠠⠏⠥⠞⠀⠞⠓⠑⠀⠦⠛⠊⠧⠑⠴⠀⠊⠝⠀⠞⠓⠁⠝⠅⠎⠛⠊⠧⠊⠝⠛⠠⠄");
		testDencoder("The crowd shouted \"STOP THAT BALL!\"", "ueb1", "⠠⠞⠓⠑⠀⠉⠗⠕⠺⠙⠀⠎⠓⠕⠥⠞⠑⠙⠀⠦⠠⠠⠠⠎⠞⠕⠏⠀⠞⠓⠁⠞⠀⠃⠁⠇⠇⠖⠠⠄⠴");
	}
	
	private void testDencoder(String value, String variant, String expectedEncodedValue) {
		testDencoder(value, variant, expectedEncodedValue, null);
	}
	
	private void testDencoder(String value, String variant, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = StringBrailleDencoder.encStrBraille(condition(value, variant));
		assertEquals(expectedEncodedValue, encodedValue);
		String decodedValue = StringBrailleDencoder.decStrBraille(condition(encodedValue, variant));
		if (expectedDecodedValue == null) {
			assertEquals(value, decodedValue);
		} else {
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
	
	private DencodeCondition condition(String value, String variant) {
		return condition(value, StandardCharsets.UTF_8, variant);
	}
	
	private DencodeCondition condition(String value, Charset charset, String variant) {
		return new DencodeCondition(value, charset, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("string.braille.variant", variant);
			}
		});
	}
 }
 