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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.line-sort")
public class StringLineSortDencoder {
	
	private StringLineSortDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrLineSort(DencodeCondition cond) {
		return encStrLineSort(cond.valueAsLines(), cond.options().getOrDefault("encStrLineSortOrder", "asc"));
	}
	

	private static String encStrLineSort(List<String> varLines, String order) {
		switch (order) {
		case "desc": return encStrLineSortDesc(varLines);
		case "reverse": return encStrLineSortReverse(varLines);
		default: return encStrLineSortAsc(varLines);
		}
	}
	
	private static String encStrLineSortAsc(List<String> varLines) {
		return varLines.stream()
				.sorted()
				.collect(Collectors.joining("\n"));
	}
	
	private static String encStrLineSortDesc(List<String> varLines) {
		return varLines.stream()
				.sorted(Collections.reverseOrder())
				.collect(Collectors.joining("\n"));
	}
	
	private static String encStrLineSortReverse(List<String> varLines) {
		List<String> list = new ArrayList<>(varLines);
		Collections.reverse(list);
		return list.stream()
				.collect(Collectors.joining("\n"));
	}
}
