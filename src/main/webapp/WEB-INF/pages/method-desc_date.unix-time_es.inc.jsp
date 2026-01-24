<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre el Tiempo UNIX</h3>
<p>El Tiempo UNIX (Tiempo POSIX, segundos de epoc) es el número de segundos transcurridos desde la época UNIX, 1 de enero de 1970 00:00:00 (UTC), excluyendo segundos intercalares.</p>
<p>Las horas anteriores a la época UNIX se representan con valores negativos.</p>
<p>En DenCode, el tiempo UNIX se maneja en unidades de segundos. Los milisegundos y microsegundos se representan como decimales.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Fecha y hora</th><th>Tiempo UNIX</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
