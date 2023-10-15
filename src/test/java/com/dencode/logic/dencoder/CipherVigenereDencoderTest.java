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

import java.nio.charset.StandardCharsets;
import java.util.HashMap;

import org.junit.jupiter.api.Test;

import com.dencode.logic.model.DencodeCondition;

public class CipherVigenereDencoderTest {

	@Test
	public void test_blank() {
		// Blank
		testDencoder("", "", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "", "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "", "abcdefghijklmnopqrstuvwxyz");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "", "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "", "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ");
		
		// Unsupported characters
		testDencoder(" ", "", " ");
		testDencoder("!", "", "!");
		testDencoder("!a!", "", "!a!");
	}
	
	@Test
	public void test_A() {
		// Blank
		testDencoder("", "A", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "A", "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "A", "abcdefghijklmnopqrstuvwxyz");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "A", "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "A", "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ");
		
		// Unsupported characters
		testDencoder(" ", "A", " ");
		testDencoder("!", "A", "!");
		testDencoder("!a!", "A", "!a!");
	}
	
	@Test
	public void test_AAA() {
		// Blank
		testDencoder("", "AAA", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "AAA", "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "AAA", "abcdefghijklmnopqrstuvwxyz");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "AAA", "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "AAA", "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ");
		
		// Unsupported characters
		testDencoder(" ", "AAA", " ");
		testDencoder("!", "AAA", "!");
		testDencoder("!a!", "AAA", "!a!");
	}
	
	@Test
	public void test_SECRET() {
		// Blank
		testDencoder("", "SECRET", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "SECRET", "SFEUIYYLKAOEERQGUKKXWMAQQD");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "SECRET", "sfeuiyylkaoeerqgukkxwmaqqd");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "SECRET", "ＳＦＥＵＩＹＹＬＫＡＯＥＥＲＱＧＵＫＫＸＷＭＡＱＱＤ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "SECRET", "ｓｆｅｕｉｙｙｌｋａｏｅｅｒｑｇｕｋｋｘｗｍａｑｑｄ");
		
		// Unsupported characters
		testDencoder(" ", "SECRET", " ");
		testDencoder("!", "SECRET", "!");
		testDencoder("!a!", "SECRET", "!s!");
		
		testDencoder("!a!a!a!a!a!a!a!", "SECRET", "!s!e!c!r!e!t!s!");
	}
	
	@Test
	public void test__Se_c_r_et_() {
		// Blank
		testDencoder("", " Se c!r/et ", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", " Se c!r/et ", "SFEUIYYLKAOEERQGUKKXWMAQQD");
		testDencoder("abcdefghijklmnopqrstuvwxyz", " Se c!r/et ", "sfeuiyylkaoeerqgukkxwmaqqd");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", " Se c!r/et ", "ＳＦＥＵＩＹＹＬＫＡＯＥＥＲＱＧＵＫＫＸＷＭＡＱＱＤ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", " Se c!r/et ", "ｓｆｅｕｉｙｙｌｋａｏｅｅｒｑｇｕｋｋｘｗｍａｑｑｄ");
		
		// Unsupported characters
		testDencoder(" ", " Se c!r/et ", " ");
		testDencoder("!", " Se c!r/et ", "!");
		testDencoder("!a!", " Se c!r/et ", "!s!");
		
		testDencoder("!a!a!a!a!a!a!a!", " Se c!r/et ", "!s!e!c!r!e!t!s!");
	}

	@Test
	public void test_X() {
		// Blank
		testDencoder("", "X", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "X", "XYZABCDEFGHIJKLMNOPQRSTUVW");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "X", "xyzabcdefghijklmnopqrstuvw");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "X", "ＸＹＺＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "X", "ｘｙｚａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗ");
		
		// Unsupported characters
		testDencoder(" ", "X", " ");
		testDencoder("!", "X", "!");
		testDencoder("!a!", "X", "!x!");
	}

	@Test
	public void test_X_lower() {
		// Blank
		testDencoder("", "x", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "x", "XYZABCDEFGHIJKLMNOPQRSTUVW");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "x", "xyzabcdefghijklmnopqrstuvw");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "x", "ＸＹＺＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "x", "ｘｙｚａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗ");
		
		// Unsupported characters
		testDencoder(" ", "x", " ");
		testDencoder("!", "x", "!");
		testDencoder("!a!", "x", "!x!");
	}

	@Test
	public void test_X_fullWidth() {
		// Blank
		testDencoder("", "Ｘ", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "Ｘ", "XYZABCDEFGHIJKLMNOPQRSTUVW");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "Ｘ", "xyzabcdefghijklmnopqrstuvw");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "Ｘ", "ＸＹＺＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "Ｘ", "ｘｙｚａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗ");
		
		// Unsupported characters
		testDencoder(" ", "Ｘ", " ");
		testDencoder("!", "Ｘ", "!");
		testDencoder("!a!", "Ｘ", "!x!");
	}

	@Test
	public void test_D() {
		// Blank
		testDencoder("", "D", "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "D", "DEFGHIJKLMNOPQRSTUVWXYZABC");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "D", "defghijklmnopqrstuvwxyzabc");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "D", "ＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺＡＢＣ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "D", "ｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚａｂｃ");
		
		// Unsupported characters
		testDencoder(" ", "D", " ");
		testDencoder("!", "D", "!");
		testDencoder("!a!", "D", "!d!");
	}
	
	private void testDencoder(String value, String key, String expectedEncodedValue) {
		testDencoder(value, key, expectedEncodedValue, value);
	}
	
	private void testDencoder(String value, String key, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = CipherVigenereDencoder.encCipherVigenere(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("cipher.vigenere.key", key);
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = CipherVigenereDencoder.decCipherVigenere(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("cipher.vigenere.key", key);
			}
		}));
		if (expectedDecodedValue == null) {
			assertEquals(value, decodedValue);
		} else {
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
 }
 