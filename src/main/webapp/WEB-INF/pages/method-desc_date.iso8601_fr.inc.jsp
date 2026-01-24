<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du format de date ISO 8601</h3>
<p>ISO 8601 est un format de représentation de la date et de l'heure défini comme norme internationale par l'ISO.</p>
<p>La date et l'heure sont séparées par un "T". Le fuseau horaire est exprimé comme une différence par rapport à UTC, comme "+09:00", et dans le cas de UTC, il est représenté par "Z".</p>
<p>Les secondes et les millisecondes sont séparées par une virgule (,) ou un point (.). Dans DenCode, si les millisecondes sont 000, elles sont omises.</p>

<p>Il existe plusieurs formats dans ISO 8601.</p>
<p>Par exemple, si vous convertissez le 23 janvier 2000 à 01:23:45.678 (JST; +09:00) en ISO 8601, le résultat sera le suivant.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Format</th><th>Résultat de la conversion</th></tr>
		<tr><td>Format de base</td><td>20000123T012345.678+0900</td></tr>
		<tr><td>Format étendu</td><td>2000-01-23T01:23:45.678+09:00</td></tr>
		<tr><td>Semaine (Année-Semaine-Jour)</td><td>2000-W03-7T01:23:45.678+09:00</td></tr>
		<tr><td>Jour (Année-Jour de l'année)</td><td>2000-023T01:23:45.678+09:00</td></tr>
	</table>
</div>
