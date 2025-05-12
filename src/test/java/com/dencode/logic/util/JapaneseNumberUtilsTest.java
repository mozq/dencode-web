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
package com.dencode.logic.util;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.math.BigDecimal;

import org.junit.jupiter.api.Test;

public class JapaneseNumberUtilsTest {

	@Test
	public void test_toJPNum() throws Exception {
		assertEquals(null, JapaneseNumberUtils.toJPNum((BigDecimal)null));
		
		assertEquals("〇", JapaneseNumberUtils.toJPNum(new BigDecimal("0")));
		assertEquals("一", JapaneseNumberUtils.toJPNum(new BigDecimal("1")));
		assertEquals("二", JapaneseNumberUtils.toJPNum(new BigDecimal("2")));
		
		assertEquals("十", JapaneseNumberUtils.toJPNum(new BigDecimal("10")));
		assertEquals("十一", JapaneseNumberUtils.toJPNum(new BigDecimal("11")));
		assertEquals("十二", JapaneseNumberUtils.toJPNum(new BigDecimal("12")));
		
		assertEquals("二十", JapaneseNumberUtils.toJPNum(new BigDecimal("20")));
		assertEquals("二十一", JapaneseNumberUtils.toJPNum(new BigDecimal("21")));

		assertEquals("九十九", JapaneseNumberUtils.toJPNum(new BigDecimal("99")));

		assertEquals("百", JapaneseNumberUtils.toJPNum(new BigDecimal("100")));
		assertEquals("百一", JapaneseNumberUtils.toJPNum(new BigDecimal("101")));
		
		assertEquals("百十", JapaneseNumberUtils.toJPNum(new BigDecimal("110")));
		assertEquals("百十一", JapaneseNumberUtils.toJPNum(new BigDecimal("111")));
		assertEquals("百二十", JapaneseNumberUtils.toJPNum(new BigDecimal("120")));
		assertEquals("百二十一", JapaneseNumberUtils.toJPNum(new BigDecimal("121")));
		
		assertEquals("二千", JapaneseNumberUtils.toJPNum(new BigDecimal("2000")));
		
		assertEquals("二万三千四百五十六", JapaneseNumberUtils.toJPNum(new BigDecimal("23456")));
		
		assertEquals("九千八百七十六無量大数五千四百三十二不可思議千九十八那由他七千六百五十四阿僧祇三千二百十恒河沙九千八百七十六極五千四百三十三載二千百九正八千七百六十五澗四千三百二十一溝九百八十七穣六千五百四十三秭二千百九垓八千七百六十五京四千三百二十一兆九百八十七億六千五百四十三万二千百九", JapaneseNumberUtils.toJPNum(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109")));
		assertEquals("玖阡捌陌漆拾陸無量大数伍阡肆陌参拾弐不可思議阡玖拾捌那由他漆阡陸陌伍拾肆阿僧祇参阡弐陌拾恒河沙玖阡捌陌漆拾陸極伍阡肆陌参拾参載弐阡陌玖正捌阡漆陌陸拾伍澗肆阡参陌弐拾壱溝玖陌捌拾漆穣陸阡伍陌肆拾参秭弐阡陌玖垓捌阡漆陌陸拾伍京肆阡参陌弐拾壱兆玖陌捌拾漆億陸阡伍陌肆拾参萬弐阡陌玖", JapaneseNumberUtils.toJPNum(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), false, true, false));
		assertEquals("玖阡捌陌柒拾陸無量大数伍阡肆陌參拾貳不可思議阡玖拾捌那由他柒阡陸陌伍拾肆阿僧祇參阡貳陌拾恒河沙玖阡捌陌柒拾陸極伍阡肆陌參拾參載貳阡陌玖正捌阡柒陌陸拾伍澗肆阡參陌貳拾壹溝玖陌捌拾柒穣陸阡伍陌肆拾參秭貳阡陌玖垓捌阡柒陌陸拾伍京肆阡參陌貳拾壹兆玖陌捌拾柒億陸阡伍陌肆拾參萬貳阡陌玖", JapaneseNumberUtils.toJPNum(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), false, true, true));
		assertEquals("玖阡捌陌漆拾陸無量大数伍阡肆陌参拾弐不可思議壱阡玖拾捌那由他漆阡陸陌伍拾肆阿僧祇参阡弐陌壱拾恒河沙玖阡捌陌漆拾陸極伍阡肆陌参拾参載弐阡壱陌玖正捌阡漆陌陸拾伍澗肆阡参陌弐拾壱溝玖陌捌拾漆穣陸阡伍陌肆拾参秭弐阡壱陌玖垓捌阡漆陌陸拾伍京肆阡参陌弐拾壱兆玖陌捌拾漆億陸阡伍陌肆拾参萬弐阡壱陌玖", JapaneseNumberUtils.toJPNum(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), true, true, false));
		assertEquals("玖阡捌陌柒拾陸無量大数伍阡肆陌參拾貳不可思議壹阡玖拾捌那由他柒阡陸陌伍拾肆阿僧祇參阡貳陌壹拾恒河沙玖阡捌陌柒拾陸極伍阡肆陌參拾參載貳阡壹陌玖正捌阡柒陌陸拾伍澗肆阡參陌貳拾壹溝玖陌捌拾柒穣陸阡伍陌肆拾參秭貳阡壹陌玖垓捌阡柒陌陸拾伍京肆阡參陌貳拾壹兆玖陌捌拾柒億陸阡伍陌肆拾參萬貳阡壹陌玖", JapaneseNumberUtils.toJPNum(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), true, true, true));
		
		assertEquals("〇・〇", JapaneseNumberUtils.toJPNum(new BigDecimal("0.0")));
		
		assertEquals("〇・〇〇", JapaneseNumberUtils.toJPNum(new BigDecimal("0.00")));
		
		assertEquals("〇・〇一二", JapaneseNumberUtils.toJPNum(new BigDecimal("0.012")));
		
		
		assertEquals("−九千八百七十六無量大数五千四百三十二不可思議千九十八那由他七千六百五十四阿僧祇三千二百十恒河沙九千八百七十六極五千四百三十三載二千百九正八千七百六十五澗四千三百二十一溝九百八十七穣六千五百四十三秭二千百九垓八千七百六十五京四千三百二十一兆九百八十七億六千五百四十三万二千百九", JapaneseNumberUtils.toJPNum(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109")));
		assertEquals("−玖阡捌陌漆拾陸無量大数伍阡肆陌参拾弐不可思議阡玖拾捌那由他漆阡陸陌伍拾肆阿僧祇参阡弐陌拾恒河沙玖阡捌陌漆拾陸極伍阡肆陌参拾参載弐阡陌玖正捌阡漆陌陸拾伍澗肆阡参陌弐拾壱溝玖陌捌拾漆穣陸阡伍陌肆拾参秭弐阡陌玖垓捌阡漆陌陸拾伍京肆阡参陌弐拾壱兆玖陌捌拾漆億陸阡伍陌肆拾参萬弐阡陌玖", JapaneseNumberUtils.toJPNum(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), false, true, false));
		assertEquals("−玖阡捌陌柒拾陸無量大数伍阡肆陌參拾貳不可思議阡玖拾捌那由他柒阡陸陌伍拾肆阿僧祇參阡貳陌拾恒河沙玖阡捌陌柒拾陸極伍阡肆陌參拾參載貳阡陌玖正捌阡柒陌陸拾伍澗肆阡參陌貳拾壹溝玖陌捌拾柒穣陸阡伍陌肆拾參秭貳阡陌玖垓捌阡柒陌陸拾伍京肆阡參陌貳拾壹兆玖陌捌拾柒億陸阡伍陌肆拾參萬貳阡陌玖", JapaneseNumberUtils.toJPNum(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), false, true, true));
		assertEquals("−玖阡捌陌漆拾陸無量大数伍阡肆陌参拾弐不可思議壱阡玖拾捌那由他漆阡陸陌伍拾肆阿僧祇参阡弐陌壱拾恒河沙玖阡捌陌漆拾陸極伍阡肆陌参拾参載弐阡壱陌玖正捌阡漆陌陸拾伍澗肆阡参陌弐拾壱溝玖陌捌拾漆穣陸阡伍陌肆拾参秭弐阡壱陌玖垓捌阡漆陌陸拾伍京肆阡参陌弐拾壱兆玖陌捌拾漆億陸阡伍陌肆拾参萬弐阡壱陌玖", JapaneseNumberUtils.toJPNum(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), true, true, false));
		assertEquals("−玖阡捌陌柒拾陸無量大数伍阡肆陌參拾貳不可思議壹阡玖拾捌那由他柒阡陸陌伍拾肆阿僧祇參阡貳陌壹拾恒河沙玖阡捌陌柒拾陸極伍阡肆陌參拾參載貳阡壹陌玖正捌阡柒陌陸拾伍澗肆阡參陌貳拾壹溝玖陌捌拾柒穣陸阡伍陌肆拾參秭貳阡壹陌玖垓捌阡柒陌陸拾伍京肆阡參陌貳拾壹兆玖陌捌拾柒億陸阡伍陌肆拾參萬貳阡壹陌玖", JapaneseNumberUtils.toJPNum(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), true, true, true));
		
		
		assertEquals("〇・〇", JapaneseNumberUtils.toJPNum(new BigDecimal("-0.0"))); // BigDecimal has not signed zero
		
		assertEquals("〇・〇〇", JapaneseNumberUtils.toJPNum(new BigDecimal("-0.00"))); // BigDecimal has not signed zero
		
		assertEquals("−〇・〇一二", JapaneseNumberUtils.toJPNum(new BigDecimal("-0.012")));
	}
	
	@Test
	public void test_parseJPNum() throws Exception {
		assertEquals(null, JapaneseNumberUtils.parseJPNum(null));
		
		assertEquals(new BigDecimal("0"), JapaneseNumberUtils.parseJPNum("〇"));
		assertEquals(new BigDecimal("1"), JapaneseNumberUtils.parseJPNum("一"));
		
		assertEquals(new BigDecimal("10"), JapaneseNumberUtils.parseJPNum("十"));
		
		assertEquals(new BigDecimal("11"), JapaneseNumberUtils.parseJPNum("十一"));
		
		assertEquals(new BigDecimal("20"), JapaneseNumberUtils.parseJPNum("二十"));
		assertEquals(new BigDecimal("21"), JapaneseNumberUtils.parseJPNum("二十一"));
		
		assertEquals(new BigDecimal("99"), JapaneseNumberUtils.parseJPNum("九十九"));
		
		assertEquals(new BigDecimal("100"), JapaneseNumberUtils.parseJPNum("百"));
		assertEquals(new BigDecimal("101"), JapaneseNumberUtils.parseJPNum("百一"));
		
		assertEquals(new BigDecimal("110"), JapaneseNumberUtils.parseJPNum("百十"));
		assertEquals(new BigDecimal("111"), JapaneseNumberUtils.parseJPNum("百十一"));
		assertEquals(new BigDecimal("120"), JapaneseNumberUtils.parseJPNum("百二十"));
		assertEquals(new BigDecimal("121"), JapaneseNumberUtils.parseJPNum("百二十一"));
		
		assertEquals(new BigDecimal("2000"), JapaneseNumberUtils.parseJPNum("二千"));
		
		assertEquals(new BigDecimal("23456"), JapaneseNumberUtils.parseJPNum("二万三千四百五十六"));
		
		assertEquals(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("九千八百七十六無量大数五千四百三十二不可思議千九十八那由他七千六百五十四阿僧祇三千二百十恒河沙九千八百七十六極五千四百三十三載二千百九正八千七百六十五澗四千三百二十一溝九百八十七穣六千五百四十三秭二千百九垓八千七百六十五京四千三百二十一兆九百八十七億六千五百四十三万二千百九"));
		assertEquals(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("玖阡捌陌漆拾陸無量大数伍阡肆陌参拾弐不可思議阡玖拾捌那由他漆阡陸陌伍拾肆阿僧祇参阡弐陌拾恒河沙玖阡捌陌漆拾陸極伍阡肆陌参拾参載弐阡陌玖正捌阡漆陌陸拾伍澗肆阡参陌弐拾壱溝玖陌捌拾漆穣陸阡伍陌肆拾参秭弐阡陌玖垓捌阡漆陌陸拾伍京肆阡参陌弐拾壱兆玖陌捌拾漆億陸阡伍陌肆拾参萬弐阡陌玖"));
		assertEquals(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("玖阡捌陌柒拾陸無量大数伍阡肆陌參拾貳不可思議阡玖拾捌那由他柒阡陸陌伍拾肆阿僧祇參阡貳陌拾恒河沙玖阡捌陌柒拾陸極伍阡肆陌參拾參載貳阡陌玖正捌阡柒陌陸拾伍澗肆阡參陌貳拾壹溝玖陌捌拾柒穣陸阡伍陌肆拾參秭貳阡陌玖垓捌阡柒陌陸拾伍京肆阡參陌貳拾壹兆玖陌捌拾柒億陸阡伍陌肆拾參萬貳阡陌玖"));
		assertEquals(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("玖阡捌陌漆拾陸無量大数伍阡肆陌参拾弐不可思議壱阡玖拾捌那由他漆阡陸陌伍拾肆阿僧祇参阡弐陌壱拾恒河沙玖阡捌陌漆拾陸極伍阡肆陌参拾参載弐阡壱陌玖正捌阡漆陌陸拾伍澗肆阡参陌弐拾壱溝玖陌捌拾漆穣陸阡伍陌肆拾参秭弐阡壱陌玖垓捌阡漆陌陸拾伍京肆阡参陌弐拾壱兆玖陌捌拾漆億陸阡伍陌肆拾参萬弐阡壱陌玖"));
		assertEquals(new BigDecimal("987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("玖阡捌陌柒拾陸無量大数伍阡肆陌參拾貳不可思議壹阡玖拾捌那由他柒阡陸陌伍拾肆阿僧祇參阡貳陌壹拾恒河沙玖阡捌陌柒拾陸極伍阡肆陌參拾參載貳阡壹陌玖正捌阡柒陌陸拾伍澗肆阡參陌貳拾壹溝玖陌捌拾柒穣陸阡伍陌肆拾參秭貳阡壹陌玖垓捌阡柒陌陸拾伍京肆阡參陌貳拾壹兆玖陌捌拾柒億陸阡伍陌肆拾參萬貳阡壹陌玖"));
		
		
		assertEquals(new BigDecimal("0.0"), JapaneseNumberUtils.parseJPNum("〇・〇"));
		assertEquals(new BigDecimal("1.0"), JapaneseNumberUtils.parseJPNum("一・〇"));
		
		assertEquals(new BigDecimal("0.00"), JapaneseNumberUtils.parseJPNum("〇・〇〇"));
		assertEquals(new BigDecimal("1.00"), JapaneseNumberUtils.parseJPNum("一・〇〇"));
		
		assertEquals(new BigDecimal("0.012"), JapaneseNumberUtils.parseJPNum("〇・〇一二"));
		assertEquals(new BigDecimal("1.012"), JapaneseNumberUtils.parseJPNum("一・〇一二"));
		
		
		assertEquals(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("−九千八百七十六無量大数五千四百三十二不可思議千九十八那由他七千六百五十四阿僧祇三千二百十恒河沙九千八百七十六極五千四百三十三載二千百九正八千七百六十五澗四千三百二十一溝九百八十七穣六千五百四十三秭二千百九垓八千七百六十五京四千三百二十一兆九百八十七億六千五百四十三万二千百九"));
		assertEquals(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("−玖阡捌陌漆拾陸無量大数伍阡肆陌参拾弐不可思議阡玖拾捌那由他漆阡陸陌伍拾肆阿僧祇参阡弐陌拾恒河沙玖阡捌陌漆拾陸極伍阡肆陌参拾参載弐阡陌玖正捌阡漆陌陸拾伍澗肆阡参陌弐拾壱溝玖陌捌拾漆穣陸阡伍陌肆拾参秭弐阡陌玖垓捌阡漆陌陸拾伍京肆阡参陌弐拾壱兆玖陌捌拾漆億陸阡伍陌肆拾参萬弐阡陌玖"));
		assertEquals(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("−玖阡捌陌柒拾陸無量大数伍阡肆陌參拾貳不可思議阡玖拾捌那由他柒阡陸陌伍拾肆阿僧祇參阡貳陌拾恒河沙玖阡捌陌柒拾陸極伍阡肆陌參拾參載貳阡陌玖正捌阡柒陌陸拾伍澗肆阡參陌貳拾壹溝玖陌捌拾柒穣陸阡伍陌肆拾參秭貳阡陌玖垓捌阡柒陌陸拾伍京肆阡參陌貳拾壹兆玖陌捌拾柒億陸阡伍陌肆拾參萬貳阡陌玖"));
		assertEquals(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("−玖阡捌陌漆拾陸無量大数伍阡肆陌参拾弐不可思議壱阡玖拾捌那由他漆阡陸陌伍拾肆阿僧祇参阡弐陌壱拾恒河沙玖阡捌陌漆拾陸極伍阡肆陌参拾参載弐阡壱陌玖正捌阡漆陌陸拾伍澗肆阡参陌弐拾壱溝玖陌捌拾漆穣陸阡伍陌肆拾参秭弐阡壱陌玖垓捌阡漆陌陸拾伍京肆阡参陌弐拾壱兆玖陌捌拾漆億陸阡伍陌肆拾参萬弐阡壱陌玖"));
		assertEquals(new BigDecimal("-987654321098765432109876543321098765432109876543210987654321098765432109"), JapaneseNumberUtils.parseJPNum("−玖阡捌陌柒拾陸無量大数伍阡肆陌參拾貳不可思議壹阡玖拾捌那由他柒阡陸陌伍拾肆阿僧祇參阡貳陌壹拾恒河沙玖阡捌陌柒拾陸極伍阡肆陌參拾參載貳阡壹陌玖正捌阡柒陌陸拾伍澗肆阡參陌貳拾壹溝玖陌捌拾柒穣陸阡伍陌肆拾參秭貳阡壹陌玖垓捌阡柒陌陸拾伍京肆阡參陌貳拾壹兆玖陌捌拾柒億陸阡伍陌肆拾參萬貳阡壹陌玖"));
		
		
		assertEquals(new BigDecimal("0.0"), JapaneseNumberUtils.parseJPNum("−〇・〇"));
		assertEquals(new BigDecimal("-1.0"), JapaneseNumberUtils.parseJPNum("−一・〇"));
		
		assertEquals(new BigDecimal("0.00"), JapaneseNumberUtils.parseJPNum("−〇・〇〇"));
		assertEquals(new BigDecimal("-1.00"), JapaneseNumberUtils.parseJPNum("−一・〇〇"));
		
		assertEquals(new BigDecimal("-0.012"), JapaneseNumberUtils.parseJPNum("−〇・〇一二"));
		assertEquals(new BigDecimal("-1.012"), JapaneseNumberUtils.parseJPNum("−一・〇一二"));
		

		assertEquals(new BigDecimal("25"), JapaneseNumberUtils.parseJPNum("25"));
		assertEquals(new BigDecimal("2.5"), JapaneseNumberUtils.parseJPNum("2.5"));
		
		assertEquals(new BigDecimal("250"), JapaneseNumberUtils.parseJPNum("25十"));
		assertEquals(new BigDecimal("25"), JapaneseNumberUtils.parseJPNum("2.5十"));
		
		assertEquals(new BigDecimal("2500"), JapaneseNumberUtils.parseJPNum("25百"));
		assertEquals(new BigDecimal("250"), JapaneseNumberUtils.parseJPNum("2.5百"));
		
		assertEquals(new BigDecimal("25000"), JapaneseNumberUtils.parseJPNum("25千"));
		assertEquals(new BigDecimal("2500"), JapaneseNumberUtils.parseJPNum("2.5千"));
		
		assertEquals(new BigDecimal("250000"), JapaneseNumberUtils.parseJPNum("25万"));
		assertEquals(new BigDecimal("25000"), JapaneseNumberUtils.parseJPNum("2.5万"));
		
		assertEquals(new BigDecimal("2500000"), JapaneseNumberUtils.parseJPNum("25十万"));
		assertEquals(new BigDecimal("250000"), JapaneseNumberUtils.parseJPNum("2.5十万"));
		
		assertEquals(new BigDecimal("25000000"), JapaneseNumberUtils.parseJPNum("25百万"));
		assertEquals(new BigDecimal("2500000"), JapaneseNumberUtils.parseJPNum("2.5百万"));
		
		assertEquals(new BigDecimal("250000000"), JapaneseNumberUtils.parseJPNum("25千万"));
		assertEquals(new BigDecimal("25000000"), JapaneseNumberUtils.parseJPNum("2.5千万"));
		
		assertEquals(new BigDecimal("2500000000"), JapaneseNumberUtils.parseJPNum("25億"));
		assertEquals(new BigDecimal("250000000"), JapaneseNumberUtils.parseJPNum("2.5億"));
		
		
		assertEquals(new BigDecimal("277502525"), JapaneseNumberUtils.parseJPNum("2.5億2.5千2.5百万2.5千2.5十"));
		
		
		assertThrows(IllegalArgumentException.class, () -> {
			JapaneseNumberUtils.parseJPNum("");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			JapaneseNumberUtils.parseJPNum("−");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			JapaneseNumberUtils.parseJPNum("あ");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			JapaneseNumberUtils.parseJPNum("二あ");
		});
	}
}
