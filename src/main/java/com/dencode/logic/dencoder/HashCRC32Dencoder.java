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

import java.util.zip.CRC32;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

@Dencoder(type="hash", method="hash.crc32")
public class HashCRC32Dencoder {
	
	private HashCRC32Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encHashCRC32(DencodeCondition cond) {
		return encHashCRC32(cond.valueAsBinary());
	}
	
	
	private static String encHashCRC32(byte[] binValue) {
		CRC32 crc = new CRC32();
		crc.update(binValue, 0, binValue.length);
		return Long.toHexString(crc.getValue());
	}
}