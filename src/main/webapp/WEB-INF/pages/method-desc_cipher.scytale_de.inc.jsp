<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über die Skytale-Chiffre</h3>
<p>Die Skytale-Chiffre ist eine Transpositionschiffre. Skytale ist griechisch und bedeutet Stab.</p>
<p>Zur Verschlüsselung wird ein Streifen Pergament um einen Stab (Skytale) gewickelt und die Nachricht quer über den Stab geschrieben.</p>
<p>Der Schlüssel ist die Anzahl der Buchstaben, die auf eine Umdrehung des Stabes passen (oder die Anzahl der Zeilen).</p>

<p>Beispiel: Verschlüsselung von „THIS_IS_A_SECRET_MESSAGE“ mit einem Stabumfang von 4 Buchstaben.</p>

<p>1. Den Text quer über den aufgewickelten Streifen schreiben. Bei 4 Buchstaben pro Umfang und 24 Buchstaben Textlänge ergeben sich 6 Spalten.</p>
<pre>
-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------
</pre>

<p>2. Wenn man den Streifen vom Stab abwickelt, erhält man den verschlüsselten Text.</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>
