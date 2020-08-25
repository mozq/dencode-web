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
package com.dencode.web.model;

/**
 * @author masa
 *
 */
public class DencodeModel {
	
	private int textLength;
	private int textByteLength;
	
	private String decStrBin;
	private String decStrHex;
	private String decStrHTMLEscape;
	private String decStrURLEncoding;
	private String decStrPunycode;
	private String decStrBase32Encoding;
	private String decStrBase64Encoding;
	private String decStrQuotedPrintable;
	private String decStrUnicodeEscape;
	private String decStrProgramString;
	private String decStrUnicodeNFC;
	private String decStrUnicodeNFKC;
	private String decNumBin;
	private String decNumOct;
	private String decNumHex;
	private String decNumEnShortScale;
	private String decNumJP;
	private String decCipherCaesar;
	private String decCipherROT13;
	private String decCipherROT18;
	private String decCipherROT47;
	private String decCipherScytale;
	private String decCipherRailFence;

	private String encStrBin;
	private String encStrHex;
	private String encStrHTMLEscape;
	private String encStrHTMLEscapeFully;
	private String encStrURLEncoding;
	private String encStrPunycode;
	private String encStrBase32Encoding;
	private String encStrBase64Encoding;
	private String encStrQuotedPrintable;
	private String encStrUnicodeEscape;
	private String encStrProgramString;
	private String encStrHalfWidth;
	private String encStrFullWidth;
	private String encStrUpperCase;
	private String encStrLowerCase;
	private String encStrSwapCase;
	private String encStrCapitalize;
	private String encStrInitials;
	private String encStrReverse;
	private String encStrUpperCamelCase;
	private String encStrLowerCamelCase;
	private String encStrUpperSnakeCase;
	private String encStrLowerSnakeCase;
	private String encStrUpperKebabCase;
	private String encStrLowerKebabCase;
	private String encStrUnicodeNFC;
	private String encStrUnicodeNFKC;
	private String encStrLineSortAsc;
	private String encStrLineSortDesc;
	private String encStrLineSortReverse;
	private String encStrLineUnique;
	private String encNumBin;
	private String encNumOct;
	private String encNumHex;
	private String encNumEnShortScale;
	private String encNumEnShortScaleFraction;
	private String encNumJP;
	private String encNumJPDaiji;
	private String encDateUnixTime;
	private String encDateW3CDTF;
	private String encDateISO8601;
	private String encDateISO8601Ext;
	private String encDateISO8601Week;
	private String encDateISO8601Ordinal;
	private String encDateRFC2822;
	private String encDateCTime;
	private String encDateJapaneseEra;
	private String encColorName;
	private String encColorRGBHex3;
	private String encColorRGBHex6;
	private String encColorRGBFn8;
	private String encColorRGBFn;
	private String encColorHSLFn;
	private String encColorHSVFn;
	private String encColorCMYFn;
	private String encColorCMYKFn;
	private String encCipherCaesar;
	private String encCipherROT13;
	private String encCipherROT18;
	private String encCipherROT47;
	private String encCipherScytale;
	private String encCipherRailFence;
	private String encHashMD2;
	private String encHashMD5;
	private String encHashSHA1;
	private String encHashSHA256;
	private String encHashSHA384;
	private String encHashSHA512;
	private String encHashCRC32;

	/**
	 * 
	 */
	public DencodeModel() {
	}

	public int getTextLength() {
		return textLength;
	}

	public void setTextLength(int textLength) {
		this.textLength = textLength;
	}

	public int getTextByteLength() {
		return textByteLength;
	}

	public void setTextByteLength(int textByteLength) {
		this.textByteLength = textByteLength;
	}

	public String getDecStrBin() {
		return decStrBin;
	}

	public void setDecStrBin(String decStrBin) {
		this.decStrBin = decStrBin;
	}

	public String getDecStrHex() {
		return decStrHex;
	}

	public void setDecStrHex(String decStrHex) {
		this.decStrHex = decStrHex;
	}

	public String getDecStrHTMLEscape() {
		return decStrHTMLEscape;
	}

	public void setDecStrHTMLEscape(String decStrHTMLEscape) {
		this.decStrHTMLEscape = decStrHTMLEscape;
	}

	public String getDecStrURLEncoding() {
		return decStrURLEncoding;
	}

	public void setDecStrURLEncoding(String decStrURLEncoding) {
		this.decStrURLEncoding = decStrURLEncoding;
	}

	public String getDecStrPunycode() {
		return decStrPunycode;
	}

	public void setDecStrPunycode(String decStrPunycode) {
		this.decStrPunycode = decStrPunycode;
	}

