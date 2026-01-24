<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre cadenas binarias</h3>
<p>La cadena binaria es una representación del valor binario de una cadena de texto en notación binaria.</p>
<p>Dependiendo de la codificación de caracteres, los valores binarios difieren, por lo que el resultado de la conversión a cadena binaria también difiere.</p>

<p>Por ejemplo, el resultado de convertir "サンプル" a una cadena binaria es el siguiente:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Codificación</th><th>Cadena binaria</th></tr>
		<tr><td>UTF-8</td><td>11100011 10000010 10110101 11100011 10000011 10110011 11100011 10000011 10010111 11100011 10000011 10101011</td></tr>
		<tr><td>UTF-16</td><td>00110000 10110101 00110000 11110011 00110000 11010111 00110000 11101011</td></tr>
		<tr><td>Shift_JIS</td><td>10000011 01010100 10000011 10010011 10000011 01110110 10000011 10001011</td></tr>
	</table>
</div>
