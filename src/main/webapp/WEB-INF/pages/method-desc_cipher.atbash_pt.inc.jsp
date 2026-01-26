<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre a Cifra Atbash</h3>
<p>A Cifra Atbash é um tipo de cifra de substituição monoalfabética que criptografa substituindo caracteres no texto por outros caracteres.</p>
<p>A substituição de caracteres é feita mapeando a lista de caracteres na ordem inversa.</p>
<p>Por exemplo, no caso do alfabeto "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "A" é criptografado como "Z" e "B" como "Y".</p>

<pre>
Antes da Criptografia  : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Depois da Criptografia : ZYXWVUTSRQPONMLKJIHGFEDCBA
</pre>

<pre>
Texto antes da Criptografia  : THIS IS A SECRET MESSAGE
Texto depois da Criptografia : GSRH RH Z HVXIVG NVHHZTV
</pre>

<p>Originalmente, era usada como uma cifra para o hebraico. A criptografia hebraica é a seguinte:</p>

<pre>
Antes da Criptografia  : אבגדהוזחטיכלמנסעפצקרשת
Depois da Criptografia : תשרקצפעסנמלכיטחזוהדגבא
</pre>

<p>Existe uma reversibilidade onde criptografar o texto cifrado novamente produz o texto simples, então a descriptografia pode ser feita da mesma maneira que a criptografia.</p>


<h4>Suporte a outros idiomas</h4>
<p>Além dos caracteres latinos e hebraico, caracteres cirílicos e Hiragana/Katakana japoneses são suportados.</p>

<h5>Cirílico</h5>
<pre>
Antes da Criptografia  : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Depois da Criptografia : ЯЮЭЬЫЪЩШЧЦХФУТСРПОНМЛКЙИЗЖЕДГВБА
</pre>

<h5>Hiragana / Katakana Japonês</h5>
<pre>
Antes da Criptografia  : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Depois da Criptografia : ゔんをゑゐわゎろれるりらよょゆゅやゃもめむみまぽぼほぺべへぷぶふぴびひぱばはのねぬになどとでてづつっぢちだたぞそぜせずすじしざさごこげけぐくぎきがかおぉえぇうぅいぃあぁ
</pre>

<pre>
Antes da Criptografia  : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Depois da Criptografia : ヴンヲヱヰワヮロレルリラヨョユュヤャモメムミマポボホペベヘプブフピビヒパバハノネヌニナドトデテヅツッヂチダタゾソゼセズスジシザサゴコゲケグクギキガカオォエェウゥイィアァ
</pre>

<p>A ordem dos caracteres é baseada na definição Unicode. Note que "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", e "ヺ" não estão sujeitos a criptografia.</p>
