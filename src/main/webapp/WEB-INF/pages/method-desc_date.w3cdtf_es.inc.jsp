<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre la fecha y hora W3C-DTF</h3>
<p>W3C-DTF es un formato de notación de fecha y hora definido en <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3C NOTE-datetime</a>. Es un subconjunto limitado a algunos formatos de ISO 8601.</p>
<p>La fecha y la hora están conectadas por "T". La zona horaria se expresa como la diferencia con UTC, como "+09:00", y en el caso de UTC se expresa como "Z".</p>
<p>Segundos y milisegundos se separan por un punto (.).</p>

<p>W3C-DTF se utiliza como notación de fecha y hora en encabezados HTTP y RSS.</p>

<p>Por ejemplo, convertir 2000-01-23 01:23:45.678 (JST; +09:00) a W3C-DTF da el siguiente resultado:</p>

<pre>2000-01-23T01:23:45.678+09:00</pre>
