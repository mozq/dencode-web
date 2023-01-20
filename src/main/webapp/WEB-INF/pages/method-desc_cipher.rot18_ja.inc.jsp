<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>ROT18について</h3>
<p>ROT18は、文章の文字を他の文字に置換することで暗号化する単一換字式暗号のひとつです。</p>
<p>文字の置換は、「A」から「Z」までの文字を「ABCDEFGHIJKLMNOPQRSTUVWXYZ」の26文字の中で13文字シフトさせることで行います。また、数字の「0」から「9」は「0123456789」の10文字の中で5文字シフトさせます。</p>
<p>例えば、「A」は「N」、「0」は「5」に暗号化されます。</p>

<pre>暗号化前: ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
暗号化後: NOPQRSTUVWXYZABCDEFGHIJKLM5678901234</pre>

<pre>暗号化前の文章: THIS IS A SECRET MESSAGE 123
暗号化後の文章: GUVF VF N FRPERG ZRFFNTR 567</pre>

<p>暗号文を再度暗号化すると平文が得られるという反転性があるため、暗号化と同じ流れで復号化もできます。</p>
