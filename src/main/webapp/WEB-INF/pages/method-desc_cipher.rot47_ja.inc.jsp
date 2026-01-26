<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>ROT47について</h3>
<p>ROT47は、文章の文字を他の文字に置換することで暗号化する単一換字式暗号のひとつです。</p>
<p>文字の置換は、「!」から「~」までの文字を「!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~」の94文字の中で47文字シフトさせることで行います。</p>
<p>例えば、「!」は「P」、「A」は「p」、「0」は「_」に暗号化されます。</p>

<pre>
暗号化前 : !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
暗号化後 : PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO
</pre>

<pre>
暗号化前の文章 : THIS IS A SECRET MESSAGE 123!
暗号化後の文章 : %wx$ x$ p $tr#t% |t$$pvt `abP
</pre>

<p>暗号文を再度暗号化すると平文が得られるという反転性があるため、暗号化と同じ流れで復号化もできます。</p>
