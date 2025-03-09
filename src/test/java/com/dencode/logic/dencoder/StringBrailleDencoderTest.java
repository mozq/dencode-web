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

public class StringBrailleDencoderTest {
	
	@Test
	public void testUEB1() {
		// Blank
		testDencoder("", "ueb1", "");
		
		// Letters
		testDencoder("a", "ueb1", "⠁");
		testDencoder("A", "ueb1", "⠠⠁");
		testDencoder("abcdefghijklmnopqrstuvwxyz", "ueb1", "⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵");
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "ueb1", "⠠⠠⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵");
		
		// Letters & Whitespace
		testDencoder(" abcdefg hijklmnop   qrstuv wxyz ", "ueb1", "⠀⠁⠃⠉⠙⠑⠋⠛⠀⠓⠊⠚⠅⠇⠍⠝⠕⠏⠀⠀⠀⠟⠗⠎⠞⠥⠧⠀⠺⠭⠽⠵⠀");
		testDencoder(" ABCDEFG HIJKLMNOP   QRSTUV WXYZ ", "ueb1", "⠀⠠⠠⠠⠁⠃⠉⠙⠑⠋⠛⠀⠓⠊⠚⠅⠇⠍⠝⠕⠏⠀⠀⠀⠟⠗⠎⠞⠥⠧⠀⠺⠭⠽⠵⠀⠠⠄");
		
		// Numbers
		testDencoder("1234567890", "ueb1", "⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚");
		testDencoder("1,234,567,890", "ueb1", "⠼⠁⠂⠃⠉⠙⠂⠑⠋⠛⠂⠓⠊⠚");
		testDencoder("1 234 567 890", "ueb1", "⠼⠁⠐⠃⠉⠙⠐⠑⠋⠛⠐⠓⠊⠚"); // U+2007 Numeric space
		testDencoder("12345.67890", "ueb1", "⠼⠁⠃⠉⠙⠑⠲⠋⠛⠓⠊⠚");
		testDencoder("abc1234567890abc", "ueb1", "⠁⠃⠉⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠰⠁⠃⠉");
		testDencoder("abc 1234567890 abc", "ueb1", "⠁⠃⠉⠀⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠀⠁⠃⠉");
		testDencoder("ABC1234567890ABC", "ueb1", "⠠⠠⠁⠃⠉⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠠⠠⠁⠃⠉");
		testDencoder("ABC 1234567890 ABC", "ueb1", "⠠⠠⠠⠁⠃⠉⠀⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠀⠁⠃⠉⠠⠄");
		testDencoder("2012/01/23", "ueb1", "⠼⠃⠚⠁⠃⠸⠌⠼⠚⠁⠸⠌⠼⠃⠉");
		testDencoder("2012-01-23", "ueb1", "⠼⠃⠚⠁⠃⠤⠼⠚⠁⠤⠼⠃⠉");
		testDencoder("100g", "ueb1", "⠼⠁⠚⠚⠰⠛");
		testDencoder("'90's", "ueb1", "⠄⠼⠊⠚⠄⠎");
		testDencoder("-20%", "ueb1", "⠤⠼⠃⠚⠨⠴"); // Hyphen
		testDencoder("−20%", "ueb1", "⠐⠤⠼⠃⠚⠨⠴"); // U+2212 Minus sign
		
		// Symbols - ASCII
		testDencoder("!\"#$%&'()*+,-./", "ueb1", "⠖⠠⠶⠸⠹⠈⠎⠨⠴⠈⠯⠄⠐⠣⠐⠜⠐⠔⠐⠖⠂⠤⠲⠸⠌"); // ASCII 0x2x
		testDencoder(":;<=>?", "ueb1", "⠒⠆⠈⠣⠐⠶⠈⠜⠦"); // ASCII 0x3x
		testDencoder("@", "ueb1", "⠈⠁"); //0x4x
		testDencoder("[\\]^_", "ueb1", "⠨⠣⠸⠡⠨⠜⠈⠢⠨⠤"); // ASCII 0x5x
		testDencoder("`", "ueb1", "⠘⠡"); // ASCII 0x6x
		testDencoder("{|}~", "ueb1", "⠸⠣⠸⠳⠸⠜⠈⠔"); // ASCII 0x7x
		
