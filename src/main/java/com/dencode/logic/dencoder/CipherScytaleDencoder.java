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

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="cipher", method="cipher.scytale", hasEncoder=true, hasDecoder=true)
public class CipherScytaleDencoder {
	
	private CipherScytaleDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherScytale(DencodeCondition cond) {
		return encCipherScytale(cond.valueAsCodePointsWithLf(),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.scytale.key", DencodeUtils.getOptionAsInt(cond.options(), "encCipherScytaleKey", 2)),
				DencodeUtils.getOption(cond.options(), "cipher.scytale.key-per", DencodeUtils.getOption(cond.options(), "encCipherScytaleKeyPer", "y")).equals("x"));
	}
	
	@DencoderFunction
	public static String decCipherScytale(DencodeCondition cond) {
		return decCipherScytale(cond.valueAsCodePointsWithLf(),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.scytale.key", DencodeUtils.getOptionAsInt(cond.options(), "decCipherScytaleKey", 2)),
				DencodeUtils.getOption(cond.options(), "cipher.scytale.key-per", DencodeUtils.getOption(cond.options(), "decCipherScytaleKeyPer", "y")).equals("x"));
	}
	
	
	private static String encCipherScytale(int[] cps, int key, boolean keyPerX) {
		if (cps == null) {
			return null;
		}
		
		int len = cps.length;
		
		if (len == 0) {
			return "";
		}
		
		StringBuilder sb = new StringBuilder(len); // Extends automatically if surrogate pairs are included
		
		int maxY = key;
		int maxX = (int)Math.ceil(((double)len) / maxY);
		if (keyPerX) {
			// Swap x/y
			int tmpX = maxX;
			maxX = maxY;
			maxY = tmpX;
		}
		
		for (int x = 0; x < maxX; x++) {
			for (int idx = x; idx < len; idx = idx + maxX) {
				int cp = cps[idx];
				sb.appendCodePoint(cp);
			}
		}
		
		return sb.toString();
	}
	
	private static String decCipherScytale(int[] cps, int key, boolean keyPerX) {
		if (cps == null) {
			return null;
		}
		
		int len = cps.length;
		
		if (len == 0) {
			return "";
		}
		
		StringBuilder sb = new StringBuilder(len);
		
		int maxX;
		int maxY;
		if (keyPerX) {
			// Key per X
			maxX = key;
			maxY = (int)Math.ceil(((double)len) / maxX);
		} else {
			// Key per Y
			maxX = (int)Math.ceil(((double)len) / key);
			maxY = Math.min(key, (int)Math.ceil(((double)len) / maxX));
		}
		
		int minX = len % maxX;
		minX = (minX == 0) ? maxX : minX;
		
		for (int y = 1; y <= maxY; y++) {
			boolean isBottom = (y == maxY);
			
			for (int x = 1; x <= maxX; x++) {
				int offset = 0;
				if (minX < x) {
					if (isBottom) {
						break;
					}
					
					offset -= (x - minX - 1);
				}
				
				int idx = (maxY * (x - 1)) + y - 1 + offset;
				
				int cp = cps[idx];
				sb.appendCodePoint(cp);
			}
		}
		
		return sb.toString();
	}
}
