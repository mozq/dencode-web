<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sui Numeri Inglesi</h3>
<p>Esprime i numeri utilizzando parole inglesi.</p>

<p>Ad esempio, il risultato della conversione di 123456789 in numeri inglesi è il seguente:</p>
<pre>123456789 = One Hundred Twenty-Three Million Four Hundred Fifty-Six Thousand Seven Hundred Eighty-Nine</pre>

<p>I valori decimali possono essere espressi parola per parola o come frazioni. Ad esempio, 0.99 è "Zero point Nine Nine" in parole e "Zero and 99/100" come frazione.</p>
<pre>0.99 = Zero point Nine Nine
0.99 = Zero and 99/100</pre>


<h4>Numeri grandi</h4>
<p>Per i numeri più grandi, le cifre sono espresse in Scala Corta (Short Scale) o Scala Lunga (Long Scale) come segue. Nella Scala Corta, il nome della cifra cambia ogni 3 cifre, mentre nella Scala Lunga cambia ogni 6 cifre. Inoltre, la Scala Lunga include il sistema Chuquet, che esprime 10<sup>6N+3</sup> cifre come "Thousand -illion", e il sistema Peletier, che utilizza "-illiard".</p>
<p>La Scala Corta è utilizzata principalmente nei paesi di lingua inglese come Stati Uniti, Canada e Regno Unito (dal 1974). La Scala Lunga è utilizzata nel Regno Unito (sistema Chuquet prima del 1973) e in molti paesi europei non anglofoni come Francia, Germania e Italia (sistema Peletier), con notazioni specifiche per ogni lingua (es. Miliardo per Milliard in italiano).</p>
<p>DenCode adotta la Scala Corta, che è comune nell'inglese moderno.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th></th><th colspan="2">Scala Corta</th><th colspan="2">Scala Lunga (Chuquet)</th><th colspan="2">Scala Lunga (Peletier)</th></tr>
			<tr><th>Cifra</th><th>N (10<sup>3N+3</sup>)</th><th>Nome</th><th>N (10<sup>6N</sup>)</th><th>Nome</th><th>N (10<sup>6N</sup>)</th><th>Nome</th></tr>
		</thead>
		<tbody>
			<tr><td>10<sup>3</sup></td><td>0</td><td>Thousand</td><td>0.5</td><td>Thousand</td><td>0.5</td><td>Thousand</td></tr>
			<tr><td>10<sup>6</sup></td><td>1</td><td>Million</td><td>1</td><td>Million</td><td>1</td><td>Million</td></tr>
			<tr><td>10<sup>9</sup></td><td>2</td><td>Billion</td><td>1.5</td><td>Thousand Million</td><td>1.5</td><td>Milliard</td></tr>
			<tr><td>10<sup>12</sup></td><td>3</td><td>Trillion</td><td>2</td><td>Billion</td><td>2</td><td>Billion</td></tr>
			<tr><td>10<sup>15</sup></td><td>4</td><td>Quadrillion</td><td>2.5</td><td>Thousand Billion</td><td>2.5</td><td>Billiard</td></tr>
			<tr><td>10<sup>18</sup></td><td>5</td><td>Quintillion</td><td>3</td><td>Trillion</td><td>3</td><td>Trillion</td></tr>
			<tr><td>10<sup>21</sup></td><td>6</td><td>Sextillion</td><td>3.5</td><td>Thousand Trillion</td><td>3.5</td><td>Trilliard</td></tr>
			<tr><td>10<sup>24</sup></td><td>7</td><td>Septillion</td><td>4</td><td>Quadrillion</td><td>4</td><td>Quadrillion</td></tr>
			<tr><td>10<sup>27</sup></td><td>8</td><td>Octillion</td><td>4.5</td><td>Thousand Quadrillion</td><td>4.5</td><td>Quadrilliard</td></tr>
			<tr><td>10<sup>30</sup></td><td>9</td><td>Nonillion</td><td>5</td><td>Quintillion</td><td>5</td><td>Quintillion</td></tr>
			<tr><td>10<sup>33</sup></td><td>10</td><td>Decillion</td><td>5.5</td><td>Thousand Quintillion</td><td>5.5</td><td>Quintilliard</td></tr>
			<tr><td>10<sup>36</sup></td><td>11</td><td>Undecillion</td><td>6</td><td>Sextillion</td><td>6</td><td>Sextillion</td></tr>
			<tr><td>10<sup>39</sup></td><td>12</td><td>Duodecillion</td><td>6.5</td><td>Thousand Sextillion</td><td>6.5</td><td>Sextilliard</td></tr>
			<tr><td>10<sup>42</sup></td><td>13</td><td>Tredecillion</td><td>7</td><td>Septillion</td><td>7</td><td>Septillion</td></tr>
			<tr><td>10<sup>45</sup></td><td>14</td><td>Quattuordecillion</td><td>7.5</td><td>Thousand Septillion</td><td>7.5</td><td>Septilliard</td></tr>
			<tr><td>10<sup>48</sup></td><td>15</td><td>Quindecillion</td><td>8</td><td>Octillion</td><td>8</td><td>Octillion</td></tr>
			<tr><td>10<sup>51</sup></td><td>16</td><td>Sexdecillion</td><td>8.5</td><td>Thousand Octillion</td><td>8.5</td><td>Octilliard</td></tr>
			<tr><td>10<sup>54</sup></td><td>17</td><td>Septendecillion</td><td>9</td><td>Nonillion</td><td>9</td><td>Nonillion</td></tr>
			<tr><td>10<sup>57</sup></td><td>18</td><td>Octodecillion</td><td>9.5</td><td>Thousand Nonillion</td><td>9.5</td><td>Nonilliard</td></tr>
			<tr><td>10<sup>60</sup></td><td>19</td><td>Novemdecillion</td><td>10</td><td>Decillion</td><td>10</td><td>Decillion</td></tr>
			<tr><td>10<sup>63</sup></td><td>20</td><td>Vigintillion</td><td>10.5</td><td>Thousand Decillion</td><td>10.5</td><td>Decilliard</td></tr>
		</tbody>
	</table>