	public String getDecStrBase32Encoding() {
		return decStrBase32Encoding;
	}

	public void setDecStrBase32Encoding(String decStrBase32Encoding) {
		this.decStrBase32Encoding = decStrBase32Encoding;
	}

	public String getDecStrBase64Encoding() {
		return decStrBase64Encoding;
	}

	public void setDecStrBase64Encoding(String decStrBase64Encoding) {
		this.decStrBase64Encoding = decStrBase64Encoding;
	}

	public String getDecStrQuotedPrintable() {
		return decStrQuotedPrintable;
	}

	public void setDecStrQuotedPrintable(String decStrQuotedPrintable) {
		this.decStrQuotedPrintable = decStrQuotedPrintable;
	}

	public String getDecStrUnicodeEscape() {
		return decStrUnicodeEscape;
	}

	public void setDecStrUnicodeEscape(String decStrUnicodeEscape) {
		this.decStrUnicodeEscape = decStrUnicodeEscape;
	}

	public String getDecStrProgramString() {
		return decStrProgramString;
	}

	public void setDecStrProgramString(String decStrProgramString) {
		this.decStrProgramString = decStrProgramString;
	}

	public String getDecStrUnicodeNFC() {
		return decStrUnicodeNFC;
	}

	public void setDecStrUnicodeNFC(String decStrUnicodeNFC) {
		this.decStrUnicodeNFC = decStrUnicodeNFC;
	}

	public String getDecStrUnicodeNFKC() {
		return decStrUnicodeNFKC;
	}

	public void setDecStrUnicodeNFKC(String decStrUnicodeNFKC) {
		this.decStrUnicodeNFKC = decStrUnicodeNFKC;
	}

	public String getDecNumBin() {
		return decNumBin;
	}

	public void setDecNumBin(String decNumBin) {
		this.decNumBin = decNumBin;
	}

	public String getDecNumOct() {
		return decNumOct;
	}

	public void setDecNumOct(String decNumOct) {
		this.decNumOct = decNumOct;
	}

	public String getDecNumHex() {
		return decNumHex;
	}

	public void setDecNumHex(String decNumHex) {
		this.decNumHex = decNumHex;
	}

	public String getDecNumEnShortScale() {
		return decNumEnShortScale;
	}

	public void setDecNumEnShortScale(String decNumEnShortScale) {
		this.decNumEnShortScale = decNumEnShortScale;
	}

	public String getDecNumJP() {
		return decNumJP;
	}

	public void setDecNumJP(String decNumJP) {
		this.decNumJP = decNumJP;
	}

	public String getDecCipherCaesar() {
		return decCipherCaesar;
	}

	public void setDecCipherCaesar(String decCipherCaesar) {
		this.decCipherCaesar = decCipherCaesar;
	}

	public String getDecCipherROT13() {
		return decCipherROT13;
	}

	public void setDecCipherROT13(String decCipherROT13) {
		this.decCipherROT13 = decCipherROT13;
	}

	public String getDecCipherROT18() {
		return decCipherROT18;
	}

	public void setDecCipherROT18(String decCipherROT18) {
		this.decCipherROT18 = decCipherROT18;
	}

	public String getDecCipherROT47() {
		return decCipherROT47;
	}

	public void setDecCipherROT47(String decCipherROT47) {
		this.decCipherROT47 = decCipherROT47;
	}

	public String getDecCipherScytale() {
		return decCipherScytale;
	}

	public void setDecCipherScytale(String decCipherScytale) {
		this.decCipherScytale = decCipherScytale;
	}

	public String getDecCipherRailFence() {
		return decCipherRailFence;
	}

	public void setDecCipherRailFence(String decCipherRailFence) {
		this.decCipherRailFence = decCipherRailFence;
	}

	public String getEncStrBin() {
		return encStrBin;
	}

	public void setEncStrBin(String encStrBin) {
		this.encStrBin = encStrBin;
	}

	public String getEncStrHex() {
		return encStrHex;
	}

	public void setEncStrHex(String encStrHex) {
		this.encStrHex = encStrHex;
	}

	public String getEncStrHTMLEscape() {
		return encStrHTMLEscape;
	}

	public void setEncStrHTMLEscape(String encStrHTMLEscape) {
		this.encStrHTMLEscape = encStrHTMLEscape;
	}

	public String getEncStrHTMLEscapeFully() {
		return encStrHTMLEscapeFully;
	}

	public void setEncStrHTMLEscapeFully(String encStrHTMLEscapeFully) {
		this.encStrHTMLEscapeFully = encStrHTMLEscapeFully;
	}

