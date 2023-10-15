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

public class StringMorseCodeDencoderTest {
	
	@Test
	public void testInternational() {
		String language = "international";
		
		testDencoder("", "", "", language);
		
		testDencoder("A", ".-", "A", language);
		testDencoder("a", ".-", "A", language);
		
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", ".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", language);
		testDencoder("abcdefghijklmnopqrstuvwxyz", ".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", language);
		
		testDencoder("1234567890", ".---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----", "1234567890", language);
		
		testDencoder(".,:?'-/()\"=+@", ".-.-.- --..-- ---... ..--.. .----. -....- -..-. -.--. -.--.- .-..-. -...- .-.-. .--.-.", ".,:?'-/()\"=+@", language);
		testDencoder("×", "-..-", "X", language);
		
		
		testDencoder(" ", "/", " ", language);
		testDencoder("A Z", ".- / --..", "A Z", language);
		testDencoder("A  Z", ".- / / --..", "A  Z", language);
		testDencoder(" Z", "/ --..", " Z", language);
		testDencoder("  Z", "/ / --..", "  Z", language);
		testDencoder("A ", ".- /", "A ", language);
		testDencoder("A  ", ".- / /", "A  ", language);
		
		// New line
		testDencoder("A\r\nZ", ".-\r\n--..", "A\r\nZ", language);
		testDencoder("\r\nZ", "\r\n--..", "\r\nZ", language);
		testDencoder("A\r\n", ".-\r\n", "A\r\n", language);
		
		// Undefined code
		testDencoder(null, "......... / .........\r\n.........", "......... .........\r\n.........", language);
		testDencoder(null, "\r\n.........\r\n", "\r\n.........\r\n", language);
		testDencoder(null, " ......... \r\n ", ".........\r\n", language);
		
		// Unsupported letter
		testDencoder("*** ***\r\n***", "* * * / * * *\r\n* * *", "*** ***\r\n***", language);
		
		// Alternative code symbols
		testDencoder(null, "・－／", "A ", language);
	}
	
	@Test
	public void testJapanese() {
		String language = "japanese";
		
		testDencoder("", "", "", language);
		
		testDencoder("イ", ".-", "イ", language);
		testDencoder("ィ", ".-", "イ", language);

		testDencoder("イロハニホヘトチリヌルヲワカヨタレソツネナラムウヰノオクヤマケフコエテアサキユメミシヱヒモセスン", ".- .-.- -... -.-. -.. . ..-.. ..-. --. .... -.--. .--- -.- .-.. -- -. --- ---. .--. --.- .-. ... - ..- .-..- ..-- .-... ...- .-- -..- -.-- --.. ---- -.--- .-.-- --.-- -.-.- -.-.. -..-- -...- ..-.- --.-. .--.. --..- -..-. .---. ---.- .-.-.", "イロハニホヘトチリヌルヲワカヨタレソツネナラムウヰノオクヤマケフコエテアサキユメミシヱヒモセスン", language);
		testDencoder("いろはにほへとちりぬるをわかよたれそつねならむうゐのおくやまけふこえてあさきゆめみしゑひもせすん", ".- .-.- -... -.-. -.. . ..-.. ..-. --. .... -.--. .--- -.- .-.. -- -. --- ---. .--. --.- .-. ... - ..- .-..- ..-- .-... ...- .-- -..- -.-- --.. ---- -.--- .-.-- --.-- -.-.- -.-.. -..-- -...- ..-.- --.-. .--.. --..- -..-. .---. ---.- .-.-.", "イロハニホヘトチリヌルヲワカヨタレソツネナラムウヰノオクヤマケフコエテアサキユメミシヱヒモセスン", language);
		
		testDencoder("ぁぃぅぇぉっゃゅょ", "--.-- .- ..- -.--- .-... .--. .-- -..-- --", "アイウエオツヤユヨ", language);
		testDencoder("ァィゥェォッャュョ", "--.-- .- ..- -.--- .-... .--. .-- -..-- --", "アイウエオツヤユヨ", language);
		
		testDencoder("ガギグゲゴザジズゼゾダヂヅデドバビブベボヴ", ".-.. .. -.-.. .. ...- .. -.-- .. ---- .. -.-.- .. --.-. .. ---.- .. .---. .. ---. .. -. .. ..-. .. .--. .. .-.-- .. ..-.. .. -... .. --..- .. --.. .. . .. -.. .. ..- ..", "ガギグゲゴザジズゼゾダヂヅデドバビブベボヴ", language);
		testDencoder("がぎぐげござじずぜぞだぢづでどばびぶべぼゔ", ".-.. .. -.-.. .. ...- .. -.-- .. ---- .. -.-.- .. --.-. .. ---.- .. .---. .. ---. .. -. .. ..-. .. .--. .. .-.-- .. ..-.. .. -... .. --..- .. --.. .. . .. -.. .. ..- ..", "ガギグゲゴザジズゼゾダヂヅデドバビブベボヴ", language);
		
		testDencoder("パピプペポ", "-... ..--. --..- ..--. --.. ..--. . ..--. -.. ..--.", "パピプペポ", language);
		testDencoder("ぱぴぷぺぽ", "-... ..--. --..- ..--. --.. ..--. . ..--. -.. ..--.", "パピプペポ", language);
		
		testDencoder("１２３４５６７８９０", ".---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----", "１２３４５６７８９０", language);
		testDencoder("1234567890", ".---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----", "１２３４５６７８９０", language);
		
		testDencoder("ー、。（）", ".--.- .-.-.- .-.-.. -.--.- .-..-.", "ー、。（）", language);
		testDencoder("，.", ".-.-.- .-.-..", "、。", language);
		testDencoder("()", "-.--.- .-..-.", "（）", language);
		
		// Word space
		testDencoder(" ", "/", " ", language);
		testDencoder("イ ン", ".- / .-.-.", "イ ン", language);
		testDencoder("イ  ン", ".- / / .-.-.", "イ  ン", language);
		testDencoder(" ン", "/ .-.-.", " ン", language);
		testDencoder("  ン", "/ / .-.-.", "  ン", language);
		testDencoder("イ ", ".- /", "イ ", language);
		testDencoder("イ  ", ".- / /", "イ  ", language);
		
		// New line
		testDencoder("イ\r\nン", ".-\r\n.-.-.", "イ\r\nン", language);
		testDencoder("\r\nン", "\r\n.-.-.", "\r\nン", language);
		testDencoder("イ\r\n", ".-\r\n", "イ\r\n", language);
		
		// Undefined code
		testDencoder(null, "......... / .........\r\n.........", "......... .........\r\n.........", language);
		testDencoder(null, "\r\n.........\r\n", "\r\n.........\r\n", language);
		testDencoder(null, " ......... \r\n ", ".........\r\n", language);
		
		// Unsupported letter
		testDencoder("*** ***\r\n***", "* * * / * * *\r\n* * *", "*** ***\r\n***", language);
		
		// Alternative code symbols
		testDencoder(null, "・－／", "イ ", language);
	}
	
