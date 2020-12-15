<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Caesar Cipher</h3>
<p>Caesar cipher is one of the single transliteration ciphers that encrypts by replacing the characters in the text with other characters.</p>
<p>Character replacement is performed by shifting the characters from "A" to "Z" to the left or right among the 26 characters of "ABCDEFGHIJKLMNOPQRSTUVWXYZ".</p>
<p>For example, when shifting 3 characters to the left, "A" is encrypted to "D" and "Z" is encrypted to "C".</p>

<pre>Plain : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Cipher: DEFGHIJKLMNOPQRSTUVWXYZABC</pre>

<pre>Plain text : THIS IS A SECRET MESSAGE
Cipher text: WKLV LV D VHFUHW PHVVDJH</pre>

<p>The number of shifts is the key to encryption.</p>
<p>Only letters are encrypted, not numbers or symbols.</p>
<p>If the number of shifts is 13, the result is the same as <a href="rot13">ROT13</a>.</p>

<p>Shifts characters while retaining the diacritic mark. So, for example, "Á" is encrypted to "D́".</p>


<h4>Other language support</h4>
<p>In addition to Latin letters, it supports Cyrillic letters.</p>

<p>If you want to shift the Cyrillic character to the left by 3 characters, it will be encrypted as follows.</p>

<pre>Plain : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Cipher: ГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯАБВ</pre>

<p>The diacritic mark shifts the character while holding it. So, for example, the Russian letter "Ё" is encrypted to "Ӥ". The characters "Й" and "й" are treated as unique characters, not the characters "И" and "и" with the diacritical mark " ̆" (Breve).</p>
