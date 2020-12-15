<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Scytale Cipher</h3>
<p>Scytale cipher is one of the transposition ciphers. Scytale means baton in Greek.</p>
<p>A strip of parchment is wrapped around the scytale and encrypted by writing characters across the parchment.</p>
<p>The encryption key is the number of turns the parchment is wrapped around the scytale (the maximum number of characters that can be written on one line).</p>

<p>For example, when "THIS_IS_A_SECRET_MESSAGE" is encrypted with 6 turns the parchment, it is as follows.</p>

<p>1. Place the characters across the strip of parchment. Since the number of turns is 6, we will write 6 characters per line.</p>
<pre>-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------</pre>

<p>2. It is encrypted by unwinding the parchment from the scytale.</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>
