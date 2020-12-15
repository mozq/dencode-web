<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About ROT18</h3>
<p>ROT18 is one of the single transliteration ciphers that encrypts by replacing the characters in the text with other characters.</p>
<p>Character replacement is performed by shifting the characters from "A" to "Z" by 13 characters out of the 26 characters of "ABCDEFGHIJKLMNOPQRSTUVWXYZ". Also, the numbers "0" to "9" are shifted by 5 characters out of the 10 characters of "0123456789".</p>
<p>For example, "A" is encrypted to "N" and "0" is encrypted to "5".</p>

<pre>Plain : ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
Cipher: NOPQRSTUVWXYZABCDEFGHIJKLM5678901234</pre>

<pre>Plain text : THIS IS A SECRET MESSAGE 123
Cipher text: GUVF VF N FRPERG ZRFFNTR 567</pre>
