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

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.zip.InflaterInputStream;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.fasterxml.jackson.dataformat.cbor.databind.CBORMapper;

@Dencoder(type="string", method="string.base45", hasEncoder=true, hasDecoder=true, useOe=true, useNl=true)
public class StringBase45Dencoder {
	private static final int BASE_N = 45;
	
	private static final char MIN_ENCODE_CHAR = ' ';
	private static final char MAX_ENCODE_CHAR = 'Z';
	
	private static final char[] ENCODE_TABLE = {
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
			'U', 'V', 'W', 'X', 'Y', 'Z', ' ', '$', '%', '*',
			'+', '-', '.', '/', ':'
			};
	
	private static final int[] DECODE_TABLE = new int[MAX_ENCODE_CHAR + 1];
	static {
		Arrays.fill(DECODE_TABLE, -1);
		for (int i = 0; i < ENCODE_TABLE.length; i++) {
			DECODE_TABLE[(int)ENCODE_TABLE[i]] = i;
		}
	}
	
	private static final int RAW_CHUNK_SIZE_FULL = 2;
	private static final int RAW_CHUNK_SIZE_PART = 1;
	private static final int ENCODED_CHUNK_SIZE_FULL = 3;
	private static final int ENCODED_CHUNK_SIZE_PART = 2;
	
	
	private StringBase45Dencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encStrBase45(DencodeCondition cond) {
		return encStrBase45Encoding(cond.valueAsBinary());
	}
	
	@DencoderFunction
	public static String decStrBase45(DencodeCondition cond) {
		byte[] decValue = decStrBase45Encoding(cond.value());
		if (decValue == null) {
			return null;
		}
		
		return new String(decValue, cond.charset());
	}
	
	@DencoderFunction
	public static String decStrBase45ZlibCoseCbor(DencodeCondition cond) {
		byte[] decValue = decStrBase45Encoding(cond.value());
		if (decValue == null) {
			// Remove prefix like "HC1:" and "NO1:"
			String v = cond.value();
			int idx = v.indexOf(':');
			if (idx < 0) {
				return null;
			}
			
			decValue = decStrBase45Encoding(v.substring(idx + 1));
			if (decValue == null) {
				return null;
			}
		}
		
		// Zlib to COSE to CBOR to JSON
		String cborJson;
		try (InputStream zlibIs = new ByteArrayInputStream(decValue)) {
			// Zlib to COSE
			try (InputStream coseIs = new InflaterInputStream(zlibIs)) {
				ObjectMapper cborMapper = new CBORMapper();
				ObjectMapper jsonMapper = new JsonMapper();
				
				// COSE to CBOR
				JsonNode coseNode = cborMapper.readTree(coseIs);
				JsonNode cosePayloadNode = coseNode.get(2);
				if (cosePayloadNode == null) {
					return null;
				}
				
				byte[] cborBin = cosePayloadNode.binaryValue();
				if (cborBin == null) {
					return null;
				}
				
				// CBOR to JSON
				JsonNode cborNode = cborMapper.readTree(cborBin);
				cborJson = jsonMapper.writerWithDefaultPrettyPrinter().writeValueAsString(cborNode);
			}
		} catch (IOException e) {
			return null;
		}
		
		return cborJson;
	}
	
	private static String encStrBase45Encoding(byte[] binValue) {
		int len = binValue.length;
		int c2 = len / RAW_CHUNK_SIZE_FULL;
		int c1 = len % RAW_CHUNK_SIZE_FULL;
		int len2 = len - c1;
		int bufLen = (c2 * ENCODED_CHUNK_SIZE_FULL) + (c1 * ENCODED_CHUNK_SIZE_PART);
		
		StringBuilder sb = new StringBuilder(bufLen);
		for (int i = 0; i < len; ) {
			boolean fullChunk = (i < len2);
			
			int n = (fullChunk)
					? ((binValue[i++] & 0xFF) << 8) | (binValue[i++] & 0xFF)
					: (binValue[i++] & 0xFF);
			int n3 = n / (BASE_N * BASE_N);
			int nn = n % (BASE_N * BASE_N);
			int n2 = nn / BASE_N;
			int n1 = nn % BASE_N;
			
			sb.append(ENCODE_TABLE[n1]);
			sb.append(ENCODE_TABLE[n2]);
			if (fullChunk) {
				sb.append(ENCODE_TABLE[n3]);
			}
		}
		
		return sb.toString();
	}
	
	private static byte[] decStrBase45Encoding(String val) {
		int len = val.length();
		int c3 = len / ENCODED_CHUNK_SIZE_FULL;
		int c2 = len % ENCODED_CHUNK_SIZE_FULL;
		
		if (c2 == 1) {
			// Illegal chunk size
			return null;
		}
		
		int len3 = len - c2;
		int bufLen = (c3 * RAW_CHUNK_SIZE_FULL) + ((c2 == 0) ? 0 : RAW_CHUNK_SIZE_PART);
		
		byte[] buf = new byte[bufLen];
		int bufIdx = 0;
		
		// i = 0, 3, 6, 9, ...
		for (int i = 0; i < len; i += ENCODED_CHUNK_SIZE_FULL) {
			
			// j = 2, 1, 0
			// idx = [2, 1, 0], [5, 4, 3], [8, 7, 6], ...
			int n = 0;
			for (int j = ENCODED_CHUNK_SIZE_FULL - 1; 0 <= j; j--) {
				int idx = i + j;
				if (len <= idx) {
					continue;
				}
				
				char ch = val.charAt(idx);
				if (ch < MIN_ENCODE_CHAR || MAX_ENCODE_CHAR < ch) {
					// Unsupported value
					return null;
				}
				
				int nx = DECODE_TABLE[ch];
				if (nx < 0) {
					// Unsupported value
					return null;
				}
				
				n = (n * BASE_N) + nx;
			}
			
			boolean fullChunk = (i < len3);
			
			if ((fullChunk && 0xFFFF < n) || (!fullChunk && 0xFF < n)) {
				// Illegal value
				return null;
			}
			
			if (fullChunk) {
				buf[bufIdx++] = (byte)((n >> 8) & 0xFF);
			}
			buf[bufIdx++] = (byte)(n & 0xFF);
		}
		
		return buf;
	}
}
