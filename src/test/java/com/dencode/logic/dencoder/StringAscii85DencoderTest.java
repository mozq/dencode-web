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
import java.util.Map;

import org.junit.jupiter.api.Test;

import com.dencode.logic.model.DencodeCondition;

public class StringAscii85DencoderTest {
	
	@Test
	public void testZ85() {
		testDencoder("", "", "z85");
		testDencoder("H", "nb", "z85");
		testDencoder("He", "nm.", "z85");
		testDencoder("Hel", "nm=P", "z85");
		testDencoder("Hell", "nm=QN", "z85");
		testDencoder("Hello", "nm=QNzV", "z85");
		testDencoder("Hello!", "nm=QNzY]", "z85");
		
		testDencoder("Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.",
				"o<}]Zx(+zcx(!xgzFa9aB7/b}efF?GBrCHty<vdjC{3^mB0bHmvrlv8efFzABrC4raARphB0bKrzFa9dvr9GfvrlH7z/cXfA=k!qz//V7AV!!dx(do{B1wCTxLy%&azC)tvixxeB95Kyw/#hewGU&7zE+pvBzb98ayYQsvixJ2A=U/nwPzi%v}u^3w/$R}y?WJ}BrCpnaARpday/tcBzkSnwN(](zE:(7zE^r<vrui@vpB4:azkn6wPzj3x(v(iz!pbczF%-nwN]B+efFIGv}xjZB0bNrwGV5cz/P}xC4Ct#zdNP{wGU]6ayPekay!&2zEEu7Abo8]B9hIme=",
				"z85");
		
		// Zeros
		testDencoder("\0", "00", "z85");
		testDencoder("\0\0", "000", "z85");
		testDencoder("\0\0\0", "0000", "z85");
		testDencoder("\0\0\0\0", "00000", "z85");
		testDencoder("\0\0\0\0\0", "0000000", "z85");
		
		// Spaces
		testDencoder(" ", "ao", "z85");
		testDencoder("  ", "arQ", "z85");
		testDencoder("   ", "arR^", "z85");
		testDencoder("    ", "arR^H", "z85");
		testDencoder("     ", "arR^Hao", "z85");
	}
	
	@Test
	public void testAdobe() {
		testDencoder("", "", "adobe");
		testDencoder("H", "8,", "adobe");
		testDencoder("He", "87_", "adobe");
		testDencoder("Hel", "87cT", "adobe");
		testDencoder("Hell", "87cUR", "adobe");
		testDencoder("Hello", "87cURDZ", "adobe");
		testDencoder("Hello!", "87cURD]o", "adobe");
		
		testDencoder("Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.",
				"9jqo^BlbD-BleB1DJ+*+F(f,q/0JhKF<GL>Cj@.4Gp$d7F!,L7@<6@)/0JDEF<G%<+EV:2F!,O<DJ+\r\n" +
				"*.@<*K0@<6L(Df-\\0Ec5e;DffZ(EZee.Bl.9pF\"AGXBPCsi+DGm>@3BB/F*&OCAfu2/AKYi(DIb:@FD,\r\n" +
				"*)+C]U=@3BN#EcYf8ATD3s@q?d$AftVqCh[NqF<G:8+EV:.+Cf>-FD5W8ARlolDIal(DId<j@<?3r@:F\r\n" +
				"%a+D58'ATD4$Bl@l3De:,-DJs`8ARoFb/0JMK@qB4^F!,R<AKZ&-DfTqBG%G>uD.RTpAKYo'+CT/5+Ce\r\n" +
				"i#DII?(E,9)oF*2M7/c",
				"adobe");
		
		// Zeros
		testDencoder("\0", "!!", "adobe");
		testDencoder("\0\0", "!!!", "adobe");
		testDencoder("\0\0\0", "!!!!", "adobe");
		testDencoder("\0\0\0\0", "z", "adobe");
		testDencoder("\0\0\0\0\0", "z!!", "adobe");
		
		// Spaces
		testDencoder(" ", "+9", "adobe");
		testDencoder("  ", "+<U", "adobe");
		testDencoder("   ", "+<Vd", "adobe");
		testDencoder("    ", "+<VdL", "adobe");
		testDencoder("     ", "+<VdL+9", "adobe");
		
		// line-break and white-space
		assertEquals("Hello!", StringAscii85Dencoder.decStrAscii85(condition("<~87 cU  RD  \r\n  ]o~>", "adobe")));
	}
	
