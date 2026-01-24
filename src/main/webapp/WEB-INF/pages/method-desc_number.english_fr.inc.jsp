<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos des nombres en anglais</h3>
<p>Représente les nombres par des mots anglais.</p>

<p>Par exemple, le résultat de la conversion de 123456789 en nombres anglais est le suivant.</p>
<pre>123456789 = One Hundred Twenty-Three Million Four Hundred Fifty-Six Thousand Seven Hundred Eighty-Nine</pre>

<p>Les valeurs après la virgule peuvent être représentées par des mots pour chaque chiffre ou par des fractions. Par exemple, 0.99 est exprimé comme "Zero point Nine Nine" en mots, et "Zero and 99/100" en fractions.</p>
<pre>0.99 = Zero point Nine Nine
0.99 = Zero and 99/100</pre>


<h4>Grands nombres</h4>
<p>Pour les grands nombres, les chiffres sont exprimés en échelle courte (Short Scale) ou en échelle longue (Long Scale) comme suit. En échelle courte, le nom des unités change tous les 3 chiffres, tandis qu'en échelle longue, il change tous les 6 chiffres. De plus, pour l'échelle longue, il existe le système Chuquet où les 10<sup>6N+3</sup> sont exprimés par "Thousand -illion", et le système Peletier où ils sont exprimés par "-illiard".</p>
<p>L'échelle courte est principalement utilisée dans les pays anglophones tels que les États-Unis, le Canada et le Royaume-Uni (depuis 1974). L'échelle longue, quant à elle, était utilisée au Royaume-Uni avec le système Chuquet avant 1973, et le système Peletier est utilisé en France, en Allemagne, au Italie et dans d'autres pays européens principalement non anglophones avec des notations spécifiques à chaque langue.</p>
<p>DenCode adopte l'échelle courte, qui est courante dans le monde anglophone moderne.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th></th><th colspan="2">Échelle courte</th><th colspan="2">Échelle longue (Chuquet)</th><th colspan="2">Échelle longue (Peletier)</th></tr>
			<tr><th>Chiffre</th><th>N (10<sup>3N+3</sup>)</th><th>Nom</th><th>N (10<sup>6N</sup>)</th><th>Nom</th><th>N (10<sup>6N</sup>)</th><th>Nom</th></tr>
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

<p>Les noms des unités ci-dessus sont ceux couramment utilisés dans les dictionnaires anglais actuels.</p>
<p>L'origine des noms des systèmes Chuquet et Peletier de l'échelle longue remonte à 1484, lorsque le mathématicien français Nicolas Chuquet a défini les noms jusqu'à N=9 "Nonillion" (Byllion, Tryllion, Quadrillion, Quyllion, Sixlion, Septyllion, Ottyllion, Nonyllion en français), et en 1549, Jacques Peletier du Mans a popularisé le terme "Milliard" (Milliart) (qui s'est répandu au sens de 10<sup>12</sup>, puis réduit à 10<sup>9</sup> à la fin du 17ème siècle).</p>


<h4>Système Conway-Wechsler</h4>
<p>Une méthode représentative pour nommer les grands nombres de N=10 ou plus (10<sup>33</sup> ou plus) est le <dfn>système Conway-Wechsler</dfn> défini par John Horton Conway et Allan Wechsler. Le système Conway-Wechsler nomme les unités selon les règles suivantes.</p>

<div class="table-responsive">
	<table class="table">
		<caption>Système Conway-Wechsler</caption>
		<thead>
			<tr><th></th><th>Unités</th><th>Dizaines</th><th>Centaines</th></tr>
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

<p>Le système Conway-Wechsler a été défini pour l'échelle courte, mais peut également être utilisé pour l'échelle longue. Pour obtenir le nom d'une unité avec ce système, trouvez N pour 10<sup>3N+3</sup> en échelle courte et 10<sup>6N</sup> en échelle longue, et dérivez le nom à partir de la valeur de N en utilisant le tableau ci-dessus.</p>
<p>Par exemple, pour 10<sup>96</sup>, en échelle courte c'est 10<sup>3*31+3</sup> donc N=31. En combinant les chiffres du plus bas au plus haut : "un"(1) + "triginta"(30) + "illion" = "Untrigintillion". Si la voyelle "aeiou" précède "illion", elle est supprimée avant la combinaison.</p>
<pre>10<sup>96</sup> = 10<sup>3*31+3</sup> = One Untrigintillion</pre>

<p>De plus, les caractères entre parenthèses <sup>(mnsx)</sup> dans le tableau ci-dessus indiquent que lors de la combinaison des Unités avec les Dizaines ou les Centaines, si les caractères correspondent, ils sont inclus dans la combinaison. C'est ce qu'on appelle la règle d'assimilation. Par exemple, pour N=36, "se <sup>(sx)</sup>"(6) + "<sup>(ns)</sup> triginta"(30) + "illion" = "Se<b>s</b>trigintillion".</p>
<pre>10<sup>111</sup> = 10<sup>3*36+3</sup> = One Sestrigintillion</pre>

