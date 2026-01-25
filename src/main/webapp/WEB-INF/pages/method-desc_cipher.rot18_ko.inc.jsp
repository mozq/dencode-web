<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>ROT18에 대해서</h3>
<p>ROT18은 문장의 문자를 다른 문자로 치환하여 암호화하는 단일 환자 암호 중 하나입니다.</p>
<p>문자 치환은 'A'부터 'Z'까지의 문자를 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'의 26문자 중에서 13문자 시프트시키는 것으로 수행합니다. 또한 숫자 '0'부터 '9'는 '0123456789'의 10문자 중에서 5문자 시프트시킵니다.</p>
<p>예를 들어, 'A'는 'N', '0'은 '5'로 암호화됩니다.</p>

<pre>암호화 전: ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
암호화 후: NOPQRSTUVWXYZABCDEFGHIJKLM5678901234</pre>

<pre>암호화 전 문장: THIS IS A SECRET MESSAGE 123
암호화 후 문장: GUVF VF N FRPERG ZRFFNTR 567</pre>

<p>암호문을 다시 암호화하면 평문이 얻어지는 반전성이 있기 때문에, 암호화와 같은 흐름으로 복호화도 가능합니다.</p>
