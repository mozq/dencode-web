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
package com.dencode.logic.model;

import java.math.BigDecimal;
import java.nio.charset.Charset;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import org.mifmi.commons4j.graphics.color.RGBColor;
import org.mifmi.commons4j.util.StringUtilz;

import com.dencode.logic.parser.ColorParser;
import com.dencode.logic.parser.DateParser;
import com.dencode.logic.parser.NumberParser;

public class DencodeCondition {
	
	private String value;
	private Charset charset;
	private String lineBreak;
	private ZoneId zone;
	
	private List<String> linesValue;
	private int textLengthDiff;
	
	private byte[] binaryValue;
	
	private boolean codePointsWithLfValueParsed;
	private int[] codePointsWithLfValue;
	
	private boolean numberValueParsed;
	private BigDecimal numberValue;
	
	private boolean numbersValueParsed;
	private List<BigDecimal> numbersValue;
	
	private boolean dateValueParsed;
	private ZonedDateTime dateValue;
	
	private boolean datesValueParsed;
	private List<ZonedDateTime> datesValue;
	
	private boolean colorValueParsed;
	private RGBColor colorValue;
	
	private boolean colorsValueParsed;
	private List<RGBColor> colorsValue;
	
	private Map<String, String> options;
	
	public DencodeCondition(String value, Charset charset, String lineBreak, ZoneId zone, Map<String, String> options) {
		if (value == null) {
			throw new NullPointerException("value is null");
		}
		
		this.value = value;
		this.charset = charset;
		this.lineBreak = lineBreak;
		this.zone = zone;
		
		this.linesValue = List.of(this.value.split("\r?\n", -1));
		if (1 < this.linesValue.size()) {
			this.value = StringUtilz.join(this.lineBreak, this.linesValue);
		}
		
		this.textLengthDiff = (this.linesValue.isEmpty()) ? 0 : -((this.lineBreak.length() - 1) * (this.linesValue.size() - 1));
		
		this.binaryValue = this.value.getBytes(this.charset);
		
		this.codePointsWithLfValueParsed = false;
		this.codePointsWithLfValue = null;
		
		this.numberValueParsed = false;
		this.numberValue = null;
		
		this.numbersValueParsed = false;
		this.numbersValue = null;
		
		this.dateValueParsed = false;
		this.dateValue = null;
		
		this.datesValueParsed = false;
		this.datesValue = null;
		
		this.colorValueParsed = false;
		this.colorValue = null;
		
		this.colorsValueParsed = false;
		this.colorsValue = null;
		
		this.options = Collections.unmodifiableMap(options);
	}
	
	
	public String value() {
		return value;
	}
	
	public Charset charset() {
		return charset;
	}
	
	public String lineBreak() {
		return lineBreak;
	}
	
	public ZoneId zone() {
		return zone;
	}
	
	public int textLengthDiff() {
		return textLengthDiff;
	}
	
	public List<String> valueAsLines() {
		return linesValue;
	}
	
	public byte[] valueAsBinary() {
		return binaryValue;
	}
	
	public int[] valueAsCodePointsWithLf() {
		if (!this.codePointsWithLfValueParsed) {
			String value = value();
			if (1 < valueAsLines().size()) {
				value = StringUtilz.join("\n", valueAsLines());
			}
			this.codePointsWithLfValue = value.codePoints().toArray();
			this.codePointsWithLfValueParsed = true;
		}
		return this.codePointsWithLfValue;
	}
	
	public BigDecimal valueAsNumber() {
		if (!this.numberValueParsed) {
			this.numberValue = NumberParser.parse(value());
			this.numberValueParsed = true;
		}
		return this.numberValue;
	}
	
	public List<BigDecimal> valueAsNumbers() {
		if (!this.numbersValueParsed) {
			this.numbersValue = valueAsParsedLines((val) -> NumberParser.parse(val));
			this.numbersValueParsed = true;
		}
		return this.numbersValue;
	}
	
	public ZonedDateTime valueAsDate() {
		if (!this.dateValueParsed) {
			this.dateValue = DateParser.parseDateAsZonedDateTime(value(), zone());
			this.dateValueParsed = true;
		}
		return this.dateValue;
	}
	
	public List<ZonedDateTime> valueAsDates() {
		if (!this.datesValueParsed) {
			this.datesValue = valueAsParsedLines((val) -> DateParser.parseDateAsZonedDateTime(val, zone()));
			this.datesValueParsed = true;
		}
		return this.datesValue;
	}
	
	public RGBColor valueAsColor() {
		if (!this.colorValueParsed) {
			this.colorValue = ColorParser.parseColor(value());
			this.colorValueParsed = true;
		}
		return this.colorValue;
	}
	
	public List<RGBColor> valueAsColors() {
		if (!this.colorsValueParsed) {
			this.colorsValue = valueAsParsedLines((val) -> ColorParser.parseColor(val));
			this.colorsValueParsed = true;
		}
		return this.colorsValue;
	}
	
	public <T> List<T> valueAsParsedLines(Function<String, T> func) {
		return parse(valueAsLines(), func);
	}
	
	public Map<String, String> options() {
		return options;
	}
	
	private static <R> List<R> parse(List<String> vals, Function<String, R> func) {
		if (vals == null) {
			return null;
		}
		
		int parsedCount = 0;
		List<R> parsedVals = new ArrayList<R>(vals.size());
		for (String val : vals) {
			R parsedVal;
			if (val.isEmpty()) {
				// ignore empty line
				parsedVal = null;
			} else {
				parsedVal = func.apply(val);
				if (parsedVal == null) {
					// terminate
					return null;
				}
				parsedCount++;
			}
			parsedVals.add(parsedVal);
		}
		
		if (parsedCount == 0) {
			return null;
		}
		
		return parsedVals;
	}
}
