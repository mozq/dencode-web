<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos des chaînes hexadécimales</h3>
<p>Une chaîne hexadécimale est une représentation de la valeur binaire d'une chaîne de caractères en notation hexadécimale.</p>
<p>Selon l'encodage des caractères, la valeur binaire est différente, et donc le résultat de la conversion en chaîne hexadécimale est également différent.</p>

<p>Par exemple, le résultat de la conversion de "サンプル" (exemple) en chaîne hexadécimale est le suivant.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Encodage des caractères</th><th>Chaîne hexadécimale</th></tr>
		<tr><td>UTF-8</td><td>E3 82 B5 E3 83 B3 E3 83 97 E3 83 AB</td></tr>
		<tr><td>UTF-16</td><td>30 B5 30 F3 30 D7 30 EB</td></tr>
		<tr><td>Shift_JIS</td><td>83 54 83 93 83 76 83 8B</td></tr>
	</table>
</div>
