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

public class StringUnicodeEscapeDencoderTest {
	
	@Test
	public void test_code_upper() {
		// Blank
		testDencoder("", "", "upper", "");
		
		// ASCII
		testDencoder("Z", "", "upper", "\\u005A");
		testDencoder("Z", "cubu", "upper", "\\u005A");
		testDencoder("Z", "cpbu_bub", "upper", "\\u005A");
		testDencoder("Z", "cpbu_bU", "upper", "\\u005A");
		testDencoder("Z", "cpbub", "upper", "\\u{5A}");
		testDencoder("Z", "cpbxb", "upper", "\\x{5A}");
		testDencoder("Z", "cpb", "upper", "\\5A");
		testDencoder("Z", "cpahx", "upper", "&#x5A;");
		testDencoder("Z", "cupu", "upper", "%u005A");
		testDencoder("Z", "cp", "upper", "U+005A");
		testDencoder("Z", "cp0x", "upper", "0x5A");
		
		// non-ASCII (Latin-1)
		testDencoder("ä", "", "upper", "\\u00E4");
		testDencoder("ä", "cubu", "upper", "\\u00E4");
		testDencoder("ä", "cpbu_bub", "upper", "\\u00E4");
		testDencoder("ä", "cpbu_bU", "upper", "\\u00E4");
		testDencoder("ä", "cpbub", "upper", "\\u{E4}");
		testDencoder("ä", "cpbxb", "upper", "\\x{E4}");
		testDencoder("ä", "cpb", "upper", "\\E4");
		testDencoder("ä", "cpahx", "upper", "&#xE4;");
		testDencoder("ä", "cupu", "upper", "%u00E4");
		testDencoder("ä", "cp", "upper", "U+00E4");
		testDencoder("ä", "cp0x", "upper", "0xE4");
		
		// non-ASCII (Japanese)
		testDencoder("ア", "", "upper", "\\u30A2");
		testDencoder("ア", "cubu", "upper", "\\u30A2");
		testDencoder("ア", "cpbu_bub", "upper", "\\u30A2");
		testDencoder("ア", "cpbu_bU", "upper", "\\u30A2");
		testDencoder("ア", "cpbub", "upper", "\\u{30A2}");
		testDencoder("ア", "cpbxb", "upper", "\\x{30A2}");
		testDencoder("ア", "cpb", "upper", "\\30A2");
		testDencoder("ア", "cpahx", "upper", "&#x30A2;");
		testDencoder("ア", "cupu", "upper", "%u30A2");
		testDencoder("ア", "cp", "upper", "U+30A2");
		testDencoder("ア", "cp0x", "upper", "0x30A2");
		
		// non-BMP
		testDencoder("😀", "", "upper", "\\uD83D\\uDE00");
		testDencoder("😀", "cubu", "upper", "\\uD83D\\uDE00");
		testDencoder("😀", "cpbu_bub", "upper", "\\u{1F600}");
		testDencoder("😀", "cpbu_bU", "upper", "\\U0001F600");
		testDencoder("😀", "cpbub", "upper", "\\u{1F600}");
		testDencoder("😀", "cpbxb", "upper", "\\x{1F600}");
		testDencoder("😀", "cpb", "upper", "\\1F600");
		testDencoder("😀", "cpahx", "upper", "&#x1F600;");
		testDencoder("😀", "cupu", "upper", "%uD83D%uDE00");
		testDencoder("😀", "cp", "upper", "U+1F600");
		testDencoder("😀", "cp0x", "upper", "0x1F600");
		
		// Mixed
		testDencoder("Z😀ア", "", "upper", "\\u005A\\uD83D\\uDE00\\u30A2");
		testDencoder("Z😀ア", "cubu", "upper", "\\u005A\\uD83D\\uDE00\\u30A2");
		testDencoder("Z😀ア", "cpbu_bub", "upper", "\\u005A\\u{1F600}\\u30A2");
		testDencoder("Z😀ア", "cpbu_bU", "upper", "\\u005A\\U0001F600\\u30A2");
		testDencoder("Z😀ア", "cpbub", "upper", "\\u{5A}\\u{1F600}\\u{30A2}");
		testDencoder("Z😀ア", "cpbxb", "upper", "\\x{5A}\\x{1F600}\\x{30A2}");
		testDencoder("Z😀ア", "cpb", "upper", "\\5A\\1F600\\30A2");
		testDencoder("Z😀ア", "cpahx", "upper", "&#x5A;&#x1F600;&#x30A2;");
		testDencoder("Z😀ア", "cupu", "upper", "%u005A%uD83D%uDE00%u30A2");
		testDencoder("Z😀ア", "cp", "upper", "U+005A U+1F600 U+30A2");
		testDencoder("Z😀ア", "cp0x", "upper", "0x5A 0x1F600 0x30A2");
	}
	
