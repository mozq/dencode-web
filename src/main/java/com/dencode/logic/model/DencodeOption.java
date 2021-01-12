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

public class DencodeOption {
	
	private String encStrBinSeparatorEach = "";
	private String encStrHexSeparatorEach = "";
	private String encStrHexCase = "lower";
	private String encStrBase64LineBreakEach = "";
	private String encStrUnicodeEscapeSurrogatePairFormat = "";
	private int encCipherCaesarShift = 0;
	private int decCipherCaesarShift = 0;
	private int encCipherScytaleKey = 2;
	private int decCipherScytaleKey = 2;
	private int encCipherRailFenceKey = 2;
	private int decCipherRailFenceKey = 2;
	
	public DencodeOption() {
	}
	
	public String getEncStrBinSeparatorEach() {
		return encStrBinSeparatorEach;
	}
	
	public void setEncStrBinSeparatorEach(String encStrBinSeparatorEach) {
		this.encStrBinSeparatorEach = encStrBinSeparatorEach;
	}
	
	public String getEncStrHexSeparatorEach() {
		return encStrHexSeparatorEach;
	}
	
	public void setEncStrHexSeparatorEach(String encStrHexSeparatorEach) {
		this.encStrHexSeparatorEach = encStrHexSeparatorEach;
	}
	
	public String getEncStrHexCase() {
		return encStrHexCase;
	}
	
	public void setEncStrHexCase(String encStrHexCase) {
		this.encStrHexCase = encStrHexCase;
	}
	
	public String getEncStrBase64LineBreakEach() {
		return encStrBase64LineBreakEach;
	}
	
	public void setEncStrBase64LineBreakEach(String encStrBase64LineBreakEach) {
		this.encStrBase64LineBreakEach = encStrBase64LineBreakEach;
	}
	
	public String getEncStrUnicodeEscapeSurrogatePairFormat() {
		return encStrUnicodeEscapeSurrogatePairFormat;
	}
	
	public void setEncStrUnicodeEscapeSurrogatePairFormat(String encStrUnicodeEscapeSurrogatePairFormat) {
		this.encStrUnicodeEscapeSurrogatePairFormat = encStrUnicodeEscapeSurrogatePairFormat;
	}
	
	public int getEncCipherCaesarShift() {
		return encCipherCaesarShift;
	}
	
	public void setEncCipherCaesarShift(int encCipherCaesarShift) {
		this.encCipherCaesarShift = encCipherCaesarShift;
	}
	
	public int getDecCipherCaesarShift() {
		return decCipherCaesarShift;
	}
	
	public void setDecCipherCaesarShift(int decCipherCaesarShift) {
		this.decCipherCaesarShift = decCipherCaesarShift;
	}
	
	public int getEncCipherScytaleKey() {
		return encCipherScytaleKey;
	}
	
	public void setEncCipherScytaleKey(int encCipherScytaleKey) {
		this.encCipherScytaleKey = encCipherScytaleKey;
	}
	
	public int getDecCipherScytaleKey() {
		return decCipherScytaleKey;
	}
	
	public void setDecCipherScytaleKey(int decCipherScytaleKey) {
		this.decCipherScytaleKey = decCipherScytaleKey;
	}
	
	public int getEncCipherRailFenceKey() {
		return encCipherRailFenceKey;
	}
	
	public void setEncCipherRailFenceKey(int encCipherRailFenceKey) {
		this.encCipherRailFenceKey = encCipherRailFenceKey;
	}
	
	public int getDecCipherRailFenceKey() {
		return decCipherRailFenceKey;
	}
	
	public void setDecCipherRailFenceKey(int decCipherRailFenceKey) {
		this.decCipherRailFenceKey = decCipherRailFenceKey;
	}
}
