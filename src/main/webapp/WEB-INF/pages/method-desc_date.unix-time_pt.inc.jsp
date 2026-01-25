<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre o Tempo UNIX</h3>
<p>O Tempo UNIX (Tempo POSIX, Segundos de Época) é o número de segundos decorridos desde a Época UNIX de 1º de janeiro de 1970 00:00:00 (UTC), não incluindo segundos bissextos.</p>
<p>Horários anteriores à Época UNIX são representados por valores negativos.</p>
<p>O DenCode lida com o tempo UNIX em segundos. Milissegundos e microssegundos são representados por casas decimais.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Data e Hora</th><th>Tempo UNIX</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
