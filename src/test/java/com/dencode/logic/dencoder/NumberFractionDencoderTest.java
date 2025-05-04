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

public class NumberFractionDencoderTest {
	
	@Test
	public void test() {
		testDencoder("0", "0/1");
		testDencoder("+0", "0/1");
		testDencoder("-0", "0/1");
		
		testDencoder("0.0", "0/1");
		testDencoder("+0.0", "0/1");
		testDencoder("-0.0", "0/1");
		
		testDencoder("1", "1/1");
		testDencoder("+1", "1/1");
		testDencoder("-1", "-1/1");
		
		testDencoder("1.0", "1/1");
		testDencoder("+1.0", "1/1");
		testDencoder("-1.0", "-1/1");
		
		testDencoder("1.00", "1/1");
		testDencoder("+1.00", "1/1");
		testDencoder("-1.00", "-1/1");
		
		testDencoder("0.4", "2/5");
		testDencoder("-0.4", "-2/5");
		
		testDencoder("0.5", "1/2");
		testDencoder("-0.5", "-1/2");
		
		testDencoder("0.25", "1/4");
		testDencoder("-0.25", "-1/4");
		
		testDencoder("333.0", "333/1");
		testDencoder("33.0", "33/1");
		
		testDencoder("0.01234567890", "123456789/10000000000");
		
		testDencoder("1/0", null);
		
		testDencoder("0/1", "0/1");
		testDencoder("0/-1", "0/1");
		testDencoder("0/2", "0/1");
		testDencoder("0/-2", "0/1");
		
		testDencoder("1/3", "1/3");
		testDencoder("+1/3", "1/3");
		testDencoder("1/+3", "1/3");
		testDencoder("+1/+3", "1/3");
		testDencoder("-1/3", "-1/3");
		testDencoder("1/-3", "-1/3");
		testDencoder("-1/-3", "1/3");
		
		testDencoder("111/333", "1/3");
		testDencoder("333/111", "3/1");
		
		testDencoder("1234567890/234567890", "123456789/23456789");
		
		testDencoder("0.5/0.5", "1/1");
		testDencoder("5.0/0.5", "10/1");
		testDencoder("50.0/0.5", "100/1");
		testDencoder("0.5/5.0", "1/10");
		testDencoder("0.5/50.0", "1/100");
		
		testDencoder("33", "33/1");
		testDencoder("33.0", "33/1");
		testDencoder("33.3", "333/10");
		testDencoder("33.33", "3333/100");
		testDencoder("3.3", "33/10");
		testDencoder("0.3", "3/10");
		testDencoder("0.33", "33/100");
		testDencoder("0.033", "33/1000");
		testDencoder("0.0033", "33/10000");
		testDencoder("-0.33", "-33/100");
		
		testDencoder("0...", "0/1"); // Zero
		testDencoder("0....", "0/1"); // Zero
		testDencoder("0.0...", "0/1"); // Zero
		
		testDencoder("0.3...", "3/10"); // Non-repeating number
		testDencoder("0.33...", "1/3"); // Repeating number
		testDencoder("0.333...", "1/3"); // Repeating number
		
		testDencoder("0.6...", "3/5"); // Non-repeating number
		testDencoder("0.66...", "2/3"); // Repeating number
		testDencoder("0.666...", "2/3"); // Repeating number
		
		testDencoder("0.67...", "67/100"); // Non-epeating number (round up)
		testDencoder("0.667...", "2/3"); // Repeating number (round up)
		testDencoder("0.6667...", "2/3"); // Repeating number (round up)
		
		testDencoder("0.8...", "4/5"); // Non-epeating number
		testDencoder("0.88...", "8/9"); // Repeating number
		testDencoder("0.888...", "8/9"); // Repeating number
		
		testDencoder("0.89...", "89/100"); // Non-epeating number (round up)
		testDencoder("0.889...", "8/9"); // Repeating number (round up)
		testDencoder("0.8889...", "8/9"); // Repeating number (round up)
		
		testDencoder("0.9...", "9/10"); // Non-epeating number
		testDencoder("0.99...", "1/1"); // Repeating number
		testDencoder("0.999...", "1/1"); // Repeating number
		
		// Repeating number (3)
		testDencoder("33.3...", "100/3");
		testDencoder("3.3...", "10/3");
		testDencoder("0.33...", "1/3");
		testDencoder("0.033...", "1/30");
		testDencoder("0.0033...", "1/300");
		testDencoder("-0.33...", "-1/3");
		
		// Repeating number (428571)
		testDencoder("42.8571428571...", "300/7");
		testDencoder("4.28571428571...", "30/7");
		testDencoder("0.428571428571...", "3/7");
		testDencoder("0.0428571428571...", "3/70");
		testDencoder("0.00428571428571...", "3/700");
		testDencoder("-0.428571428571...", "-3/7");
		
		// Repeating number 1(571428)
		testDencoder("157.1428571428...", "1100/7");
		testDencoder("15.71428571428...", "110/7");
		testDencoder("1.571428571428...", "11/7");
		testDencoder("0.1571428571428...", "11/70");
		testDencoder("0.01571428571428...", "11/700");
		testDencoder("0.001571428571428...", "11/7000");
		testDencoder("-1.571428571428...", "-11/7");
		
		// Repeating number 58(114)
		testDencoder("581.44144...", "64540/111");
		testDencoder("58.144144...", "6454/111");
		testDencoder("5.8144144...", "3227/555");
		testDencoder("0.58144144...", "3227/5550");
		testDencoder("0.058144144...", "3227/55500");
		testDencoder("0.0058144144...", "3227/555000");
		testDencoder("-5.8144144...", "-3227/555");
		
		// Repeating number 15(857142)
		testDencoder("1585.71428571428...", "11100/7");
		testDencoder("158.571428571428...", "1110/7");
		testDencoder("15.8571428571428...", "111/7");
		testDencoder("1.58571428571428...", "111/70");
		testDencoder("0.158571428571428...", "111/700");
		testDencoder("0.0158571428571428...", "111/7000");
		testDencoder("0.00158571428571428...", "111/70000");
		testDencoder("-15.8571428571428...", "-111/7");
		
		// Repeating number 11(1886792452830)
		testDencoder("1118.867924528301886792452830...", "59300/53");
		testDencoder("111.8867924528301886792452830...", "5930/53");
		testDencoder("11.18867924528301886792452830...", "593/53");
		testDencoder("1.118867924528301886792452830...", "593/530");
		testDencoder("0.1118867924528301886792452830...", "593/5300");
		testDencoder("0.01118867924528301886792452830...", "593/53000");
		testDencoder("0.001118867924528301886792452830...", "593/530000");
		testDencoder("-11.18867924528301886792452830...", "-593/53");
	}
	
	private void testDencoder(String value, String expectedEncodedValue) {
		String encodedValue = NumberFractionDencoder.encNumFraction(condition(value));
		assertEquals(expectedEncodedValue, encodedValue);
	}
	
	private DencodeCondition condition(String value) {
		return condition(value, StandardCharsets.UTF_8);
	}
	
	private DencodeCondition condition(String value, Charset charset) {
		return new DencodeCondition(value, charset, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
			}
		});
	}
 }
 