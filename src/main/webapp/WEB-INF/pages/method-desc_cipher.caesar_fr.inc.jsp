<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du chiffre de César</h3>
<p>Le chiffre de César est l'un des chiffres de substitution monoalphabétique qui chiffre en remplaçant les caractères du texte par d'autres caractères.</p>
<p>Le remplacement des caractères est effectué en décalant les caractères de "A" à "Z" parmi les 26 caractères de "ABCDEFGHIJKLMNOPQRSTUVWXYZ".</p>
<p>Par exemple, lors d'un décalage de -3 caractères, "A" est chiffré en "X" et "Z" est chiffré en "W".</p>

<pre>Texte clair  : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Texte chiffré: XYZABCDEFGHIJKLMNOPQRSTUVW</pre>

<pre>Texte clair  : THIS IS A SECRET MESSAGE
Texte chiffré: QEFP FP X PBZOBQ JBPPXDB</pre>

<p>Le nombre de décalages est la clé du chiffrement.</p>
<p>Seules les lettres sont chiffrées, pas les chiffres ou les symboles.</p>
<p>Si le nombre de décalages est de 13, le résultat est le même que <a href="rot13">ROT13</a>.</p>

<p>Décale les caractères tout en conservant le signe diacritique. Ainsi, par exemple, "Á" est chiffré en "X́".</p>


<h4>Support d'autres langues</h4>
<p>En plus des lettres latines, le cyrillique et les Hiragana / Katakana japonais sont supportés.</p>

<h5>Cyrillique</h5>
<p>Si vous souhaitez décaler le caractère cyrillique de -3 caractères, il sera chiffré comme suit.</p>

<pre>Texte clair  : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Texte chiffré: ЭЮЯАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬ</pre>

<p>Le signe diacritique décale le caractère tout en le maintenant. Ainsi, par exemple, la lettre russe "Ё" est chiffrée en "В̈". Les caractères "Й" et "й" sont traités comme des caractères uniques, et non comme les caractères "И" et "и" avec le signe diacritique " ̆" (brève).</p>

<h5>Hiragana / Katakana japonais</h5>
<p>Si vous souhaitez décaler le caractère Hiragana / Katakana japonais de -3 caractères, il sera chiffré comme suit.</p>

<pre>Texte clair  : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Texte chiffré: をんゔぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑ</pre>

<pre>Texte clair  : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Texte chiffré: ヲンヴァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱ</pre>

<p>L'ordre des caractères est l'ordre de définition Unicode. Veuillez noter que «ゕ», «ゖ», «ヵ», «ヶ», «ヷ», «ヸ», «ヹ», et «ヺ» ne sont pas sujets au chiffrement.</p>
