<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sulla data ISO 8601</h3>
<p>ISO 8601 è un formato di notazione di data e ora definito come standard internazionale dall'ISO.</p>
<p>Data e ora sono unite da una "T". Il fuso orario è espresso come differenza rispetto all'UTC, come "+09:00", o "Z" per UTC.</p>
<p>I secondi e i millisecondi sono separati da una virgola (,) o un punto (.). In DenCode, se i millisecondi sono 000, vengono omessi.</p>

<p>Esistono diversi formati per ISO 8601.</p>
<p>Ad esempio, la conversione del 23 gennaio 2000 01:23:45.678 (JST; +09:00) in ISO 8601 fornisce i seguenti risultati:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Formato</th><th>Risultato conversione</th></tr>
		<tr><td>Formato base</td><td>20000123T012345.678+0900</td></tr>
		<tr><td>Formato esteso</td><td>2000-01-23T01:23:45.678+09:00</td></tr>
		<tr><td>Settimana (Anno-Settimana-Giorno)</td><td>2000-W03-7T01:23:45.678+09:00</td></tr>
		<tr><td>Giorno (Anno-Giorno dell'anno)</td><td>2000-023T01:23:45.678+09:00</td></tr>
	</table>
</div>
