<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About the Enigma Cipher</h3>
<p>The Enigma cipher is a type of commutative cipher that encrypts letters by replacing them with other letters. It supports encryption of 26 characters from "A" to "Z".</p>
<p>Character substitution is done using the Enigma cipher machine, and DenCode supports the following Enigma machine simulations</p>

<ul>
	<li>Enigma I</li>
	<li>Enigma M3</li>
	<li>Enigma M4 (U-boat Enigma)</li>
	<li>Norway Enigma "Norenigma"</li>
	<li>Sondermaschine (Special machine)</li>
	<li>Enigma G "Zählwerk Enigma" (A28/G31)</li>
	<li>Enigma G G-312 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-260 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-111 (G31 Hungarian Enigma)</li>
	<li>Enigma D (Commercial Enigma A26)</li>
	<li>Enigma K (Commercial Enigma A27)</li>
	<li>Enigma KD (Enigma K with UKW-D)</li>
	<li>Swiss-K (Swiss Enigma K variant)</li>
	<li>Railway Enigma "Rocket I"</li>
	<li>Enigma T "Tirpitz" (Japanese Enigma)</li>
</ul>

<p>The Enigma machine consists of the following components. Characters entered from the keyboard (Tastatur) pass through a plugboard (Steckerbrett), an entry wheel (ETW, Eintrittswalze), three or four rotors (Walze), a reflector (UKW, Umkehrwalze), and then the reverse. The encrypted result is displayed on the lamp board (Lampenfeld). Lettering is performed at all locations, including the rotor.</p>

<pre>
 UKW   Walze  Walze  Walze   ETW  (Stecker)
         3      2      1
 ___    ___    ___    ___    ___    ___
|   |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- < Tastatur
| | |  |   |  |   |  |   |  |   |  |   |
| | |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- > Lampenfeld
|   |  |   |  |   |  |   |  |   |  |   |
 ---    ---    ---    ---    ---    ---
</pre>

<p>The entry wheels, rotors, and reflectors are wired internally to convert the 26 letters from "A" to "Z" into other letters, and the conversion is done when the wires are energized. For example, the rotor "I" of Enigma I is wired as shown below, and the letter "A" is converted to "E". For example, the rotor "I" of Enigma I is wired as follows: the letter "A" is converted to "E", and the letter "J" coming back from the reflector is converted to "Z" by following the reverse wiring.</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>All wiring for Enigma I is as follows.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>Wheel</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
		<tr><td>ETW</td><td>ABCDEFGHIJKLMNOPQRSTUVWXYZ</td></tr>
		<tr><td>I</td><td>EKMFLGDQVZNTOWYHXUSPAIBRCJ</td></tr>
		<tr><td>II</td><td>AJDKSIRUXBLHWTMCQGZNPYFVOE</td></tr>
		<tr><td>III</td><td>BDFHJLCPRTXVZNYEIWGAKMUSQO</td></tr>
		<tr><td>IV</td><td>ESOVPZJAYQUIRHXLNFTGKDCMWB</td></tr>
		<tr><td>V</td><td>VZBRGITYUPSDNHLXAWMJQOFECK</td></tr>
		<tr><td>UKW-A</td><td>EJMZALYXVBWFCRQUONTSPIKHGD</td></tr>
		<tr><td>UKW-B</td><td>YRUHQSLDPXNGOKMIEBFZCWVJAT</td></tr>
		<tr><td>UKW-C</td><td>FVPJIAOYEDRZXWGCTKUQSBNMHL</td></tr>
	</table>
</div>

<p>The plugboard is a mechanism that allows the transliteration to be wired by the user. In some Enigma machines, there is a plugboard at the front of the ETW. The plugboard has input and output terminals for 26 alphabets, from "A" to "Z." By connecting any two alphabets with a cable, the two characters can be converted. For example, if you connect "A" and "M" with a cable, "A" will be converted to "M" and "M" to "A". The characters of the input and output terminals that are not wired with cables will not be converted.</p>
<p>When you enter a character from the keyboard, the rotor rotates one step. The rotation of the rotor starts with the rotor on the right side, and when it reaches the notch on the rotor, the rotor on the left side also rotates by one step. This rotation of the rotor changes the wiring for encryption for each character, so even if you enter the same character, it will be converted to a different character from the previous one.</p>
<p>The rotor has a ring, with the letters "A" through "Z" (or "01" through "26") engraved on the outer circumference of the ring. The ring can be set to 26 different offsets between the letter on its periphery and the wiring inside the rotor. For example, in the case of the "I" rotor of the Enigma I, if the ring setting is "A (01)", the "A" will be converted to an "E", but if the ring setting is "B (02)", the "A" will be converted to a "K" as the original Z-J wiring because the internal wiring is shifted by one.</p>

<pre>
Ring: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

