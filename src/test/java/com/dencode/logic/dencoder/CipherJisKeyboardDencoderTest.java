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

public class CipherJisKeyboardDencoderTest {
	
	@Test
	public void testStrict() {
		// Blank
		testDencoder("", "strict", "");
		
		// Supported characters
		testDencoder("1234567890-^|", "strict", "ぬふあうえおやゆよわほへー");
		testDencoder("qwertyuiop @[", "strict", "たていすかんなにらせ ゛゜");
		testDencoder("asdfghjkl;:]", "strict", "ちとしはきくまのりれけむ");
		testDencoder("zxcvbnm,./\\", "strict", "つさそひこみもねるめろ");
		testDencoder("#$%&'()", "strict", "ぁぅぇぉゃゅょ");
		testDencoder("E{", "strict", "ぃ「");
		testDencoder("}", "strict", "」");
		testDencoder("Z<>?", "strict", "っ、。・");
		
		// Voiced sound mark
		testDencoder("t@g@h@:@b@", "strict", "がぎぐげご");
		testDencoder("x@d@r@p@c@", "strict", "ざじずぜぞ");
		testDencoder("q@a@z@w@s@", "strict", "だぢづでど");
		testDencoder("f@v@2@^@-@", "strict", "ばびぶべぼ");
		testDencoder("4@", "strict", "ゔ");
		testDencoder("f[v[2[^[-[", "strict", "ぱぴぷぺぽ");
		testDencoder("1@1[", "strict", "ぬ゛ぬ゜");
		testDencoder("@1", "strict", "゛ぬ");
		testDencoder("[1", "strict", "゜ぬ");
		testDencoder("@", "strict", "゛");
		testDencoder("[", "strict", "゜");
		
		// Upper alphabet
		testDencoder("QWERTYUIOP", "strict", "QWぃRTYUIOP");
		testDencoder("ASDFGHJKL", "strict", "ASDFGHJKL");
		testDencoder("ZXCVBNM", "strict", "っXCVBNM");
		
		// Katakana
		testDencoder("ヌフアウエオヤユヨワホヘ", "strict", "ヌフアウエオヤユヨワホヘ");
		testDencoder("タテイスカンナニラセ", "strict", "タテイスカンナニラセ");
		testDencoder("チトシハキクマノリレケム", "strict", "チトシハキクマノリレケム");
		testDencoder("ツサソヒコミモネルメロ", "strict", "ツサソヒコミモネルメロ");
		testDencoder("ァゥェォャュョ", "strict", "ァゥェォャュョ");
		testDencoder("ィ", "strict", "ィ");
		testDencoder("ッ", "strict", "ッ");
		testDencoder("ガギグゲゴ", "strict", "ガギグゲゴ");
		testDencoder("ザジズゼゾ", "strict", "ザジズゼゾ");
		testDencoder("ダヂヅデド", "strict", "ダヂヅデド");
		testDencoder("バビブベボ", "strict", "バビブベボ");
		testDencoder("ヴ", "strict", "ヴ");
		testDencoder("パピプペポ", "strict", "パピプペポ");
		
		// Unsupported characters
		testDencoder("!\"=~`+*_", "strict", "!\"=~`+*_"); // Unsupported symbols
		testDencoder("漢字＠", "strict", "漢字＠"); // Unsupported full-width characters
		testDencoder("を", "strict", "を"); // Unsupported Hiragana character
		
		// Mixed
		testDencoder("nttを「みかか」に変換します!?", "strict", "みかかを{ntt}i変換djr!・");
	}
	@Test
	public void testLenient() {
		// Blank
		testDencoder("", "lenient", "");
		
		// Supported characters
		testDencoder("1234567890-^|", "lenient", "ぬふあうえおやゆよわほへー");
		testDencoder("qwertyuiop @[", "lenient", "たていすかんなにらせ ゛゜");
		testDencoder("asdfghjkl;:]", "lenient", "ちとしはきくまのりれけむ");
		testDencoder("zxcvbnm,./\\", "lenient", "つさそひこみもねるめろ");
		testDencoder("#$%&'()", "lenient", "ぁぅぇぉゃゅょ");
		testDencoder("E{", "lenient", "ぃ「");
		testDencoder("}", "lenient", "」");
		testDencoder("Z<>?", "lenient", "っ、。・");
		
		// Voiced sound mark
		testDencoder("t@g@h@:@b@", "lenient", "がぎぐげご");
		testDencoder("x@d@r@p@c@", "lenient", "ざじずぜぞ");
		testDencoder("q@a@z@w@s@", "lenient", "だぢづでど");
		testDencoder("f@v@2@^@-@", "lenient", "ばびぶべぼ");
		testDencoder("4@", "lenient", "ゔ");
		testDencoder("f[v[2[^[-[", "lenient", "ぱぴぷぺぽ");
		testDencoder("1@1[", "lenient", "ぬ゛ぬ゜");
		testDencoder("@1", "lenient", "゛ぬ");
		testDencoder("[1", "lenient", "゜ぬ");
		testDencoder("@", "lenient", "゛");
		testDencoder("[", "lenient", "゜");
		
		// Upper alphabet
		testDencoder("QWERTYUIOP", "lenient", "たてぃすかんなにらせ", "qwErtyuiop");
		testDencoder("ASDFGHJKL", "lenient", "ちとしはきくまのり", "asdfghjkl");
		testDencoder("ZXCVBNM", "lenient", "っさそひこみも", "Zxcvbnm");
		
		// Katakana
		testDencoder("ヌフアウエオヤユヨワホヘ", "lenient", "1234567890-^", "ぬふあうえおやゆよわほへ");
		testDencoder("タテイスカンナニラセ", "lenient", "qwertyuiop", "たていすかんなにらせ");
		testDencoder("チトシハキクマノリレケム", "lenient", "asdfghjkl;:]", "ちとしはきくまのりれけむ");
		testDencoder("ツサソヒコミモネルメロ", "lenient", "zxcvbnm,./\\", "つさそひこみもねるめろ");
		testDencoder("ァゥェォャュョ", "lenient", "#$%&'()", "ぁぅぇぉゃゅょ");
		testDencoder("ィ", "lenient", "E", "ぃ");
		testDencoder("ッ", "lenient", "Z", "っ");
		testDencoder("ガギグゲゴ", "lenient", "t@g@h@:@b@", "がぎぐげご");
		testDencoder("ザジズゼゾ", "lenient", "x@d@r@p@c@", "ざじずぜぞ");
		testDencoder("ダヂヅデド", "lenient", "q@a@z@w@s@", "だぢづでど");
		testDencoder("バビブベボ", "lenient", "f@v@2@^@-@", "ばびぶべぼ");
		testDencoder("ヴ", "lenient", "4@", "ゔ");
		testDencoder("パピプペポ", "lenient", "f[v[2[^[-[", "ぱぴぷぺぽ");
		
		// Unsupported characters
		testDencoder("!\"=~`+*_", "lenient", "!\"=~`+*_"); // Unsupported symbols
		testDencoder("漢字＠", "lenient", "漢字＠"); // Unsupported full-width characters
		testDencoder("を", "lenient", "を"); // Unsupported Hiragana character
		
		// Mixed
		testDencoder("NTTを「みかか」に変換します!?", "lenient", "みかかを{ntt}i変換djr!・", "nttを「みかか」に変換します!?");
	}
	
	private void testDencoder(String value, String mode, String expectedEncodedValue) {
		testDencoder(value, mode, expectedEncodedValue, null);
	}
	
	private void testDencoder(String value, String mode, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = CipherJisKeyboardDencoder.encCipherJisKeyboard(condition(value, mode));
		assertEquals(expectedEncodedValue, encodedValue);
		String decodedValue = CipherJisKeyboardDencoder.encCipherJisKeyboard(condition(encodedValue, mode));
		if (expectedDecodedValue == null) {
			assertEquals(value, decodedValue);
		} else {
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
	
	private DencodeCondition condition(String value, String mode) {
		return condition(value, StandardCharsets.UTF_8, mode);
	}
	
	private DencodeCondition condition(String value, Charset charset, String mode) {
		return new DencodeCondition(value, charset, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("encCipherJisKeyboardMode", mode);
			}
		});
	}
 }
 