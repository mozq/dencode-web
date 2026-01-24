<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre el Cifrado Atbash</h3>
<p>El Cifrado Atbash es un tipo de cifrado de sustitución monoalfabética que encripta reemplazando caracteres en un texto con otros caracteres.</p>
<p>La sustitución de caracteres se realiza invirtiendo la lista de caracteres.</p>
<p>Por ejemplo, en el caso de las letras "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "A" se cifra como "Z" y "B" como "Y".</p>

<pre>Antes:   ABCDEFGHIJKLMNOPQRSTUVWXYZ
Después: ZYXWVUTSRQPONMLKJIHGFEDCBA</pre>

<pre>Texto antes:   THIS IS A SECRET MESSAGE
Texto después: GSRH RH Z HVXIVG NVHHZTV</pre>

<p>Originalmente se usaba como un cifrado para el hebreo. El cifrado hebreo es el siguiente:</p>

<pre>Antes:   אבגדהוזחטיכלמנסעפצקרשת
Después: תשרקצפעסנמלכיטחזוהדגבא</pre>

<p>Debido a la propiedad de reversibilidad donde cifrar el texto cifrado nuevamente produce el texto plano, el descifrado se puede realizar de la misma manera que el cifrado.</p>


<h4>Soporte para otros idiomas</h4>
<p>Además del alfabeto latino y hebreo, se soportan el alfabeto cirílico y Hiragana/Katakana japonés.</p>

<h5>Cirílico</h5>
<pre>Antes:   АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Después: ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА</pre>

<h5>Hiragana/Katakana Japonés</h5>
<pre>Antes:   ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Después: ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ</pre>

<pre>Antes:   ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Después: ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ</pre>

<p>El orden de los caracteres se basa en el orden de definición de Unicode. Tenga en cuenta que "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", y "ヺ" no están sujetos a cifrado.</p>
