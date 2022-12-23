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

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;

import org.junit.jupiter.api.Test;

import com.dencode.logic.model.DencodeCondition;

public class CipherScytaleDencoderTest {
	
	@Test
	public void testKeyPerY() {
		// Blank
		testDencoder("", 2, "y", "");
		testDencoder("", 4, "y", "");

		// THIS_IS_A_SE
		// CRET_MESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 2, "y", "TCHRIEST__IMSE_SAS_ASGEE");
		
		// THIS_IS_
		// A_SECRET
		// _MESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 3, "y", "TA_H_MISESES_CSIRASEG_TE");
		
		// THIS_I
		// S_A_SE
		// CRET_M
		// ESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 4, "y", "TSCEH_RSIAESS_TA_S_GIEME");
		
		// THIS_
		// IS_A_
		// SECRE
		// T_MES
		// SAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 5, "y", "TISTSHSE_AI_CMGSAREE__ES");
		
		// THIS
		// _IS_
		// A_SE
		// CRET
		// _MES
		// SAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 6, "y", "T_AC_SHI_RMAISSEEGS_ETSE");

		// THIS
		// _IS_
		// A_SE
		// CRET
		// _MES
		// SAGE
		// 
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 7, "y", "T_AC_SHI_RMAISSEEGS_ETSE");
		
		// THI
		// S_I
		// S_A
		// _SE
		// CRE
		// T_M
		// ESS
		// AGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 8, "y", "TSS_CTEAH__SR_SGIIAEEMSE");
		
		// THI
		// S_I
		// S_A
		// _SE
		// CRE
		// T_M
		// ESS
		// AGE
		// 
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 9, "y", "TSS_CTEAH__SR_SGIIAEEMSE");
		
		// THI
		// S_I
		// S_A
		// _SE
		// CRE
		// T_M
		// ESS
		// AGE
		// 
		// 
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 10, "y", "TSS_CTEAH__SR_SGIIAEEMSE");
		
		// THI
		// S_I
		// S_A
		// _SE
		// CRE
		// T_M
		// ESS
		// AGE
		// 
		// 
		// 
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 11, "y", "TSS_CTEAH__SR_SGIIAEEMSE");
		
		// TH
		// IS
		// _I
		// S_
		// A_
		// SE
		// CR
		// ET
		// _M
		// ES
		// SA
		// GE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 12, "y", "TI_SASCE_ESGHSI__ERTMSAE");
		
		// TH
		// IS
		// _I
		// S_
		// A_
		// SE
		// CR
		// ET
		// _M
		// ES
		// SA
		// GE
		// 
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 13, "y", "TI_SASCE_ESGHSI__ERTMSAE");
		
		// T
		// ...
		// E
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 24, "y", "THIS_IS_A_SECRET_MESSAGE");
		
		// Out of length
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 100, "y", "THIS_IS_A_SECRET_MESSAGE");
	}
	
	@Test
	public void testKeyPerX() {
		// Blank
		testDencoder("", 2, "x", "");
		testDencoder("", 4, "x", "");

		// TH
		// IS
		// _I
		// S_
		// A_
		// SE
		// CR
		// ET
		// _M
		// ES
		// SA
		// GE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 2, "x", "TI_SASCE_ESGHSI__ERTMSAE");
		
		// THI
		// S_I
		// S_A
		// _SE
		// CRE
		// T_M
		// ESS
		// AGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 3, "x", "TSS_CTEAH__SR_SGIIAEEMSE");
		
		// THIS
		// _IS_
		// A_SE
		// CRET
		// _MES
		// SAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 4, "x", "T_AC_SHI_RMAISSEEGS_ETSE");
		
		// THIS_
		// IS_A_
		// SECRE
		// T_MES
		// SAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 5, "x", "TISTSHSE_AI_CMGSAREE__ES");
		
		// THIS_I
		// S_A_SE
		// CRET_M
		// ESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 6, "x", "TSCEH_RSIAESS_TA_S_GIEME");
		
		// THIS_IS
		// _A_SECR
		// ET_MESS
		// AGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 7, "x", "T_EAHATGI__ESSM_EEICSSRS");
		
		// THIS_IS_
		// A_SECRET
		// _MESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 8, "x", "TA_H_MISESES_CSIRASEG_TE");
		
		// THIS_IS_A
		// _SECRET_M
		// ESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 9, "x", "T_EHSSIESSCA_RGIEEST__AM");
		
		// THIS_IS_A_
		// SECRET_MES
		// SAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 10, "x", "TSSHEAICGSRE_EITS__MAE_S");
		
		// THIS_IS_A_S
		// ECRET_MESSA
		// GE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 11, "x", "TEGHCEIRSE_TI_SM_EAS_SSA");
		
		// THIS_IS_A_SE
		// CRET_MESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 12, "x", "TCHRIEST__IMSE_SAS_ASGEE");
		
		// THIS_IS_A_SEC
		// RET_MESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 13, "x", "TRHEITS__MIESS_SAA_GSEEC");
		
		// THIS_IS_A_SECRET_MESSAG
		// E
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 23, "x", "TEHIS_IS_A_SECRET_MESSAG");
		
		// THIS_IS_A_SECRET_MESSAGE
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 24, "x", "THIS_IS_A_SECRET_MESSAGE");
		
		// Out of length
		testDencoder("THIS_IS_A_SECRET_MESSAGE", 100, "x", "THIS_IS_A_SECRET_MESSAGE");
	}
	
	private void testDencoder(String value, int key, String keyPer, String expectedEncodedValue) {
		testDencoder(value, key, keyPer, expectedEncodedValue, null);
	}
	
	private void testDencoder(String value, int key, String keyPer, String expectedEncodedValue, String expectedDecodedValue) {
		String encodedValue = CipherScytaleDencoder.encCipherScytale(new DencodeCondition(value, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("encCipherScytaleKey", String.valueOf(key));
				put("encCipherScytaleKeyPer", keyPer);
			}
		}));
		assertEquals(expectedEncodedValue, encodedValue);
		
		String decodedValue = CipherScytaleDencoder.decCipherScytale(new DencodeCondition(encodedValue, StandardCharsets.UTF_8, "\r\n", null, new HashMap<>() {
			private static final long serialVersionUID = 1L;
			{
				put("decCipherScytaleKey", String.valueOf(key));
				put("decCipherScytaleKeyPer", keyPer);
			}
		}));
		if (expectedDecodedValue == null) {
			assertEquals(value, decodedValue);
		} else {
			assertEquals(expectedDecodedValue, decodedValue);
		}
	}
 }
 