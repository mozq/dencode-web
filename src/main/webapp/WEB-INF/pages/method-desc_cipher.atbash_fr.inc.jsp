<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du chiffre Atbash</h3>
<p>Le chiffre Atbash est l'un des chiffres de substitution monoalphabétique qui chiffre en remplaçant les caractères du texte par d'autres caractères.</p>
<p>Le remplacement des caractères est effectué en mappant la liste des caractères dans l'ordre inverse.</p>
<p>Par exemple, pour l'alphabet "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "A" est chiffré en "Z" et "B" en "Y".</p>

<pre>Texte clair  : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Texte chiffré: ZYXWVUTSRQPONMLKJIHGFEDCBA</pre>

<pre>Texte clair  : THIS IS A SECRET MESSAGE
Texte chiffré: GSRH RH Z HVXIVG NVHHZTV</pre>

<p>Il était à l'origine utilisé comme chiffre hébreu. Le chiffrement hébreu est le suivant.</p>

<pre>Texte clair  : אבגדהוזחטיכלמנסעפצקרשת
Texte chiffré: תשרקצפעסנמלכיטחזוהדגבא</pre>

<p>Puisqu'il existe une réciprocité permettant d'obtenir le texte clair en chiffrant à nouveau le texte chiffré, le déchiffrement peut être effectué dans le même flux que le chiffrement.</p>


<h4>Support d'autres langues</h4>
<p>En plus des lettres latines et hébraïques, le cyrillique et les Hiragana / Katakana japonais sont supportés.</p>

<h5>Cyrillique</h5>
<pre>Texte clair  : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Texte chiffré: ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА</pre>

<h5>Hiragana / Katakana japonais</h5>
<pre>Texte clair  : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Texte chiffré: ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ</pre>

<pre>Texte clair  : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Texte chiffré: ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ</pre>

<p>L'ordre des caractères est l'ordre de définition Unicode. Veuillez noter que «ゕ», «ゖ», «ヵ», «ヶ», «ヷ», «ヸ», «ヹ», et «ヺ» ne sont pas sujets au chiffrement.</p>
