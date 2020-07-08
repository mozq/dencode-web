package com.dencode.web.logic;

public final class CommonLogic {

	private CommonLogic() {
		// NOP
	}

	public static String mapShortCharsetName(String charsetName) {
		if (charsetName == null) {
			return null;
		}
		
		switch (charsetName) {
			case "utf8": return "UTF-8";
			case "utf16": return "UTF-16BE";
			case "utf32": return "UTF-32BE";
			case "eucjp": return "EUC-JP";
			case "sjis": return "Shift_JIS";
			case "iso2022jp": return "ISO-2022-JP";
			case "iso88591": return "ISO-8859-1";
			case "iso88592": return "ISO-8859-2";
			case "iso88594": return "ISO-8859-4";
			case "iso88595": return "ISO-8859-5";
			case "iso88596": return "ISO-8859-6";
			case "iso88597": return "ISO-8859-7";
			case "iso88598": return "ISO-8859-8";
			case "iso88599": return "ISO-8859-9";
			case "iso885913": return "ISO-8859-13";
			case "iso885915": return "ISO-8859-15";
			case "cp874": return "windows-874";
			case "cp1250": return "windows-1250";
			case "cp1251": return "windows-1251";
			case "cp1252": return "windows-1252";
			case "cp1253": return "windows-1253";
			case "cp1254": return "windows-1254";
			case "cp1255": return "windows-1255";
			case "cp1256": return "windows-1256";
			case "cp1257": return "windows-1257";
			case "cp1258": return "windows-1258";
			case "koi8r": return "KOI8-R";
			case "koi8u": return "KOI8-U";
			case "big5hkscs": return "Big5-HKSCS";
			case "euccn": return "GB2312";
			case "gb18030": return "GB18030";
			case "euckr": return "EUC-KR";
			case "iso2022kr": return "ISO-2022-KR";
			case "tis620": return "TIS-620";
			default: return charsetName;
		}
	}
}
