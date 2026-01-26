<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über die Caesar-Chiffre</h3>
<p>Die Caesar-Chiffre ist eine monoalphabetische Substitutionschiffre, bei der jeder Buchstabe eines Textes durch einen anderen ersetzt wird.</p>
<p>Die Ersetzung erfolgt durch eine Verschiebung der Buchstaben „A“ bis „Z“ innerhalb des Alphabets „ABCDEFGHIJKLMNOPQRSTUVWXYZ“.</p>
<p>Zum Beispiel, bei einer Verschiebung um -3 Zeichen wird „A“ zu „X“ und „Z“ zu „W“ verschlüsselt.</p>

<pre>
Klartext   : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Geheimtext : XYZABCDEFGHIJKLMNOPQRSTUVW
</pre>

<pre>
Klartext-Nachricht   : THIS IS A SECRET MESSAGE
Geheimtext-Nachricht : QEFP FP X PBZOBQ JBPPXDB
</pre>

<p>Die Anzahl der verschobenen Stellen ist der Schlüssel (Key) der Verschlüsselung.</p>
<p>Nur Buchstaben werden verschlüsselt; Zahlen und Symbole bleiben unverändert.</p>
<p>Bei einer Verschiebung um 13 entspricht das Ergebnis <a href="rot13">ROT13</a>.</p>

<p>Buchstaben werden unter Beibehaltung diakritischer Zeichen verschoben. So wird zum Beispiel „Á“ zu „X́“ verschlüsselt.</p>

<h4>Unterstützung anderer Sprachen</h4>
<p>Neben lateinischen Buchstaben werden auch Kyrillisch und japanisches Hiragana/Katakana unterstützt.</p>

<h5>Kyrillisch</h5>
<p>Wenn kyrillische Buchstaben um -3 Zeichen verschoben werden, sieht die Verschlüsselung wie folgt aus:</p>

<pre>
Klartext   : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Geheimtext : ЭЮЯАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬ
</pre>

<p>Buchstaben werden unter Beibehaltung diakritischer Zeichen verschoben. Zum Beispiel wird das russische „Ё“ zu „В̈“ verschlüsselt. Die Zeichen „Й“ und „й“ werden als eigenständige Zeichen behandelt und nicht als „И“ oder „и“ mit einem Breve „ ̆“.</p>

<h5>Japanisches Hiragana/Katakana</h5>
<p>Wenn japanisches Hiragana/Katakana um -3 Zeichen verschoben wird, sieht die Verschlüsselung wie folgt aus:</p>

<pre>
Klartext   : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Geheimtext : をんゔぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑ
</pre>

<pre>
Klartext   : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Geheimtext : ヲンヴァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱ
</pre>

<p>Die Reihenfolge der Zeichen entspricht der Unicode-Definition. Bitte beachten Sie, dass „ゕ“, „ゖ“, „ヵ“, „ヶ“ sowie „ヷ“, „ヸ“, „ヹ“, „ヺ“ nicht verschlüsselt werden.</p>