		// Symbols - Non-ASCII
		testDencoder("£₣¢€$₦¥", "ueb1", "⠈⠇⠈⠋⠈⠉⠈⠑⠈⠎⠈⠝⠈⠽");
		testDencoder("®©´`™°♀♂¶§", "ueb1", "⠘⠗⠘⠉⠘⠌⠘⠡⠘⠞⠘⠚⠘⠭⠘⠽⠘⠏⠘⠎");
		testDencoder("•", "ueb1", "⠸⠲");
		testDencoder("〃×÷*−", "ueb1", "⠐⠂⠐⠦⠐⠌⠐⠔⠐⠤");
		testDencoder("†‡", "ueb1", "⠈⠠⠹⠈⠠⠻");
		testDencoder("¡¿", "ueb1", "⠘⠰⠖⠘⠰⠦");
		
		// Quotation marks and brackets
		testDencoder("\"Hello, world?\"", "ueb1", "⠦⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠴"); // Non-specific quotation
		testDencoder("“Hello, world?”", "ueb1", "⠘⠦⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠘⠴"); // U+201C, U+201D
		testDencoder("'Hello, world?'", "ueb1", "⠄⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠄"); // This is an apostrophe, not quotation marks
		testDencoder("‘Hello, world?’", "ueb1", "⠠⠦⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠴"); // U+2018, U+2019
		testDencoder("<Hello, world?>", "ueb1", "⠈⠣⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠈⠜");
		testDencoder("{Hello, world?}", "ueb1", "⠸⠣⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠸⠜");
		testDencoder("[Hello, world?]", "ueb1", "⠨⠣⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠨⠜");
		testDencoder("(Hello, world?)", "ueb1", "⠐⠣⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠐⠜");
		
		testDencoder("Abc \"HELLO, WORLD?\" Abc", "ueb1", "⠠⠁⠃⠉⠀⠦⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠴⠀⠠⠁⠃⠉"); // Non-specific quotation
		testDencoder("Abc “HELLO, WORLD?” Abc", "ueb1", "⠠⠁⠃⠉⠀⠘⠦⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠘⠴⠀⠠⠁⠃⠉"); // U+201C, U+201D
		testDencoder("Abc 'HELLO, WORLD?' Abc", "ueb1", "⠠⠁⠃⠉⠀⠄⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠄⠀⠁⠠⠄⠃⠉"); // This is an apostrophe, not quotation marks
		testDencoder("Abc ‘HELLO, WORLD?’ Abc", "ueb1", "⠠⠁⠃⠉⠀⠠⠦⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠠⠴⠀⠠⠁⠃⠉"); // U+2018, U+2019
		testDencoder("Abc <HELLO, WORLD?> Abc", "ueb1", "⠠⠁⠃⠉⠀⠈⠣⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠈⠜⠀⠠⠁⠃⠉");
		testDencoder("Abc {HELLO, WORLD?} Abc", "ueb1", "⠠⠁⠃⠉⠀⠸⠣⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠸⠜⠀⠠⠁⠃⠉");
		testDencoder("Abc [HELLO, WORLD?] Abc", "ueb1", "⠠⠁⠃⠉⠀⠨⠣⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠨⠜⠀⠠⠁⠃⠉");
		testDencoder("Abc (HELLO, WORLD?) Abc", "ueb1", "⠠⠁⠃⠉⠀⠐⠣⠠⠠⠠⠓⠑⠇⠇⠕⠂⠀⠺⠕⠗⠇⠙⠦⠠⠄⠐⠜⠀⠠⠁⠃⠉");
		
		// Dash
		testDencoder("a - z", "ueb1", "⠁⠀⠤⠀⠵"); // Hyphen
		testDencoder("a -- z", "ueb1", "⠁⠀⠤⠤⠀⠵"); // Hyphen x 2
		testDencoder("a — z", "ueb1", "⠁⠀⠠⠤⠀⠵"); // Em Dash
		testDencoder("a —— z", "ueb1", "⠁⠀⠐⠠⠤⠀⠵"); // Em Dash x 2 ( Long Dash)
		