</div>

<p>I nomi delle cifre sopra sono standard nei dizionari inglesi attuali.</p>
<p>L'origine dei nomi dei sistemi di Scala Lunga Chuquet e Peletier risale al 1484, quando il matematico francese Nicolas Chuquet definì i numeri fino a N=9 "Nonillion" (Byllion, Tryllion, Quadrillion, Quyllion, Sixlion, Septyllion, Ottyllion, Nonyllion in francese), e nel 1549 Jacques Peletier du Mans rese popolare "Milliard" (Milliart) (originariamente "Milliard" significava 10<sup>12</sup>, poi ridotto a 10<sup>9</sup> alla fine del XVII secolo).</p>


<h4>Sistema Conway-Wechsler</h4>
<p>Un metodo rappresentativo per nominare grandi numeri oltre N=10 (10<sup>33</sup>) è il <dfn>sistema Conway-Wechsler</dfn> definito da John Horton Conway e Allan Wechsler. Il sistema Conway-Wechsler nomina le cifre secondo le seguenti regole:</p>

<div class="table-responsive">
	<table class="table">
		<caption>Conway-Wechsler system</caption>
		<thead>
			<tr><th></th><th>Units (Unità)</th><th>Tens (Decine)</th><th>Hundreds (Centinaia)</th></tr>
		</thead>
		<tbody>
			<tr><td>1</td><td>un</td><td><sup>(n)</sup> deci</td><td><sup>(nx)</sup> centi</td></tr>
			<tr><td>2</td><td>duo</td><td><sup>(ms)</sup> viginti</td><td><sup>(n)</sup> ducenti</td></tr>
			<tr><td>3</td><td>tre <sup>(s(x))</sup></td><td><sup>(ns)</sup> triginta</td><td><sup>(ns)</sup> trecenti</td></tr>
			<tr><td>4</td><td>quattuor</td><td><sup>(ns)</sup> quadraginta</td><td><sup>(ns)</sup> quadringenti</td></tr>
			<tr><td>5</td><td>quin(qua)</td><td><sup>(ns)</sup> quinquaginta</td><td><sup>(ns)</sup> quingenti</td></tr>
			<tr><td>6</td><td>se <sup>(sx)</sup></td><td><sup>(n)</sup> sexaginta</td><td><sup>(n)</sup> sescenti</td></tr>
			<tr><td>7</td><td>septe <sup>(mn)</sup></td><td><sup>(n)</sup> septuaginta</td><td><sup>(n)</sup> septingenti</td></tr>
			<tr><td>8</td><td>octo</td><td><sup>(mx)</sup> octoginta</td><td><sup>(mx)</sup> octingenti</td></tr>
			<tr><td>9</td><td>nove <sup>(mn)</sup></td><td>nonaginta</td><td>nongenti</td></tr>
		</tbody>
	</table>
