<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre cadenas hexadecimales</h3>
<p>La cadena hexadecimal es una representación del valor binario de una cadena de texto en notación hexadecimal.</p>
<p>Dependiendo de la codificación de caracteres, los valores binarios difieren, por lo que el resultado de la conversión a cadena hexadecimal también difiere.</p>

<p>Por ejemplo, el resultado de convertir "サンプル" a una cadena hexadecimal es el siguiente:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Codificación</th><th>Cadena hexadecimal</th></tr>
		<tr><td>UTF-8</td><td>E3 82 B5 E3 83 B3 E3 83 97 E3 83 AB</td></tr>
		<tr><td>UTF-16</td><td>30 B5 30 F3 30 D7 30 EB</td></tr>
		<tr><td>Shift_JIS</td><td>83 54 83 93 83 76 83 8B</td></tr>
	</table>
</div>
