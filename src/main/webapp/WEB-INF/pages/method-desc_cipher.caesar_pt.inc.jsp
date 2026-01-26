<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre a Cifra de César</h3>
<p>A Cifra de César é um tipo de cifra de substituição monoalfabética que criptografa substituindo caracteres no texto por outros caracteres.</p>
<p>A substituição de caracteres é feita deslocando os caracteres de "A" a "Z" dentro dos 26 caracteres "ABCDEFGHIJKLMNOPQRSTUVWXYZ".</p>
<p>Por exemplo, se deslocar -3 caracteres, "A" é criptografado para "X" e "Z" para "W".</p>

<pre>
Antes da Criptografia  : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Depois da Criptografia : XYZABCDEFGHIJKLMNOPQRSTUVW
</pre>

<pre>
Texto antes da Criptografia  : THIS IS A SECRET MESSAGE
Texto depois da Criptografia : QEFP FP X PBZOBQ JBPPXDB
</pre>

<p>O número de deslocamentos torna-se a chave da cifra.</p>
<p>Apenas letras são criptografadas; números e símbolos não são criptografados.</p>
<p>Se o número de deslocamentos for 13, o resultado é o mesmo que <a href="rot13">ROT13</a>.</p>

<p>Os caracteres são deslocados mantendo as marcas diacríticas. Portanto, por exemplo, "Á" é criptografado como "X́".</p>


<h4>Suporte a outros idiomas</h4>
<p>Além dos caracteres latinos, caracteres cirílicos e Hiragana/Katakana japoneses são suportados.</p>

<h5>Cirílico</h5>
<p>Se deslocar caracteres cirílicos por -3 caracteres, eles serão criptografados da seguinte forma:</p>

<pre>
Antes da Criptografia  : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Depois da Criptografia : ЭЮЯАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬ
</pre>

<p>Os caracteres são deslocados mantendo as marcas diacríticas. Portanto, por exemplo, "Ё" em russo é criptografado como "В̈". Os caracteres "Й" e "й" são tratados como caracteres únicos, não como "И" e "и" com uma marca diacrítica " ̆" (Breve).</p>

<h5>Hiragana / Katakana Japonês</h5>
<p>Se deslocar Hiragana/Katakana japoneses por -3 caracteres, eles serão criptografados da seguinte forma:</p>

<pre>
Antes da Criptografia  : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Depois da Criptografia : をんゔぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑ
</pre>

<pre>
Antes da Criptografia  : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Depois da Criptografia : ヲンヴァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱ
</pre>

<p>A ordem dos caracteres é baseada na definição Unicode. Note que "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", e "ヺ" não estão sujeitos a criptografia.</p>
