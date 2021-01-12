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

import java.nio.charset.Charset;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="string", method="string.hex")
public class StringHexDencoder {
	
	private StringHexDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrHex(DencodeCondition cond) {
		return encStrHex(cond.valueAsBinary(), cond.option().getEncStrHexSeparatorEach(), cond.option().getEncStrHexCase());
	}
	
	@DencoderFunction
	public static String decStrHex(DencodeCondition cond) {
		return decStrHex(cond.value(), cond.charset());
	}
	
	
	private static String encStrHex(byte[] binValue, String separatorEach, String hexCase) {
		return toHexString(binValue, separatorEach, hexCase.equals("upper"));
	}
	
	private static String decStrHex(String val, Charset charset) {
		if (val == null || val.isEmpty()) {
			return null;
		}

		val = val.replaceAll("\\s", "");
		
		try {
			int len = val.length();
			int binLen = 0;
			byte[] binValue = new byte[len / 2 + 1];
			for (int i = 0; i < val.length(); ) {
				int lastIdx = Math.min(i + 2, len);
				String v = val.substring(i, lastIdx);
				byte b = (byte)Integer.parseInt(v, 16);
				binValue[binLen++] = b;
				i = lastIdx;
			}
			return new String(binValue, 0, binLen, charset);
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	private static String toHexString(byte[] binary, String separatorEach, boolean upperCase) {
		if (binary == null) {
			return null;
		}
		if (binary.length == 0) {
			return "";
		}
		
		int separatorEachByte = DencodeUtils.parseDataSizeAsByte(separatorEach);
		
		int len = binary.length;
		
		char baseCharA = (upperCase) ? 'A' : 'a';
		
		StringBuilder sb = new StringBuilder(len * 3);
		for (int i = 0; i < len; i++) {
			byte b = binary[i];
			
			if (i != 0 && 0 < separatorEachByte && (i % separatorEachByte) == 0) {
				sb.append(' ');
			}
			int high = ((b >>> 4) & 0xF);
			int low = (b & 0xF);
			if (high < 10) {
				sb.append((char)('0' + high));
			} else {
				sb.append((char)(baseCharA + (high - 10)));
			}
			if (low < 10) {
				sb.append((char)('0' + low));
			} else {
				sb.append((char)(baseCharA + (low - 10)));
			}
		}
		return sb.toString();
	}
}
