<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Atbash Cipher</h3>
<p>Atbash cipher is one of the single transliteration ciphers that encrypts by replacing the characters in the text with other characters.</p>
<p>Character replacement is done by mapping the list of characters in reverse order.</p>
<p>For example, in the alphabet "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "A" is encrypted to "Z" and "B" to "Y".</p>

<pre>Plain : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Cipher: ZYXWVUTSRQPONMLKJIHGFEDCBA</pre>

<pre>Plain text : THIS IS A SECRET MESSAGE
Cipher text: GSRH RH Z HVXIVG NVHHZTV</pre>

<p>It was originally used as a Hebrew cipher. The Hebrew encryption is as follows.</p>

<pre>Plain : אבגדהוזחטיכלמנסעפצקרשת
Cipher: תשרקצפעסנמלכיטחזוהדגבא</pre>

<p>Since there is reciprocity that plaintext can be obtained by encrypting ciphertext again, decryption can be done in the same flow as encryption.</p>


<h4>Other language support</h4>
<p>In addition to Latin and Hebrew letters, Cyrillic and Japanese Hiragana / Katakana are supported.</p>

<h5>Cyrillic</h5>
<pre>Plain : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Cipher: ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА</pre>

<h5>Japanese Hiragana / Katakana</h5>
<pre>Plain : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Cipher: ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ</pre>

<pre>Plain : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Cipher: ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ</pre>

<p>The character order is the Unicode definition order. Please note that "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", and "ヺ" are not subject to encryption.</p>