	@Test
	public void test_code_lower() {
		// Blank
		testDencoder("", "", "lower", "");
		
		// ASCII
		testDencoder("Z", "", "lower", "\\u005a");
		testDencoder("Z", "cubu", "lower", "\\u005a");
		testDencoder("Z", "cpbu_bub", "lower", "\\u005a");
		testDencoder("Z", "cpbu_bU", "lower", "\\u005a");
		testDencoder("Z", "cpbub", "lower", "\\u{5a}");
		testDencoder("Z", "cpbxb", "lower", "\\x{5a}");
		testDencoder("Z", "cpb", "lower", "\\5a");
		testDencoder("Z", "cpahx", "lower", "&#x5a;");
		testDencoder("Z", "cupu", "lower", "%u005a");
		testDencoder("Z", "cp", "lower", "U+005a");
		testDencoder("Z", "cp0x", "lower", "0x5a");
		
		// non-ASCII (Latin-1)
		testDencoder("ä", "", "lower", "\\u00e4");
		testDencoder("ä", "cubu", "lower", "\\u00e4");
		testDencoder("ä", "cpbu_bub", "lower", "\\u00e4");
		testDencoder("ä", "cpbu_bU", "lower", "\\u00e4");
		testDencoder("ä", "cpbub", "lower", "\\u{e4}");
		testDencoder("ä", "cpbxb", "lower", "\\x{e4}");
		testDencoder("ä", "cpb", "lower", "\\e4");
		testDencoder("ä", "cpahx", "lower", "&#xe4;");
		testDencoder("ä", "cupu", "lower", "%u00e4");
		testDencoder("ä", "cp", "lower", "U+00e4");
		testDencoder("ä", "cp0x", "lower", "0xe4");
		
		// non-ASCII (Japanese)
		testDencoder("ア", "", "lower", "\\u30a2");
		testDencoder("ア", "cubu", "lower", "\\u30a2");
		testDencoder("ア", "cpbu_bub", "lower", "\\u30a2");
		testDencoder("ア", "cpbu_bU", "lower", "\\u30a2");
		testDencoder("ア", "cpbub", "lower", "\\u{30a2}");
		testDencoder("ア", "cpbxb", "lower", "\\x{30a2}");
		testDencoder("ア", "cpb", "lower", "\\30a2");
		testDencoder("ア", "cpahx", "lower", "&#x30a2;");
		testDencoder("ア", "cupu", "lower", "%u30a2");
		testDencoder("ア", "cp", "lower", "U+30a2");
		testDencoder("ア", "cp0x", "lower", "0x30a2");
		
		// non-BMP
		testDencoder("😀", "", "lower", "\\ud83d\\ude00");
		testDencoder("😀", "cubu", "lower", "\\ud83d\\ude00");
		testDencoder("😀", "cpbu_bub", "lower", "\\u{1f600}");
		testDencoder("😀", "cpbu_bU", "lower", "\\U0001f600");
		testDencoder("😀", "cpbub", "lower", "\\u{1f600}");
		testDencoder("😀", "cpbxb", "lower", "\\x{1f600}");
		testDencoder("😀", "cpb", "lower", "\\1f600");
		testDencoder("😀", "cpahx", "lower", "&#x1f600;");
		testDencoder("😀", "cupu", "lower", "%ud83d%ude00");
		testDencoder("😀", "cp", "lower", "U+1f600");
		testDencoder("😀", "cp0x", "lower", "0x1f600");
		
		// Mixed
		testDencoder("Z😀ア", "", "lower", "\\u005a\\ud83d\\ude00\\u30a2");
		testDencoder("Z😀ア", "cubu", "lower", "\\u005a\\ud83d\\ude00\\u30a2");
		testDencoder("Z😀ア", "cpbu_bub", "lower", "\\u005a\\u{1f600}\\u30a2");
		testDencoder("Z😀ア", "cpbu_bU", "lower", "\\u005a\\U0001f600\\u30a2");
		testDencoder("Z😀ア", "cpbub", "lower", "\\u{5a}\\u{1f600}\\u{30a2}");
		testDencoder("Z😀ア", "cpbxb", "lower", "\\x{5a}\\x{1f600}\\x{30a2}");
		testDencoder("Z😀ア", "cpb", "lower", "\\5a\\1f600\\30a2");
		testDencoder("Z😀ア", "cpahx", "lower", "&#x5a;&#x1f600;&#x30a2;");
		testDencoder("Z😀ア", "cupu", "lower", "%u005a%ud83d%ude00%u30a2");
		testDencoder("Z😀ア", "cp", "lower", "U+005a U+1f600 U+30a2");
		testDencoder("Z😀ア", "cp0x", "lower", "0x5a 0x1f600 0x30a2");
	}
	
