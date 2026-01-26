<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über ROT18</h3>
<p>ROT18 ist eine monoalphabetische Substitutionschiffre, bei der jeder Buchstabe eines Textes durch einen anderen ersetzt wird.</p>
<p>Die Ersetzung erfolgt, indem die Buchstaben „A“ bis „Z“ um 13 Stellen im Alphabet „ABCDEFGHIJKLMNOPQRSTUVWXYZ“ verschoben werden. Zusätzlich werden die Ziffern „0“ bis „9“ um 5 Stellen innerhalb von „0123456789“ verschoben.</p>
<p>Zum Beispiel wird „A“ zu „N“ und „0“ zu „5“ verschlüsselt.</p>

<pre>
Klartext   : ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
Geheimtext : NOPQRSTUVWXYZABCDEFGHIJKLM5678901234
</pre>

<pre>
Klartext-Nachricht   : THIS IS A SECRET MESSAGE 123
Geheimtext-Nachricht : GUVF VF N FRPERG ZRFFNTR 567
</pre>

<p>Da die erneute Verschlüsselung des Geheimtextes wieder den Klartext ergibt (Reziprozität), kann die Entschlüsselung auf demselben Weg wie die Verschlüsselung erfolgen.</p>
