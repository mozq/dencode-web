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

public class StringBase64DencoderTest {
	
	@Test
	public void test() {
		// Blank
		testDencoder("", "", "");
		
		// ASCII
		testDencoder("A", "", "QQ==");
		testDencoder("AA", "", "QUE=");
		testDencoder("AAA", "", "QUFB");
		testDencoder("AAAA", "", "QUFBQQ==");
		testDencoder("AAAAA", "", "QUFBQUE=");
		testDencoder("AAAAAA", "", "QUFBQUFB");
		testDencoder("AAAAAAA", "", "QUFBQUFBQQ==");
		
		// non-ASCII (Latin-1)
		testDencoder("ä", "", "w6Q=");
		testDencoder("ää", "", "w6TDpA==");
		testDencoder("äää", "", "w6TDpMOk");
		testDencoder("ääää", "", "w6TDpMOkw6Q=");
		
		// non-ASCII (Japanese)
		testDencoder("ア", "", "44Ki");
		testDencoder("アア", "", "44Ki44Ki");
		testDencoder("アアア", "", "44Ki44Ki44Ki");
		
		// non-BMP
		testDencoder("😀", "", "8J+YgA==");
		testDencoder("😀😀", "", "8J+YgPCfmIA=");
		testDencoder("😀😀😀", "", "8J+YgPCfmIDwn5iA");
	}
	
	@Test
	public void test_lineBreak() {
		// None
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", "", "QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVphYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjM0NTY3ODk=");
		
		// 64
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", "64", "QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVphYmNkZWZnaGlqa2xtbm9wcXJzdHV2\r\n"
				+ "d3h5ejAxMjM0NTY3ODk=");
		
		// 76
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", "76", "QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVphYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjM0\r\n"
				+ "NTY3ODk=");
	}
	
	@Test
	public void test_decoder() {
		// Blank
		testDecoder("", "");
		
		// Padding
		testDecoder("QUFBQQ==", "AAAA");
		testDecoder("QUFBQQ=", "AAAA");
		testDecoder("QUFBQQ", "AAAA");
		testDecoder("QQ==", "A");
		testDecoder("QQ=", "A");
		testDecoder("QQ", "A");
		
		// Trailing white-spaces
		testDecoder("QQ =\t=\r\n", "A");
		
		// White-space (Ignore SPACE, TAB, CR and LF)
		testDecoder("QU FB\tQU\rFB\nQQ==", "AAAAAAA");
		
		// Bbase64 / Base64url
		testDecoder("77u/Pj4+", "\uFEFF>>>"); // 62nd = '+', 63rd = '/' : RFC 4648 Base64
		testDecoder("77u_Pj4-", "\uFEFF>>>"); // 62nd = '-', 63rd = '_' : RFC 4648 Base64url
		
		// RFC 2047
		testDecoder("Subject: =?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?=\r\n"
				+ "    =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=",
				"Subject: If you can read this you understand the example."
				);
		testDecoder("(=?iso-8859-8?b?7eXs+SDv4SDp7Oj08A==?=)", "(םולש ןב ילטפנ)");
		testDecoder("Subject: =?UTF-8?B?44K144Oz44OX44Or?=", "Subject: サンプル");
		
		// RFC 2231
		testDecoder("Subject: =?UTF-8*ja-JP?B?44K144Oz44OX44Or?=", "Subject: サンプル");
	}
	
	private void testDencoder(String value, String lineBreakEach, String expectedEncodedValue) {
		testDencoder(value, lineBreakEach, expectedEncodedValue, value);
	}
	
	private void testDencoder(String value, String lineBreakEach, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = StringBase64Dencoder.encStrBase64(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("string.base64.line-break-each", lineBreakEach);
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = StringBase64Dencoder.decStrBase64(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedDecodedValue, decodedValue);
	}
	
	private void testDecoder(String value, String expectedDecodedValue) {
		String decodedValue = StringBase64Dencoder.decStrBase64(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedDecodedValue, decodedValue);
	}
 }
 