	public String getEncStrURLEncoding() {
		return encStrURLEncoding;
	}

	public void setEncStrURLEncoding(String encStrURLEncoding) {
		this.encStrURLEncoding = encStrURLEncoding;
	}

	public String getEncStrPunycode() {
		return encStrPunycode;
	}

	public void setEncStrPunycode(String encStrPunycode) {
		this.encStrPunycode = encStrPunycode;
	}

	public String getEncStrBase32Encoding() {
		return encStrBase32Encoding;
	}

	public void setEncStrBase32Encoding(String encStrBase32Encoding) {
		this.encStrBase32Encoding = encStrBase32Encoding;
	}

	public String getEncStrBase64Encoding() {
		return encStrBase64Encoding;
	}

	public void setEncStrBase64Encoding(String encStrBase64Encoding) {
		this.encStrBase64Encoding = encStrBase64Encoding;
	}

	public String getEncStrQuotedPrintable() {
		return encStrQuotedPrintable;
	}

	public void setEncStrQuotedPrintable(String encStrQuotedPrintable) {
		this.encStrQuotedPrintable = encStrQuotedPrintable;
	}

	public String getEncStrUnicodeEscape() {
		return encStrUnicodeEscape;
	}

	public void setEncStrUnicodeEscape(String encStrUnicodeEscape) {
		this.encStrUnicodeEscape = encStrUnicodeEscape;
	}

	public String getEncStrProgramString() {
		return encStrProgramString;
	}

	public void setEncStrProgramString(String encStrProgramString) {
		this.encStrProgramString = encStrProgramString;
	}

	public String getEncStrHalfWidth() {
		return encStrHalfWidth;
	}

	public void setEncStrHalfWidth(String encStrHalfWidth) {
		this.encStrHalfWidth = encStrHalfWidth;
	}

	public String getEncStrFullWidth() {
		return encStrFullWidth;
	}

	public void setEncStrFullWidth(String encStrFullWidth) {
		this.encStrFullWidth = encStrFullWidth;
	}

	public String getEncStrUpperCase() {
		return encStrUpperCase;
	}

	public void setEncStrUpperCase(String encStrUpperCase) {
		this.encStrUpperCase = encStrUpperCase;
	}

	public String getEncStrLowerCase() {
		return encStrLowerCase;
	}

	public void setEncStrLowerCase(String encStrLowerCase) {
		this.encStrLowerCase = encStrLowerCase;
	}

	public String getEncStrSwapCase() {
		return encStrSwapCase;
	}

	public void setEncStrSwapCase(String encStrSwapCase) {
		this.encStrSwapCase = encStrSwapCase;
	}

	public String getEncStrCapitalize() {
		return encStrCapitalize;
	}

	public void setEncStrCapitalize(String encStrCapitalize) {
		this.encStrCapitalize = encStrCapitalize;
	}

	public String getEncStrInitials() {
		return encStrInitials;
	}

	public void setEncStrInitials(String encStrInitials) {
		this.encStrInitials = encStrInitials;
	}

	public String getEncStrReverse() {
		return encStrReverse;
	}

	public void setEncStrReverse(String encStrReverse) {
		this.encStrReverse = encStrReverse;
	}

	public String getEncStrUpperCamelCase() {
		return encStrUpperCamelCase;
	}

	public void setEncStrUpperCamelCase(String encStrUpperCamelCase) {
		this.encStrUpperCamelCase = encStrUpperCamelCase;
	}

	public String getEncStrLowerCamelCase() {
		return encStrLowerCamelCase;
	}

	public void setEncStrLowerCamelCase(String encStrLowerCamelCase) {
		this.encStrLowerCamelCase = encStrLowerCamelCase;
	}

	public String getEncStrUpperSnakeCase() {
		return encStrUpperSnakeCase;
	}

	public void setEncStrUpperSnakeCase(String encStrUpperSnakeCase) {
		this.encStrUpperSnakeCase = encStrUpperSnakeCase;
	}

	public String getEncStrLowerSnakeCase() {
		return encStrLowerSnakeCase;
	}

	public void setEncStrLowerSnakeCase(String encStrLowerSnakeCase) {
		this.encStrLowerSnakeCase = encStrLowerSnakeCase;
	}

	public String getEncStrUpperKebabCase() {
		return encStrUpperKebabCase;
	}

	public void setEncStrUpperKebabCase(String encStrUpperKebabCase) {
		this.encStrUpperKebabCase = encStrUpperKebabCase;
	}

	public String getEncStrLowerKebabCase() {
		return encStrLowerKebabCase;
	}

	public void setEncStrLowerKebabCase(String encStrLowerKebabCase) {
		this.encStrLowerKebabCase = encStrLowerKebabCase;
	}