</div>

<p>Il sistema Conway-Wechsler è stato definito per la Scala Corta, ma può essere utilizzato anche per la Scala Lunga. Per ottenere il nome di una cifra con questo sistema, trova N in 10<sup>3N+3</sup> per la Scala Corta o 10<sup>6N</sup> per la Scala Lunga, e deriva il nome dalla tabella sopra in base al valore di N.</p>
<p>Ad esempio, 10<sup>96</sup> è 10<sup>3*31+3</sup> nella Scala Corta, quindi N=31. Combinando i nomi dall'unità più bassa alla più alta di N, si ottiene "un"(1) + "triginta"(30) + "illion" = "Untrigintillion". Se la vocale "aeiou" precede "illion", viene rimossa.</p>
<pre>10<sup>96</sup> = 10<sup>3*31+3</sup> = One Untrigintillion</pre>

<p>I caratteri tra parentesi <sup>(mnsx)</sup> nella tabella sopra sono regole di assimilazione: se, combinando Units con Tens o Hundreds, i caratteri corrispondono, vengono inclusi. Ad esempio, per N=36, "se <sup>(sx)</sup>"(6) + "<sup>(ns)</sup> triginta"(30) + "illion" = "Se<b>s</b>trigintillion".</p>
<pre>10<sup>111</sup> = 10<sup>3*36+3</sup> = One Sestrigintillion</pre>

<p>Il caso di "tre <sup>(s(x))</sup>"(3) è speciale: aggiunge "s" se il carattere successivo è uno dei due <sup>(sx)</sup>. Ad esempio, per N=83, "tre <sup>(s(x))</sup>"(3) + "<sup>(mx)</sup> octoginta"(80) + "illion" = "Tre<b>s</b>octogintillion".</p>
<pre>10<sup>252</sup> = 10<sup>3*83+3</sup> = One Tresoctogintillion</pre>

<p>Per numeri ancora più grandi con N=1,000 o più (10<sup>3003</sup>+), i nomi vengono derivati per ogni gruppo di 3 cifre di N come sopra e poi combinati. Se N=1,000,000<b>X</b> + 1,000<b>Y</b> + <b>Z</b> e i nomi delle cifre sono "<b>X</b>illion", "<b>Y</b>illion", "<b>Z</b>illion", vengono combinati come "<b>X</b>illi<b>y</b>illi<b>z</b>illion", omettendo "on" di "-illion" nel mezzo. Ad esempio, per N=1,003, "Million"(1) + "Trillion"(3) = "Millitrillion". Per N=12,210, "Duodecillion"(12) + "Deciducentillion"(210) = "Duodecillideciducentillion".</p>
<p>Se il valore di 3 cifre è 0, diventa "Nillion", quindi per N=1,000,003, "Million"(1) + "Nillion"(0) + "Trillion"(3) = "Millinillitrillion".</p>
<pre>10<sup>3012</sup> = 10<sup>3*1003+3</sup> = One Millitrillion
10<sup>36633</sup> = 10<sup>3*12210+3</sup> = One Duodecillideciducentillion
10<sup>3000012</sup> = 10<sup>3*1000003+3</sup> = One Millinillitrillion</pre>

<p>Poiché il sistema Conway-Wechsler è basato fondamentalmente sul latino, esistono differenze con i nomi definiti nei dizionari inglesi, come mostrato di seguito.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Sistema Conway-Wechsler</th><th>Dizionario Inglese</th><th>Parola Latina</th></tr>
		</thead>
		<tbody>
			<tr><td>15</td><td>Quin<b>qua</b>decillion</td><td>Quindecillion</td><td>5 è "quinque", ma per 15 "quindecim" è più comune di "quinquadecim".</td></tr>
			<tr><td>16</td><td>Sedecillion</td><td>Se<b>x</b>decillion</td><td>"sedecim" è più comune di "sexdecim".</td></tr>
			<tr><td>19</td><td>Nove<b>n</b>decillion</td><td>Nove<b>m</b>decillion</td><td>Di solito "undeviginti", ma a volte scritto "novendecim" o "novemdecim". Per N=17, regola simile, "septendecim" è più comune di "septemdecim".</td></tr>
		</tbody>
	</table>
</div>

