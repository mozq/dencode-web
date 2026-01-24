<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über W3C-DTF</h3>
<p>W3C-DTF ist ein Datumsformat, das in <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3C NOTE-datetime</a> definiert ist. Es handelt sich um eine Teilmenge von ISO 8601.</p>
<p>Datum und Uhrzeit werden durch ein „T“ getrennt. Die Zeitzone wird als Differenz zu UTC wie „+09:00“ angegeben, oder als „Z“ für UTC.</p>
<p>Sekunden und Millisekunden werden durch einen Punkt (.) getrennt.</p>

<p>W3C-DTF wird häufig in HTTP-Headern oder RSS-Feeds verwendet.</p>

<p>Beispiel für die Konvertierung von 23. Januar 2000, 01:23:45.678 (JST; +09:00) in W3C-DTF:</p>

<pre>2000-01-23T01:23:45.678+09:00</pre>
