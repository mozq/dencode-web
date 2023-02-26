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

public class StringBase32DencoderTest {
	
	@Test
	public void test() {
		// Blank
		testDencoder("", "");
		
		// ASCII
		testDencoder("A", "IE======");
		testDencoder("AA", "IFAQ====");
		testDencoder("AAA", "IFAUC===");
		testDencoder("AAAA", "IFAUCQI=");
		testDencoder("AAAAA", "IFAUCQKB");
		testDencoder("AAAAAA", "IFAUCQKBIE======");
		testDencoder("AAAAAAA", "IFAUCQKBIFAQ====");
		
		// non-ASCII (Latin-1)
		testDencoder("ä", "YOSA====");
		testDencoder("ää", "YOSMHJA=");
		testDencoder("äää", "YOSMHJGDUQ======");
		testDencoder("ääää", "YOSMHJGDUTB2I===");
		
		// non-ASCII (Japanese)
		testDencoder("ア", "4OBKE===");
		testDencoder("アア", "4OBKFY4CUI======");
		testDencoder("アアア", "4OBKFY4CULRYFIQ=");
		
		// non-BMP
		testDencoder("😀", "6CPZRAA=");
		testDencoder("😀😀", "6CPZRAHQT6MIA===");
		testDencoder("😀😀😀", "6CPZRAHQT6MIB4E7TCAA====");
	}
	
	@Test
	public void test_decoder() {
		// Blank
		testDecoder("", "");
		
		// Case
		testDecoder("IFAUCQKBIFAQ====", "AAAAAAA");
		testDecoder("ifaucqkbifaq====", "AAAAAAA");
		
		// Padding
		testDecoder("IE======", "A");
		testDecoder("IE=====", "A");
		testDecoder("IE====", "A");
		testDecoder("IE===", "A");
		testDecoder("IE==", "A");
		testDecoder("IE=", "A");
		testDecoder("IE", "A");
		
		// Trailing white-spaces
		testDecoder("IE ==\t====\r\n", "A");
		
		// White-space (Ignore SPACE, TAB, CR and LF)
		testDecoder("IF AU\tCQK\r\nBIE======", "AAAAAA");
	}
	
	private void testDencoder(String value, String expectedEncodedValue) {
		testDencoder(value, expectedEncodedValue, value);
	}
	
	private void testDencoder(String value, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = StringBase32Dencoder.encStrBase32(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = StringBase32Dencoder.decStrBase32(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedDecodedValue, decodedValue);
	}
	
	private void testDecoder(String value, String expectedDecodedValue) {
		String decodedValue = StringBase32Dencoder.decStrBase32(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedDecodedValue, decodedValue);
	}
 }
 