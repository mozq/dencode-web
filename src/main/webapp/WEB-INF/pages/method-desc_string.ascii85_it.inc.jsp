<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni su Ascii85</h3>
<p>Ascii85 è uno schema di codifica che utilizza caratteri ASCII stampabili a 7 bit. È anche chiamato Base85.</p>
<p>Ascii85 divide i dati in blocchi di 4 byte e li converte in 5 caratteri ASCII.</p>
<p>Esistono diverse varianti di Ascii85. DenCode supporta i seguenti tre tipi. L'originale è btoa, seguito da Adobe e Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Panoramica</th></tr>
		<tr><th>Z85</th><td>Utilizzato in ZeroMQ. Evita caratteri che richiedono escape come "\" (backslash) o "'" (apostrofo).</td></tr>
		<tr><th>Adobe</th><td>Utilizzato per codificare immagini e altri dati nei file PostScript e PDF (Portable Document Format) di Adobe. È racchiuso tra "&lt;~" e "~&gt;".</td></tr>
		<tr><th>btoa</th><td>Formato del comando btoa di UNIX. Usato in passato per lo scambio di dati binari, ma ora meno comune. È racchiuso tra le linee "xbtoa Begin" e "xbtoa End".</td></tr>
	</table>
</div>

<p>I caratteri ASCII utilizzati in Ascii85 sono i seguenti. Tratta un valore di 4 byte come un intero senza segno big-endian, calcola le cifre in base 85 (5 cifre) e ottiene il risultato della conversione Ascii85 basato sui seguenti caratteri ASCII.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Caratteri ASCII</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(L'originale usava caratteri da " " (spazio) a "t", ma alcuni mailer rimuovevano lo spazio finale, quindi è stato sostituito con caratteri da "!" a "u".)</td></tr>
	</table>
</div>

<p>Ad esempio, la conversione di "Hello" in Ascii85 è la seguente.</p>

<p>1. Dividi ogni 4 byte. Se meno di 4 byte, riempi con "00" alla fine.</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. Tratta ogni 4 byte come un intero senza segno big-endian e converti il valore nelle cifre in base 85.</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. Converti ogni cifra in base 85 in un carattere ASCII. Se è stato aggiunto padding "00" alla fine, rimuovi la parte di padding per Adobe/Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. Unisci tutti i caratteri per ottenere il risultato della conversione Ascii85. Adobe è racchiuso tra "&lt;~" &amp; "~&gt;" e va a capo ogni 80 caratteri. btoa è racchiuso tra "xbtoa Begin" &amp; "xbtoa End" (inclusi lunghezza dati e checksum) e va a capo ogni 78 caratteri.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Risultato conversione</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>Sono definite anche alcune abbreviazioni.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Abbreviazione</th></tr>
		<tr><th>Z85</th><td>Nessuna</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (da btoa v4.2)<br /></td></tr>
	</table>
</div>
