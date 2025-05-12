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

import static com.dencode.logic.util.EnglishNumberUtils.DecimalNotation.*;
import static com.dencode.logic.util.EnglishNumberUtils.Scale.*;
import static com.dencode.logic.util.EnglishNumberUtils.System.*;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.math.BigDecimal;

import org.junit.jupiter.api.Test;

public class EnglishNumberUtilsTest {

	@Test
	public void test_tooEnNum_shortScale() throws Exception {
		assertEquals(null, EnglishNumberUtils.toEnNum((BigDecimal)null, FRACTION, CW4EN));
		assertEquals(null, EnglishNumberUtils.toEnNum((BigDecimal)null, POINT, CW4EN));
		
		assertEquals("Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0"), POINT, CW4EN));
		assertEquals("One", EnglishNumberUtils.toEnNum(new BigDecimal("1"), POINT, CW4EN));
		assertEquals("Two", EnglishNumberUtils.toEnNum(new BigDecimal("2"), POINT, CW4EN));
		
		assertEquals("Ten", EnglishNumberUtils.toEnNum(new BigDecimal("10"), POINT, CW4EN));
		assertEquals("Eleven", EnglishNumberUtils.toEnNum(new BigDecimal("11"), POINT, CW4EN));
		assertEquals("Twelve", EnglishNumberUtils.toEnNum(new BigDecimal("12"), POINT, CW4EN));
		
		assertEquals("Twenty", EnglishNumberUtils.toEnNum(new BigDecimal("20"), POINT, CW4EN));
		assertEquals("Twenty-One", EnglishNumberUtils.toEnNum(new BigDecimal("21"), POINT, CW4EN));

		assertEquals("Ninety-Nine", EnglishNumberUtils.toEnNum(new BigDecimal("99"), POINT, CW4EN));

		assertEquals("One Hundred", EnglishNumberUtils.toEnNum(new BigDecimal("100"), POINT, CW4EN));
		assertEquals("One Hundred One", EnglishNumberUtils.toEnNum(new BigDecimal("101"), POINT, CW4EN));
		
		assertEquals("One Hundred Ten", EnglishNumberUtils.toEnNum(new BigDecimal("110"), POINT, CW4EN));
		assertEquals("One Hundred Eleven", EnglishNumberUtils.toEnNum(new BigDecimal("111"), POINT, CW4EN));
		assertEquals("One Hundred Twenty", EnglishNumberUtils.toEnNum(new BigDecimal("120"), POINT, CW4EN));
		assertEquals("One Hundred Twenty-One", EnglishNumberUtils.toEnNum(new BigDecimal("121"), POINT, CW4EN));
		
		assertEquals("Two Thousand", EnglishNumberUtils.toEnNum(new BigDecimal("2000"), POINT, CW4EN));
		
		assertEquals("Twenty-Three Thousand Four Hundred Fifty-Six", EnglishNumberUtils.toEnNum(new BigDecimal("23456"), POINT, CW4EN));
		
		assertEquals("Twelve Thousand Three Hundred Forty-Five", EnglishNumberUtils.toEnNum(new BigDecimal("12345"), POINT, CW4EN));
		assertEquals("One Hundred Twenty-Three Thousand Four Hundred Fifty-Six", EnglishNumberUtils.toEnNum(new BigDecimal("123456"), POINT, CW4EN));
		assertEquals("One Million Two Hundred Thirty-Four Thousand Five Hundred Sixty-Seven", EnglishNumberUtils.toEnNum(new BigDecimal("1234567"), POINT, CW4EN));
		assertEquals("Twelve Million Three Hundred Forty-Five Thousand Six Hundred Seventy-Eight", EnglishNumberUtils.toEnNum(new BigDecimal("12345678"), POINT, CW4EN));
		
		assertEquals("Nine Hundred Eighty-Seven Septillion Six Hundred Fifty-Four Sextillion Three Hundred Twenty-One Quintillion Ninety-Eight Quadrillion Seven Hundred Sixty-Five Trillion Four Hundred Thirty-Two Billion One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", EnglishNumberUtils.toEnNum(new BigDecimal("987654321098765432109876543"), POINT, CW4EN));
		assertEquals("Nine Hundred Eighty-Seven Vigintillion Six Hundred Fifty-Four Novemdecillion Three Hundred Twenty-One Octodecillion Ninety-Eight Septendecillion Seven Hundred Sixty-Five Sexdecillion Four Hundred Thirty-Two Quindecillion One Hundred Nine Quattuordecillion Eight Hundred Seventy-Six Tredecillion Five Hundred Forty-Three Duodecillion Two Hundred Ten Undecillion Nine Hundred Eighty-Seven Decillion Six Hundred Fifty-Four Nonillion Three Hundred Twenty-One Octillion Ninety-Eight Septillion Seven Hundred Sixty-Five Sextillion Four Hundred Thirty-Two Quintillion One Hundred Nine Quadrillion Eight Hundred Seventy-Six Trillion Five Hundred Forty-Three Billion Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", EnglishNumberUtils.toEnNum(new BigDecimal("987654321098765432109876543210987654321098765432109876543210987654"), POINT, CW4EN));
		{
			BigDecimal v = BigDecimal.ZERO;
			for (int i = 1, n = 6; i <= 305; i++, n = (n == 0) ? 9 : n - 1) {
				v = v.scaleByPowerOfTen(1).add(BigDecimal.valueOf(n));
				assert v.precision() == i && v.signum() == 1;
				assertEquals(v, EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CW4EN)));
			}
		}	
		
		
		assertEquals("Zero point Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0.0"), POINT, CW4EN));
		assertEquals("One and 0/10", EnglishNumberUtils.toEnNum(new BigDecimal("1.0"), FRACTION, CW4EN));
		
		assertEquals("Zero point Zero Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0.00"), POINT, CW4EN));
		assertEquals("One and 0/100", EnglishNumberUtils.toEnNum(new BigDecimal("1.00"), FRACTION, CW4EN));
		
		assertEquals("Zero point Zero One Two", EnglishNumberUtils.toEnNum(new BigDecimal("0.012"), POINT, CW4EN));
		assertEquals("One and 12/1000", EnglishNumberUtils.toEnNum(new BigDecimal("1.012"), FRACTION, CW4EN));
		
		
		assertEquals("Negative Nine Hundred Eighty-Seven Septillion Six Hundred Fifty-Four Sextillion Three Hundred Twenty-One Quintillion Ninety-Eight Quadrillion Seven Hundred Sixty-Five Trillion Four Hundred Thirty-Two Billion One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", EnglishNumberUtils.toEnNum(new BigDecimal("-987654321098765432109876543"), POINT, CW4EN));
		assertEquals("Negative Nine Hundred Eighty-Seven Vigintillion Six Hundred Fifty-Four Novemdecillion Three Hundred Twenty-One Octodecillion Ninety-Eight Septendecillion Seven Hundred Sixty-Five Sexdecillion Four Hundred Thirty-Two Quindecillion One Hundred Nine Quattuordecillion Eight Hundred Seventy-Six Tredecillion Five Hundred Forty-Three Duodecillion Two Hundred Ten Undecillion Nine Hundred Eighty-Seven Decillion Six Hundred Fifty-Four Nonillion Three Hundred Twenty-One Octillion Ninety-Eight Septillion Seven Hundred Sixty-Five Sextillion Four Hundred Thirty-Two Quintillion One Hundred Nine Quadrillion Eight Hundred Seventy-Six Trillion Five Hundred Forty-Three Billion Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", EnglishNumberUtils.toEnNum(new BigDecimal("-987654321098765432109876543210987654321098765432109876543210987654"), POINT, CW4EN));
		{
			BigDecimal v = BigDecimal.ZERO;
			for (int i = 1, n = 6; i <= 305; i++, n = (n == 0) ? 9 : n - 1) {
				v = v.scaleByPowerOfTen(1).subtract(BigDecimal.valueOf(n));
				assert v.precision() == i && v.signum() == -1;
				assertEquals(v, EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CW4EN)));
			}
		}
		
		
		assertEquals("Zero point Zero", EnglishNumberUtils.toEnNum(new BigDecimal("-0.0"), POINT, CW4EN)); // BigDecimal has not signed zero
		assertEquals("Negative One and 0/10", EnglishNumberUtils.toEnNum(new BigDecimal("-1.0"), FRACTION, CW4EN));
		
		assertEquals("Zero point Zero Zero", EnglishNumberUtils.toEnNum(new BigDecimal("-0.00"), POINT, CW4EN)); // BigDecimal has not signed zero
		assertEquals("Negative One and 0/100", EnglishNumberUtils.toEnNum(new BigDecimal("-1.00"), FRACTION, CW4EN));
		
		assertEquals("Negative Zero point Zero One Two", EnglishNumberUtils.toEnNum(new BigDecimal("-0.012"), POINT, CW4EN));
		assertEquals("Negative One and 12/1000", EnglishNumberUtils.toEnNum(new BigDecimal("-1.012"), FRACTION, CW4EN));
	}
	
	@Test
	public void test_toEnNum_longScale() throws Exception {
		assertEquals(null, EnglishNumberUtils.toEnNum((BigDecimal)null, POINT, CW4EN, LONG_SCALE, false));
		assertEquals(null, EnglishNumberUtils.toEnNum((BigDecimal)null, FRACTION, CW4EN, LONG_SCALE, false));
		
		assertEquals("Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One", EnglishNumberUtils.toEnNum(new BigDecimal("1"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("Two", EnglishNumberUtils.toEnNum(new BigDecimal("2"), POINT, CW4EN, LONG_SCALE, false));
		
		assertEquals("Ten", EnglishNumberUtils.toEnNum(new BigDecimal("10"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("Eleven", EnglishNumberUtils.toEnNum(new BigDecimal("11"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("Twelve", EnglishNumberUtils.toEnNum(new BigDecimal("12"), POINT, CW4EN, LONG_SCALE, false));
		
		assertEquals("Twenty", EnglishNumberUtils.toEnNum(new BigDecimal("20"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("Twenty-One", EnglishNumberUtils.toEnNum(new BigDecimal("21"), POINT, CW4EN, LONG_SCALE, false));

		assertEquals("Ninety-Nine", EnglishNumberUtils.toEnNum(new BigDecimal("99"), POINT, CW4EN, LONG_SCALE, false));

		assertEquals("One Hundred", EnglishNumberUtils.toEnNum(new BigDecimal("100"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One Hundred One", EnglishNumberUtils.toEnNum(new BigDecimal("101"), POINT, CW4EN, LONG_SCALE, false));
		
		assertEquals("One Hundred Ten", EnglishNumberUtils.toEnNum(new BigDecimal("110"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One Hundred Eleven", EnglishNumberUtils.toEnNum(new BigDecimal("111"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One Hundred Twenty", EnglishNumberUtils.toEnNum(new BigDecimal("120"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One Hundred Twenty-One", EnglishNumberUtils.toEnNum(new BigDecimal("121"), POINT, CW4EN, LONG_SCALE, false));
		
		assertEquals("Two Thousand", EnglishNumberUtils.toEnNum(new BigDecimal("2000"), POINT, CW4EN, LONG_SCALE, false));
		
		assertEquals("Twenty-Three Thousand Four Hundred Fifty-Six", EnglishNumberUtils.toEnNum(new BigDecimal("23456"), POINT, CW4EN, LONG_SCALE, false));
		
		assertEquals("Twelve Thousand Three Hundred Forty-Five", EnglishNumberUtils.toEnNum(new BigDecimal("12345"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One Hundred Twenty-Three Thousand Four Hundred Fifty-Six", EnglishNumberUtils.toEnNum(new BigDecimal("123456"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One Million Two Hundred Thirty-Four Thousand Five Hundred Sixty-Seven", EnglishNumberUtils.toEnNum(new BigDecimal("1234567"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("Twelve Million Three Hundred Forty-Five Thousand Six Hundred Seventy-Eight", EnglishNumberUtils.toEnNum(new BigDecimal("12345678"), POINT, CW4EN, LONG_SCALE, false));
		
		assertEquals("Nine Hundred Eighty-Seven Quadrillion Six Hundred Fifty-Four Thousand Three Hundred Twenty-One Trillion Ninety-Eight Thousand Seven Hundred Sixty-Five Billion Four Hundred Thirty-Two Thousand One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", EnglishNumberUtils.toEnNum(new BigDecimal("987654321098765432109876543"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four Decillion Three Hundred Twenty-One Thousand Ninety-Eight Nonillion Seven Hundred Sixty-Five Thousand Four Hundred Thirty-Two Octillion One Hundred Nine Thousand Eight Hundred Seventy-Six Septillion Five Hundred Forty-Three Thousand Two Hundred Ten Sextillion Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four Quintillion Three Hundred Twenty-One Thousand Ninety-Eight Quadrillion Seven Hundred Sixty-Five Thousand Four Hundred Thirty-Two Trillion One Hundred Nine Thousand Eight Hundred Seventy-Six Billion Five Hundred Forty-Three Thousand Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", EnglishNumberUtils.toEnNum(new BigDecimal("987654321098765432109876543210987654321098765432109876543210987654"), POINT, CW4EN, LONG_SCALE, false));
		{
			BigDecimal v = BigDecimal.ZERO;
			for (int i = 1, v1 = 6; i <= 605; i++, v1 = (v1 == 0) ? 9 : v1 - 1) {
				v = v.scaleByPowerOfTen(1).add(BigDecimal.valueOf(v1));
				assert v.precision() == i && v.signum() == 1;
				assertEquals(v, EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CW4EN, LONG_SCALE, false), LONG_SCALE));
			}
		}
		
		
		assertEquals("Zero point Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0.0"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One and 0/10", EnglishNumberUtils.toEnNum(new BigDecimal("1.0"), FRACTION, CW4EN, LONG_SCALE, false));
		
		assertEquals("Zero point Zero Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0.00"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One and 0/100", EnglishNumberUtils.toEnNum(new BigDecimal("1.00"), FRACTION, CW4EN, LONG_SCALE, false));
		
		assertEquals("Zero point Zero One Two", EnglishNumberUtils.toEnNum(new BigDecimal("0.012"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("One and 12/1000", EnglishNumberUtils.toEnNum(new BigDecimal("1.012"), FRACTION, CW4EN, LONG_SCALE, false));
		
		
		assertEquals("Negative Nine Hundred Eighty-Seven Quadrillion Six Hundred Fifty-Four Thousand Three Hundred Twenty-One Trillion Ninety-Eight Thousand Seven Hundred Sixty-Five Billion Four Hundred Thirty-Two Thousand One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", EnglishNumberUtils.toEnNum(new BigDecimal("-987654321098765432109876543"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("Negative Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four Decillion Three Hundred Twenty-One Thousand Ninety-Eight Nonillion Seven Hundred Sixty-Five Thousand Four Hundred Thirty-Two Octillion One Hundred Nine Thousand Eight Hundred Seventy-Six Septillion Five Hundred Forty-Three Thousand Two Hundred Ten Sextillion Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four Quintillion Three Hundred Twenty-One Thousand Ninety-Eight Quadrillion Seven Hundred Sixty-Five Thousand Four Hundred Thirty-Two Trillion One Hundred Nine Thousand Eight Hundred Seventy-Six Billion Five Hundred Forty-Three Thousand Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", EnglishNumberUtils.toEnNum(new BigDecimal("-987654321098765432109876543210987654321098765432109876543210987654"), POINT, CW4EN, LONG_SCALE, false));
		{
			BigDecimal v = BigDecimal.ZERO;
			for (int i = 1, v1 = 6; i <= 605; i++, v1 = (v1 == 0) ? 9 : v1 - 1) {
				v = v.scaleByPowerOfTen(1).subtract(BigDecimal.valueOf(v1));
				assert v.precision() == i && v.signum() == -1;
				assertEquals(v, EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CW4EN, LONG_SCALE, false), LONG_SCALE));
			}
		}
		
		
		assertEquals("Zero point Zero", EnglishNumberUtils.toEnNum(new BigDecimal("-0.0"), POINT, CW4EN, LONG_SCALE, false)); // BigDecimal has not signed zero
		assertEquals("Negative One and 0/10", EnglishNumberUtils.toEnNum(new BigDecimal("-1.0"), FRACTION, CW4EN, LONG_SCALE, false));
		
		assertEquals("Zero point Zero Zero", EnglishNumberUtils.toEnNum(new BigDecimal("-0.00"), POINT, CW4EN, LONG_SCALE, false)); // BigDecimal has not signed zero
		assertEquals("Negative One and 0/100", EnglishNumberUtils.toEnNum(new BigDecimal("-1.00"), FRACTION, CW4EN, LONG_SCALE, false));
		
		assertEquals("Negative Zero point Zero One Two", EnglishNumberUtils.toEnNum(new BigDecimal("-0.012"), POINT, CW4EN, LONG_SCALE, false));
		assertEquals("Negative One and 12/1000", EnglishNumberUtils.toEnNum(new BigDecimal("-1.012"), FRACTION, CW4EN, LONG_SCALE, false));
	}
	
	@Test
	public void test_toEnNum_longScale_useIlliard() throws Exception {
		assertEquals(null, EnglishNumberUtils.toEnNum((BigDecimal)null, POINT, CW4EN, LONG_SCALE, true));
		assertEquals(null, EnglishNumberUtils.toEnNum((BigDecimal)null, FRACTION, CW4EN, LONG_SCALE, true));
		
		assertEquals("Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One", EnglishNumberUtils.toEnNum(new BigDecimal("1"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("Two", EnglishNumberUtils.toEnNum(new BigDecimal("2"), POINT, CW4EN, LONG_SCALE, true));
		
		assertEquals("Ten", EnglishNumberUtils.toEnNum(new BigDecimal("10"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("Eleven", EnglishNumberUtils.toEnNum(new BigDecimal("11"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("Twelve", EnglishNumberUtils.toEnNum(new BigDecimal("12"), POINT, CW4EN, LONG_SCALE, true));
		
		assertEquals("Twenty", EnglishNumberUtils.toEnNum(new BigDecimal("20"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("Twenty-One", EnglishNumberUtils.toEnNum(new BigDecimal("21"), POINT, CW4EN, LONG_SCALE, true));

		assertEquals("Ninety-Nine", EnglishNumberUtils.toEnNum(new BigDecimal("99"), POINT, CW4EN, LONG_SCALE, true));

		assertEquals("One Hundred", EnglishNumberUtils.toEnNum(new BigDecimal("100"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One Hundred One", EnglishNumberUtils.toEnNum(new BigDecimal("101"), POINT, CW4EN, LONG_SCALE, true));
		
		assertEquals("One Hundred Ten", EnglishNumberUtils.toEnNum(new BigDecimal("110"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One Hundred Eleven", EnglishNumberUtils.toEnNum(new BigDecimal("111"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One Hundred Twenty", EnglishNumberUtils.toEnNum(new BigDecimal("120"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One Hundred Twenty-One", EnglishNumberUtils.toEnNum(new BigDecimal("121"), POINT, CW4EN, LONG_SCALE, true));
		
		assertEquals("Two Thousand", EnglishNumberUtils.toEnNum(new BigDecimal("2000"), POINT, CW4EN, LONG_SCALE, true));
		
		assertEquals("Twenty-Three Thousand Four Hundred Fifty-Six", EnglishNumberUtils.toEnNum(new BigDecimal("23456"), POINT, CW4EN, LONG_SCALE, true));
		
		assertEquals("Twelve Thousand Three Hundred Forty-Five", EnglishNumberUtils.toEnNum(new BigDecimal("12345"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One Hundred Twenty-Three Thousand Four Hundred Fifty-Six", EnglishNumberUtils.toEnNum(new BigDecimal("123456"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One Million Two Hundred Thirty-Four Thousand Five Hundred Sixty-Seven", EnglishNumberUtils.toEnNum(new BigDecimal("1234567"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("Twelve Million Three Hundred Forty-Five Thousand Six Hundred Seventy-Eight", EnglishNumberUtils.toEnNum(new BigDecimal("12345678"), POINT, CW4EN, LONG_SCALE, true));
		
		assertEquals("Nine Hundred Eighty-Seven Quadrillion Six Hundred Fifty-Four Trilliard Three Hundred Twenty-One Trillion Ninety-Eight Billiard Seven Hundred Sixty-Five Billion Four Hundred Thirty-Two Milliard One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", EnglishNumberUtils.toEnNum(new BigDecimal("987654321098765432109876543"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("Nine Hundred Eighty-Seven Decilliard Six Hundred Fifty-Four Decillion Three Hundred Twenty-One Nonilliard Ninety-Eight Nonillion Seven Hundred Sixty-Five Octilliard Four Hundred Thirty-Two Octillion One Hundred Nine Septilliard Eight Hundred Seventy-Six Septillion Five Hundred Forty-Three Sextilliard Two Hundred Ten Sextillion Nine Hundred Eighty-Seven Quintilliard Six Hundred Fifty-Four Quintillion Three Hundred Twenty-One Quadrilliard Ninety-Eight Quadrillion Seven Hundred Sixty-Five Trilliard Four Hundred Thirty-Two Trillion One Hundred Nine Billiard Eight Hundred Seventy-Six Billion Five Hundred Forty-Three Milliard Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", EnglishNumberUtils.toEnNum(new BigDecimal("987654321098765432109876543210987654321098765432109876543210987654"), POINT, CW4EN, LONG_SCALE, true));
		{
			BigDecimal v = BigDecimal.ZERO;
			for (int i = 1, v1 = 6; i <= 605; i++, v1 = (v1 == 0) ? 9 : v1 - 1) {
				v = v.scaleByPowerOfTen(1).add(BigDecimal.valueOf(v1));
				assert v.precision() == i && v.signum() == 1;
				assertEquals(v, EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CW4EN, LONG_SCALE, true), LONG_SCALE));
			}
		}
		
		
		assertEquals("Zero point Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0.0"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One and 0/10", EnglishNumberUtils.toEnNum(new BigDecimal("1.0"), FRACTION, CW4EN, LONG_SCALE, true));
		
		assertEquals("Zero point Zero Zero", EnglishNumberUtils.toEnNum(new BigDecimal("0.00"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One and 0/100", EnglishNumberUtils.toEnNum(new BigDecimal("1.00"), FRACTION, CW4EN, LONG_SCALE, true));
		
		assertEquals("Zero point Zero One Two", EnglishNumberUtils.toEnNum(new BigDecimal("0.012"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("One and 12/1000", EnglishNumberUtils.toEnNum(new BigDecimal("1.012"), FRACTION, CW4EN, LONG_SCALE, true));
		
		
		assertEquals("Negative Nine Hundred Eighty-Seven Quadrillion Six Hundred Fifty-Four Trilliard Three Hundred Twenty-One Trillion Ninety-Eight Billiard Seven Hundred Sixty-Five Billion Four Hundred Thirty-Two Milliard One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", EnglishNumberUtils.toEnNum(new BigDecimal("-987654321098765432109876543"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("Negative Nine Hundred Eighty-Seven Decilliard Six Hundred Fifty-Four Decillion Three Hundred Twenty-One Nonilliard Ninety-Eight Nonillion Seven Hundred Sixty-Five Octilliard Four Hundred Thirty-Two Octillion One Hundred Nine Septilliard Eight Hundred Seventy-Six Septillion Five Hundred Forty-Three Sextilliard Two Hundred Ten Sextillion Nine Hundred Eighty-Seven Quintilliard Six Hundred Fifty-Four Quintillion Three Hundred Twenty-One Quadrilliard Ninety-Eight Quadrillion Seven Hundred Sixty-Five Trilliard Four Hundred Thirty-Two Trillion One Hundred Nine Billiard Eight Hundred Seventy-Six Billion Five Hundred Forty-Three Milliard Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", EnglishNumberUtils.toEnNum(new BigDecimal("-987654321098765432109876543210987654321098765432109876543210987654"), POINT, CW4EN, LONG_SCALE, true));
		{
			BigDecimal v = BigDecimal.ZERO;
			for (int i = 1, v1 = 6; i <= 605; i++, v1 = (v1 == 0) ? 9 : v1 - 1) {
				v = v.scaleByPowerOfTen(1).subtract(BigDecimal.valueOf(v1));
				assert v.precision() == i && v.signum() == -1;
				assertEquals(v, EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CW4EN, LONG_SCALE, true), LONG_SCALE));
			}
		}
		
		
		assertEquals("Zero point Zero", EnglishNumberUtils.toEnNum(new BigDecimal("-0.0"), POINT, CW4EN, LONG_SCALE, true)); // BigDecimal has not signed zero
		assertEquals("Negative One and 0/10", EnglishNumberUtils.toEnNum(new BigDecimal("-1.0"), FRACTION, CW4EN, LONG_SCALE, true));
		
		assertEquals("Zero point Zero Zero", EnglishNumberUtils.toEnNum(new BigDecimal("-0.00"), POINT, CW4EN, LONG_SCALE, true)); // BigDecimal has not signed zero
		assertEquals("Negative One and 0/100", EnglishNumberUtils.toEnNum(new BigDecimal("-1.00"), FRACTION, CW4EN, LONG_SCALE, true));
		
		assertEquals("Negative Zero point Zero One Two", EnglishNumberUtils.toEnNum(new BigDecimal("-0.012"), POINT, CW4EN, LONG_SCALE, true));
		assertEquals("Negative One and 12/1000", EnglishNumberUtils.toEnNum(new BigDecimal("-1.012"), FRACTION, CW4EN, LONG_SCALE, true));
	}
	
	@Test
	public void test_parseEnNum_shortScale() throws Exception {
		assertEquals(null, EnglishNumberUtils.parseEnNum(null));

		assertEquals(new BigDecimal("0"), EnglishNumberUtils.parseEnNum("Zero"));
		assertEquals(new BigDecimal("1"), EnglishNumberUtils.parseEnNum("One"));
		
		assertEquals(new BigDecimal("10"), EnglishNumberUtils.parseEnNum("Ten"));
		
		assertEquals(new BigDecimal("11"), EnglishNumberUtils.parseEnNum("Eleven"));
		
		assertEquals(new BigDecimal("20"), EnglishNumberUtils.parseEnNum("Twenty"));
		assertEquals(new BigDecimal("21"), EnglishNumberUtils.parseEnNum("Twenty-One"));
		
		assertEquals(new BigDecimal("99"), EnglishNumberUtils.parseEnNum("Ninety-Nine"));
		
		assertEquals(new BigDecimal("100"), EnglishNumberUtils.parseEnNum("One Hundred"));
		assertEquals(new BigDecimal("101"), EnglishNumberUtils.parseEnNum("One Hundred One"));
		
		assertEquals(new BigDecimal("110"), EnglishNumberUtils.parseEnNum("One Hundred Ten"));
		assertEquals(new BigDecimal("111"), EnglishNumberUtils.parseEnNum("One Hundred Eleven"));
		assertEquals(new BigDecimal("120"), EnglishNumberUtils.parseEnNum("One Hundred Twenty"));
		assertEquals(new BigDecimal("121"), EnglishNumberUtils.parseEnNum("One Hundred Twenty-One"));
		
		assertEquals(new BigDecimal("2000"), EnglishNumberUtils.parseEnNum("Two Thousand"));
		
		assertEquals(new BigDecimal("23456"), EnglishNumberUtils.parseEnNum("Twenty-Three Thousand Four Hundred Fifty-Six"));
		
		assertEquals(new BigDecimal("987654321098765432109876543"), EnglishNumberUtils.parseEnNum("Nine Hundred Eighty-Seven Septillion Six Hundred Fifty-Four Sextillion Three Hundred Twenty-One Quintillion Ninety-Eight Quadrillion Seven Hundred Sixty-Five Trillion Four Hundred Thirty-Two Billion One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three"));
		assertEquals(new BigDecimal("987654321098765432109876543210987654321098765432109876543210987654"), EnglishNumberUtils.parseEnNum("Nine Hundred Eighty-Seven Vigintillion Six Hundred Fifty-Four Novemdecillion Three Hundred Twenty-One Octodecillion Ninety-Eight Septendecillion Seven Hundred Sixty-Five Sexdecillion Four Hundred Thirty-Two Quindecillion One Hundred Nine Quattuordecillion Eight Hundred Seventy-Six Tredecillion Five Hundred Forty-Three Duodecillion Two Hundred Ten Undecillion Nine Hundred Eighty-Seven Decillion Six Hundred Fifty-Four Nonillion Three Hundred Twenty-One Octillion Ninety-Eight Septillion Seven Hundred Sixty-Five Sextillion Four Hundred Thirty-Two Quintillion One Hundred Nine Quadrillion Eight Hundred Seventy-Six Trillion Five Hundred Forty-Three Billion Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four"));
		
		{
			for (int n = 1; n <= 999; n++) {
				BigDecimal v = BigDecimal.valueOf(9).scaleByPowerOfTen(3 * n + 3);
				
				// Default system
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CW4EN))));
				
				// Conway-Wechsler system
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CONWAY_WECHSLER))));
			}
		}
		
		{
			for (int n = 1000; n <= 100000; n *= 10) {
				BigDecimal v = BigDecimal.valueOf(9).scaleByPowerOfTen(3 * n + 3);

				// Default system
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CW4EN))));
				
				// Conway-Wechsler system
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, POINT, CONWAY_WECHSLER))));
			}
		}
		
		
		assertEquals(new BigDecimal("0.0"), EnglishNumberUtils.parseEnNum("Zero point Zero"));
		assertEquals(new BigDecimal("1.0"), EnglishNumberUtils.parseEnNum("One and 0/10"));
		
		assertEquals(new BigDecimal("0.00"), EnglishNumberUtils.parseEnNum("Zero point Zero Zero"));
		assertEquals(new BigDecimal("1.00"), EnglishNumberUtils.parseEnNum("One and 0/100"));
		
		assertEquals(new BigDecimal("0.012"), EnglishNumberUtils.parseEnNum("Zero point Zero One Two"));
		assertEquals(new BigDecimal("1.012"), EnglishNumberUtils.parseEnNum("One and 12/1000"));
		

		assertEquals(new BigDecimal("-987654321098765432109876543"), EnglishNumberUtils.parseEnNum("Negative Nine Hundred Eighty-Seven Septillion Six Hundred Fifty-Four Sextillion Three Hundred Twenty-One Quintillion Ninety-Eight Quadrillion Seven Hundred Sixty-Five Trillion Four Hundred Thirty-Two Billion One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three"));
		assertEquals(new BigDecimal("-987654321098765432109876543210987654321098765432109876543210987654"), EnglishNumberUtils.parseEnNum("Negative Nine Hundred Eighty-Seven Vigintillion Six Hundred Fifty-Four Novemdecillion Three Hundred Twenty-One Octodecillion Ninety-Eight Septendecillion Seven Hundred Sixty-Five Sexdecillion Four Hundred Thirty-Two Quindecillion One Hundred Nine Quattuordecillion Eight Hundred Seventy-Six Tredecillion Five Hundred Forty-Three Duodecillion Two Hundred Ten Undecillion Nine Hundred Eighty-Seven Decillion Six Hundred Fifty-Four Nonillion Three Hundred Twenty-One Octillion Ninety-Eight Septillion Seven Hundred Sixty-Five Sextillion Four Hundred Thirty-Two Quintillion One Hundred Nine Quadrillion Eight Hundred Seventy-Six Trillion Five Hundred Forty-Three Billion Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four"));
		
		
		assertEquals(new BigDecimal("0.0"), EnglishNumberUtils.parseEnNum("Negative Zero point Zero"));
		assertEquals(new BigDecimal("-1.0"), EnglishNumberUtils.parseEnNum("Negative One and 0/10"));
		
		assertEquals(new BigDecimal("0.00"), EnglishNumberUtils.parseEnNum("Negative Zero point Zero Zero"));
		assertEquals(new BigDecimal("-1.00"), EnglishNumberUtils.parseEnNum("Negative One and 0/100"));
		
		assertEquals(new BigDecimal("-0.012"), EnglishNumberUtils.parseEnNum("Negative Zero point Zero One Two"));
		assertEquals(new BigDecimal("-1.012"), EnglishNumberUtils.parseEnNum("Negative One and 12/1000"));
		
		
		assertEquals(new BigDecimal("25"), EnglishNumberUtils.parseEnNum("25"));
		assertEquals(new BigDecimal("2.5"), EnglishNumberUtils.parseEnNum("2.5"));
		
		assertEquals(new BigDecimal("2500"), EnglishNumberUtils.parseEnNum("25 Hundred"));
		assertEquals(new BigDecimal("250"), EnglishNumberUtils.parseEnNum("2.5 Hundred"));
		
		assertEquals(new BigDecimal("25000"), EnglishNumberUtils.parseEnNum("25 Thousand"));
		assertEquals(new BigDecimal("2500"), EnglishNumberUtils.parseEnNum("2.5 Thousand"));
		
		assertEquals(new BigDecimal("25000000"), EnglishNumberUtils.parseEnNum("25 Million"));
		assertEquals(new BigDecimal("2500000"), EnglishNumberUtils.parseEnNum("2.5 Million"));
		
		assertThrows(IllegalArgumentException.class, () -> {
			EnglishNumberUtils.parseEnNum("");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			EnglishNumberUtils.parseEnNum("-");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			EnglishNumberUtils.parseEnNum("xxx");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			EnglishNumberUtils.parseEnNum("Two Hundreds");
		});
	}
	
	@Test
	public void test_parseEnNum_longScale() throws Exception {
		assertEquals(null, EnglishNumberUtils.parseEnNum(null, LONG_SCALE));

		assertEquals(new BigDecimal("0"), EnglishNumberUtils.parseEnNum("Zero", LONG_SCALE));
		assertEquals(new BigDecimal("1"), EnglishNumberUtils.parseEnNum("One", LONG_SCALE));
		
		assertEquals(new BigDecimal("10"), EnglishNumberUtils.parseEnNum("Ten", LONG_SCALE));
		
		assertEquals(new BigDecimal("11"), EnglishNumberUtils.parseEnNum("Eleven", LONG_SCALE));
		
		assertEquals(new BigDecimal("20"), EnglishNumberUtils.parseEnNum("Twenty", LONG_SCALE));
		assertEquals(new BigDecimal("21"), EnglishNumberUtils.parseEnNum("Twenty-One", LONG_SCALE));
		
		assertEquals(new BigDecimal("99"), EnglishNumberUtils.parseEnNum("Ninety-Nine", LONG_SCALE));
		
		assertEquals(new BigDecimal("100"), EnglishNumberUtils.parseEnNum("One Hundred", LONG_SCALE));
		assertEquals(new BigDecimal("101"), EnglishNumberUtils.parseEnNum("One Hundred One", LONG_SCALE));
		
		assertEquals(new BigDecimal("110"), EnglishNumberUtils.parseEnNum("One Hundred Ten", LONG_SCALE));
		assertEquals(new BigDecimal("111"), EnglishNumberUtils.parseEnNum("One Hundred Eleven", LONG_SCALE));
		assertEquals(new BigDecimal("120"), EnglishNumberUtils.parseEnNum("One Hundred Twenty", LONG_SCALE));
		assertEquals(new BigDecimal("121"), EnglishNumberUtils.parseEnNum("One Hundred Twenty-One", LONG_SCALE));
		
		assertEquals(new BigDecimal("2000"), EnglishNumberUtils.parseEnNum("Two Thousand", LONG_SCALE));
		
		assertEquals(new BigDecimal("23456"), EnglishNumberUtils.parseEnNum("Twenty-Three Thousand Four Hundred Fifty-Six", LONG_SCALE));
		
		assertEquals(new BigDecimal("987654321098765432109876543"), EnglishNumberUtils.parseEnNum("Nine Hundred Eighty-Seven Quadrillion Six Hundred Fifty-Four Thousand Three Hundred Twenty-One Trillion Ninety-Eight Thousand Seven Hundred Sixty-Five Billion Four Hundred Thirty-Two Thousand One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", LONG_SCALE));
		assertEquals(new BigDecimal("987654321098765432109876543210987654321098765432109876543210987654"), EnglishNumberUtils.parseEnNum("Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four Decillion Three Hundred Twenty-One Thousand Ninety-Eight Nonillion Seven Hundred Sixty-Five Thousand Four Hundred Thirty-Two Octillion One Hundred Nine Thousand Eight Hundred Seventy-Six Septillion Five Hundred Forty-Three Thousand Two Hundred Ten Sextillion Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four Quintillion Three Hundred Twenty-One Thousand Ninety-Eight Quadrillion Seven Hundred Sixty-Five Thousand Four Hundred Thirty-Two Trillion One Hundred Nine Thousand Eight Hundred Seventy-Six Billion Five Hundred Forty-Three Thousand Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", LONG_SCALE));
		// -illiard
		assertEquals(new BigDecimal("987654321098765432109876543"), EnglishNumberUtils.parseEnNum("Nine Hundred Eighty-Seven Quadrillion Six Hundred Fifty-Four Trilliard Three Hundred Twenty-One Trillion Ninety-Eight Billiard Seven Hundred Sixty-Five Billion Four Hundred Thirty-Two Milliard One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", LONG_SCALE));
		assertEquals(new BigDecimal("987654321098765432109876543210987654321098765432109876543210987654"), EnglishNumberUtils.parseEnNum("Nine Hundred Eighty-Seven Decilliard Six Hundred Fifty-Four Decillion Three Hundred Twenty-One Nonilliard Ninety-Eight Nonillion Seven Hundred Sixty-Five Octilliard Four Hundred Thirty-Two Octillion One Hundred Nine Septilliard Eight Hundred Seventy-Six Septillion Five Hundred Forty-Three Sextilliard Two Hundred Ten Sextillion Nine Hundred Eighty-Seven Quintilliard Six Hundred Fifty-Four Quintillion Three Hundred Twenty-One Quadrilliard Ninety-Eight Quadrillion Seven Hundred Sixty-Five Trilliard Four Hundred Thirty-Two Trillion One Hundred Nine Billiard Eight Hundred Seventy-Six Billion Five Hundred Forty-Three Milliard Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", LONG_SCALE));
		
		{
			for (int n = 1; n <= 999; n++) {
				BigDecimal v = BigDecimal.valueOf(9).scaleByPowerOfTen(6 * n);
				
				// Default system
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, FRACTION, CW4EN, LONG_SCALE, false), LONG_SCALE)));
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, FRACTION, CW4EN, LONG_SCALE, true), LONG_SCALE)));
				
				// Conway-Wechsler system
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, FRACTION, CONWAY_WECHSLER, LONG_SCALE, false), LONG_SCALE)));
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, FRACTION, CONWAY_WECHSLER, LONG_SCALE, true), LONG_SCALE)));
			}
		}
		
		{
			for (int n = 1000; n <= 100000; n *= 10) {
				BigDecimal v = BigDecimal.valueOf(9).scaleByPowerOfTen(6 * n);
				
				// Default system
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, FRACTION, CW4EN, LONG_SCALE, false), LONG_SCALE)));
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, FRACTION, CW4EN, LONG_SCALE, true), LONG_SCALE)));
				
				// Conway-Wechsler system
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, FRACTION, CONWAY_WECHSLER, LONG_SCALE, false), LONG_SCALE)));
				assertEquals(0, v.compareTo(EnglishNumberUtils.parseEnNum(EnglishNumberUtils.toEnNum(v, FRACTION, CONWAY_WECHSLER, LONG_SCALE, true), LONG_SCALE)));
			}
		}
		
		
		assertEquals(new BigDecimal("0.0"), EnglishNumberUtils.parseEnNum("Zero point Zero", LONG_SCALE));
		assertEquals(new BigDecimal("1.0"), EnglishNumberUtils.parseEnNum("One and 0/10", LONG_SCALE));
		
		assertEquals(new BigDecimal("0.00"), EnglishNumberUtils.parseEnNum("Zero point Zero Zero", LONG_SCALE));
		assertEquals(new BigDecimal("1.00"), EnglishNumberUtils.parseEnNum("One and 0/100", LONG_SCALE));
		
		assertEquals(new BigDecimal("0.012"), EnglishNumberUtils.parseEnNum("Zero point Zero One Two", LONG_SCALE));
		assertEquals(new BigDecimal("1.012"), EnglishNumberUtils.parseEnNum("One and 12/1000", LONG_SCALE));
		
		
		assertEquals(new BigDecimal("-987654321098765432109876543"), EnglishNumberUtils.parseEnNum("Negative Nine Hundred Eighty-Seven Quadrillion Six Hundred Fifty-Four Thousand Three Hundred Twenty-One Trillion Ninety-Eight Thousand Seven Hundred Sixty-Five Billion Four Hundred Thirty-Two Thousand One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", LONG_SCALE));
		assertEquals(new BigDecimal("-987654321098765432109876543210987654321098765432109876543210987654"), EnglishNumberUtils.parseEnNum("Negative Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four Decillion Three Hundred Twenty-One Thousand Ninety-Eight Nonillion Seven Hundred Sixty-Five Thousand Four Hundred Thirty-Two Octillion One Hundred Nine Thousand Eight Hundred Seventy-Six Septillion Five Hundred Forty-Three Thousand Two Hundred Ten Sextillion Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four Quintillion Three Hundred Twenty-One Thousand Ninety-Eight Quadrillion Seven Hundred Sixty-Five Thousand Four Hundred Thirty-Two Trillion One Hundred Nine Thousand Eight Hundred Seventy-Six Billion Five Hundred Forty-Three Thousand Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", LONG_SCALE));
		// -illiard
		assertEquals(new BigDecimal("-987654321098765432109876543"), EnglishNumberUtils.parseEnNum("Negative Nine Hundred Eighty-Seven Quadrillion Six Hundred Fifty-Four Trilliard Three Hundred Twenty-One Trillion Ninety-Eight Billiard Seven Hundred Sixty-Five Billion Four Hundred Thirty-Two Milliard One Hundred Nine Million Eight Hundred Seventy-Six Thousand Five Hundred Forty-Three", LONG_SCALE));
		assertEquals(new BigDecimal("-987654321098765432109876543210987654321098765432109876543210987654"), EnglishNumberUtils.parseEnNum("Negative Nine Hundred Eighty-Seven Decilliard Six Hundred Fifty-Four Decillion Three Hundred Twenty-One Nonilliard Ninety-Eight Nonillion Seven Hundred Sixty-Five Octilliard Four Hundred Thirty-Two Octillion One Hundred Nine Septilliard Eight Hundred Seventy-Six Septillion Five Hundred Forty-Three Sextilliard Two Hundred Ten Sextillion Nine Hundred Eighty-Seven Quintilliard Six Hundred Fifty-Four Quintillion Three Hundred Twenty-One Quadrilliard Ninety-Eight Quadrillion Seven Hundred Sixty-Five Trilliard Four Hundred Thirty-Two Trillion One Hundred Nine Billiard Eight Hundred Seventy-Six Billion Five Hundred Forty-Three Milliard Two Hundred Ten Million Nine Hundred Eighty-Seven Thousand Six Hundred Fifty-Four", LONG_SCALE));
		
		
		assertEquals(new BigDecimal("0.0"), EnglishNumberUtils.parseEnNum("Negative Zero point Zero", LONG_SCALE));
		assertEquals(new BigDecimal("-1.0"), EnglishNumberUtils.parseEnNum("Negative One and 0/10", LONG_SCALE));
		
		assertEquals(new BigDecimal("0.00"), EnglishNumberUtils.parseEnNum("Negative Zero point Zero Zero", LONG_SCALE));
		assertEquals(new BigDecimal("-1.00"), EnglishNumberUtils.parseEnNum("Negative One and 0/100", LONG_SCALE));
		
		assertEquals(new BigDecimal("-0.012"), EnglishNumberUtils.parseEnNum("Negative Zero point Zero One Two", LONG_SCALE));
		assertEquals(new BigDecimal("-1.012"), EnglishNumberUtils.parseEnNum("Negative One and 12/1000", LONG_SCALE));
		
		
		assertEquals(new BigDecimal("25"), EnglishNumberUtils.parseEnNum("25", LONG_SCALE));
		assertEquals(new BigDecimal("2.5"), EnglishNumberUtils.parseEnNum("2.5", LONG_SCALE));
		
		assertEquals(new BigDecimal("2500"), EnglishNumberUtils.parseEnNum("25 Hundred", LONG_SCALE));
		assertEquals(new BigDecimal("250"), EnglishNumberUtils.parseEnNum("2.5 Hundred", LONG_SCALE));
		
		assertEquals(new BigDecimal("25000"), EnglishNumberUtils.parseEnNum("25 Thousand", LONG_SCALE));
		assertEquals(new BigDecimal("2500"), EnglishNumberUtils.parseEnNum("2.5 Thousand", LONG_SCALE));
		
		assertEquals(new BigDecimal("25000000"), EnglishNumberUtils.parseEnNum("25 Million", LONG_SCALE));
		assertEquals(new BigDecimal("2500000"), EnglishNumberUtils.parseEnNum("2.5 Million", LONG_SCALE));
		
		assertThrows(IllegalArgumentException.class, () -> {
			EnglishNumberUtils.parseEnNum("");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			EnglishNumberUtils.parseEnNum("-");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			EnglishNumberUtils.parseEnNum("xxx");
		});
		
		assertThrows(IllegalArgumentException.class, () -> {
			EnglishNumberUtils.parseEnNum("Two Hundreds");
		});
	}
}
