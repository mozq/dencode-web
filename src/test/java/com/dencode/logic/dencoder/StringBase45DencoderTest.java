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

public class StringBase45DencoderTest {
	
	@Test
	public void test() {
		testDencoder("AB", "BB8");
		testDencoder("Hello!!", "%69 VD92EX0");
		testDencoder("base-45", "UJCLQE7W581");
		testDencoder("ietf!", "QED8WEX0");
		
		testDencoder("テスト", "DYSG2HUNGDYS13");
		testDencoder("A", "K1");
		testDencoder("😀", "*IUPCJ");
		testDencoder("\0", "00");
		testDencoder("\0\0", "000");
		testDencoder("", "");
		
		// Boundary value - Partial chunk
		assertEquals("\u0000", StringBase45Dencoder.decStrBase45(condition("00", StandardCharsets.ISO_8859_1)));
		assertEquals("\u00FF", StringBase45Dencoder.decStrBase45(condition("U5", StandardCharsets.ISO_8859_1)));
		assertEquals(null, StringBase45Dencoder.decStrBase45(condition("V5", StandardCharsets.ISO_8859_1))); // Overflow: 0x100
		
		// Boundary value - Full chunk
		assertEquals("\u0000", StringBase45Dencoder.decStrBase45(condition("000", StandardCharsets.UTF_16BE)));
		assertEquals("\u00FF", StringBase45Dencoder.decStrBase45(condition("U50", StandardCharsets.UTF_16BE)));
		assertEquals("\u0100", StringBase45Dencoder.decStrBase45(condition("V50", StandardCharsets.UTF_16BE)));
		assertEquals("\uFFFF", StringBase45Dencoder.decStrBase45(condition("FGW", StandardCharsets.UTF_16BE)));
		assertEquals(null, StringBase45Dencoder.decStrBase45(condition("GGW", StandardCharsets.UTF_16BE))); // Overflow: 0x10000
	}
	
	private void testDencoder(String value, String expectedEncodedValue) {
		String encodedValue = StringBase45Dencoder.encStrBase45(condition(value));
		assertEquals(expectedEncodedValue, encodedValue);
		String decodedValue = StringBase45Dencoder.decStrBase45(condition(encodedValue));
		assertEquals(value, decodedValue);
	}
	
	private DencodeCondition condition(String value) {
		return condition(value, StandardCharsets.UTF_8);
	}
	
	private DencodeCondition condition(String value, Charset charset) {
		return new DencodeCondition(value, charset, "\r\n", null, new HashMap<>());
	}
 }
 