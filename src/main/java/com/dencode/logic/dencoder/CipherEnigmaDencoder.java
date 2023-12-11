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

import java.util.List;

import com.dencode.logic.dencoder.annotation.Dencoder;
import com.dencode.logic.dencoder.annotation.DencoderFunction;
import com.dencode.logic.model.DencodeCondition;

import net.mozq.enigma4j.Enigma;
import net.mozq.enigma4j.machine.EnigmaFeature;
import net.mozq.enigma4j.machine.EnigmaMachine;
import net.mozq.enigma4j.scrambler.Reflector;
import net.mozq.enigma4j.scrambler.UnsupportedWiringException;
import net.mozq.enigma4j.scrambler.WiringPair;

@Dencoder(type="cipher", method="cipher.enigma", hasEncoder=true, hasDecoder=true)
public class CipherEnigmaDencoder {
	
	private CipherEnigmaDencoder() {
		// NOP
	}
	
	
	@DencoderFunction
	public static String encCipherEnigma(DencodeCondition cond) {
		return dencCipherEnigma(
				cond.value(),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.machine", "I"),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.reflector", "UKW-A"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.reflector-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.reflector-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.rotor4", "Beta"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor4-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor4-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.rotor3", "III"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor3-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor3-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.rotor2", "II"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor2-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor2-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.rotor1", "I"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor1-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor1-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.plugboard", ""),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.uhr", 0),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.ukwd", "")
				);
	}
	
	@DencoderFunction
	public static String decCipherEnigma(DencodeCondition cond) {
		return dencCipherEnigma(
				cond.value(),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.machine", "I"),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.reflector", "UKW-A"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.reflector-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.reflector-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.rotor4", "Beta"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor4-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor4-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.rotor3", "III"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor3-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor3-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.rotor2", "II"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor2-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor2-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.rotor1", "I"),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor1-ring", 1),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.rotor1-position", 1),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.plugboard", ""),
				DencodeUtils.getOptionAsInt(cond.options(), "cipher.enigma.uhr", 0),
				DencodeUtils.getOption(cond.options(), "cipher.enigma.ukwd", "")
				);
	}
	
	
	private static String dencCipherEnigma(
			String val,
			String machine,
			String reflector, int reflectorRing, int reflectorPosition,
			String rotor4, int rotor4Ring, int rotor4Position,
			String rotor3, int rotor3Ring, int rotor3Position,
			String rotor2, int rotor2Ring, int rotor2Position,
			String rotor1, int rotor1Ring, int rotor1Position,
			String plugboard,
			int uhr,
			String ukwd
			) {
		
		if (val == null || val.isEmpty()) {
			return val;
		}
		
		if (machine.isEmpty()) {
			return "";
		}
		
		try {
			EnigmaMachine m = Enigma.machine(machine);
			
			// Reflector
			if (reflector.equals("UKW-D")) {
				m.reflector(Reflector.UKW_D(ukwd.toUpperCase()));
			} else if (m.spec().hasFeature(EnigmaFeature.SETTABLE_REFLECTOR)) {
				m.reflector(reflector, reflectorRing, reflectorPosition);
			} else {
				m.reflector(reflector);
			}
	
			// Rotors
			if (m.spec().isSupportFourthRotor() && !reflector.equals("UKW-D")) {
				m.rotor(4, rotor4, rotor4Ring, rotor4Position);
			}
			m.rotor(3, rotor3, rotor3Ring, rotor3Position);
			m.rotor(2, rotor2, rotor2Ring, rotor2Position);
			m.rotor(1, rotor1, rotor1Ring, rotor1Position);
			
			// Plugboard, Uhr
			if (m.spec().hasFeature(EnigmaFeature.PLUGBOARD)) {
				List<WiringPair> plugboardPairs = WiringPair.toPairs(plugboard.toUpperCase());
				if (m.spec().hasFeature(EnigmaFeature.UHR) && plugboardPairs.size() == 10) {
					// Plugboard + Uhr
					m.plugboard(plugboardPairs, uhr);
				} else {
					// Plugboard
					m.plugboard(plugboardPairs);
				}
			}
			
			return m.translate(val);
		} catch (IllegalArgumentException e) {
			return "";
		} catch (UnsupportedWiringException e) {
			return "";
		}
	}
}
