<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni su UNIX Time</h3>
<p>UNIX Time (tempo POSIX, secondi dall'epoca) è il numero di secondi trascorsi dall'UNIX Epoch, 00:00:00 UTC del 1 gennaio 1970, esclusi i secondi intercalari.</p>
<p>I tempi precedenti all'UNIX Epoch sono rappresentati da valori negativi.</p>
<p>DenCode gestisce l'UNIX time in secondi. I millisecondi e i microsecondi sono rappresentati da valori decimali.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Data e ora</th><th>UNIX Time</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
