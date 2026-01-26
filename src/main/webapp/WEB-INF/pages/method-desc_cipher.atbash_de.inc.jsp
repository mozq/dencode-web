<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über die Atbash-Chiffre</h3>
<p>Die Atbash-Chiffre ist eine monoalphabetische Substitutionschiffre, bei der das Alphabet umgedreht wird.</p>
<p>Die Substitution erfolgt, indem das Alphabet in umgekehrter Reihenfolge abgebildet wird.</p>
<p>Zum Beispiel bei den Buchstaben „ABCDEFGHIJKLMNOPQRSTUVWXYZ“ wird „A“ zu „Z“ und „B“ zu „Y“ verschlüsselt.</p>

<pre>
Klartext   : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Geheimtext : ZYXWVUTSRQPONMLKJIHGFEDCBA
</pre>

<pre>
Klartext-Nachricht   : THIS IS A SECRET MESSAGE
Geheimtext-Nachricht : GSRH RH Z HVXIVG NVHHZTV
</pre>

<p>Ursprünglich wurde sie als Chiffre für die hebräische Sprache verwendet. Die Verschlüsselung im Hebräischen sieht wie folgt aus:</p>

<pre>
Klartext   : אבגדהוזחטיכלמנסעפצקרשת
Geheimtext : תשרקצפעסנמלכיטחזוהדגבא
</pre>

<p>Da die erneute Verschlüsselung des Geheimtextes wieder den Klartext ergibt (Reziprozität), kann die Entschlüsselung auf demselben Weg wie die Verschlüsselung erfolgen.</p>

<h4>Unterstützung anderer Sprachen</h4>
<p>Neben lateinischen Buchstaben und Hebräisch werden auch Kyrillisch und japanisches Hiragana/Katakana unterstützt.</p>

<h5>Kyrillisch</h5>
<pre>
Klartext   : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Geheimtext : ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА
</pre>

<h5>Japanisches Hiragana/Katakana</h5>
<pre>
Klartext   : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Geheimtext : ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ
</pre>

<pre>
Klartext   : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Geheimtext : ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ
</pre>

<p>Die Reihenfolge der Zeichen entspricht der Unicode-Definition. Bitte beachten Sie, dass „ゕ“, „ゖ“, „ヵ“, „ヶ“ sowie „ヷ“, „ヸ“, „ヹ“, „ヺ“ nicht verschlüsselt werden.</p>
