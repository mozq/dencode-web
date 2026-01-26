<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Sandi Atbash</h3>
<p>Sandi Atbash adalah salah satu sandi substitusi tunggal yang mengenkripsi dengan mengganti karakter dalam teks dengan karakter lain.</p>
<p>Substitusi karakter dilakukan dengan memetakan daftar karakter dalam urutan terbalik.</p>
<p>Misalnya, dalam kasus alfabet "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "A" dienkrpsi menjadi "Z", dan "B" menjadi "Y".</p>

<pre>
Sebelum : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Sesudah : ZYXWVUTSRQPONMLKJIHGFEDCBA
</pre>

<pre>
Teks asli  : THIS IS A SECRET MESSAGE
Teks sandi : GSRH RH Z HVXIVG NVHHZTV
</pre>

<p>Awalnya digunakan sebagai sandi Ibrani. Enkripsi Ibrani adalah sebagai berikut.</p>

<pre>
Sebelum : אבגדהוזחטיכלמנסעפצקרשת
Sesudah : תשרקצפעסנמלכיטחזוהדגבא
</pre>

<p>Karena membalikkan teks sandi lagi akan menghasilkan teks asli, dekripsi dapat dilakukan dengan alur yang sama seperti enkripsi.</p>


<h4>Dukungan Bahasa Lain</h4>
<p>Selain huruf Latin dan Ibrani, huruf Sirilik dan Hiragana/Katakana Jepang juga didukung.</p>

<h5>Huruf Sirilik</h5>
<pre>
Sebelum : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Sesudah : ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА
</pre>

<h5>Hiragana/Katakana Jepang</h5>
<pre>
Sebelum : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Sesudah : ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ
</pre>

<pre>
Sebelum : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Sesudah : ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ
</pre>

<p>Urutan karakter didasarkan pada urutan definisi di Unicode. Harap dicatat bahwa "ゕ", "ゖ", "ヵ", "ヶ" dan "ヷ", "ヸ", "ヹ", "ヺ" tidak dikenakan enkripsi.</p>
