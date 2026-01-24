<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über Ascii85</h3>
<p>Ascii85 ist eine Kodierung, die 7-Bit druckbare ASCII-Zeichen verwendet. Es wird auch Base85 genannt.</p>
<p>Bei Ascii85 werden Daten in 4-Byte-Blöcke geteilt und in 5 ASCII-Zeichen umgewandelt.</p>
<p>Es gibt verschiedene Varianten von Ascii85. DenCode unterstützt die folgenden drei Typen. Das Original war btoa, gefolgt von Adobe und Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Übersicht</th></tr>
		<tr><th>Z85</th><td>Verwendet von ZeroMQ. Es vermeidet Zeichen, die maskiert werden müssen, wie „\“ (Backslash) oder „'“ (Apostroph).</td></tr>
		<tr><th>Adobe</th><td>Verwendet in Adobes PostScript und PDF (Portable Document Format). Es wird von „&lt;~“ und „~&gt;“ umschlossen.</td></tr>
		<tr><th>btoa</th><td>Format des UNIX-Befehls btoa. Wurde früher für den Austausch von Binärdaten verwendet, ist heute aber nicht mehr üblich. Wird von „xbtoa Begin“ und „xbtoa End“ umschlossen.</td></tr>
	</table>
</div>

<p>Die verwendeten ASCII-Zeichen sind wie folgt. Ein 4-Byte-Wert wird als vorzeichenlose Big-Endian-Ganzzahl behandelt, in 5 Stellen zur Basis 85 umgerechnet und dann anhand der folgenden Tabelle in ASCII-Zeichen umgewandelt.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>ASCII-Zeichen</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(Ursprünglich Zeichen von „ “ (Leerzeichen) bis „t“, wurde aber später ersetzt durch „!“ bis „u“, da einige Mail-Programme Leerzeichen am Zeilenende entfernten.)</td></tr>
	</table>
</div>

<p>Beispiel für die Konvertierung von „Hello“ in Ascii85:</p>

<p>1. In 4-Byte-Blöcke teilen. Wenn weniger als 4 Bytes, mit „00“ auffüllen.</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. Als 4-Byte Big-Endian Integer interpretieren und in Basis-85 (5 Stellen) umwandeln.</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. Jede Basis-85-Ziffer in ein ASCII-Zeichen umwandeln. Wenn gepaddet wurde, wird das Padding bei Adobe/Z85 entfernt.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. Zeichen verbinden. Adobe fügt „&lt;~“ und „~&gt;“ hinzu und bricht zeilenweise um. btoa fügt Header/Footer hinzu.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Ergebnis</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br /> 87cURDZBb;<br /> xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>Es gibt einige definierte Kurzformen:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Kurzform</th></tr>
		<tr><th>Z85</th><td>Keine</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (ab btoa v4.2)<br /></td></tr>
	</table>
</div>
