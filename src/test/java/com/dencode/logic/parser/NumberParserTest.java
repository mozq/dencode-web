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
package com.dencode.logic.parser;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

import com.dencode.logic.parser.NumberParser.RepeatingInfo;

public class NumberParserTest {
	
	@Test
	public void test_analyzeRepeatingDecimal_null() {
		assertThrows(NullPointerException.class, () -> {
			NumberParser.analyzeRepeatingDecimal(null);
		});
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_blank() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("");
		assertEquals(0, rep.count());
		assertEquals(-1, rep.startIndex());
		assertEquals(0, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_beginIdx_indexOutOfBounds_over() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.33", 10, 4);
		assertEquals(0, rep.count());
		assertEquals(-1, rep.startIndex());
		assertEquals(0, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_beginIdx_indexOutOfBounds_under() {
		assertThrows(StringIndexOutOfBoundsException.class, () -> {
			NumberParser.analyzeRepeatingDecimal("0.33", -1, 4);
		});
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_endIdx_indexOutOfBounds_over() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.33", 0, 5);
		assertEquals(1, rep.count());
		assertEquals(2, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_endIdx_indexOutOfBounds_under() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.33", 2, -1);
		assertEquals(0, rep.count());
		assertEquals(-1, rep.startIndex());
		assertEquals(0, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_3() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("3");
		assertEquals(0, rep.count());
		assertEquals(-1, rep.startIndex());
		assertEquals(0, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_33() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("33");
		assertEquals(1, rep.count());
		assertEquals(0, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_333() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("333");
		assertEquals(2, rep.count());
		assertEquals(0, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_3333() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("3333");
		assertEquals(3, rep.count());
		assertEquals(0, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	
	@Test
	public void test_analyzeRepeatingDecimal_0p3() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.3", 2, 3);
		assertEquals(0, rep.count());
		assertEquals(-1, rep.startIndex());
		assertEquals(0, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p33() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.33", 2, 4);
		assertEquals(1, rep.count());
		assertEquals(2, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p333() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.333", 2, 5);
		assertEquals(2, rep.count());
		assertEquals(2, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p3333() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.3333", 2, 6);
		assertEquals(3, rep.count());
		assertEquals(2, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	
	@Test
	public void test_analyzeRepeatingDecimal_0p03() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.03", 2, 4);
		assertEquals(0, rep.count());
		assertEquals(-1, rep.startIndex());
		assertEquals(0, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p033() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.033", 2, 5);
		assertEquals(1, rep.count());
		assertEquals(3, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p0333() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.0333", 2, 6);
		assertEquals(2, rep.count());
		assertEquals(3, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p03333() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.03333", 2, 7);
		assertEquals(3, rep.count());
		assertEquals(3, rep.startIndex());
		assertEquals(1, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	
	@Test
	public void test_analyzeRepeatingDecimal_0p001100110011() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.001100110011", 2, 14);
		assertEquals(2, rep.count());
		assertEquals(2, rep.startIndex());
		assertEquals(4, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p0001100110011() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.0001100110011", 2, 15);
		assertEquals(2, rep.count());
		assertEquals(3, rep.startIndex());
		assertEquals(4, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	
	@Test
	public void test_analyzeRepeatingDecimal_15p71428571428570() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("15.71428571428570", 3, 17);
		assertEquals(2, rep.count());
		assertEquals(3, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(2, rep.oddRepetendLength());
		assertEquals(-1, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_1p571428571428570() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("1.571428571428570", 2, 17);
		assertEquals(2, rep.count());
		assertEquals(2, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(3, rep.oddRepetendLength());
		assertEquals(-1, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p1571428571428570() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.1571428571428570", 2, 18);
		assertEquals(2, rep.count());
		assertEquals(3, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(3, rep.oddRepetendLength());
		assertEquals(-1, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_0p01571428571428570() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("0.01571428571428570", 2, 19);
		assertEquals(2, rep.count());
		assertEquals(4, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(3, rep.oddRepetendLength());
		assertEquals(-1, rep.roundingDifference());
	}
	
	
	@Test
	public void test_analyzeRepeatingDecimal_157142857142() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("157142857142");
		assertEquals(0, rep.count());
		assertEquals(-1, rep.startIndex());
		assertEquals(0, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_1571428571428() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("1571428571428");
		assertEquals(1, rep.count());
		assertEquals(1, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_15714285714285() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("15714285714285");
		assertEquals(2, rep.count());
		assertEquals(1, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(1, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_157142857142857() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("157142857142857");
		assertEquals(2, rep.count());
		assertEquals(1, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(2, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_1571428571428571() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("1571428571428571");
		assertEquals(2, rep.count());
		assertEquals(1, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(3, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_15714285714285714() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("15714285714285714");
		assertEquals(2, rep.count());
		assertEquals(1, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(4, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_157142857142857142() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("157142857142857142");
		assertEquals(2, rep.count());
		assertEquals(1, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(5, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_1571428571428571428() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("1571428571428571428");
		assertEquals(2, rep.count());
		assertEquals(1, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(0, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
	
	@Test
	public void test_analyzeRepeatingDecimal_15714285714285714285() {
		RepeatingInfo rep = NumberParser.analyzeRepeatingDecimal("15714285714285714285");
		assertEquals(3, rep.count());
		assertEquals(1, rep.startIndex());
		assertEquals(6, rep.repetendLength());
		assertEquals(1, rep.oddRepetendLength());
		assertEquals(0, rep.roundingDifference());
	}
 }
 