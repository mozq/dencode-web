<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Rail Fence Cipher</h3>
<p>Rail fence cipher is a transposition cipher.</p>
<p>Characters are arranged in a zigzag pattern on the rail of the fence, and finally, characters are concatenated in rails for encryption.</p>
<p>The encryption key is a number of rails.</p>

<p>For example, when "THIS_IS_A_SECRET_MESSAGE" is encrypted with 4 rails, it is as follows.</p>

<p>1. Prepare four rails (height 4) and arrange the characters in zigzag from the upper left.</p>
<pre>
-----------------------------------------------
T           S           C           E          
-----------------------------------------------
  H       I   _       E   R       M   S       E
-----------------------------------------------
    I   _       A   S       E   _       S   G  
-----------------------------------------------
      S           _           T           A    
-----------------------------------------------
</pre>

<p>2. Get the placed characters in each rail.</p>
<pre>
TSCE
HI_ERMSE
I_ASE_SG
S_TA
</pre>

<p>3. Concatenated the rail characters.</p>
<pre>TSCEHI_ERMSEI_ASE_SGS_TA</pre>
