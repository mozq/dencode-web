<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre ROT18</h3>
<p>ROT18 é um tipo de cifra de substituição monoalfabética que criptografa substituindo caracteres no texto por outros caracteres.</p>
<p>A substituição de caracteres é feita deslocando os caracteres de "A" a "Z" dentro dos 26 caracteres "ABCDEFGHIJKLMNOPQRSTUVWXYZ" em 13 caracteres. Além disso, os números de "0" a "9" são deslocados em 5 caracteres dentro dos 10 caracteres "0123456789".</p>
<p>Por exemplo, "A" é criptografado como "N" e "0" como "5".</p>

<pre>
Antes da Criptografia  : ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
Depois da Criptografia : NOPQRSTUVWXYZABCDEFGHIJKLM5678901234
</pre>

<pre>
Texto antes da Criptografia  : THIS IS A SECRET MESSAGE 123
Texto depois da Criptografia : GUVF VF N FRPERG ZRFFNTR 567
</pre>

<p>Existe uma reversibilidade onde criptografar o texto cifrado novamente produz o texto simples, então a descriptografia pode ser feita da mesma maneira que a criptografia.</p>
