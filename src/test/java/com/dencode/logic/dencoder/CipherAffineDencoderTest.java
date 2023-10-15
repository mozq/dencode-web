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

public class CipherAffineDencoderTest {

	@Test
	public void test_passthrough() {
		// Blank
		testDencoder("", 1, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 1, 0, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		testDencoder("abcdefghijklmnopqrstuvwxyz", 1, 0, "abcdefghijklmnopqrstuvwxyz");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", 1, 0, "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", 1, 0, "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", 1, 0, "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ");
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", 1, 0, "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ");
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", 1, 0, "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", 1, 0, "абвгдежзийклмнопрстуфхцчшщъыьэюя");
		
		// Unsupported characters
		testDencoder(" ", 1, 0, " ");
		testDencoder("!", 1, 0, "!");
		testDencoder("!a!", 1, 0, "!a!");
	}

	@Test
	public void test_caesar_n3() {
		// Blank
		testDencoder("", 1, -3, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 1, -3, "XYZABCDEFGHIJKLMNOPQRSTUVW");
		testDencoder("abcdefghijklmnopqrstuvwxyz", 1, -3, "xyzabcdefghijklmnopqrstuvw");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", 1, -3, "ＸＹＺＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", 1, -3, "ｘｙｚａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", 1, -3, "をんゔぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑ");
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", 1, -3, "ヲンヴァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱ");
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", 1, -3, "ЭЮЯАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬ");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", 1, -3, "эюяабвгдежзийклмнопрстуфхцчшщъыь");
		
		// Unsupported characters
		testDencoder(" ", 1, -3, " ");
		testDencoder("!", 1, -3, "!");
		testDencoder("!a!", 1, -3, "!x!");
	}

	@Test
	public void test_caesar_p3() {
		// Blank
		testDencoder("", 1, 3, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 1, 3, "DEFGHIJKLMNOPQRSTUVWXYZABC");
		testDencoder("abcdefghijklmnopqrstuvwxyz", 1, 3, "defghijklmnopqrstuvwxyzabc");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", 1, 3, "ＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺＡＢＣ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", 1, 3, "ｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚａｂｃ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", 1, 3, "いぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔぁあぃ");
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", 1, 3, "イゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴァアィ");
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", 1, 3, "ГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯАБВ");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", 1, 3, "гдежзийклмнопрстуфхцчшщъыьэюяабв");
		
