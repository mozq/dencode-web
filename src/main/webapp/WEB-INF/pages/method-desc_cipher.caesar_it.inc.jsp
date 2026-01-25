<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sul Cifrario di Cesare</h3>
<p>Il Cifrario di Cesare è un tipo di cifrario a sostituzione monoalfabetica che crittografa sostituendo i caratteri del testo con altri caratteri.</p>
<p>La sostituzione dei caratteri viene eseguita spostando (shift) i caratteri da "A" a "Z" tra le 26 lettere di "ABCDEFGHIJKLMNOPQRSTUVWXYZ".</p>
<p>Ad esempio, se si sposta di -3 caratteri, "A" viene cifrato in "X" e "Z" in "W".</p>

<pre>Prima: ABCDEFGHIJKLMNOPQRSTUVWXYZ
Dopo : XYZABCDEFGHIJKLMNOPQRSTUVW</pre>

<pre>Testo in chiaro: THIS IS A SECRET MESSAGE
Testo cifrato  : QEFP FP X PBZOBQ JBPPXDB</pre>

<p>Il numero di spostamenti è la chiave di crittografia.</p>
<p>Vengono cifrate solo le lettere, non numeri o simboli.</p>
<p>Se il numero di spostamenti è 13, il risultato è lo stesso di <a href="rot13">ROT13</a>.</p>

<p>Sposta i caratteri mantenendo i segni diacritici. Quindi, ad esempio, "Á" viene cifrato in "X́".</p>


<h4>Supporto per altre lingue</h4>
<p>Oltre ai caratteri latini, sono supportati i caratteri cirillici e i caratteri giapponesi Hiragana/Katakana.</p>

<h5>Cirillico</h5>
<p>Se si spostano i caratteri cirillici di -3 caratteri, vengono cifrati come segue.</p>

<pre>Prima: АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Dopo : ЭЮЯАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬ</pre>

<p>Sposta i caratteri mantenendo i segni diacritici. Quindi, ad esempio, il carattere russo "Ё" viene cifrato in "В̈". I caratteri "Й" e "й" sono trattati come caratteri unici, non come caratteri "И" e "и" con il segno diacritico " ̆" (Breve).</p>

<h5>Giapponese Hiragana/Katakana</h5>
<p>Se si spostano i caratteri giapponesi Hiragana/Katakana di -3 caratteri, vengono cifrati come segue.</p>

<pre>Prima: ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Dopo : をんゔぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑ</pre>

<pre>Prima: ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Dopo : ヲンヴァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱ</pre>

<p>L'ordine dei caratteri è quello definito in Unicode. Si noti che "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", e "ヺ" non sono soggetti a crittografia.</p>
