<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Sandi Caesar</h3>
<p>Sandi Caesar adalah salah satu sandi substitusi tunggal yang mengenkripsi dengan mengganti karakter dalam teks dengan karakter lain.</p>
<p>Substitusi karakter dilakukan dengan menggeser karakter "A" hingga "Z" di dalam 26 karakter "ABCDEFGHIJKLMNOPQRSTUVWXYZ".</p>
<p>Misalnya, saat menggeser -3 karakter, "A" dienkripsi menjadi "X" dan "Z" menjadi "W".</p>

<pre>Sebelum: ABCDEFGHIJKLMNOPQRSTUVWXYZ
Sesudah: XYZABCDEFGHIJKLMNOPQRSTUVW</pre>

<pre>Teks asli : THIS IS A SECRET MESSAGE
Teks sandi: QEFP FP X PBZOBQ JBPPXDB</pre>

<p>Jumlah pergeseran menjadi kunci sandi.</p>
<p>Hanya huruf yang dienkripsi; angka dan simbol tidak dienkripsi.</p>
<p>Jika jumlah pergeseran adalah 13, hasilnya sama dengan <a href="rot13">ROT13</a>.</p>

<p>Karakter digeser sambil mempertahankan tanda diakritik. Oleh karena itu, misalnya, "Á" dienkripsi menjadi "X́".</p>


<h4>Dukungan Bahasa Lain</h4>
<p>Selain huruf Latin, huruf Sirilik dan Hiragana/Katakana Jepang juga didukung.</p>

<h5>Huruf Sirilik</h5>
<p>Jika huruf Sirilik digeser -3 karakter, enkripsi dilakukan sebagai berikut.</p>

<pre>Sebelum: АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Sesudah: ЭЮЯАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬ</pre>

<p>Karakter digeser sambil mempertahankan tanda diakritik. Oleh karena itu, misalnya, "Ё" dalam bahasa Rusia dienkripsi menjadi "В̈". Karakter "Й" dan "й" diperlakukan sebagai karakter unik, bukan "И" dan "и" dengan tanda diakritik " ̆" (Breve).</p>

<h5>Hiragana/Katakana Jepang</h5>
<p>Jika Hiragana/Katakana Jepang digeser -3 karakter, enkripsi dilakukan sebagai berikut.</p>

<pre>Sebelum: ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Sesudah: をんゔぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑ</pre>

<pre>Sebelum: ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Sesudah: ヲンヴァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱ</pre>

<p>Urutan karakter didasarkan pada urutan definisi di Unicode. Harap dicatat bahwa "ゕ", "ゖ", "ヵ", "ヶ" dan "ヷ", "ヸ", "ヹ", "ヺ" tidak dikenakan enkripsi.</p>