		// Case
		testDencoder("B&B", "ueb1", "⠠⠃⠈⠯⠠⠃");
		testDencoder("STOP!", "ueb1", "⠠⠠⠎⠞⠕⠏⠖");
		testDencoder("ABCs", "ueb1", "⠠⠠⠁⠃⠉⠠⠄⠎");
		testDencoder("BOB'S CAFE", "ueb1", "⠠⠠⠠⠃⠕⠃⠄⠎⠀⠉⠁⠋⠑⠠⠄");
		testDencoder("BOB's CAFE", "ueb1", "⠠⠠⠃⠕⠃⠄⠎⠀⠠⠠⠉⠁⠋⠑");
		testDencoder("MERRY-GO-ROUND", "ueb1", "⠠⠠⠍⠑⠗⠗⠽⠤⠠⠠⠛⠕⠤⠠⠠⠗⠕⠥⠝⠙");
		testDencoder("CAUTION: 10 MPH LIMIT", "ueb1", "⠠⠠⠠⠉⠁⠥⠞⠊⠕⠝⠒⠀⠼⠁⠚⠀⠍⠏⠓⠀⠇⠊⠍⠊⠞⠠⠄");
		testDencoder("PUT THE \"GIVE\" IN THANKSGIVING", "ueb1", "⠠⠠⠠⠏⠥⠞⠀⠞⠓⠑⠀⠦⠛⠊⠧⠑⠴⠀⠊⠝⠀⠞⠓⠁⠝⠅⠎⠛⠊⠧⠊⠝⠛⠠⠄");
		testDencoder("The crowd shouted \"STOP THAT BALL!\"", "ueb1", "⠠⠞⠓⠑⠀⠉⠗⠕⠺⠙⠀⠎⠓⠕⠥⠞⠑⠙⠀⠦⠠⠠⠠⠎⠞⠕⠏⠀⠞⠓⠁⠞⠀⠃⠁⠇⠇⠖⠠⠄⠴");
	}
	
	@Test
	public void testJapanese() {
		// Blank
		testDencoder("", "japanese", "");
		
		testDencoder("アイウエオ", "japanese", "⠁⠃⠉⠋⠊");
		testDencoder("カキクケコ", "japanese", "⠡⠣⠩⠫⠪");
		testDencoder("サシスセソ", "japanese", "⠱⠳⠹⠻⠺");
		testDencoder("タチツテト", "japanese", "⠕⠗⠝⠟⠞");
		testDencoder("ナニヌネノ", "japanese", "⠅⠇⠍⠏⠎");
		testDencoder("ハヒフヘホ", "japanese", "⠥⠧⠭⠯⠮");
		testDencoder("マミムメモ", "japanese", "⠵⠷⠽⠿⠾");
		testDencoder("ヤユヨ", "japanese", "⠌⠬⠜");
		testDencoder("ラリルレロ", "japanese", "⠑⠓⠙⠛⠚");
		testDencoder("ワヰヱヲ", "japanese", "⠄⠆⠖⠔");
		testDencoder("ン", "japanese", "⠴");
		testDencoder("ッ", "japanese", "⠂");
		testDencoder("ー", "japanese", "⠒");
		testDencoder("、", "japanese", "⠰");
		testDencoder("。", "japanese", "⠲");
		testDencoder("？", "japanese", "⠢");
		testDencoder("！", "japanese", "⠖");
		testDencoder("・", "japanese", "⠐");
		testDencoder("ア、\r\n", "japanese", "⠁⠰\r\n");
		testDencoder("ア、ア", "japanese", "⠁⠰⠀⠁");
		testDencoder("ア。\r\n", "japanese", "⠁⠲\r\n");
		testDencoder("ア。ア", "japanese", "⠁⠲⠀⠀⠁");
		testDencoder("ア？\r\n", "japanese", "⠁⠢\r\n");
		testDencoder("ア？ア", "japanese", "⠁⠢⠀⠀⠁");
		testDencoder("ア！\r\n", "japanese", "⠁⠖\r\n");
		testDencoder("ア！ア", "japanese", "⠁⠖⠀⠀⠁");
		
		testDencoder("ヴ", "japanese", "⠐⠉");
		testDencoder("ガギグゲゴ", "japanese", "⠐⠡⠐⠣⠐⠩⠐⠫⠐⠪");
		testDencoder("ザジズゼゾ", "japanese", "⠐⠱⠐⠳⠐⠹⠐⠻⠐⠺");
		testDencoder("ダヂヅデド", "japanese", "⠐⠕⠐⠗⠐⠝⠐⠟⠐⠞");
		testDencoder("バビブベボ", "japanese", "⠐⠥⠐⠧⠐⠭⠐⠯⠐⠮");
		
		testDencoder("パピプペポ", "japanese", "⠠⠥⠠⠧⠠⠭⠠⠯⠠⠮");
		
		testDencoder("イェ", "japanese", "⠈⠋");
		testDencoder("キャキュキェキョ", "japanese", "⠈⠡⠈⠩⠈⠫⠈⠪");
		testDencoder("シャスィシュシェショ", "japanese", "⠈⠱⠈⠳⠈⠹⠈⠻⠈⠺");
		testDencoder("チャティチュチェチョ", "japanese", "⠈⠕⠈⠗⠈⠝⠈⠟⠈⠞");
		testDencoder("ニャニュニェニョ", "japanese", "⠈⠅⠈⠍⠈⠏⠈⠎");
		testDencoder("ヒャヒュヒェヒョ", "japanese", "⠈⠥⠈⠭⠈⠯⠈⠮");
		testDencoder("ミャミュミョ", "japanese", "⠈⠵⠈⠽⠈⠾");
		testDencoder("リャリュリョ", "japanese", "⠈⠑⠈⠙⠈⠚");
		testDencoder("ギャギュギョ", "japanese", "⠘⠡⠘⠩⠘⠪");
		testDencoder("ジャズィジュジェジョ", "japanese", "⠘⠱⠘⠳⠘⠹⠘⠻⠘⠺");
		testDencoder("ヂャディヂュヂョ", "japanese", "⠘⠕⠘⠗⠘⠝⠘⠞");
		testDencoder("ビャビュビョ", "japanese", "⠘⠥⠘⠭⠘⠮");
		testDencoder("ピャピュピョ", "japanese", "⠨⠥⠨⠭⠨⠮");
		testDencoder("ウァウィウェウォ", "japanese", "⠢⠁⠢⠃⠢⠋⠢⠊");
		testDencoder("クァクィクェクォ", "japanese", "⠢⠡⠢⠣⠢⠫⠢⠪");
		testDencoder("ツァツィトゥツェツォ", "japanese", "⠢⠕⠢⠗⠢⠝⠢⠟⠢⠞");
		testDencoder("ファフィフェフォフュフョ", "japanese", "⠢⠥⠢⠧⠢⠯⠢⠮⠨⠬⠨⠜");
		testDencoder("ヴァヴィヴェヴォヴュヴョ", "japanese", "⠲⠥⠲⠧⠲⠯⠲⠮⠸⠬⠸⠜");
		testDencoder("グァグィグェグォ", "japanese", "⠲⠡⠲⠣⠲⠫⠲⠪");
		testDencoder("ドゥ", "japanese", "⠲⠝");
		testDencoder("テュ", "japanese", "⠨⠝");
		testDencoder("デュ", "japanese", "⠸⠝");
		
		testDencoder("ァィゥェォ", "japanese", "⠘⠁⠘⠃⠘⠉⠘⠋⠘⠊");
		testDencoder("ャュョ", "japanese", "⠘⠌⠘⠬⠘⠜");
		testDencoder("ヮ", "japanese", "⠘⠄");
		
		// Letters
		testDencoder("ａ", "japanese", "⠰⠁");
		testDencoder("Ａ", "japanese", "⠰⠠⠁");
		testDencoder("ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ", "japanese", "⠰⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵");
		testDencoder("ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ", "japanese", "⠰⠠⠠⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵");
		
		// Letters (Half-width)
		testDencoder("abcdefghijklmnopqrstuvwxyz", "japanese", "⠰⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵", "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ");
		testDencoder("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "japanese", "⠰⠠⠠⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠅⠇⠍⠝⠕⠏⠟⠗⠎⠞⠥⠧⠺⠭⠽⠵", "ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ");
		
		// Letter case
		testDencoder("ＡＭｅＤＡＳ", "japanese", "⠰⠠⠁⠠⠍⠑⠠⠠⠙⠁⠎");
		testDencoder("ＮＩＥｓ", "japanese", "⠰⠠⠠⠝⠊⠑⠰⠎");
		testDencoder("ＮＳＡＩＤｓ", "japanese", "⠰⠠⠠⠝⠎⠁⠊⠙⠰⠎");
		testDencoder("ＳＤＧｓ", "japanese", "⠰⠠⠠⠎⠙⠛⠰⠎");
		testDencoder("ＡＴＰａｓｅ", "japanese", "⠰⠠⠠⠁⠞⠏⠰⠁⠎⠑");
		testDencoder("ＩＰｓｅｃ", "japanese", "⠰⠠⠊⠠⠏⠎⠑⠉"); // (Should put a Gaiji indicator before lower letters by the rule, but it is impossible without a dictionary)
		testDencoder("ＮｅｗＥＳＡ７２１", "japanese", "⠰⠠⠝⠑⠺⠠⠠⠑⠎⠁⠼⠛⠃⠁");
		
		testDencoder("Ｕ．Ｓ．Ａ．", "japanese", "⠰⠠⠥⠲⠠⠎⠲⠠⠁⠲");
		testDencoder("Ｃ－９０", "japanese", "⠰⠠⠉⠤⠼⠊⠚");
		testDencoder("ＣＤ－ＲＯＭ", "japanese", "⠰⠠⠠⠉⠙⠤⠰⠠⠠⠗⠕⠍"); // A Gaiji indicator will be terminated after a hyphen "-"
		testDencoder("ＤＯＳ／Ｖ", "japanese", "⠰⠠⠠⠙⠕⠎⠌⠠⠧");
		
//		// Letters & Whitespace & Letter case
		testDencoder("　ａｂｃｄｅｆｇ　ｈｉｊｋｌｍｎｏｐ　　　ｑｒｓｔｕｖ　ｗｘｙｚ　", "japanese", "⠀⠰⠁⠃⠉⠙⠑⠋⠛⠀⠰⠓⠊⠚⠅⠇⠍⠝⠕⠏⠀⠀⠀⠰⠟⠗⠎⠞⠥⠧⠀⠰⠺⠭⠽⠵⠀");
		testDencoder("　ＡｂｃｄＥｆｇ　Ｈｉｊｋｌｍｎｏｐ　　　ＱｒｓｔｕＶ　Ｗｘｙｚ　", "japanese", "⠀⠰⠠⠁⠃⠉⠙⠠⠑⠋⠛⠀⠰⠠⠓⠊⠚⠅⠇⠍⠝⠕⠏⠀⠀⠀⠰⠠⠟⠗⠎⠞⠥⠠⠧⠀⠰⠠⠺⠭⠽⠵⠀");
		testDencoder("　ＡＢＣＤＥＦＧ　ＨＩＪＫＬＭＮＯＰ　　　ＱＲＳＴＵＶ　ＷＸＹＺ　", "japanese", "⠀⠰⠠⠠⠁⠃⠉⠙⠑⠋⠛⠀⠰⠠⠠⠓⠊⠚⠅⠇⠍⠝⠕⠏⠀⠀⠀⠰⠠⠠⠟⠗⠎⠞⠥⠧⠀⠰⠠⠠⠺⠭⠽⠵⠀");
		
		// Numbers
		testDencoder("１２３４５６７８９０", "japanese", "⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚");
		testDencoder("１，２３４，５６７，８９０", "japanese", "⠼⠁⠄⠃⠉⠙⠄⠑⠋⠛⠄⠓⠊⠚");
		testDencoder("１２３４５．６７８９０", "japanese", "⠼⠁⠃⠉⠙⠑⠂⠋⠛⠓⠊⠚");
		testDencoder("ａｂｃ１２３４５６７８９０ａｂｃ", "japanese", "⠰⠁⠃⠉⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠰⠁⠃⠉");
		testDencoder("ａｂｃ　１２３４５６７８９０　ａｂｃ", "japanese", "⠰⠁⠃⠉⠀⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠀⠰⠁⠃⠉");
		testDencoder("ＡＢＣ１２３４５６７８９０ＡＢＣ", "japanese", "⠰⠠⠠⠁⠃⠉⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠰⠠⠠⠁⠃⠉");
		testDencoder("ＡＢＣ　１２３４５６７８９０　ＡＢＣ", "japanese", "⠰⠠⠠⠁⠃⠉⠀⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚⠀⠰⠠⠠⠁⠃⠉");
		testDencoder("２０１２－０１－２３", "japanese", "⠼⠃⠚⠁⠃⠤⠼⠚⠁⠤⠼⠃⠉");
		testDencoder("１００ｇ", "japanese", "⠼⠁⠚⠚⠰⠛");
		
		// Numbers (Half-width)
		testDencoder("1234567890", "japanese", "⠼⠁⠃⠉⠙⠑⠋⠛⠓⠊⠚", "１２３４５６７８９０");
		testDencoder("1,234,567,890", "japanese", "⠼⠁⠄⠃⠉⠙⠄⠑⠋⠛⠄⠓⠊⠚", "１，２３４，５６７，８９０");
		testDencoder("12345.67890", "japanese", "⠼⠁⠃⠉⠙⠑⠂⠋⠛⠓⠊⠚", "１２３４５．６７８９０");
		
		// Mixed
		testDencoder("アイウ　ａｂｃ　１２３　ａｂｃ　アイウ　１２３　アイウ", "japanese", "⠁⠃⠉⠀⠰⠁⠃⠉⠀⠼⠁⠃⠉⠀⠰⠁⠃⠉⠀⠁⠃⠉⠀⠼⠁⠃⠉⠀⠁⠃⠉");
		testDencoder("ワヲン　ｘｙｚ　７８９　ｘｙｚ　ワヲン　７８９　ワヲン", "japanese", "⠄⠔⠴⠀⠰⠭⠽⠵⠀⠼⠛⠓⠊⠀⠰⠭⠽⠵⠀⠄⠔⠴⠀⠼⠛⠓⠊⠀⠄⠔⠴");
		testDencoder("アイウａｂｃ１２３ａｂｃアイウ１２３アイウ", "japanese", "⠁⠃⠉⠰⠁⠃⠉⠼⠁⠃⠉⠰⠁⠃⠉⠤⠁⠃⠉⠼⠁⠃⠉⠤⠁⠃⠉");
		testDencoder("ワヲンｘｙｚ７８９ｘｙｚワヲン７８９ワヲン", "japanese", "⠄⠔⠴⠰⠭⠽⠵⠼⠛⠓⠊⠰⠭⠽⠵⠤⠄⠔⠴⠼⠛⠓⠊⠤⠄⠔⠴");
		
		// Symbols
		testDencoder("％＆＃＊＠", "japanese", "⠰⠏⠰⠯⠰⠩⠰⠡⠰⠪");
		testDencoder("○△□×", "japanese", "⠂⠵⠂⠷⠂⠽⠂⠿");
		
		testDencoder("スー％", "japanese", "⠹⠒⠰⠏");
		testDencoder("Ａ％", "japanese", "⠰⠠⠁⠰⠏");
		testDencoder("２５％ビキ", "japanese", "⠼⠃⠑⠰⠏⠐⠧⠣"); // FIXME: Should put a Tsunagi indicator between % and Kana
		
		testDencoder("＃５０", "japanese", "⠰⠩⠼⠑⠚");
		testDencoder("＊５０", "japanese", "⠰⠡⠼⠑⠚");
		
		testDencoder("４ワリイリ", "japanese", "⠼⠙⠤⠄⠓⠃⠓"); // If remove the Tsunagi indicator, can read it as a number 4.828
		testDencoder("４ワリ", "japanese", "⠼⠙⠤⠄⠓"); // FIXME: Does not need a Tsunagi indicator
		
		testDencoder("Ｓ／Ｎヒ", "japanese", "⠰⠠⠎⠌⠠⠝⠤⠧");
		testDencoder("Ａ／Ｈ１Ｎ１", "japanese", "⠰⠠⠁⠌⠠⠓⠼⠁⠰⠠⠝⠼⠁");
		testDencoder("ＡＤ／ＤＡコンバーター", "japanese", "⠰⠠⠠⠁⠙⠌⠠⠠⠙⠁⠤⠪⠴⠐⠥⠒⠕⠒"); // Normally, a space is placed between 'Ａ' and 'コ', but it is not placed to cover all validation patterns
		testDencoder("ＡＣ／ＤＣ　マルチ　アダプター", "japanese", "⠰⠠⠠⠁⠉⠌⠠⠠⠙⠉⠀⠵⠙⠗⠀⠁⠐⠕⠠⠭⠕⠒");
		
		testDencoder("９ジ〜１５ジ", "japanese", "⠼⠊⠐⠳⠤⠤⠼⠁⠑⠐⠳");
		
		// Punctuation marks
		testDencoder("コンニチワ。", "japanese", "⠪⠴⠇⠗⠄⠲");
		testDencoder("Ｈｅｌｌｏ．", "japanese", "⠰⠠⠓⠑⠇⠇⠕⠲");
		testDencoder("Ａ、Ｂ　ノ　アイダ", "japanese", "⠰⠠⠁⠰⠀⠰⠠⠃⠀⠎⠀⠁⠃⠐⠕");
		testDencoder("Ａ．、Ｂ．　ノ　アイダ", "japanese", "⠰⠠⠁⠲⠰⠀⠰⠠⠃⠲⠀⠎⠀⠁⠃⠐⠕");
		testDencoder("オゲンキ？ヒサシブリデスネ。", "japanese", "⠊⠐⠫⠴⠣⠢⠀⠀⠧⠱⠳⠐⠭⠓⠐⠟⠹⠏⠲");
		testDencoder("エッ！カレガ　テツガクシャ！？", "japanese", "⠋⠂⠖⠀⠀⠡⠛⠐⠡⠀⠟⠝⠐⠡⠩⠈⠱⠖⠢");
		testDencoder("マツ・スギ・ヒノキワ、シンヨージュデス。", "japanese", "⠵⠝⠐⠀⠹⠐⠣⠐⠀⠧⠎⠣⠄⠰⠀⠳⠴⠜⠒⠘⠹⠐⠟⠹⠲");
		
		// Brackets
		testDencoder("「コンニチワ」", "japanese", "⠤⠪⠴⠇⠗⠄⠤");
		testDencoder("「コンニチワ。」", "japanese", "⠤⠪⠴⠇⠗⠄⠲⠤");
		
		testDencoder("「１５００エンデス」ト　コタエタ。", "japanese", "⠤⠼⠁⠑⠚⠚⠤⠋⠴⠐⠟⠹⠤⠞⠀⠪⠕⠋⠕⠲");
		testDencoder("「コレ　１サツデ　ＯＫ！」テキナ　タイサクボン", "japanese", "⠤⠪⠛⠀⠼⠁⠱⠝⠐⠟⠀⠰⠠⠠⠕⠅⠖⠤⠟⠣⠅⠀⠕⠃⠱⠩⠐⠮⠴");
		testDencoder("「ボクワ、ハッキリ　『イヤダ。』ト　イッタヨ。」", "japanese", "⠤⠐⠮⠩⠄⠰⠀⠥⠂⠣⠓⠀⠰⠤⠃⠌⠐⠕⠲⠤⠆⠞⠀⠃⠂⠕⠜⠲⠤");
		testDencoder("「ジュウショ」「シメイ」「デンワ　バンゴー」ヲ　カイテ　クダサイ。", "japanese", "⠤⠘⠹⠉⠈⠺⠤⠀⠤⠳⠿⠃⠤⠀⠤⠐⠟⠴⠄⠀⠐⠥⠴⠐⠪⠒⠤⠔⠀⠡⠃⠟⠀⠩⠐⠕⠱⠃⠲", "「ジュウショ」　「シメイ」　「デンワ　バンゴー」ヲ　カイテ　クダサイ。"); // A space will be placed between the brackets
		testDencoder("『マクラノ　ソーシ』『ツレヅレグサ』『ホージョーキ』ワ　ニホン　３ダイ　ズイヒツト　イワレテ　イマス。", "japanese", "⠰⠤⠵⠩⠑⠎⠀⠺⠒⠳⠤⠆⠀⠰⠤⠝⠛⠐⠝⠛⠐⠩⠱⠤⠆⠀⠰⠤⠮⠒⠘⠺⠒⠣⠤⠆⠄⠀⠇⠮⠴⠀⠼⠉⠐⠕⠃⠀⠐⠹⠃⠧⠝⠞⠀⠃⠄⠛⠟⠀⠃⠵⠹⠲", "『マクラノ　ソーシ』　『ツレヅレグサ』　『ホージョーキ』ワ　ニホン　３ダイ　ズイヒツト　イワレテ　イマス。"); // A space will be placed between the brackets
		testDencoder("「フクコワ、コー『フク』ナ　『コ』ト　カキマス。」", "japanese", "⠤⠭⠩⠪⠄⠰⠀⠪⠒⠰⠤⠭⠩⠤⠆⠅⠀⠰⠤⠪⠤⠆⠞⠀⠡⠣⠵⠹⠲⠤");
		testDencoder("「フクコワ、コー「フク」ナ　「コ」ト　カキマス。」", "japanese", "⠤⠭⠩⠪⠄⠰⠀⠪⠒⠰⠄⠭⠩⠠⠆⠅⠀⠰⠄⠪⠠⠆⠞⠀⠡⠣⠵⠹⠲⠤");
		testDencoder("ヨコハマニワ　「ミナトノ（カクジョシ　「ノ」）　ミエル　オカ　コーエン」ガ　アル。", "japanese", "⠜⠪⠥⠵⠇⠄⠀⠤⠷⠅⠞⠎⠶⠡⠩⠘⠺⠳⠀⠤⠎⠤⠶⠀⠷⠋⠙⠀⠊⠡⠀⠪⠒⠋⠴⠤⠐⠡⠀⠁⠙⠲");
		
		testDencoder("ショーネン（１６サイ）ノ　スガタ", "japanese", "⠈⠺⠒⠏⠴⠶⠼⠁⠋⠱⠃⠶⠎⠀⠹⠐⠡⠕");
		testDencoder("カレワ　「コトシワ　（ホームランヲ）　５０ポン　ウツ」ト　イッテ　イル", "japanese", "⠡⠛⠄⠀⠤⠪⠞⠳⠄⠀⠶⠮⠒⠽⠑⠴⠔⠶⠀⠼⠑⠚⠠⠮⠴⠀⠉⠝⠤⠞⠀⠃⠂⠟⠀⠃⠙");
		testDencoder("スグ（ニ）（フクシ）　ヒガ　クレル。", "japanese", "⠹⠐⠩⠶⠇⠶⠀⠶⠭⠩⠳⠶⠀⠧⠐⠡⠀⠩⠛⠙⠲", "スグ（ニ）　（フクシ）　ヒガ　クレル。"); // A space will be placed between the brackets
		testDencoder("ＰＬホー（１９９５｟ヘイセイ　７｠ネン　７ガツ　ツイタチ　シコー）", "japanese", "⠰⠠⠠⠏⠇⠤⠮⠒⠶⠼⠁⠊⠊⠑⠰⠶⠯⠃⠻⠃⠀⠼⠛⠶⠆⠏⠴⠀⠼⠛⠐⠡⠝⠀⠝⠃⠕⠗⠀⠳⠪⠒⠶");
		testDencoder("ＰＬホー（１９９５（ヘイセイ　７）ネン　７ガツ　ツイタチ　シコー）", "japanese", "⠰⠠⠠⠏⠇⠤⠮⠒⠶⠼⠁⠊⠊⠑⠐⠶⠯⠃⠻⠃⠀⠼⠛⠶⠂⠏⠴⠀⠼⠛⠐⠡⠝⠀⠝⠃⠕⠗⠀⠳⠪⠒⠶");
	}
	
	private void testDencoder(String value, String variant, String expectedEncodedValue) {
		testDencoder(value, variant, expectedEncodedValue, null);
	}
	
	private void testDencoder(String value, String variant, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = StringBrailleDencoder.encStrBraille(condition(value, variant));
		assertEquals(expectedEncodedValue, encodedValue);
		String decodedValue = StringBrailleDencoder.decStrBraille(condition(encodedValue, variant));
		if (expectedDecodedValue == null) {
			assertEquals(value, decodedValue);
		} else {
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
	
	private DencodeCondition condition(String value, String variant) {
		return condition(value, StandardCharsets.UTF_8, variant);
	}
	
	private DencodeCondition condition(String value, Charset charset, String variant) {
		return new DencodeCondition(value, charset, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("string.braille.variant", variant);
			}
		});
	}
 }
 