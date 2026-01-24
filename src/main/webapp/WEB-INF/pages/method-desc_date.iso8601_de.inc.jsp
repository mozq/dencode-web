<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über ISO 8601</h3>
<p>ISO 8601 ist ein internationaler Standard für die Darstellung von Datum und Uhrzeit.</p>
<p>Datum und Uhrzeit werden durch ein „T“ getrennt. Die Zeitzone wird als Differenz zu UTC wie „+09:00“ angegeben, oder als „Z“ für UTC.</p>
<p>Sekunden und Millisekunden werden durch ein Komma (,) oder einen Punkt (.) getrennt. In DenCode werden Millisekunden weggelassen, wenn sie 000 sind.</p>

<p>Es gibt verschiedene Formate in ISO 8601.</p>
<p>Beispiel für die Konvertierung von 23. Januar 2000, 01:23:45.678 (JST; +09:00) in ISO 8601:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Format</th><th>Ergebnis</th></tr>
		<tr><td>Grundformat</td><td>20000123T012345.678+0900</td></tr>
		<tr><td>Erweitertes Format</td><td>2000-01-23T01:23:45.678+09:00</td></tr>
		<tr><td>Woche (Jahr-Woche-Tag)</td><td>2000-W03-7T01:23:45.678+09:00</td></tr>
		<tr><td>Tag (Jahr-Tag im Jahr)</td><td>2000-023T01:23:45.678+09:00</td></tr>
	</table>
</div>
