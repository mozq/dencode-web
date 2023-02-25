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
	
	@Test
	public void testBase45ZlibCoseCbor() {
		
		// see https://github.com/eu-digital-green-certificates/dgc-testdata
		assertEquals("{\n"
				+ "  \"4\" : 1620237600,\n"
				+ "  \"6\" : 1620064800,\n"
				+ "  \"1\" : \"AT\",\n"
				+ "  \"-260\" : {\n"
				+ "    \"1\" : {\n"
				+ "      \"v\" : [ {\n"
				+ "        \"dn\" : 1,\n"
				+ "        \"ma\" : \"ORG-100030215\",\n"
				+ "        \"vp\" : \"1119305005\",\n"
				+ "        \"dt\" : \"2021-02-18\",\n"
				+ "        \"co\" : \"AT\",\n"
				+ "        \"ci\" : \"urn:uvci:01:AT:10807843F94AEE0EE5093FBC254BD813P\",\n"
				+ "        \"mp\" : \"EU/1/20/1528\",\n"
				+ "        \"is\" : \"BMSGPK Austria\",\n"
				+ "        \"sd\" : 2,\n"
				+ "        \"tg\" : \"840539006\"\n"
				+ "      } ],\n"
				+ "      \"nam\" : {\n"
				+ "        \"fnt\" : \"MUSTERFRAU<GOESSINGER\",\n"
				+ "        \"fn\" : \"Musterfrau-Gößinger\",\n"
				+ "        \"gnt\" : \"GABRIELE\",\n"
				+ "        \"gn\" : \"Gabriele\"\n"
				+ "      },\n"
				+ "      \"ver\" : \"1.0.0\",\n"
				+ "      \"dob\" : \"1998-02-26\"\n"
				+ "    }\n"
				+ "  }\n"
				+ "}",
				StringBase45Dencoder.decStrBase45ZlibCoseCbor(condition("HC1:NCFOXN%TS3DHMRG2FUPNR9/MPV45NL-AH%TAIOOW%IHOT$E08WAWN0%W0AT4V22F/8X*G3M9JUPY0BX/KR96R/S09T./0LWTKD33236J3TA3M*4VV2 73-E3ND3DAJ-43%*48YIB73A*G3W19UEBY5:PI0EGSP4*2D$43B+2SEB7:I/2DY73CIBC:G 7376BXBJBAJ UNFMJCRN0H3PQN*E33H3OA70M3FMJIJN523S+0B/S7-SN2H N37J3JFTULJ5CB3ZCIATULV:SNS8F-67N%21Q21$48X2+36D-I/2DBAJDAJCNB-43SZ4RZ4E%5B/9OK53:UCT16DEZIE IE9.M CVCT1+9V*QERU1MK93P5 U02Y9.G9/G9F:QQ28R3U6/V.*NT*QM.SY$N-P1S29 34S0BYBRC.UYS1U%O6QKN*Q5-QFRMLNKNM8JI0EUGP$I/XK$M8-L9KDI:ZH2E4UR8 I185JTT3QFWDHK1QV+/UU-OJ1Q 7SP:8M1NWQTP3D/OADSM8BDHBN +0O7WNV7HJS%6G8WJP6GDZPXU8GY8U$I%0N%NST0GX-Q/$OMPG"))
				);
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
 