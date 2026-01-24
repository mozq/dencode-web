<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos des chaînes binaires</h3>
<p>Une chaîne binaire est une représentation de la valeur binaire d'une chaîne de caractères en notation binaire.</p>
<p>Selon l'encodage des caractères, la valeur binaire est différente, et donc le résultat de la conversion en chaîne binaire est également différent.</p>

<p>Par exemple, le résultat de la conversion de "サンプル" (exemple) en chaîne binaire est le suivant.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Encodage des caractères</th><th>Chaîne binaire</th></tr>
		<tr><td>UTF-8</td><td>11100011 10000010 10110101 11100011 10000011 10110011 11100011 10000011 10010111 11100011 10000011 10101011</td></tr>
		<tr><td>UTF-16</td><td>00110000 10110101 00110000 11110011 00110000 11010111 00110000 11101011</td></tr>
		<tr><td>Shift_JIS</td><td>10000011 01010100 10000011 10010011 10000011 01110110 10000011 10001011</td></tr>
	</table>
</div>
