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

public class StringQuotedPrintableDencoderTest {
	
	@Test
	public void test() {
		// Blank
		testDencoder("", "");
		
		// Printable: A-Z 0-9
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "abcdefghijklmnopqrstuvwxyz");
		testDencoder("0123456789", "0123456789");

		// Printable: Symbols
		testDencoder("!\"#$%&'()*+,-./:;<>?@[\\]^_`{|}~", "!\"#$%&'()*+,-./:;<>?@[\\]^_`{|}~");
		testDencoder("=", "=3D");
		
		// White-space
		testDencoder(" ", "=20");
		testDencoder("\t", "=09");
		testDencoder("\r\n", "=0D=0A");
		testDencoder("A A", "A A");
		testDencoder("A\tA", "A\tA");
		testDencoder("A\r\nA", "A\r\nA");
		testDencoder("   \r\n\t\t\t\r\n\r\n", "  =20\r\n\t\t=09\r\n=0D=0A");
		
		// non-ASCII (Latin-1)
		testDencoder("ä", "=C3=A4");
		
		// non-ASCII (Japanese)
		testDencoder("ア", "=E3=82=A2");
		
		// non-BMP
		testDencoder("😀", "=F0=9F=98=80");
		
		// Line-break
		testDencoder("J'interdis aux marchands de vanter trop leurs marchandises. Car ils se font vite pédagogues et t'enseignent comme but ce qui n'est par essence qu'un moyen, et te trompant ainsi sur la route à suivre les voilà bientôt qui te dégradent, car si leur musique est vulgaire ils te fabriquent pour te la vendre une âme vulgaire.\r\n"
				+ "   — Antoine de Saint-Exupéry, Citadelle (1948)",
				"J'interdis aux marchands de vanter trop leurs marchandises. Car ils se font=\r\n"
						+ " vite p=C3=A9dagogues et t'enseignent comme but ce qui n'est par essence qu=\r\n"
						+ "'un moyen, et te trompant ainsi sur la route =C3=A0 suivre les voil=C3=A0 b=\r\n"
						+ "ient=C3=B4t qui te d=C3=A9gradent, car si leur musique est vulgaire ils te =\r\n"
						+ "fabriquent pour te la vendre une =C3=A2me vulgaire.\r\n"
						+ "   =E2=80=94=E2=80=89Antoine de Saint-Exup=C3=A9ry, Citadelle (1948)"
				);
	}
	
	@Test
	public void test_decoder() {
		// Blank
		testDecoder("", "");
		
		// Padding
		testDecoder("J'interdis aux marchands de vanter trop leurs marchandises. Car ils se font=\r\n"
				+ " vite p=C3=A9dagogues et t'enseignent comme but ce qui n'est par essence qu=\r\n"
				+ "'un moyen, et te trompant ainsi sur la route =C3=A0 suivre les voil=C3=\r\n"
				+ "=A0 bient=C3=B4t qui te d=C3=A9gradent, car si leur musique est vulgaire il=\r\n"
				+ "s te fabriquent pour te la vendre une =C3=A2me vulgaire.\r\n"
				+ "   =E2=80=94=E2=80=89Antoine de Saint-Exup=C3=A9ry, Citadelle (1948)",
				"J'interdis aux marchands de vanter trop leurs marchandises. Car ils se font vite pédagogues et t'enseignent comme but ce qui n'est par essence qu'un moyen, et te trompant ainsi sur la route à suivre les voilà bientôt qui te dégradent, car si leur musique est vulgaire ils te fabriquent pour te la vendre une âme vulgaire.\r\n"
						+ "   — Antoine de Saint-Exupéry, Citadelle (1948)"
				);
		
		// RFC 2047
		testDecoder("From: =?US-ASCII?Q?Keith_Moore?= <moore@cs.utk.edu>\r\n"
				+ "   To: =?ISO-8859-1?Q?Keld_J=F8rn_Simonsen?= <keld@dkuug.dk>\r\n"
				+ "   CC: =?ISO-8859-1?Q?Andr=E9?= Pirard <PIRARD@vm1.ulg.ac.be>",
				"From: Keith Moore <moore@cs.utk.edu>\r\n"
					+ "   To: Keld Jørn Simonsen <keld@dkuug.dk>\r\n"
					+ "   CC: André Pirard <PIRARD@vm1.ulg.ac.be>"
				);
		testDecoder("From: =?ISO-8859-1?Q?Olle_J=E4rnefors?= <ojarnef@admin.kth.se>", "From: Olle Järnefors <ojarnef@admin.kth.se>");
		testDecoder("From: =?ISO-8859-1?Q?Patrik_F=E4ltstr=F6m?= <paf@nada.kth.se>", "From: Patrik Fältström <paf@nada.kth.se>");
		testDecoder("(=?ISO-8859-1?Q?a?=)", "(a)");
		testDecoder("(=?ISO-8859-1?Q?a?= b)", "(a b)");
		testDecoder("(=?ISO-8859-1?Q?a?= =?ISO-8859-1?Q?b?=)", "(ab)");
		testDecoder("(=?ISO-8859-1?Q?a?=  =?ISO-8859-1?Q?b?=)", "(ab)");
		testDecoder("(=?ISO-8859-1?Q?a?=\r\n"
				+ "    =?ISO-8859-1?Q?b?=)",
				"(ab)"
				);
		testDecoder("(=?ISO-8859-1?Q?a_b?=)", "(a b)");
		testDecoder("(=?ISO-8859-1?Q?a?= =?ISO-8859-2?Q?_b?=)", "(a b)");
		testDecoder("Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=", "Subject: サンプル");
		
		// RFC 2231
		testDecoder("Subject: =?UTF-8*ja-JP?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=", "Subject: サンプル");
	}
	
	private void testDencoder(String value, String expectedEncodedValue) {
		testDencoder(value, expectedEncodedValue, value);
	}
	
	private void testDencoder(String value, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = StringQuotedPrintableDencoder.encStrQuotedPrintable(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = StringQuotedPrintableDencoder.decStrQuotedPrintable(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedDecodedValue, decodedValue);
	}
	
	private void testDecoder(String value, String expectedDecodedValue) {
		String decodedValue = StringQuotedPrintableDencoder.decStrQuotedPrintable(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedDecodedValue, decodedValue);
	}
 }
 