	public String getEncStrUnicodeNFC() {
		return encStrUnicodeNFC;
	}

	public void setEncStrUnicodeNFC(String encStrUnicodeNFC) {
		this.encStrUnicodeNFC = encStrUnicodeNFC;
	}

	public String getEncStrUnicodeNFKC() {
		return encStrUnicodeNFKC;
	}

	public void setEncStrUnicodeNFKC(String encStrUnicodeNFKC) {
		this.encStrUnicodeNFKC = encStrUnicodeNFKC;
	}

	public String getEncStrLineSortAsc() {
		return encStrLineSortAsc;
	}

	public void setEncStrLineSortAsc(String encStrLineSortAsc) {
		this.encStrLineSortAsc = encStrLineSortAsc;
	}

	public String getEncStrLineSortDesc() {
		return encStrLineSortDesc;
	}

	public void setEncStrLineSortDesc(String encStrLineSortDesc) {
		this.encStrLineSortDesc = encStrLineSortDesc;
	}

	public String getEncStrLineSortReverse() {
		return encStrLineSortReverse;
	}

	public void setEncStrLineSortReverse(String encStrLineSortReverse) {
		this.encStrLineSortReverse = encStrLineSortReverse;
	}

	public String getEncStrLineUnique() {
		return encStrLineUnique;
	}

	public void setEncStrLineUnique(String encStrLineUnique) {
		this.encStrLineUnique = encStrLineUnique;
	}

	public String getEncNumBin() {
		return encNumBin;
	}

	public void setEncNumBin(String encNumBin) {
		this.encNumBin = encNumBin;
	}

	public String getEncNumOct() {
		return encNumOct;
	}

	public void setEncNumOct(String encNumOct) {
		this.encNumOct = encNumOct;
	}

	public String getEncNumHex() {
		return encNumHex;
	}

	public void setEncNumHex(String encNumHex) {
		this.encNumHex = encNumHex;
	}

	public String getEncNumEnShortScale() {
		return encNumEnShortScale;
	}

	public void setEncNumEnShortScale(String encNumEnShortScale) {
		this.encNumEnShortScale = encNumEnShortScale;
	}

	public String getEncNumEnShortScaleFraction() {
		return encNumEnShortScaleFraction;
	}

	public void setEncNumEnShortScaleFraction(String encNumEnShortScaleFraction) {
		this.encNumEnShortScaleFraction = encNumEnShortScaleFraction;
	}

	public String getEncNumJP() {
		return encNumJP;
	}

	public void setEncNumJP(String encNumJP) {
		this.encNumJP = encNumJP;
	}

	public String getEncNumJPDaiji() {
		return encNumJPDaiji;
	}

	public void setEncNumJPDaiji(String encNumJPDaiji) {
		this.encNumJPDaiji = encNumJPDaiji;
	}

	public String getEncDateUnixTime() {
		return encDateUnixTime;
	}

	public void setEncDateUnixTime(String encDateUnixTime) {
		this.encDateUnixTime = encDateUnixTime;
	}

	public String getEncDateW3CDTF() {
		return encDateW3CDTF;
	}

	public void setEncDateW3CDTF(String encDateW3CDTF) {
		this.encDateW3CDTF = encDateW3CDTF;
	}

	public String getEncDateISO8601() {
		return encDateISO8601;
	}

	public void setEncDateISO8601(String encDateISO8601) {
		this.encDateISO8601 = encDateISO8601;
	}

	public String getEncDateISO8601Ext() {
		return encDateISO8601Ext;
	}

	public void setEncDateISO8601Ext(String encDateISO8601Ext) {
		this.encDateISO8601Ext = encDateISO8601Ext;
	}

	public String getEncDateISO8601Week() {
		return encDateISO8601Week;
	}

	public void setEncDateISO8601Week(String encDateISO8601Week) {
		this.encDateISO8601Week = encDateISO8601Week;
	}

	public String getEncDateISO8601Ordinal() {
		return encDateISO8601Ordinal;
	}

	public void setEncDateISO8601Ordinal(String encDateISO8601Ordinal) {
		this.encDateISO8601Ordinal = encDateISO8601Ordinal;
	}

	public String getEncDateRFC2822() {
		return encDateRFC2822;
	}

	public void setEncDateRFC2822(String encDateRFC2822) {
		this.encDateRFC2822 = encDateRFC2822;
	}

	public String getEncDateCTime() {
		return encDateCTime;
	}

	public void setEncDateCTime(String encDateCTime) {
		this.encDateCTime = encDateCTime;
	}

