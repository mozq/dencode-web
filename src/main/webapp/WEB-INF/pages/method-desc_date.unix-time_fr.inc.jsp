<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du temps UNIX</h3>
<p>Le temps UNIX (temps POSIX, secondes Epoch) est le nombre de secondes écoulées depuis l'Epoch UNIX, le 1er janvier 1970 à 00:00:00 (UTC), sans compter les secondes intercalaires.</p>
<p>Les heures antérieures à l'Epoch UNIX sont représentées par des valeurs négatives.</p>
<p>Dans DenCode, le temps UNIX est traité en secondes. Les millisecondes et les microsecondes sont représentées par des chiffres après la virgule.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Date et heure</th><th>Temps UNIX</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
