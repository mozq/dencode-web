<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Caesar Cipher</h3>
<p>Caesar cipher is one of the monoalphabetic substitution ciphers that encrypts by replacing the characters in the text with other characters.</p>
<p>Character replacement is performed by shifting the characters from "A" to "Z" among the 26 characters of "ABCDEFGHIJKLMNOPQRSTUVWXYZ".</p>
<p>For example, when shifting -3 characters, "A" is encrypted to "X" and "Z" is encrypted to "W".</p>

<pre>Plain : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Cipher: XYZABCDEFGHIJKLMNOPQRSTUVW</pre>

<pre>Plain text : THIS IS A SECRET MESSAGE
Cipher text: QEFP FP X PBZOBQ JBPPXDB</pre>

<p>The number of shifts is the key to encryption.</p>
<p>Only letters are encrypted, not numbers or symbols.</p>
<p>If the number of shifts is 13, the result is the same as <a href="rot13">ROT13</a>.</p>

<p>Shifts characters while retaining the diacritic mark. So, for example, "Á" is encrypted to "X́".</p>


<h4>Other language support</h4>
<p>In addition to Latin letters, Cyrillic and Japanese Hiragana / Katakana are supported.</p>

<h5>Cyrillic</h5>
<p>If you want to shift the Cyrillic character by -3 characters, it will be encrypted as follows.</p>

<pre>Plain : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Cipher: ЭЮЯАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬ</pre>

<p>The diacritic mark shifts the character while holding it. So, for example, the Russian letter "Ё" is encrypted to "В̈". The characters "Й" and "й" are treated as unique characters, not the characters "И" and "и" with the diacritical mark " ̆" (Breve).</p>

<h5>Japanese Hiragana / Katakana</h5>
<p>If you want to shift the Japanese Hiragana / Katakana character by -3 characters, it will be encrypted as follows.</p>

<pre>Plain : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Cipher: をんゔぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑ</pre>

<pre>Plain : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Cipher: ヲンヴァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱ</pre>

<p>The character order is the Unicode definition order. Please note that "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", and "ヺ" are not subject to encryption.</p>