	public String getEncDateJapaneseEra() {
		return encDateJapaneseEra;
	}

	public void setEncDateJapaneseEra(String encDateJapaneseEra) {
		this.encDateJapaneseEra = encDateJapaneseEra;
	}

	public String getEncColorName() {
		return encColorName;
	}

	public void setEncColorName(String encColorName) {
		this.encColorName = encColorName;
	}

	public String getEncColorRGBHex3() {
		return encColorRGBHex3;
	}

	public void setEncColorRGBHex3(String encColorRGBHex3) {
		this.encColorRGBHex3 = encColorRGBHex3;
	}

	public String getEncColorRGBHex6() {
		return encColorRGBHex6;
	}

	public void setEncColorRGBHex6(String encColorRGBHex6) {
		this.encColorRGBHex6 = encColorRGBHex6;
	}

	public String getEncColorRGBFn8() {
		return encColorRGBFn8;
	}

	public void setEncColorRGBFn8(String encColorRGBFn8) {
		this.encColorRGBFn8 = encColorRGBFn8;
	}

	public String getEncColorRGBFn() {
		return encColorRGBFn;
	}

	public void setEncColorRGBFn(String encColorRGBFn) {
		this.encColorRGBFn = encColorRGBFn;
	}

	public String getEncColorHSLFn() {
		return encColorHSLFn;
	}

	public void setEncColorHSLFn(String encColorHSLFn) {
		this.encColorHSLFn = encColorHSLFn;
	}

	public String getEncColorHSVFn() {
		return encColorHSVFn;
	}

	public void setEncColorHSVFn(String encColorHSVFn) {
		this.encColorHSVFn = encColorHSVFn;
	}

	public String getEncColorCMYFn() {
		return encColorCMYFn;
	}

	public void setEncColorCMYFn(String encColorCMYFn) {
		this.encColorCMYFn = encColorCMYFn;
	}

	public String getEncColorCMYKFn() {
		return encColorCMYKFn;
	}

	public void setEncColorCMYKFn(String encColorCMYKFn) {
		this.encColorCMYKFn = encColorCMYKFn;
	}

	public String getEncCipherCaesar() {
		return encCipherCaesar;
	}

	public void setEncCipherCaesar(String encCipherCaesar) {
		this.encCipherCaesar = encCipherCaesar;
	}

	public String getEncCipherROT13() {
		return encCipherROT13;
	}

	public void setEncCipherROT13(String encCipherROT13) {
		this.encCipherROT13 = encCipherROT13;
	}

	public String getEncCipherROT18() {
		return encCipherROT18;
	}

	public void setEncCipherROT18(String encCipherROT18) {
		this.encCipherROT18 = encCipherROT18;
	}

	public String getEncCipherROT47() {
		return encCipherROT47;
	}

	public void setEncCipherROT47(String encCipherROT47) {
		this.encCipherROT47 = encCipherROT47;
	}

	public String getEncCipherScytale() {
		return encCipherScytale;
	}

	public void setEncCipherScytale(String encCipherScytale) {
		this.encCipherScytale = encCipherScytale;
	}

	public String getEncCipherRailFence() {
		return encCipherRailFence;
	}

	public void setEncCipherRailFence(String encCipherRailFence) {
		this.encCipherRailFence = encCipherRailFence;
	}

	public String getEncHashMD2() {
		return encHashMD2;
	}

	public void setEncHashMD2(String encHashMD2) {
		this.encHashMD2 = encHashMD2;
	}

	public String getEncHashMD5() {
		return encHashMD5;
	}

	public void setEncHashMD5(String encHashMD5) {
		this.encHashMD5 = encHashMD5;
	}

	public String getEncHashSHA1() {
		return encHashSHA1;
	}

	public void setEncHashSHA1(String encHashSHA1) {
		this.encHashSHA1 = encHashSHA1;
	}

	public String getEncHashSHA256() {
		return encHashSHA256;
	}

	public void setEncHashSHA256(String encHashSHA256) {
		this.encHashSHA256 = encHashSHA256;
	}

	public String getEncHashSHA384() {
		return encHashSHA384;
	}

	public void setEncHashSHA384(String encHashSHA384) {
		this.encHashSHA384 = encHashSHA384;
	}

	public String getEncHashSHA512() {
		return encHashSHA512;
	}

	public void setEncHashSHA512(String encHashSHA512) {
		this.encHashSHA512 = encHashSHA512;
	}

	public String getEncHashCRC32() {
		return encHashCRC32;
	}

	public void setEncHashCRC32(String encHashCRC32) {
		this.encHashCRC32 = encHashCRC32;
	}
}
