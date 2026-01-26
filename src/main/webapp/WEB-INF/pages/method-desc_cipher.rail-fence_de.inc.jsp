<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über die Rail Fence-Chiffre</h3>
<p>Die Rail Fence-Chiffre (Gartenzaun-Verschlüsselung) ist eine Transpositionschiffre, die die Reihenfolge der Buchstaben in einer Nachricht ändert.</p>
<p>Dabei wird der Text in einem Zickzack-Muster über mehrere „Schienen“ (Rails) geschrieben und dann Zeile für Zeile ausgelesen.</p>
<p>Die Anzahl der Schienen ist der Schlüssel der Verschlüsselung.</p>

<p>Beispiel: Verschlüsselung von „THIS_IS_A_SECRET_MESSAGE“ mit 4 Schienen.</p>

<p>1. 4 Schienen vorbereiten und den Text im Zickzack eintragen.</p>
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

<p>2. Die Zeichen Zeile für Zeile auslesen.</p>
<pre>
TSCE
HI_ERMSE
I_ASE_SG
S_TA
</pre>

<p>3. Die Zeilen aneinanderreihen.</p>
<pre>TSCEHI_ERMSEI_ASE_SGS_TA</pre>
