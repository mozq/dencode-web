<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du format de date W3C-DTF</h3>
<p>W3C-DTF est un format de représentation de la date et de l'heure défini dans la <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">NOTE-datetime du W3C</a>. Il s'agit d'un sous-ensemble limité à certains formats de la norme ISO 8601.</p>
<p>La date et l'heure sont séparées par un "T". Le fuseau horaire est exprimé comme une différence par rapport à UTC, comme "+09:00", et dans le cas de UTC, il est représenté par "Z".</p>
<p>Les secondes et les millisecondes sont séparées par un point (.).</p>

<p>W3C-DTF est utilisé comme représentation de la date et de l'heure dans les en-têtes HTTP et les flux RSS.</p>

<p>Par exemple, si vous convertissez le 23 janvier 2000 à 01:23:45.678 (JST; +09:00) en W3C-DTF, le résultat sera le suivant.</p>

<pre>2000-01-23T01:23:45.678+09:00</pre>