<p>Le cas de "tre <sup>(s(x))</sup>"(3) est spécial, on ajoute "s" quel que soit le caractère <sup>(sx)</sup> qui suit. Par exemple, pour N=83, "tre <sup>(s(x))</sup>"(3) + "<sup>(mx)</sup> octoginta"(80) + "illion" = "Tre<b>s</b>octogintillion".</p>
<pre>10<sup>252</sup> = 10<sup>3*83+3</sup> = One Tresoctogintillion</pre>

<p>Pour les nombres encore plus grands avec N=1,000 ou plus (10<sup>3003</sup> ou plus), N est divisé tous les 3 chiffres et les noms sont dérivés selon la procédure ci-dessus puis combinés à la fin. Si N=1,000,000<b>X</b> + 1,000<b>Y</b> + <b>Z</b> et que les noms de chaque partie sont "<b>X</b>illion", "<b>Y</b>illion", "<b>Z</b>illion", ils sont combinés comme "<b>X</b>illi<b>y</b>illi<b>z</b>illion", en omettant le "on" des "-illion" intermédiaires. Par exemple, pour N=1,003, "Million"(1) + "Trillion"(3) = "Millitrillion". Et pour N=12,210, "Duodecillion"(12) + "Deciducentillion"(210) = "Duodecillideciducentillion".</p>
<p>De plus, si la valeur de 3 chiffres est 0, cela devient "Nillion". Par exemple, pour N=1,000,003, "Million"(1) + "Nillion"(0) + "Trillion"(3) = "Millinillitrillion".</p>
<pre>10<sup>3012</sup> = 10<sup>3*1003+3</sup> = One Millitrillion
10<sup>36633</sup> = 10<sup>3*12210+3</sup> = One Duodecillideciducentillion
10<sup>3000012</sup> = 10<sup>3*1000003+3</sup> = One Millinillitrillion</pre>

<p>Le système Conway-Wechsler étant basé sur le latin, il existe des différences avec les noms définis dans les dictionnaires anglais, par exemple :</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Système Conway-Wechsler</th><th>Dictionnaire anglais</th><th>Mot latin</th></tr>
		</thead>
		<tbody>
			<tr><td>15</td><td>Quin<b>qua</b>decillion</td><td>Quindecillion</td><td>5 est "quinque", mais pour 15, "quindecim" est plus courant que "quinquadecim".</td></tr>
			<tr><td>16</td><td>Sedecillion</td><td>Se<b>x</b>decillion</td><td>"sedecim" est plus courant que "sexdecim".</td></tr>
			<tr><td>19</td><td>Nove<b>n</b>decillion</td><td>Nove<b>m</b>decillion</td><td>Généralement "undeviginti", mais parfois écrit "novendecim" ou "novemdecim". De même pour la règle d'assimilation, pour N=17, "septendecim" est plus courant que "septemdecim".</td></tr>
		</tbody>
	</table>
</div>

<p>"quinqua" représentant 5 est "quinque" en latin, mais 15 est "quindecim" en latin et "quindecillion" en anglais. Par conséquent, seul "quinqua" du système Conway-Wechsler est parfois remplacé par "quin". Ce remplacement a été proposé par Olivier Miakinen (Référence : <cite><a href="http://www.miakinen.net/vrac/zillions" target="_blank">Olivier Miakinen. Les zillions selon Conway, Wechsler... et Miakinen, 2003</a></cite> (Page Web en français)). DenCode adopte également "quin" qui est plus proche des noms des dictionnaires anglais.</p>


<h4>Système CW4EN</h4>
<p>DenCode supporte le système Conway-Wechsler ci-dessus, mais a défini son propre système plus conforme aux dictionnaires anglais et l'utilise comme système de conversion par défaut. Pour plus de commodité, nous l'appellerons le "<dfn>système <abbr title="Conway-Wechsler for English">CW4EN</abbr></dfn>" (système Conway-Wechsler pour l'anglais).</p>

<div class="table-responsive">
	<table class="table">
		<caption>Système CW4EN</caption>
		<thead>
			<tr><th></th><th>Unités</th><th>Dizaines</th><th>Centaines</th></tr>
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

<p>Les "tre <sup>(s(x))</sup>", "se <sup>(sx)</sup>", "septe <sup>(mn)</sup>", "nove <sup>(mn)</sup>" du système Conway-Wechsler sont fixés à "tre", "se<b>x</b>", "septe<b>n</b>", "nove<b>m</b>" dans le système CW4EN. La seule exception est pour N=103, où "Tre<b>s</b>centillion" est utilisé au lieu de "Trecentillion". Ceci afin d'éviter la duplication avec "Trecentillion" pour N=300.</p>
<p>Il existe des exemples d'adoption de systèmes similaires au système CW4EN, mais ils ne prennent pas en compte ou ne mentionnent pas la différence entre "Tre<b>s</b>centillion" et "Trecentillion". (Ex : <cite><a href="https://www.nasdaq.com/glossary" target="_blank">Glossary of Stock Market Terms &amp; Definitions | Nasdaq</a></cite>)</p>

<p>Voici une liste des principales différences de noms entre le système Conway-Wechsler et le système CW4EN.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Système Conway-Wechsler</th><th>Système CW4EN</th></tr>
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
