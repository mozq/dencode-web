<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über Oktalzahlen</h3>
<p>Oktalzahlen stellen numerische Werte im Basis-8-System dar.</p>

<p>Im Oktalsystem werden Zahlen zur Basis 8 mit den Ziffern „01234567“ dargestellt.</p>

<p>Beispiele für die Umrechnung in Oktalzahlen sind unten aufgeführt. Als Referenz sind auch Binär- und Hexadezimalzahlen angegeben.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Dezimal</th><th>Binär</th><th>Oktal</th><th>Hexadezimal</th></tr>
		</thead>
		<tbody>
			<tr><td class="text-right">0</td><td class="text-right">0</td><td class="text-right">0</td><td class="text-right">0</td></tr>
			<tr><td class="text-right">1</td><td class="text-right">1</td><td class="text-right">1</td><td class="text-right">1</td></tr>
			<tr><td class="text-right">2</td><td class="text-right">10</td><td class="text-right">2</td><td class="text-right">2</td></tr>
			<tr><td class="text-right">7</td><td class="text-right">111</td><td class="text-right">7</td><td class="text-right">7</td></tr>
			<tr><td class="text-right">8</td><td class="text-right">1000</td><td class="text-right">10</td><td class="text-right">8</td></tr>
			<tr><td class="text-right">9</td><td class="text-right">1001</td><td class="text-right">11</td><td class="text-right">9</td></tr>
			<tr><td class="text-right">10</td><td class="text-right">1010</td><td class="text-right">12</td><td class="text-right">A</td></tr>
			<tr><td class="text-right">15</td><td class="text-right">1111</td><td class="text-right">17</td><td class="text-right">F</td></tr>
			<tr><td class="text-right">16</td><td class="text-right">10000</td><td class="text-right">20</td><td class="text-right">10</td></tr>
			<tr><td class="text-right">17</td><td class="text-right">10001</td><td class="text-right">21</td><td class="text-right">11</td></tr>
		</tbody>
	</table>
</div>

<p>Nachkommastellen werden im Oktalsystem als Summe von 8<sup>-1</sup> (1/8), 8<sup>-2</sup> (1/64), 8<sup>-3</sup> (1/512), ... dargestellt. Wenn eine Dezimalzahl nicht exakt als Summe von Potenzen von 8<sup>-n</sup> dargestellt werden kann, tritt ein Konvertierungsfehler auf. In diesem Fall zeigt DenCode das Ergebnis verkürzt mit „...“ am Ende an.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Dezimal</th><th>Binär</th><th>Oktal</th><th>Hexadezimal</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
