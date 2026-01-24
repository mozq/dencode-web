<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre ROT18</h3>
<p>ROT18 es un tipo de cifrado de sustitución monoalfabética que encripta reemplazando caracteres en un texto con otros caracteres.</p>
<p>La sustitución de caracteres se realiza desplazando las letras "A" a "Z" 13 caracteres dentro de los 26 caracteres "ABCDEFGHIJKLMNOPQRSTUVWXYZ". Además, los números "0" a "9" se desplazan 5 caracteres dentro de los 10 caracteres "0123456789".</p>
<p>Por ejemplo, "A" se cifra como "N" y "0" como "5".</p>

<pre>Antes:   ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
Después: NOPQRSTUVWXYZABCDEFGHIJKLM5678901234</pre>

<pre>Texto antes:   THIS IS A SECRET MESSAGE 123
Texto después: GUVF VF N FRPERG ZRFFNTR 567</pre>

<p>Debido a la propiedad de reversibilidad donde cifrar el texto cifrado nuevamente produce el texto plano, el descifrado se puede realizar de la misma manera que el cifrado.</p>
