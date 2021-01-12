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

@Dencoder(type="cipher", method="cipher.rail-fence")
public class CipherRailFenceDencoder {

	private CipherRailFenceDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherRailFence(DencodeCondition cond) {
		return encCipherRailFence(cond.value(), cond.option().getEncCipherRailFenceKey());
	}
	
	@DencoderFunction
	public static String decCipherRailFence(DencodeCondition cond) {
		return decCipherRailFence(cond.value(), cond.option().getDecCipherRailFenceKey());
	}
	
	
	private static String encCipherRailFence(String val, int key) {
		if (val == null || val.length() <= key) {
			return val;
		}
		
		StringBuilder sb = new StringBuilder(val.length());
		
		int[] cps = val.codePoints().toArray();
		int len = cps.length;
		int maxY = key;
		int cycleX = maxY * 2 - 2;
		
		for (int yi = 0; yi < maxY; yi++) {
			for (int xi = yi; xi < len; xi += cycleX) {
				sb.appendCodePoint(cps[xi]);
				
				if (yi != 0 && (yi + 1) != maxY) {
					int nxi = xi + (cycleX - (2 * yi));
					if (nxi < len) {
						sb.appendCodePoint(cps[nxi]);
					}
				}
			}
		}
		
		return sb.toString();
	}
	
	private static String decCipherRailFence(String val, int key) {
		if (val == null || val.length() <= key) {
			return val;
		}
		
		int[] cps = val.codePoints().toArray();
		int len = cps.length;
		int maxY = key;
		int cycleX = maxY * 2 - 2;
		int[] newCPs = new int[len];
		
		int idx = 0;
		for (int yi = 0; yi < maxY; yi++) {
			for (int xi = yi; xi < len; xi += cycleX) {
				newCPs[xi] = cps[idx++];
				
				if (yi != 0 && (yi + 1) != maxY) {
					int nxi = xi + (cycleX - (2 * yi));
					if (nxi < len) {
						newCPs[nxi] = cps[idx++];
					}
				}
			}
		}
		
		return new String(newCPs, 0, len);
	}
}
