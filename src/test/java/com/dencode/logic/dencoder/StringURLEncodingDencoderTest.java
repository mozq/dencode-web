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

public class StringURLEncodingDencoderTest {
	
	@Test
	public void test_default() {
		// Blank
		testDencoder("", "", "");
		
		// A-Z 0-9
		testDencoder("AZaz09", "", "AZaz09");
		
		// Symbol (Space)
		testDencoder(" ", "", "%20");
		
		// Symbol (Reserved)
		testDencoder("%:/?=*()", "", "%25%3A%2F%3F%3D%2A%28%29");
		
		// Symbol (Unreserved)
		testDencoder("-._~", "", "-._~");
		
		// Control
		testDencoder("\0\t\r\n", "", "%00%09%0D%0A");
		
		// non-ASCII (Latin-1)
		testDencoder("ä", "", "%C3%A4");
		
		// non-ASCII (Japanese)
		testDencoder("ア", "", "%E3%82%A2");
		
		// non-BMP
		testDencoder("😀", "", "%F0%9F%98%80");
	}
	
	@Test
	public void test_form() {
		// Blank
		testDencoder("", "form", "");
		
		// A-Z 0-9
		testDencoder("AZaz09", "form", "AZaz09");
		
		// Symbol (Space)
		testDencoder(" ", "form", "+");
		
		// Symbol (Reserved)
		testDencoder("%:/?=*()", "form", "%25%3A%2F%3F%3D%2A%28%29");
		
		// Symbol (Unreserved)
		testDencoder("-._~", "form", "-._~");
		
		// Control
		testDencoder("\0\t\r\n", "form", "%00%09%0D%0A");
		
		// non-ASCII (Latin-1)
		testDencoder("ä", "form", "%C3%A4");
		
		// non-ASCII (Japanese)
		testDencoder("ア", "form", "%E3%82%A2");
		
		// non-BMP
		testDencoder("😀", "form", "%F0%9F%98%80");
	}
	
	@Test
	public void test_decoder() {
		// Blank
		testDecoder("", "");
		
		// Supported character
		testDecoder("AZaz09", "AZaz09");
		
		// Symbol (Unreserved)
		testDecoder("-._~", "-._~");
		
		// Unsupported character
		testDecoder("ア", null);
		testDecoder("😀", null);
		
		// Illegal format
		testDecoder("%", null);
		testDecoder("%x", null);
		testDecoder("%%", null);
		testDecoder("%2", null);
		testDecoder("%2x", null);
		
		// Lower case
		testDecoder("%3a", ":");
		
		// Mixed
		testDecoder("A%20Z+0%F0%9f%98%809", "A Z 0😀9");
	}
	
	private void testDencoder(String value, String space, String expectedEncodedValue) {
		testDencoder(value, space, expectedEncodedValue, value);
	}
	
	private void testDencoder(String value, String space, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = StringURLEncodingDencoder.encStrURLEncoding(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("encStrURLEncodingSpace", space);
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = StringURLEncodingDencoder.decStrURLEncoding(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedDecodedValue, decodedValue);
	}
	
	private void testDecoder(String value, String expectedDecodedValue) {
		String decodedValue = StringURLEncodingDencoder.decStrURLEncoding(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedDecodedValue, decodedValue);
	}
 }
 