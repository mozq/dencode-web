<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Scytale Cipher</h3>
<p>Scytale cipher is one of the transposition ciphers. Scytale means baton in Greek.</p>
<p>A strip of parchment is wrapped around the scytale and encrypted by writing characters across the parchment.</p>
<p>The encryption key is the number of characters that can be written in one round of the scytale. Alternatively, you can also specify the number of characters that can be written in one line (the number of times parchment is wrapped).</p>

<p>For example, when "THIS_IS_A_SECRET_MESSAGE" is encrypted with 4 characters per one round of the scytale, it is as follows.</p>

<p>1. Place the characters across the strip of parchment.</p>
<pre>
-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------
</pre>

<p>2. It is encrypted by unwinding the parchment from the scytale.</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>
