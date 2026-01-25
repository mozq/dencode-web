<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre a Data e Hora ISO 8601</h3>
<p>ISO 8601 é um formato de notação de data e hora definido como um padrão internacional pela ISO.</p>
<p>A data e a hora são conectadas por "T". O fuso horário é expresso como a diferença de tempo em relação ao UTC, como "+09:00", e no caso de UTC, é representado por "Z".</p>
<p>Segundos e milissegundos são separados por uma vírgula (,) ou um ponto (.). No DenCode, se os milissegundos forem 000, eles são omitidos.</p>

<p>Existem vários formatos na ISO 8601.</p>
<p>Por exemplo, converter 23 de janeiro de 2000, 01:23:45.678 (JST; +09:00) para ISO 8601 resulta no seguinte:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Formato</th><th>Resultado da conversão</th></tr>
		<tr><td>Formato básico</td><td>20000123T012345.678+0900</td></tr>
		<tr><td>Formato estendido</td><td>2000-01-23T01:23:45.678+09:00</td></tr>
		<tr><td>Semana (Ano-Semana-Dia da semana)</td><td>2000-W03-7T01:23:45.678+09:00</td></tr>
		<tr><td>Dia (Ano-Dia do ano)</td><td>2000-023T01:23:45.678+09:00</td></tr>
	</table>
</div>