<p>"Quinqua" per 5 è "quinque" in latino, ma 15 è "quindecim" (e "quindecillion" in inglese). Pertanto, a volte viene usato "quin" al posto di "quinqua" nel sistema Conway-Wechsler. Questa sostituzione è stata proposta da Olivier Miakinen (Rif: <cite><a href="http://www.miakinen.net/vrac/zillions" target="_blank">Olivier Miakinen. Les zillions selon Conway, Wechsler... et Miakinen, 2003</a></cite> (Pagina web in francese)). DenCode adotta "quin" che è più vicino ai nomi dei dizionari inglesi.</p>


<h4>Sistema CW4EN</h4>
<p>DenCode supporta il sistema Conway-Wechsler sopra descritto, ma definisce e utilizza come predefinito un sistema unico più conforme ai dizionari inglesi. Per comodità, lo chiamiamo "<dfn>Sistema <abbr title="Conway-Wechsler for English">CW4EN</abbr></dfn>" (Conway-Wechsler for English).</p>

<div class="table-responsive">
	<table class="table">
		<caption>Sistema CW4EN</caption>
		<thead>
			<tr><th></th><th>Units (Unità)</th><th>Tens (Decine)</th><th>Hundreds (Centinaia)</th></tr>
		</thead>
		<tbody>
			<tr><td>1</td><td>un</td><td>deci</td><td><sup>(s)</sup> centi</td></tr>
			<tr><td>2</td><td>duo</td><td>viginti</td><td>ducenti</td></tr>
			<tr><td>3</td><td>tre <sup>(s)</sup></td><td>triginta</td><td>trecenti</td></tr>
			<tr><td>4</td><td>quattuor</td><td>quadraginta</td><td>quadringenti</td></tr>
			<tr><td>5</td><td>quin</td><td>quinquaginta</td><td>quingenti</td></tr>
			<tr><td>6</td><td>se<b>x</b></td><td>sexaginta</td><td>sescenti</td></tr>
			<tr><td>7</td><td>septe<b>n</b></td><td>septuaginta</td><td>septingenti</td></tr>
			<tr><td>8</td><td>octo</td><td>octoginta</td><td>octingenti</td></tr>
			<tr><td>9</td><td>nove<b>m</b></td><td>nonaginta</td><td>nongenti</td></tr>
		</tbody>
	</table>
</div>

<p>Nel sistema CW4EN, "tre <sup>(s(x))</sup>", "se <sup>(sx)</sup>", "septe <sup>(mn)</sup>", "nove <sup>(mn)</sup>" del sistema Conway-Wechsler sono fissati come "tre", "se<b>x</b>", "septe<b>n</b>", "nove<b>m</b>". L'unica eccezione è per N=103, dove si usa "Tre<b>s</b>centillion" invece di "Trecentillion" per evitare duplicazioni con N=300.</p>
<p>Esistono esempi di sistemi simili a CW4EN, ma non considerano o menzionano la differenza "Tre<b>s</b>centillion" / "Trecentillion". (Es: <cite><a href="https://www.nasdaq.com/glossary" target="_blank">Glossary of Stock Market Terms &amp; Definitions | Nasdaq</a></cite>)</p>

