<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über Hexadezimal-Strings</h3>
<p>Hexadezimal-Strings stellen den binären Wert einer Zeichenkette in hexadezimaler Schreibweise dar.</p>
<p>Da der binäre Wert von der Zeichenkodierung abhängt, variiert auch das Ergebnis der Konvertierung.</p>

<p>Beispiel für die Konvertierung von „サンプル“ (Sample) in einen Hexadezimal-String:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Zeichenkodierung</th><th>Hexadezimal-String</th></tr>
		<tr><td>UTF-8</td><td>E3 82 B5 E3 83 B3 E3 83 97 E3 83 AB</td></tr>
		<tr><td>UTF-16</td><td>30 B5 30 F3 30 D7 30 EB</td></tr>
		<tr><td>Shift_JIS</td><td>83 54 83 93 83 76 83 8B</td></tr>
	</table>
</div>
