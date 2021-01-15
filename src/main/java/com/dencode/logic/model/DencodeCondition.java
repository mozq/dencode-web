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
	
	private String[] linesValue;
	private int textLengthDiff;
	
	private byte[] binaryValue;
	
	private boolean numberValueParsed;
	private BigDecimal numberValue;
	
	private boolean dateValueParsed;
	private ZonedDateTime dateValue;
	
	private boolean colorValueParsed;
	private RGBColor colorValue;
	
	private DencodeOption option;
	
	public DencodeCondition(String value, Charset charset, String lineBreak, ZoneId zone) {
		this.value = value;
		this.charset = charset;
		this.lineBreak = lineBreak;
		this.zone = zone;
		
		this.linesValue = StringUtilz.split(this.value, new String[] {"\r\n", "\r", "\n"});
		if (1 < this.linesValue.length) {
			this.value = StringUtilz.join(this.lineBreak, (Object[])this.linesValue);
		}
		
		this.textLengthDiff = (this.linesValue.length == 0) ? 0 : -((this.lineBreak.length() - 1) * (this.linesValue.length - 1));
		
		this.binaryValue = this.value.getBytes(this.charset);

		this.dateValueParsed = false;
		this.dateValue = null;
		
		this.colorValueParsed = false;
		this.colorValue = null;
		
		this.option = new DencodeOption();
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
	
	public String[] valueAsLines() {
		return linesValue;
	}
	
	public byte[] valueAsBinary() {
		return binaryValue;
	}
	
	public BigDecimal valueAsNumber() {
		if (!this.numberValueParsed) {
			this.numberValue = NumberParser.parseNumDec(value());
			this.numberValueParsed = true;
		}
		return this.numberValue;
	}
	
	public ZonedDateTime valueAsDate() {
		if (!this.dateValueParsed) {
			this.dateValue = DateParser.parseDateAsZonedDateTime(value(), zone());
			this.dateValueParsed = true;
		}
		return this.dateValue;
	}
	
	public RGBColor valueAsColor() {
		if (!this.colorValueParsed) {
			this.colorValue = ColorParser.parseColor(value());
			this.colorValueParsed = true;
		}
		return this.colorValue;
	}
	
	public DencodeOption option() {
		return option;
	}
}