	@Test
	public void test_name_upper() {
		// name ignores case
		
		// Blank
		testDencoder("", "cnbNb", "upper", "");
		
		// ASCII
		testDencoder("A", "cnbNb", "upper", "\\N{LATIN CAPITAL LETTER A}");
		
		// Symbol in name
		testDencoder("<", "cnbNb", "upper", "\\N{LESS-THAN SIGN}");
		testDencoder("\r\n", "cnbNb", "upper", "\\N{CARRIAGE RETURN (CR)}\\N{LINE FEED (LF)}");
		
		// Æ (U+00C6)
		testDencoder("Æ", "cnbNb", "upper", "\\N{LATIN CAPITAL LETTER AE}");
		
		// non-BMP
		testDencoder("😀", "cnbNb", "upper", "\\N{GRINNING FACE}");
	}
	
	@Test
	public void test_name_lower() {
		// name ignores case
		
		// Blank
		testDencoder("", "cnbNb", "lower", "");
		
		// ASCII
		testDencoder("A", "cnbNb", "lower", "\\N{LATIN CAPITAL LETTER A}");
		
		// Symbol in name
		testDencoder("<", "cnbNb", "lower", "\\N{LESS-THAN SIGN}");
		testDencoder("\r\n", "cnbNb", "lower", "\\N{CARRIAGE RETURN (CR)}\\N{LINE FEED (LF)}");
		
		// Æ (U+00C6)
		testDencoder("Æ", "cnbNb", "lower", "\\N{LATIN CAPITAL LETTER AE}");
		
		// non-BMP
		testDencoder("😀", "cnbNb", "lower", "\\N{GRINNING FACE}");
	}
	
