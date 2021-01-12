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

import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.line-sort")
public class StringLineSortDencoder {
	
	private StringLineSortDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrLineSortAsc(DencodeCondition cond) {
		return encStrLineSortAsc(cond.valueAsLines(), cond.lineBreak());
	}
	
	@DencoderFunction
	public static String encStrLineSortDesc(DencodeCondition cond) {
		return encStrLineSortDesc(cond.valueAsLines(), cond.lineBreak());
	}
	
	@DencoderFunction
	public static String encStrLineSortReverse(DencodeCondition cond) {
		return encStrLineSortReverse(cond.valueAsLines(), cond.lineBreak());
	}
	
	
	private static String encStrLineSortAsc(String[] varLines, String lineBreak) {
		String[] lines = Arrays.copyOf(varLines, varLines.length);
		
		Arrays.sort(lines, new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o1.compareTo(o2);
			}
		});
		
		return StringUtilz.join(lineBreak, (Object[])lines);
	}
	
	private static String encStrLineSortDesc(String[] varLines, String lineBreak) {
		String[] lines = Arrays.copyOf(varLines, varLines.length);
		
		Arrays.sort(lines, new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o2.compareTo(o1);
			}
		});
		
		return StringUtilz.join(lineBreak, (Object[])lines);
	}
	
	private static String encStrLineSortReverse(String[] varLines, String lineBreak) {
		String[] lines = Arrays.copyOf(varLines, varLines.length);
		
		List<String> lineList = Arrays.asList(lines);
		Collections.reverse(lineList);
		
		return StringUtilz.join(lineBreak, lineList);
	}
}
