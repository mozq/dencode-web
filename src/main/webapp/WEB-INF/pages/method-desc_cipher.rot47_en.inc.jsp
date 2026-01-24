<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About ROT47</h3>
<p>ROT47 is one of the monoalphabetic substitution ciphers that encrypts by replacing the characters in the text with other characters.</p>
<p>Character replacement is performed by shifting the characters from "!" to "~" by 47 characters out of the 94 characters of "!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~".</p>
<p>For example, "!" is encrypted to "P", "A" is encrypted to "p" and "0" is encrypted to "_".</p>

<pre>Plain : !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
Cipher: PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO</pre>

<pre>Plain text : THIS IS A SECRET MESSAGE 123!
Cipher text: %wx$ x$ p $tr#t% |t$$pvt `abP</pre>

<p>Since there is reciprocity that plaintext can be obtained by encrypting ciphertext again, decryption can be done in the same flow as encryption.</p>
