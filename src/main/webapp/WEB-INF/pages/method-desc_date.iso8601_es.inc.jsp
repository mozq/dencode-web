<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre la fecha y hora ISO 8601</h3>
<p>ISO 8601 es un formato de notación de fecha y hora definido como un estándar internacional por la ISO.</p>
<p>La fecha y la hora están conectadas por "T". La zona horaria se expresa como la diferencia con UTC, como "+09:00", y en el caso de UTC se expresa como "Z".</p>
<p>Segundos y milisegundos se separan por una coma (,) o un punto (.). En DenCode, si los milisegundos son 000, se omiten.</p>

<p>ISO 8601 tiene varios formatos.</p>
<p>Por ejemplo, convertir 2000-01-23 01:23:45.678 (JST; +09:00) a ISO 8601 da los siguientes resultados:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Formato</th><th>Resultado</th></tr>
		<tr><td>Básico</td><td>20000123T012345.678+0900</td></tr>
		<tr><td>Extendido</td><td>2000-01-23T01:23:45.678+09:00</td></tr>
		<tr><td>Semana (Año-Semana-Día)</td><td>2000-W03-7T01:23:45.678+09:00</td></tr>
		<tr><td>Día (Año-Día del año)</td><td>2000-023T01:23:45.678+09:00</td></tr>
	</table>
</div>
