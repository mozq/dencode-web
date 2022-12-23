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

public class CipherAtbashDencoderTest {
	
	@Test
	public void test() {
		// Blank
		testDencoder("", "");
		
		// Hebrew alphabets
		testDencoder("אבגדהוזחטיכלמנסעפצקרשת", "תשרקצפעסנמלכיטחזוהדגבא");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "ZYXWVUTSRQPONMLKJIHGFEDCBA");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "zyxwvutsrqponmlkjihgfedcba");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "ＺＹＸＷＶＵＴＳＲＱＰＯＮＭＬＫＪＩＨＧＦＥＤＣＢＡ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "ｚｙｘｗｖｕｔｓｒｑｐｏｎｍｌｋｊｉｈｇｆｅｄｃｂａ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", "ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ");
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", "ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ");
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", "ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА");
		
		// Unsupported characters
		testDencoder(" ", " ");
		testDencoder("!", "!");
		testDencoder("!a!", "!z!");
	}
	
	private void testDencoder(String value, String expectedEncodedValue) {
		testDencoder(value, expectedEncodedValue, value);
	}
	
	private void testDencoder(String value, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = CipherAtbashDencoder.encCipherAtbash(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = CipherAtbashDencoder.encCipherAtbash(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
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
 