	@Test
	public void testBTOA() {
		testDencoder("", "", "btoa");
		testDencoder("H", "8,rVi", "btoa");
		testDencoder("He", "87_c$", "btoa");
		testDencoder("Hel", "87cT;", "btoa");
		testDencoder("Hell", "87cUR", "btoa");
		testDencoder("Hello", "87cURDZBb;", "btoa");
		testDencoder("Hello!", "87cURD]o)\\", "btoa");
		
		testDencoder("Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.",
				"9jqo^BlbD-BleB1DJ+*+F(f,q/0JhKF<GL>Cj@.4Gp$d7F!,L7@<6@)/0JDEF<G%<+EV:2F!,O<DJ+\r\n" +
				"*.@<*K0@<6L(Df-\\0Ec5e;DffZ(EZee.Bl.9pF\"AGXBPCsi+DGm>@3BB/F*&OCAfu2/AKYi(DIb:@F\r\n" +
				"D,*)+C]U=@3BN#EcYf8ATD3s@q?d$AftVqCh[NqF<G:8+EV:.+Cf>-FD5W8ARlolDIal(DId<j@<?3\r\n" +
				"r@:F%a+D58'ATD4$Bl@l3De:,-DJs`8ARoFb/0JMK@qB4^F!,R<AKZ&-DfTqBG%G>uD.RTpAKYo'+C\r\n" +
				"T/5+Cei#DII?(E,9)oF*2M7/cYkO",
				"btoa");
		
		// Zeros
		testDencoder("\0", "z", "btoa");
		testDencoder("\0\0", "z", "btoa");
		testDencoder("\0\0\0", "z", "btoa");
		testDencoder("\0\0\0\0", "z", "btoa");
		testDencoder("\0\0\0\0\0", "zz", "btoa");
		
		// Spaces
		testDencoder(" ", "+92BA", "btoa");
		testDencoder("  ", "+<UXa", "btoa");
		testDencoder("   ", "+<Vd,", "btoa");
		testDencoder("    ", "y", "btoa");
		testDencoder("     ", "y+92BA", "btoa");
		
		// line-break and white-space
		assertEquals("Hello!", StringAscii85Dencoder.decStrAscii85(condition("xbtoa Begin\r\n" + "87 cU  RD  \r\n  ]o)\\" + "\r\n" + buildBTOASuffix("Hello!") + "\r\n", "btoa")));
	}
	
	private void testDencoder(String value, String expectedEncodedValue, String format) {
		if (format.equals("btoa")) {
			expectedEncodedValue = "xbtoa Begin\r\n" + expectedEncodedValue + "\r\n" + buildBTOASuffix(value) + "\r\n";
		} else if (format.equals("adobe")) {
			expectedEncodedValue = "<~" + expectedEncodedValue + "~>";
		}
		String encodedValue = StringAscii85Dencoder.encStrAscii85(condition(value, format));
		assertEquals(expectedEncodedValue, encodedValue);
		String decodedValue = StringAscii85Dencoder.decStrAscii85(condition(encodedValue, format));
		assertEquals(value, decodedValue);
	}
	
	private DencodeCondition condition(String value, String format) {
		return condition(value, format, StandardCharsets.UTF_8);
	}
	
	private DencodeCondition condition(String value, String format, Charset charset) {
		Map<String, String> options = new HashMap<>();
		options.put("encStrAscii85Variant", format);
		return new DencodeCondition(value, charset, "\r\n", null, options);
	}

	private static String buildBTOASuffix(String v) {
		byte[] x = v.getBytes(StandardCharsets.UTF_8);
		return buildBTOASuffix(x);
	}
	private static String buildBTOASuffix(byte[] x) {
		int eor = 0;
		int sum = 0;
		int rot = 0;
		
		for (int i = 0; i < x.length; i++) {
			int c = 0xFF & x[i];
			
			eor ^= c;
			sum += c;
			sum++;
			if ((rot & 0x80000000) != 0) {
				rot <<= 1;
				rot++;
			} else {
				rot <<= 1;
			}
			rot += c;
		}
		
		return String.format("xbtoa End N %d %x E %x S %x R %x", x.length, x.length, eor, sum, rot);
	}
 }
 