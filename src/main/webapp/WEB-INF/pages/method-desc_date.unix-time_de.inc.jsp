<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über UNIX-Zeit</h3>
<p>Die UNIX-Zeit (POSIX-Zeit, Epoch-Zeit) ist die Anzahl der vergangenen Sekunden seit dem 1. Januar 1970, 00:00:00 UTC (UNIX Epoch), ohne Schaltsekunden.</p>
<p>Zeiten vor der UNIX Epoch werden durch negative Werte dargestellt.</p>
<p>DenCode behandelt die UNIX-Zeit in Sekunden. Millisekunden und Mikrosekunden werden als Nachkommastellen dargestellt.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Datum</th><th>UNIX-Zeit</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
