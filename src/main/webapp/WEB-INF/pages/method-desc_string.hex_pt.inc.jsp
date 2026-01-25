<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Strings Hexadecimais</h3>
<p>Strings Hexadecimais são valores binários de uma string representados em notação hexadecimal.</p>
<p>Como o valor binário difere dependendo da codificação de caracteres, o resultado da conversão para uma string hexadecimal também difere.</p>

<p>Por exemplo, o resultado da conversão de "サンプル" para string hexadecimal é o seguinte:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Codificação de caracteres</th><th>String Hexadecimal</th></tr>
		<tr><td>UTF-8</td><td>E3 82 B5 E3 83 B3 E3 83 97 E3 83 AB</td></tr>
		<tr><td>UTF-16</td><td>30 B5 30 F3 30 D7 30 EB</td></tr>
		<tr><td>Shift_JIS</td><td>83 54 83 93 83 76 83 8B</td></tr>
	</table>
</div>
