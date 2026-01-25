<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre a Data e Hora W3C-DTF</h3>
<p>W3C-DTF é um formato de notação de data e hora definido na <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3C NOTE-datetime</a>. É um subconjunto limitado a apenas alguns formatos da ISO 8601.</p>
<p>A data e a hora são conectadas por "T". O fuso horário é expresso como a diferença de tempo em relação ao UTC, como "+09:00", e no caso de UTC, é representado por "Z".</p>
<p>Segundos e milissegundos são separados por um ponto (.).</p>

<p>W3C-DTF é usado como notação de data e hora em cabeçalhos HTTP e RSS.</p>

<p>Por exemplo, converter 23 de janeiro de 2000, 01:23:45.678 (JST; +09:00) para W3C-DTF resulta no seguinte:</p>

<pre>2000-01-23T01:23:45.678+09:00</pre>
