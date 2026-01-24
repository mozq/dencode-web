<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre ROT47</h3>
<p>ROT47 es un tipo de cifrado de sustitución monoalfabética que encripta reemplazando caracteres en un texto con otros caracteres.</p>
<p>La sustitución de caracteres se realiza desplazando caracteres de "!" a "~" 47 caracteres dentro de los 94 caracteres "!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~".</p>
<p>Por ejemplo, "!" se cifra como "P", "A" como "p", y "0" como "_".</p>

<pre>Antes:   !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
Después: PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO</pre>

<pre>Texto antes:   THIS IS A SECRET MESSAGE 123!
Texto después: %wx$ x$ p $tr#t% |t$$pvt `abP</pre>

<p>Debido a la propiedad de reversibilidad donde cifrar el texto cifrado nuevamente produce el texto plano, el descifrado se puede realizar de la misma manera que el cifrado.</p>