	@Test
	public void test_decoder() {
		// Blank
		testDecoder("", "");
		
		// Lower bound (U+0)
		testDecoder("\\u0", "\0"); // Incorrect format. (It should be 4 digits but parse lenient.)
		testDecoder("\\u0000", "\0");
		testDecoder("\\u{0}", "\0");
		testDecoder("\\U0", "\0"); // Incorrect format. (It should be 8 digits but parse lenient.)
		testDecoder("\\U00000000", "\0");
		testDecoder("\\x{0}", "\0");
		testDecoder("\\0", "\0");
		testDecoder("\\0000", "\0");
		testDecoder("&#x0;", "\0");
		testDecoder("0x0", "\0");
		
		// Upper bound - BMP (U+FFFF)
		testDecoder("\\uFFFF", "\uFFFF");
		testDecoder("\\u{FFFF}", "\uFFFF");
		testDecoder("\\UFFFF", "\uFFFF"); // Incorrect format. (It should be 8 digits but parse lenient.)
		testDecoder("\\U0000FFFF", "\uFFFF");
		testDecoder("\\x{FFFF}", "\uFFFF");
		testDecoder("\\FFFF", "\uFFFF");
		testDecoder("&#xFFFF;", "\uFFFF");
		testDecoder("U+FFFF", "\uFFFF");
		testDecoder("0xFFFF", "\uFFFF");
		
		// Upper bound - non-BMP (U+10FFFF)
		testDecoder("\\uDBFF\\uDFFF", "\uDBFF\uDFFF");
		testDecoder("\\u{10FFFF}", "\uDBFF\uDFFF");
		testDecoder("\\U10FFFF", "\uDBFF\uDFFF"); // Incorrect format. (It should be 8 digits but parse lenient.)
		testDecoder("\\U0010FFFF", "\uDBFF\uDFFF");
		testDecoder("\\x{10FFFF}", "\uDBFF\uDFFF");
		testDecoder("\\10FFFF", "\uDBFF\uDFFF");
		testDecoder("&#x10FFFF;", "\uDBFF\uDFFF");
		testDecoder("U+10FFFF", "\uDBFF\uDFFF");
		testDecoder("0x10FFFF", "\uDBFF\uDFFF");
		
		// Out of range - Out of Unicode code point (0x110000
		testDecoder("\\u{110000}", "\\u{110000}");
		testDecoder("\\U00110000", "\\U00110000");
		testDecoder("\\x{110000}", "\\x{110000}");
		testDecoder("\\110000", "\\110000");
		testDecoder("&#x110000;", "&#x110000;");
		testDecoder("U+110000", "U+110000");
		testDecoder("0x110000", "0x110000");
		
		// Out of range - 6 digits maximum (0xFFFFFF)
		testDecoder("\\u{FFFFFF}", "\\u{FFFFFF}");
		testDecoder("\\UFFFFFF", "\\UFFFFFF"); // Incorrect format. (It should be 8 digits but parse lenient.)
		testDecoder("\\U00FFFFFF", "\\U00FFFFFF");
		testDecoder("\\x{FFFFFF}", "\\x{FFFFFF}");
		testDecoder("\\FFFFFF", "\\FFFFFF");
		testDecoder("&#xFFFFFF;", "&#xFFFFFF;");
		testDecoder("U+FFFFFF", "U+FFFFFF");
		testDecoder("0xFFFFFF", "0xFFFFFF");
		
		// Out of range - 8 digits maximum (0xFFFFFFFF)
		testDecoder("\\u{FFFFFFFF}", "\\u{FFFFFFFF}");
		testDecoder("\\UFFFFFFFF", "\\UFFFFFFFF");
		testDecoder("\\x{FFFFFFFF}", "\\x{FFFFFFFF}");
		testDecoder("\\FFFFFFFF", "\\FFFFFFFF");
		testDecoder("&#xFFFFFFFF;", "&#xFFFFFFFF;");
		testDecoder("U+FFFFFFFF", "U+FFFFFFFF");
		testDecoder("0xFFFFFFFF", "0xFFFFFFFF");
		
		// Unknown name
		testDecoder("\\N{XXXXXXXX}", "\\N{XXXXXXXX}");
		
		// Unsupported character
		testDecoder("Z😀ア", "Z😀ア");
		
		// Illegal format
		testDecoder("\\", "\\");
		testDecoder("\\u", "\\u");
		testDecoder("\\U", "\\U");
		testDecoder("\\x", "\\x");
		testDecoder("\\N", "\\N");
		testDecoder("\\z", "\\z");
		testDecoder("&", "&");
		testDecoder("&#", "&#");
		testDecoder("&#x", "&#x");
		testDecoder("%", "%");
		testDecoder("%u", "%u");
		testDecoder("%z", "%z");
		testDecoder("U", "U");
		testDecoder("U+", "U+");
		testDecoder("U+z", "U+z");
		testDecoder("0", "0");
		testDecoder("0x", "0x");
		testDecoder("0xz", "0xz");
		
		// Escaped
		testDecoder("\\\\u005A", "\\u005A");
		testDecoder("\\\\\\u005A", "\\Z");
		testDecoder("\\\\\\\\u005A", "\\\\u005A");
		testDecoder("\\\\\\\\\\u005A", "\\\\Z");
		testDecoder("%%u005A", "%Z");
		testDecoder("%%%u005A", "%%Z");
		
		// Mixed
		testDecoder("\\u005a\\u{5a}\\x{5a}\\5a&#x5a;%u005a0x5aU+005a\\N{LATIN CAPITAL LETTER Z}\\uD83D\\uDE00\\x{1f600}\\1f600&#x1f600;\\u{1f600}\\U0001f600%uD83D%uDE000x1f600U+1f600\\N{GRINNING FACE}", "ZZZZZZZZZ😀😀😀😀😀😀😀😀😀😀");
		testDecoder("\\N{GRINNING FACE}0x1f600U+1f600%uD83D%uDE00\\U0001f600\\u{1f600}&#x1f600;\\1f600\\x{1f600}\\uD83D\\uDE000x5a\\N{LATIN CAPITAL LETTER Z}U+005a%u005a&#x5a;\\5a\\x{5a}\\u{5a}\\u005a", "😀😀😀😀😀😀😀😀😀😀ZZZZZZZZZ");
		
		// Mixed (with unsupported character)
		testDecoder("X\\u005aX\\u{5a}X\\x{5a}X\\5aX&#x5a;X%u005aX0x5aXU+005aX\\N{LATIN CAPITAL LETTER Z}X\\uD83D\\uDE00X\\x{1f600}X\\1f600X&#x1f600;X\\u{1f600}X\\U0001f600X%uD83D%uDE00X0x1f600XU+1f600X\\N{GRINNING FACE}X", "XZXZXZXZXZXZXZXZXZX😀X😀X😀X😀X😀X😀X😀X😀X😀X😀X");
		testDecoder("X\\N{GRINNING FACE}XU+1f600X0x1f600X%uD83D%uDE00X\\U0001f600X\\u{1f600}X&#x1f600;X\\1f600X\\x{1f600}X\\uD83D\\uDE00X\\N{LATIN CAPITAL LETTER Z}XU+005aX0x5aX%u005aX&#x5a;X\\5aX\\x{5a}X\\u{5a}X\\u005aX", "X😀X😀X😀X😀X😀X😀X😀X😀X😀X😀XZXZXZXZXZXZXZXZXZX");
		
		// Mixed (with white space)
		testDecoder("  \\u005a  \\u{5a}  \\x{5a}  \\5a  &#x5a;  %u005a  0x5a  U+005a  \\N{LATIN CAPITAL LETTER Z}  \\uD83D\\uDE00  \\x{1f600}  \\1f600  &#x1f600;  \\u{1f600}  \\U0001f600  %uD83D%uDE00  0x1f600  U+1f600  \\N{GRINNING FACE}  ", "  Z  Z  Z  Z Z  Z  Z Z Z  😀  😀  😀 😀  😀  😀  😀  😀 😀 😀  "); // Spaces will be removed after 0x and U+. One space will be removed after \.
		testDecoder("  \\N{GRINNING FACE}  U+1f600  0x1f600  %uD83D%uDE00  \\U0001f600  \\u{1f600}  &#x1f600;  \\1f600  \\x{1f600}  \\uD83D\\uDE00  \\N{LATIN CAPITAL LETTER Z}  U+005a  0x5a  %u005a  &#x5a;  \\5a  \\x{5a}  \\u{5a}  \\u005a  ", "  😀  😀 😀 😀  😀  😀  😀  😀 😀  😀  Z  Z Z Z  Z  Z Z  Z  Z  "); // Spaces will be removed after 0x and U+. One space will be removed after \.
	}
	
	private void testDencoder(String value, String notation, String hexCase, String expectedEncodedValue) {
		testDencoder(value, notation, hexCase, expectedEncodedValue, value);
	}
	
	private void testDencoder(String value, String notation, String hexCase, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = StringUnicodeEscapeDencoder.encStrUnicodeEscape(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("string.unicode-escape.notation", notation);
				put("string.unicode-escape.case", hexCase);
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = StringUnicodeEscapeDencoder.decStrUnicodeEscape(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		if (expectedDecodedValue == null) {
			assertEquals(value, decodedValue);
		} else {
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
	
	private void testDecoder(String value, String expectedDecodedValue) {
		String decodedValue = StringUnicodeEscapeDencoder.decStrUnicodeEscape(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		if (expectedDecodedValue == null) {
			assertEquals(value, decodedValue);
		} else {
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
 }
 