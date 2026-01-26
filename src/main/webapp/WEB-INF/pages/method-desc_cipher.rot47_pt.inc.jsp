<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre ROT47</h3>
<p>ROT47 é um tipo de cifra de substituição monoalfabética que criptografa substituindo caracteres no texto por outros caracteres.</p>
<p>A substituição de caracteres é feita deslocando os caracteres de "!" a "~" dentro dos 94 caracteres "!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~" em 47 caracteres.</p>
<p>Por exemplo, "!" é criptografado como "P", "A" como "p", e "0" como "_".</p>

<pre>
Antes da Criptografia  : !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
Depois da Criptografia : PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO
</pre>

<pre>
Texto antes da Criptografia  : THIS IS A SECRET MESSAGE 123!
Texto depois da Criptografia : %wx$ x$ p $tr#t% |t$$pvt `abP
</pre>

<p>Existe uma reversibilidade onde criptografar o texto cifrado novamente produz o texto simples, então a descriptografia pode ser feita da mesma maneira que a criptografia.</p>
