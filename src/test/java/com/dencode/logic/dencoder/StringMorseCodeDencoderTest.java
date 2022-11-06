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
		String variant = "international";
		
		testDencoder("", "", "", variant);
		
		testDencoder("A", ".-", "A", variant);
		testDencoder("a", ".-", "A", variant);
		
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", ".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", variant);
		testDencoder("abcdefghijklmnopqrstuvwxyz", ".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", variant);
		
		testDencoder("1234567890", ".---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----", "1234567890", variant);
		
		testDencoder(".,:?'-/()\"=+@", ".-.-.- --..-- ---... ..--.. .----. -....- -..-. -.--. -.--.- .-..-. -...- .-.-. .--.-.", ".,:?'-/()\"=+@", variant);
		testDencoder("×", "-..-", "X", variant);
		
		
		testDencoder(" ", "/", " ", variant);
		testDencoder("A Z", ".- / --..", "A Z", variant);
		testDencoder("A  Z", ".- / / --..", "A  Z", variant);
		testDencoder(" Z", "/ --..", " Z", variant);
		testDencoder("  Z", "/ / --..", "  Z", variant);
		testDencoder("A ", ".- /", "A ", variant);
		testDencoder("A  ", ".- / /", "A  ", variant);
		
		// New line
		testDencoder("A\r\nZ", ".-\r\n--..", "A\r\nZ", variant);
		testDencoder("\r\nZ", "\r\n--..", "\r\nZ", variant);
		testDencoder("A\r\n", ".-\r\n", "A\r\n", variant);
		
		// Undefined code
		testDencoder(null, "......... / .........\r\n.........", "......... .........\r\n.........", variant);
		testDencoder(null, "\r\n.........\r\n", "\r\n.........\r\n", variant);
		testDencoder(null, " ......... \r\n ", ".........\r\n", variant);
		
		// Unsupported letter
		testDencoder("*** ***\r\n***", "* * * / * * *\r\n* * *", "*** ***\r\n***", variant);
		
		// Alternative code symbols
		testDencoder(null, "・－／", "A ", variant);
	}
	
	@Test
	public void testJapanese() {
		String variant = "japanese";
		
		testDencoder("", "", "", variant);
		
		testDencoder("イ", ".-", "イ", variant);
		testDencoder("ィ", ".-", "イ", variant);

		testDencoder("イロハニホヘトチリヌルヲワカヨタレソツネナラムウヰノオクヤマケフコエテアサキユメミシヱヒモセスン", ".- .-.- -... -.-. -.. . ..-.. ..-. --. .... -.--. .--- -.- .-.. -- -. --- ---. .--. --.- .-. ... - ..- .-..- ..-- .-... ...- .-- -..- -.-- --.. ---- -.--- .-.-- --.-- -.-.- -.-.. -..-- -...- ..-.- --.-. .--.. --..- -..-. .---. ---.- .-.-.", "イロハニホヘトチリヌルヲワカヨタレソツネナラムウヰノオクヤマケフコエテアサキユメミシヱヒモセスン", variant);
		testDencoder("いろはにほへとちりぬるをわかよたれそつねならむうゐのおくやまけふこえてあさきゆめみしゑひもせすん", ".- .-.- -... -.-. -.. . ..-.. ..-. --. .... -.--. .--- -.- .-.. -- -. --- ---. .--. --.- .-. ... - ..- .-..- ..-- .-... ...- .-- -..- -.-- --.. ---- -.--- .-.-- --.-- -.-.- -.-.. -..-- -...- ..-.- --.-. .--.. --..- -..-. .---. ---.- .-.-.", "イロハニホヘトチリヌルヲワカヨタレソツネナラムウヰノオクヤマケフコエテアサキユメミシヱヒモセスン", variant);
		
		testDencoder("ぁぃぅぇぉっゃゅょ", "--.-- .- ..- -.--- .-... .--. .-- -..-- --", "アイウエオツヤユヨ", variant);
		testDencoder("ァィゥェォッャュョ", "--.-- .- ..- -.--- .-... .--. .-- -..-- --", "アイウエオツヤユヨ", variant);
		
		testDencoder("ガギグゲゴザジズゼゾダヂヅデドバビブベボヴ", ".-.. .. -.-.. .. ...- .. -.-- .. ---- .. -.-.- .. --.-. .. ---.- .. .---. .. ---. .. -. .. ..-. .. .--. .. .-.-- .. ..-.. .. -... .. --..- .. --.. .. . .. -.. .. ..- ..", "ガギグゲゴザジズゼゾダヂヅデドバビブベボヴ", variant);
		testDencoder("がぎぐげござじずぜぞだぢづでどばびぶべぼゔ", ".-.. .. -.-.. .. ...- .. -.-- .. ---- .. -.-.- .. --.-. .. ---.- .. .---. .. ---. .. -. .. ..-. .. .--. .. .-.-- .. ..-.. .. -... .. --..- .. --.. .. . .. -.. .. ..- ..", "ガギグゲゴザジズゼゾダヂヅデドバビブベボヴ", variant);
		
		testDencoder("パピプペポ", "-... ..--. --..- ..--. --.. ..--. . ..--. -.. ..--.", "パピプペポ", variant);
		testDencoder("ぱぴぷぺぽ", "-... ..--. --..- ..--. --.. ..--. . ..--. -.. ..--.", "パピプペポ", variant);
		
		testDencoder("１２３４５６７８９０", ".---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----", "１２３４５６７８９０", variant);
		testDencoder("1234567890", ".---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----", "１２３４５６７８９０", variant);
		
		testDencoder("ー、。（）", ".--.- .-.-.- .-.-.. -.--.- .-..-.", "ー、。（）", variant);
		testDencoder("，.", ".-.-.- .-.-..", "、。", variant);
		testDencoder("()", "-.--.- .-..-.", "（）", variant);
		
		// Word space
		testDencoder(" ", "/", " ", variant);
		testDencoder("イ ン", ".- / .-.-.", "イ ン", variant);
		testDencoder("イ  ン", ".- / / .-.-.", "イ  ン", variant);
		testDencoder(" ン", "/ .-.-.", " ン", variant);
		testDencoder("  ン", "/ / .-.-.", "  ン", variant);
		testDencoder("イ ", ".- /", "イ ", variant);
		testDencoder("イ  ", ".- / /", "イ  ", variant);
		
		// New line
		testDencoder("イ\r\nン", ".-\r\n.-.-.", "イ\r\nン", variant);
		testDencoder("\r\nン", "\r\n.-.-.", "\r\nン", variant);
		testDencoder("イ\r\n", ".-\r\n", "イ\r\n", variant);
		
		// Undefined code
		testDencoder(null, "......... / .........\r\n.........", "......... .........\r\n.........", variant);
		testDencoder(null, "\r\n.........\r\n", "\r\n.........\r\n", variant);
		testDencoder(null, " ......... \r\n ", ".........\r\n", variant);
		
		// Unsupported letter
		testDencoder("*** ***\r\n***", "* * * / * * *\r\n* * *", "*** ***\r\n***", variant);
		
		// Alternative code symbols
		testDencoder(null, "・－／", "イ ", variant);
	}
	
	@Test
	public void testRussian() {
		String variant = "russian";
		
		testDencoder("", "", "", variant);
		
		testDencoder("А", ".-", "А", variant);
		testDencoder("а", ".-", "А", variant);
		
		testDencoder("АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", ".- -... .-- --. -.. . ...- --.. .. .--- -.- .-.. -- -. --- .--. .-. ... - ..- ..-. .... -.-. ---. ---- --.- --.-- -.-- -..- ..-.. ..-- .-.-", "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", variant);
		testDencoder("абвгдежзийклмнопрстуфхцчшщъыьэюя", ".- -... .-- --. -.. . ...- --.. .. .--- -.- .-.. -- -. --- .--. .-. ... - ..- ..-. .... -.-. ---. ---- --.- --.-- -.-- -..- ..-.. ..-- .-.-", "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ", variant);
		testDencoder("ЁѢ", ". ..-..", "ЕЭ", variant);
		testDencoder("ёѣ", ". ..-..", "ЕЭ", variant);
		
		testDencoder("1234567890", ".---- ..--- ...-- ....- ..... -.... --... ---.. ----. -----", "1234567890", variant);
		
		testDencoder(".,:;()'\"—/?!-@", "...... .-.-.- ---... -.-.- -.--.- -.--.- .----. .-..-. -....- -..-. ..--.. --..-- -...- .--.-.", ".,:;(('\"—/?!-@", variant);
		
		// Word space
		testDencoder(" ", "/", " ", variant);
		testDencoder("А Я", ".- / .-.-", "А Я", variant);
		testDencoder("А  Я", ".- / / .-.-", "А  Я", variant);
		testDencoder(" Я", "/ .-.-", " Я", variant);
		testDencoder("  Я", "/ / .-.-", "  Я", variant);
		testDencoder("А ", ".- /", "А ", variant);
		testDencoder("А  ", ".- / /", "А  ", variant);
		
		// New line
		testDencoder("А\r\nЯ", ".-\r\n.-.-", "А\r\nЯ", variant);
		testDencoder("\r\nЯ", "\r\n.-.-", "\r\nЯ", variant);
		testDencoder("А\r\n", ".-\r\n", "А\r\n", variant);
		
		// Undefined code
		testDencoder(null, "......... / .........\r\n.........", "......... .........\r\n.........", variant);
		testDencoder(null, "\r\n.........\r\n", "\r\n.........\r\n", variant);
		testDencoder(null, " ......... \r\n ", ".........\r\n", variant);
		
		// Unsupported letter
		testDencoder("*** ***\r\n***", "* * * / * * *\r\n* * *", "*** ***\r\n***", variant);
		
		// Alternative code symbols
		testDencoder(null, "・－／", "А ", variant);
	}
	
	private void testDencoder(String value, String expectedEncodedValue, String expectedDecodedValue, String variant) {
		if (value == null ) {
			String decodedValue = StringMorseCodeDencoder.decStrMorseCode(condition(expectedEncodedValue, variant));
			assertEquals(expectedDecodedValue, decodedValue);
		} else {
			String encodedValue = StringMorseCodeDencoder.encStrMorseCode(condition(value, variant));
			assertEquals(expectedEncodedValue, encodedValue);
			String decodedValue = StringMorseCodeDencoder.decStrMorseCode(condition(encodedValue, variant));
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
	
	private DencodeCondition condition(String value, String variant) {
		return new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<String, String>() {
				private static final long serialVersionUID = 1L;
				{
					put("encStrMorseCodeVariant", variant);
					put("decStrMorseCodeVariant", variant);
				}
				});
	}
 }
 