Ring: B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>Rotors can be set in order and initial position of rotation. For example, if there are three types of rotors, "I", "II", and "III", they can be set in the Enigma machine in the order "II", "I", and "III", and the initial position of each rotor can be set between "A (01)" and "Z (26)". Reflectors are also interchangeable among several types of reflectors with different wiring, and some Enigma machines can be set to an initial position. The entry wheel is fixed and cannot be changed. For Enigma machines that have plugboards, the plugboard can also be set. These settings are the key to encryption by the Enigma machine.</p>
<p>An example of encryption with Enigma I is shown below.</p>

<pre>
Wheel order     : UKW-A II I III
Ring setting    : X M V  (24 13 22)
Position setting: A B L  (01 02 12)
Plugboard       : AM FI NV PS TU WZ

Text before encryption: SECRET
Text after encryption : LCGODU
</pre>

<p>In this case, the first letter "S" will be converted into the following sequence, and finally encrypted into "L".</p>

<pre>
S -> P  : Plugboard
P -> P  : ETW
P -> L  : III
L -> P  : I
P -> W  : II
W -> K  : UKW-A
K -> Q  : II
Q -> O  : I
O -> L  : III
L -> L  : ETW
L -> L  : Plugboard
</pre>

<p>The rotational position of the rotor and the input (+) / output (-) positions are represented by the letters on the ring as shown below. (Since the rotor is rotating, the above "transcribed characters" and "characters as positions on the ring" are different.)</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Plugboard
           -   +          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           -   +          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           +  -           
BCDEFGHIJKLMNOPQRSTUVWXYZA  : I
               +-         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          -           +   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>

<p>The Enigma machine has a feature that if you encrypt an encrypted text again with the same settings, you will get the plain text before encryption. Therefore, inputting the encrypted "L" in the above example will yield the original "S".</p>

<pre>
L -> L  : Plugboard
L -> L  : ETW
L -> O  : III
O -> Q  : I
Q -> K  : II
K -> W  : UKW-A
W -> P  : II
P -> L  : I
L -> P  : III
P -> P  : ETW
P -> S  : Plugboard
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Plugboard
           +   -          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           +   -          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           -  +           
BCDEFGHIJKLMNOPQRSTUVWXYZA  : I
               -+         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          +           -   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>


<h3>Setting items in DenCode</h3>

<h4>Wheel order (Walzenlage)</h4>
<p>Set the type of reflector and rotor, and the order of the rotors.</p>
<p>Since the input is from the right side of the Enigma machine, the rotors are counted from the right rotor as 1, 2, 3, and so on, but when describing the wheel order settings, they are generally written in order from left to right. For example, a wheel order of "UKW-A II I III" indicates the settings of rotor 1 "III", rotor 2 "I", rotor 3 "II", and the reflector "UKW-A".</p>
<p>Normally, there is one reflector and three rotors for a total of four, but the Enigma M4 can be configured with a "thin reflector" and a "thin rotor" in the reflector slot. In DenCode, the "thin reflector" is treated like a normal reflector, and the "thin rotor" (Beta, Gamma) is additionally displayed as rotor 4, for a total of 5 settings. However, if the reflector is UKW-D, Rotor 4 cannot be set because it occupies the reflector slot.</p>

<h4>Ring setting (Ringstellung)</h4>
<p>Set the ring of the rotor. This setting changes the position of the rotor's internal wiring relative to the ring. On some Enigma machines, the reflector can also be set to ring.</p>

<h4>Position setting (Grundstellung)</h4>
<p>Set the initial position of the rotor. On some Enigma machines, the reflector can also be set to its initial position.</p>
<p>It is sometimes called the "Message key" because it was set differently for each message.</p>

<h4>Plugboard wiring (Steckerverbindungen)</h4>
<p>Set up the wiring pairs for the plugboard.</p>
<p>In DenCode, wiring is specified by enumerating pairs of two characters to be converted, such as "AB CD EF GH IJ KL", separated by a space. In this example, the pairs are "A" and "B", "C" and "D", and so on.</p>

<h4>Uhr</h4>
<p>Uhr is an accessory that connects to a plugboard and selects wiring from 40 ways from "00" to "39". The plugboard and Uhr are connected by 20 cables. When the Uhr is set to "00", that pair of cables is equal to the one wired directly on the plugboard.</p>
<p>Uhr can only be set for Enigma I. Uhr can be set by first specifying 10 sets of wiring pairs on the plugboard.</p>

<h4>UKW-D wiring</h4>
<p>UKW-D is a reflector with changeable internal wiring.</p>
<p>The normal notation for reflector rings is "ABCDEFGHIJKLMNOPQRSTUVWXYZ", but UKW-D's notation is in a special order, "A-ZXWVUTSRQPON-MLKIHGFEDCB". The two "-" (BO in normal notation) in the notation are fixed and always wired to each other and cannot be changed. The other 24 characters and 12 pairs of wires are set.</p>

<pre>
UKW-D notation : A-ZXWVUTSRQPON-MLKIHGFEDCB
Normal notation: ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-D can be set for Enigma I, Enigma M4, and Enigma KD.</p>
