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

@Dencoder(type="string", method="string.bin", hasEncoder=true, hasDecoder=true, useOe=true, useNl=true)
public class StringBinDencoder {
	
	private StringBinDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrBin(DencodeCondition cond) {
		return encStrBin(
				cond.valueAsBinary(),
				DencodeUtils.getOption(cond.options(), "string.bin.separator-each", "")
				);
	}
	
	@DencoderFunction
	public static String decStrBin(DencodeCondition cond) {
		return decStrBin(cond.value(), cond.charset());
	}
	
	
	private static String encStrBin(byte[] binValue, String separatorEach) {
		return toBinString(binValue, separatorEach);
	}
	
	private static String decStrBin(String val, Charset charset) {
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		int len = val.length();
		byte[] binValue = new byte[len / 8 + 1];
		int binIdx = -1;
		int digits = 0;
		
		for (int i = 0; i < len; i++) {
			char ch = val.charAt(i);
			
			if (Character.isWhitespace(ch)) {
				continue;
			}
			
			int b;
			switch (ch) {
				case '0': b = 0; break;
				case '1': b = 1; break;
				default: return null;
			}
			
			if (digits == 0) {
				binValue[++binIdx] = (byte)b;
				digits = 1;
			} else {
				binValue[binIdx] = (byte)((binValue[binIdx] << 1) | b);
				digits += 1;
				if (digits >= 8) {
					digits = 0;
				}
			}
		}
		
		if (digits != 0) {
			binValue[binIdx] = (byte)((binValue[binIdx] << (8 - digits)));
		}
		
		return new String(binValue, 0, binIdx + 1, charset);
	}
	
	private static String toBinString(byte[] binary, String separatorEach) {
		if (binary == null) {
			return null;
		}
		if (binary.length == 0) {
			return "";
		}
		
		int separatorEachBit = DencodeUtils.parseDataSizeAsBit(separatorEach);
		int separatorEachByte = (separatorEachBit + 7) / 8; // Round UP
		
		int len = binary.length;
		
		StringBuilder sb = new StringBuilder(len * 10);
		for (int i = 0; i < len; i++) {
			byte b = binary[i];
			
			if (i != 0 && 0 < separatorEachByte && (i % separatorEachByte) == 0) {
				sb.append(' ');
			}
			
			sb.append(((b & 0x80) == 0) ? '0' : '1');
			sb.append(((b & 0x40) == 0) ? '0' : '1');
			sb.append(((b & 0x20) == 0) ? '0' : '1');
			sb.append(((b & 0x10) == 0) ? '0' : '1');
			if (separatorEachBit == 4) {
				sb.append(' ');
			}
			sb.append(((b & 0x8) == 0) ? '0' : '1');
			sb.append(((b & 0x4) == 0) ? '0' : '1');
			sb.append(((b & 0x2) == 0) ? '0' : '1');
			sb.append(((b & 0x1) == 0) ? '0' : '1');
		}
		return sb.toString();
	}
}