<p>Di seguito sono elencate le principali differenze tra il sistema Conway-Wechsler e il sistema CW4EN.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Sistema Conway-Wechsler</th><th>Sistema CW4EN</th></tr>
		</thead>
		<tbody>
			<tr><td>16</td><td>Sedecillion</td><td>Se<b>x</b>decillion</td></tr>
			<tr><td>19</td><td>Nove<b>n</b>decillion</td><td>Nove<b>m</b>decillion</td></tr>
			<tr><td>23</td><td>Tre<b>s</b>vigintillion</td><td>Trevigintillion</td></tr>
			<tr><td>26</td><td>Se<b>s</b>vigintillion</td><td>Se<b>x</b>vigintillion</td></tr>
			<tr><td>27</td><td>Septe<b>m</b>vigintillion</td><td>Septe<b>n</b>vigintillion</td></tr>
			<tr><td>33</td><td>Tre<b>s</b>trigintillion</td><td>Tretrigintillion</td></tr>
			<tr><td>36</td><td>Se<b>s</b>trigintillion</td><td>Se<b>x</b>trigintillion</td></tr>
			<tr><td>39</td><td>Nove<b>n</b>trigintillion</td><td>Nove<b>m</b>trigintillion</td></tr>
			<tr><td>43</td><td>Tre<b>s</b>quadragintillion</td><td>Trequadragintillion</td></tr>
			<tr><td>46</td><td>Se<b>s</b>quadragintillion</td><td>Se<b>x</b>quadragintillion</td></tr>
			<tr><td>49</td><td>Nove<b>n</b>quadragintillion</td><td>Nove<b>m</b>quadragintillion</td></tr>
			<tr><td>53</td><td>Tre<b>s</b>quinquagintillion</td><td>Trequinquagintillion</td></tr>
			<tr><td>56</td><td>Se<b>s</b>quinquagintillion</td><td>Se<b>x</b>quinquagintillion</td></tr>
			<tr><td>59</td><td>Nove<b>n</b>quinquagintillion</td><td>Nove<b>m</b>quinquagintillion</td></tr>
			<tr><td>66</td><td>Sesexagintillion</td><td>Se<b>x</b>sexagintillion</td></tr>
			<tr><td>69</td><td>Nove<b>n</b>sexagintillion</td><td>Nove<b>m</b>sexagintillion</td></tr>
			<tr><td>76</td><td>Seseptuagintillion</td><td>Se<b>x</b>septuagintillion</td></tr>
			<tr><td>79</td><td>Nove<b>n</b>septuagintillion</td><td>Nove<b>m</b>septuagintillion</td></tr>
			<tr><td>83</td><td>Tre<b>s</b>octogintillion</td><td>Treoctogintillion</td></tr>
			<tr><td>87</td><td>Septe<b>m</b>octogintillion</td><td>Septe<b>n</b>octogintillion</td></tr>
			<tr><td>96</td><td>Senonagintillion</td><td>Se<b>x</b>nonagintillion</td></tr>
			<tr><td>97</td><td>Septenonagintillion</td><td>Septe<b>n</b>nonagintillion</td></tr>
			<tr><td>99</td><td>Nove<b>n</b>onagintillion</td><td>Nove<b>m</b>nonagintillion</td></tr>
			<tr><td>109</td><td>Nove<b>n</b>centillion</td><td>Nove<b>m</b>centillion</td></tr>
			<tr><td>206</td><td>Seducentillion</td><td>Se<b>x</b>ducentillion</td></tr>
			<tr><td>209</td><td>Nove<b>n</b>ducentillion</td><td>Nove<b>m</b>ducentillion</td></tr>
			<tr><td>303</td><td>Tre<b>s</b>trecentillion</td><td>Tretrecentillion</td></tr>
			<tr><td>306</td><td>Se<b>s</b>trecentillion</td><td>Se<b>x</b>trecentillion</td></tr>
			<tr><td>309</td><td>Nove<b>n</b>trecentillion</td><td>Nove<b>m</b>trecentillion</td></tr>
			<tr><td>403</td><td>Tre<b>s</b>quadringentillion</td><td>Trequadringentillion</td></tr>
			<tr><td>406</td><td>Se<b>s</b>quadringentillion</td><td>Se<b>x</b>quadringentillion</td></tr>
			<tr><td>409</td><td>Nove<b>n</b>quadringentillion</td><td>Nove<b>m</b>quadringentillion</td></tr>
			<tr><td>503</td><td>Tre<b>s</b>quingentillion</td><td>Trequingentillion</td></tr>
			<tr><td>506</td><td>Se<b>s</b>quingentillion</td><td>Se<b>x</b>quingentillion</td></tr>
			<tr><td>509</td><td>Nove<b>n</b>quingentillion</td><td>Nove<b>m</b>quingentillion</td></tr>
			<tr><td>606</td><td>Sesescentillion</td><td>Se<b>x</b>sescentillion</td></tr>
			<tr><td>609</td><td>Nove<b>n</b>sescentillion</td><td>Nove<b>m</b>sescentillion</td></tr>
			<tr><td>706</td><td>Seseptingentillion</td><td>Se<b>x</b>septingentillion</td></tr>
			<tr><td>709</td><td>Nove<b>n</b>septingentillion</td><td>Nove<b>m</b>septingentillion</td></tr>
			<tr><td>803</td><td>Tre<b>s</b>octingentillion</td><td>Treoctingentillion</td></tr>
			<tr><td>807</td><td>Septe<b>m</b>octingentillion</td><td>Septe<b>n</b>octingentillion</td></tr>
			<tr><td>906</td><td>Senongentillion</td><td>Se<b>x</b>nongentillion</td></tr>
			<tr><td>907</td><td>Septenongentillion</td><td>Septe<b>n</b>nongentillion</td></tr>
			<tr><td>909</td><td>Nove<b>n</b>ongentillion</td><td>Nove<b>m</b>nongentillion</td></tr>
		</tbody>
	</table>
</div>
