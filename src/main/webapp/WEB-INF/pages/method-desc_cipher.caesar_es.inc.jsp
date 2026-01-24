<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre el Cifrado César</h3>
<p>El Cifrado César es un tipo de cifrado de sustitución monoalfabética que encripta reemplazando caracteres en un texto con otros caracteres.</p>
<p>La sustitución de caracteres se realiza desplazando las letras "A" a "Z" dentro de los 26 caracteres "ABCDEFGHIJKLMNOPQRSTUVWXYZ".</p>
<p>Por ejemplo, si se desplaza -3 caracteres, "A" se cifra como "X" y "Z" como "W".</p>

<pre>Antes:   ABCDEFGHIJKLMNOPQRSTUVWXYZ
Después: XYZABCDEFGHIJKLMNOPQRSTUVW</pre>

<pre>Texto antes:   THIS IS A SECRET MESSAGE
Texto después: QEFP FP X PBZOBQ JBPPXDB</pre>

<p>El número de desplazamiento es la clave de cifrado.</p>
<p>Solo se cifran las letras inglesas, no se cifran números ni símbolos.</p>
<p>Si el número de desplazamiento es 13, el resultado es el mismo que <a href="rot13">ROT13</a>.</p>

<p>Los caracteres se desplazan manteniendo sus signos diacríticos. Por lo tanto, por ejemplo, "Á" se cifra como "X́".</p>


<h4>Soporte para otros idiomas</h4>
<p>Además del alfabeto latino, se soportan el alfabeto cirílico y Hiragana/Katakana japonés.</p>

<h5>Cirílico</h5>
<p>Si se desplazan -3 caracteres en cirílico, se cifra de la siguiente manera:</p>

<pre>Antes:   АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Después: ЭЮЯАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬ</pre>

<p>Los caracteres se desplazan manteniendo sus signos diacríticos. Por lo tanto, por ejemplo, "Ё" en ruso se cifra como "В̈". Tenga en cuenta que "Й" y "й" se tratan como caracteres únicos, no como "И" e "и" con un signo diacrítico " ̆" (Breve).</p>

<h5>Hiragana/Katakana Japonés</h5>
<p>Si se desplazan -3 caracteres en Hiragana/Katakana japonés, se cifra de la siguiente manera:</p>

<pre>Antes:   ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Después: をんゔぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑ</pre>

<pre>Antes:   ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Después: ヲンヴァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱ</pre>

<p>El orden de los caracteres se basa en el orden de definición de Unicode. Tenga en cuenta que "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", y "ヺ" no están sujetos a cifrado.</p>
