<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über ROT47</h3>
<p>ROT47 ist eine Substitutionschiffre, die Zeichen durch andere ersetzt.</p>
<p>Die Substitution erfolgt, indem die ASCII-Zeichen von „!“ bis „~“ (insgesamt 94 Zeichen) um 47 Positionen rotiert werden.</p>
<p>Dabei wird beispielsweise „!“ zu „P“, „A“ zu „p“ und „0“ zu „_“.</p>

<pre>
Klartext  : !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
Geheimtext: PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO
</pre>

<pre>
Klartext-Nachricht   : THIS IS A SECRET MESSAGE 123!
Geheimtext-Nachricht : %wx$ x$ p $tr#t% |t$$pvt `abP
</pre>

<p>Da die erneute Verschlüsselung des Geheimtextes wieder den Klartext ergibt (Reziprozität), kann die Entschlüsselung auf demselben Weg wie die Verschlüsselung erfolgen.</p>
