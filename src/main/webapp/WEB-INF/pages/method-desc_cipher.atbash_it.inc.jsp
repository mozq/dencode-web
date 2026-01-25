<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sul Cifrario Atbash</h3>
<p>Il Cifrario Atbash è un tipo di cifrario a sostituzione monoalfabetica che crittografa sostituendo i caratteri del testo con altri caratteri.</p>
<p>La sostituzione dei caratteri viene eseguita mappando l'elenco dei caratteri in ordine inverso.</p>
<p>Ad esempio, nel caso delle lettere dell'alfabeto "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "A" viene cifrato in "Z", "B" in "Y".</p>

<pre>Prima: ABCDEFGHIJKLMNOPQRSTUVWXYZ
Dopo : ZYXWVUTSRQPONMLKJIHGFEDCBA</pre>

<pre>Testo in chiaro: THIS IS A SECRET MESSAGE
Testo cifrato  : GSRH RH Z HVXIVG NVHHZTV</pre>

<p>Originariamente era usato come cifrario ebraico. La crittografia ebraica è la seguente:</p>

<pre>Prima: אבגדהוזחטיכלמנסעפצקרשת
Dopo : תשרקצפעסנמלכיטחזוהדגבא</pre>

<p>Poiché ha la proprietà di reversibilità per cui cifrando nuovamente il testo cifrato si ottiene il testo in chiaro, la decrittografia può essere eseguita con lo stesso procedimento della crittografia.</p>


<h4>Supporto per altre lingue</h4>
<p>Oltre ai caratteri latini ed ebraici, sono supportati i caratteri cirillici e i caratteri giapponesi Hiragana/Katakana.</p>

<h5>Cirillico</h5>
<pre>Prima: АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Dopo : ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА</pre>

<h5>Giapponese Hiragana/Katakana</h5>
<pre>Prima: ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Dopo : ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ</pre>

<pre>Prima: ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Dopo : ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ</pre>

<p>L'ordine dei caratteri è quello definito in Unicode. Si noti che "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", e "ヺ" non sono soggetti a crittografia.</p>