	@Test
	public void testRussian() {
		String language = "russian";
		
		testDencoder("", "", "", language);
		
		testDencoder("А", ".-", "А", language);
		testDencoder("а", ".-", "А", language);
		
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", ".- -... .-- --. -.. . ...- --.. .. .--- -.- .-.. -- -. --- .--. .-. ... - ..- ..-. .... -.-. ---. ---- --.- --.-- -.-- -..- ..-.. ..-- .-.-", "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", language);
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", ".- -... .-- --. -.. . ...- --.. .. .--- -.- .-.. -- -. --- .--. .-. ... - ..- ..-. .... -.-. ---. ---- --.- --.-- -.-- -..- ..-.. ..-- .-.-", "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", language);
		testDencoder("ЁѢ", ". ..-..", "ЕЭ", language);
		testDencoder("ёѣ", ". ..-..", "ЕЭ", language);
		
		testDencoder("1234567890", ".---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----", "1234567890", language);
		
		testDencoder(".,:;()'\"—/?!-@", "...... .-.-.- ---... -.-.- -.--.- -.--.- .----. .-..-. -....- -..-. ..--.. --..-- -...- .--.-.", ".,:;(('\"—/?!-@", language);
		
		// Word space
		testDencoder(" ", "/", " ", language);
		testDencoder("А Я", ".- / .-.-", "А Я", language);
		testDencoder("А  Я", ".- / / .-.-", "А  Я", language);
		testDencoder(" Я", "/ .-.-", " Я", language);
		testDencoder("  Я", "/ / .-.-", "  Я", language);
		testDencoder("А ", ".- /", "А ", language);
		testDencoder("А  ", ".- / /", "А  ", language);
		
		// New line
		testDencoder("А\r\nЯ", ".-\r\n.-.-", "А\r\nЯ", language);
		testDencoder("\r\nЯ", "\r\n.-.-", "\r\nЯ", language);
		testDencoder("А\r\n", ".-\r\n", "А\r\n", language);
		
		// Undefined code
		testDencoder(null, "......... / .........\r\n.........", "......... .........\r\n.........", language);
		testDencoder(null, "\r\n.........\r\n", "\r\n.........\r\n", language);
		testDencoder(null, " ......... \r\n ", ".........\r\n", language);
		
		// Unsupported letter
		testDencoder("*** ***\r\n***", "* * * / * * *\r\n* * *", "*** ***\r\n***", language);
		
		// Alternative code symbols
		testDencoder(null, "・－／", "А ", language);
	}
	
	private void testDencoder(String value, String expectedEncodedValue, String expectedDecodedValue, String language) {
		if (value == null ) {
			String decodedValue = StringMorseCodeDencoder.decStrMorseCode(condition(expectedEncodedValue, language));
			assertEquals(expectedDecodedValue, decodedValue);
		} else {
			String encodedValue = StringMorseCodeDencoder.encStrMorseCode(condition(value, language));
			assertEquals(expectedEncodedValue, encodedValue);
			String decodedValue = StringMorseCodeDencoder.decStrMorseCode(condition(encodedValue, language));
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
	
	private DencodeCondition condition(String value, String variant) {
		return new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<String, String>() {
				private static final long serialVersionUID = 1L;
				{
					put("string.morse-code.variant", variant);
				}
				});
	}
 }
 