		// Unsupported characters
		testDencoder(" ", 1, 3, " ");
		testDencoder("!", 1, 3, "!");
		testDencoder("!a!", 1, 3, "!d!");
	}
	
	@Test
	public void test_atabsh() {
		// Blank
		testDencoder("", -1, -1, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", -1, -1, "ZYXWVUTSRQPONMLKJIHGFEDCBA");
		testDencoder("abcdefghijklmnopqrstuvwxyz", -1, -1, "zyxwvutsrqponmlkjihgfedcba");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", -1, -1, "ＺＹＸＷＶＵＴＳＲＱＰＯＮＭＬＫＪＩＨＧＦＥＤＣＢＡ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", -1, -1, "ｚｙｘｗｖｕｔｓｒｑｐｏｎｍｌｋｊｉｈｇｆｅｄｃｂａ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", -1, -1, "ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ");
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", -1, -1, "ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ");
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", -1, -1, "ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", -1, -1, "яюэьыъщшчцхфутсрпонмлкйизжедгвба");
		
		// Unsupported characters
		testDencoder(" ", -1, -1, " ");
		testDencoder("!", -1, -1, "!");
		testDencoder("!a!", -1, -1, "!z!");
	}
	
	@Test
	public void test_an1_b0() {
		// Blank
		testDencoder("", -1, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", -1, 0, "AZYXWVUTSRQPONMLKJIHGFEDCB");
		testDencoder("abcdefghijklmnopqrstuvwxyz", -1, 0, "azyxwvutsrqponmlkjihgfedcb");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", -1, 0, "ＡＺＹＸＷＶＵＴＳＲＱＰＯＮＭＬＫＪＩＨＧＦＥＤＣＢ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", -1, 0, "ａｚｙｘｗｖｕｔｓｒｑｐｏｎｍｌｋｊｉｈｇｆｅｄｃｂ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", -1, 0, "ぁゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあ");
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", -1, 0, "ァヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィア");
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", -1, 0, "АЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБ");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", -1, 0, "аяюэьыъщшчцхфутсрпонмлкйизжедгвб");
		
		// Unsupported characters
		testDencoder(" ", -1, 0, " ");
		testDencoder("!", -1, 0, "!");
		testDencoder("!a!", -1, 0, "!a!");
	}
	
	@Test
	public void test_ap2_b0() {
		// Blank
		testDencoder("", 24, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 2, 0, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"); // ** not Co-prime **
		testDencoder("abcdefghijklmnopqrstuvwxyz", 2, 0, "abcdefghijklmnopqrstuvwxyz"); // ** not Co-prime **
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", 2, 0, "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ"); // ** not Co-prime **
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", 2, 0, "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ"); // ** not Co-prime **
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", 2, 0, "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ"); // ** not Co-prime **
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", 2, 0, "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ"); // ** not Co-prime **
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", 2, 0, "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"); // ** not Co-prime **
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", 2, 0, "абвгдежзийклмнопрстуфхцчшщъыьэюя"); // ** not Co-prime **
		
		// Unsupported characters
		testDencoder(" ", 2, 0, " ");
		testDencoder("!", 2, 0, "!");
		testDencoder("!a!", 2, 0, "!a!"); // ** not Co-prime **
	}
	
	@Test
	public void test_an2_b0() {
		// Blank
		testDencoder("", -2, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", -2, 0, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"); // ** not Co-prime **
		testDencoder("abcdefghijklmnopqrstuvwxyz", -2, 0, "abcdefghijklmnopqrstuvwxyz"); // ** not Co-prime **
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", -2, 0, "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ"); // ** not Co-prime **
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", -2, 0, "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ"); // ** not Co-prime **
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", -2, 0, "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ"); // ** not Co-prime **
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", -2, 0, "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ"); // ** not Co-prime **
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", -2, 0, "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"); // ** not Co-prime **
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", -2, 0, "абвгдежзийклмнопрстуфхцчшщъыьэюя"); // ** not Co-prime **
		
		// Unsupported characters
		testDencoder(" ", -2, 0, " ");
		testDencoder("!", -2, 0, "!");
		testDencoder("!a!", -2, 0, "!a!"); // ** not Co-prime **
	}
	
	@Test
	public void test_ap3_b0() {
		// Blank
		testDencoder("", 3, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 3, 0, "ADGJMPSVYBEHKNQTWZCFILORUX");
		testDencoder("abcdefghijklmnopqrstuvwxyz", 3, 0, "adgjmpsvybehknqtwzcfilorux");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", 3, 0, "ＡＤＧＪＭＰＳＶＹＢＥＨＫＮＱＴＷＺＣＦＩＬＯＲＵＸ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", 3, 0, "ａｄｇｊｍｐｓｖｙｂｅｈｋｎｑｔｗｚｃｆｉｌｏｒｕｘ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", 3, 0, "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ"); // ** not Co-prime **
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", 3, 0, "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ"); // ** not Co-prime **
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", 3, 0, "АГЖЙМПТХШЫЮБДЗКНРУЦЩЬЯВЕИЛОСФЧЪЭ");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", 3, 0, "агжймптхшыюбдзкнруцщьявеилосфчъэ");
		
		// Unsupported characters
		testDencoder(" ", 3, 0, " ");
		testDencoder("!", 3, 0, "!");
		testDencoder("!a!", 3, 0, "!a!");
	}
	
	@Test
	public void test_an3_b0() {
		// Blank
		testDencoder("", -3, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", -3, 0, "AXUROLIFCZWTQNKHEBYVSPMJGD");
		testDencoder("abcdefghijklmnopqrstuvwxyz", -3, 0, "axurolifczwtqnkhebyvspmjgd");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", -3, 0, "ＡＸＵＲＯＬＩＦＣＺＷＴＱＮＫＨＥＢＹＶＳＰＭＪＧＤ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", -3, 0, "ａｘｕｒｏｌｉｆｃｚｗｔｑｎｋｈｅｂｙｖｓｐｍｊｇｄ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", -3, 0, "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ"); // ** not Co-prime **
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", -3, 0, "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ"); // ** not Co-prime **
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", -3, 0, "АЭЪЧФСОЛИЕВЯЬЩЦУРНКЗДБЮЫШХТПМЙЖГ");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", -3, 0, "аэъчфсолиевяьщцурнкздбюышхтпмйжг");
		
		// Unsupported characters
		testDencoder(" ", -3, 0, " ");
		testDencoder("!", -3, 0, "!");
		testDencoder("!a!", -3, 0, "!a!");
	}
	
	@Test
	public void test_ap24_b0() {
		// Blank
		testDencoder("", 24, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 24, 0, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"); // ** not Co-prime **
		testDencoder("abcdefghijklmnopqrstuvwxyz", 24, 0, "abcdefghijklmnopqrstuvwxyz"); // ** not Co-prime **
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", 24, 0, "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ"); // ** not Co-prime **
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", 24, 0, "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ"); // ** not Co-prime **
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", 24, 0, "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ"); // ** not Co-prime **
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", 24, 0, "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ"); // ** not Co-prime **
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", 24, 0, "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"); // ** not Co-prime **
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", 24, 0, "абвгдежзийклмнопрстуфхцчшщъыьэюя"); // ** not Co-prime **
		
		// Unsupported characters
		testDencoder(" ", 24, 0, " ");
		testDencoder("!", 24, 0, "!");
		testDencoder("!a!", 24, 0, "!a!"); // ** not Co-prime **
	}
	
	@Test
	public void test_an24_b0() {
		// Blank
		testDencoder("", -24, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", -24, 0, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"); // ** not Co-prime **
		testDencoder("abcdefghijklmnopqrstuvwxyz", -24, 0, "abcdefghijklmnopqrstuvwxyz"); // ** not Co-prime **
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", -24, 0, "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ"); // ** not Co-prime **
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", -24, 0, "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ"); // ** not Co-prime **
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", -24, 0, "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ"); // ** not Co-prime **
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", -24, 0, "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ"); // ** not Co-prime **
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", -24, 0, "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"); // ** not Co-prime **
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", -24, 0, "абвгдежзийклмнопрстуфхцчшщъыьэюя"); // ** not Co-prime **
		
		// Unsupported characters
		testDencoder(" ", -24, 0, " ");
		testDencoder("!", -24, 0, "!");
		testDencoder("!a!", -24, 0, "!a!"); // ** not Co-prime **
	}
	
	@Test
	public void test_ap25_b0() {
		// Blank
		testDencoder("", 25, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 25, 0, "AZYXWVUTSRQPONMLKJIHGFEDCB");
		testDencoder("abcdefghijklmnopqrstuvwxyz", 25, 0, "azyxwvutsrqponmlkjihgfedcb");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", 25, 0, "ＡＺＹＸＷＶＵＴＳＲＱＰＯＮＭＬＫＪＩＨＧＦＥＤＣＢ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", 25, 0, "ａｚｙｘｗｖｕｔｓｒｑｐｏｎｍｌｋｊｉｈｇｆｅｄｃｂ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", 25, 0, "ぁずびれけなゃえちぺんじぱりくとめうたへゑざはよきてみいそぶわごねゆかつぽあせぴろげにやぉぢほゔすひるぐどもぇだべをしばらぎでむぅぞぷゐさのょがづまぃぜふゎこぬゅおっぼ");
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", 25, 0, "ァズビレケナャエチペンジパリクトメウタヘヱザハヨキテミイソブワゴネユカツポアセピロゲニヤォヂホヴスヒルグドモェダベヲシバラギデムゥゾプヰサノョガヅマィゼフヮコヌュオッボ");
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", 25, 0, "АЩТЛДЭЦПИБЪУМЕЮЧРЙВЫФНЖЯШСКГЬХОЗ");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", 25, 0, "ащтлдэцпибъумеючрйвыфнжяшскгьхоз");
		
		// Unsupported characters
		testDencoder(" ", 25, 0, " ");
		testDencoder("!", 25, 0, "!");
		testDencoder("!a!", 25, 0, "!a!");
	}
	
	@Test
	public void test_an25_b0() {
		// Blank
		testDencoder("", -25, 0, "");
		
		// Half-width Latin alphabets
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", -25, 0, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		testDencoder("abcdefghijklmnopqrstuvwxyz", -25, 0, "abcdefghijklmnopqrstuvwxyz");
		
		// Full-width Latin alphabets
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", -25, 0, "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", -25, 0, "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ");
		
		// Full-width Japanese Hiragana
		testDencoder("ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ", -25, 0, "ぁぼっおゅぬこゎふぜぃまづがょのさゐぷぞぅむでぎらばしをべだぇもどぐるひすゔほぢぉやにげろぴせあぽつかゆねごわぶそいみてきよはざゑへたうめとくりぱじんぺちえゃなけれびず");
		
		// Full-width Japanese Katakana
		testDencoder("ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ", -25, 0, "ァボッオュヌコヮフゼィマヅガョノサヰプゾゥムデギラバシヲベダェモドグルヒスヴホヂォヤニゲロピセアポツカユネゴワブソイミテキヨハザヱヘタウメトクリパジンペチエャナケレビズ");
		
		// Cyrillic alphabets
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", -25, 0, "АЗОХЬГКСШЯЖНФЫВЙРЧЮЕМУЪБИПЦЭДЛТЩ");
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", -25, 0, "азохьгксшяжнфывйрчюемуъбипцэдлтщ");
		
		// Unsupported characters
		testDencoder(" ", -25, 0, " ");
		testDencoder("!", -25, 0, "!");
		testDencoder("!a!", -25, 0, "!a!");
	}
	
	private void testDencoder(String value, int a, int b, String expectedEncodedValue) {
		testDencoder(value, a, b, expectedEncodedValue, value);
	}
	
	private void testDencoder(String value, int a, int b, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = CipherAffineDencoder.encCipherAffine(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("cipher.affine.a", String.valueOf(a));
				put("cipher.affine.b", String.valueOf(b));
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = CipherAffineDencoder.decCipherAffine(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("cipher.affine.a", String.valueOf(a));
				put("cipher.affine.b", String.valueOf(b));
			}
		}));
		if (expectedDecodedValue == null) {
			assertEquals(value, decodedValue);
		} else {
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
 }
 