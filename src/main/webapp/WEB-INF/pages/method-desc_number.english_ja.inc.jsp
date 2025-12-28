<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>英語数字について</h3>
<p>数値を英語のワードで表します。</p>

<p>例えば、123456789 を英語数字に変換した結果は以下のとおりです。</p>
<pre>123456789 = One Hundred Twenty-Three Million Four Hundred Fifty-Six Thousand Seven Hundred Eighty-Nine</pre>

<p>小数点以下の値は、桁ごとのワードか、または分数で表せます。例えば、 0.99 は、ワードでは「Zero point Nine Nine」、分数では「Zero and 99/100」として表します。</p>
<pre>0.99 = Zero point Nine Nine
0.99 = Zero and 99/100</pre>


<h4>大きな数字</h4>
<p>より大きな数字については、桁はショートスケールまたはロングスケールで、以下のように表します。ショートスケールでは3桁ずつ、ロングスケールでは6桁ずつに桁の名称が変わっていきます。また、ロングスケールには、10<sup>6N+3</sup>桁を "Thousand -illion" で表すChuquetシステムと "-illiard" で表すPeletierシステムがあります。</p>
<p>ショートスケールは、主に英語圏である米国、カナダ、イギリス(1974年以降)などで使用されています。また、ロングスケールは、Chuquetシステムは1973年以前のイギリスで使用されており、Peletierシステムはフランス、ドイツ、イタリアなどの主に非英語圏であるヨーロッパで各言語固有の表記にて使用されています。</p>
<p>DenCodeでは、現代の英語圏で一般的なショートスケールを採用しています。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th></th><th colspan="2">ショートスケール</th><th colspan="2">ロングスケール (Chuquet)</th><th colspan="2">ロングスケール (Peletier)</th></tr>
			<tr><th>桁</th><th>N (10<sup>3N+3</sup>)</th><th>桁名</th><th>N (10<sup>6N</sup>)</th><th>桁名</th><th>N (10<sup>6N</sup>)</th><th>桁名</th></tr>
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

<p>上記の桁の名前は、現在の英語辞書による一般的なものです。</p>
<p>ロングスケールのChuquetおよびPeletierシステムの呼称の由来は、1484年にフランスの数学者である Nicolas Chuquet によって N=9 の "Nonillion" まで (フランス語で Byllion, Tryllion, Quadrillion, Quyllion, Sixlion, Septyllion, Ottyllion, Nonyllion) が定義され、1549年に Jacques Peletier du Mans が "Milliard" (Milliart) を広めたことによります（"Milliard" は 10<sup>12</sup> の意味で広まり、後の17世紀後半に 10<sup>9</sup> に減少しました）。</p>


<h4>Conway-Wechslerシステム</h4>
<p>N=10 以上 (10<sup>33</sup>以上) の大きな桁の命名方法として代表的なものに、John Horton Conway と Allan Wechsler が定義した <dfn>Conway-Wechslerシステム</dfn> があります。Conway-Wechslerシステムは以下のルールで桁を命名します。</p>

<div class="table-responsive">
	<table class="table">
		<caption>Conway-Wechsler system</caption>
		<thead>
			<tr><th></th><th>Units</th><th>Tens</th><th>Hundreds</th></tr>
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

<p>Conway-Wechslerシステムはショートスケール用に定義されましたが、ロングスケールでも使用可能です。このシステムにより桁の名前を得るには、ショートスケールでは 10<sup>3N+3</sup>、ロングスケールでは 10<sup>6N</sup> の N を求めて、そのNの値から上記の表を基に名前を導きます。</p>
<p>例えば、10<sup>96</sup> は、ショートスケールでは 10<sup>3*31+3</sup> のため N=31 であり、Nの低い桁から高い桁の順に結合し "un"(1) + "triginta"(30) + "illion" = "Untrigintillion" となります。"illion" の直前に母音 "aeiou" がある場合には、母音を除いて結合します。</p>
<pre>10<sup>96</sup> = 10<sup>3*31+3</sup> = One Untrigintillion</pre>

<p>また、上記の表の括弧内の文字 <sup>(mnsx)</sup> は、Units と Tens または Hundreds を組み合わせる際に、文字が一致した場合にはその文字を含めて結合します。これを同化ルールと呼びます。例えば、 N=36 の場合は、"se <sup>(sx)</sup>"(6) + "<sup>(ns)</sup> triginta"(30) + "illion" = "Se<b>s</b>trigintillion" となります。</p>
<pre>10<sup>111</sup> = 10<sup>3*36+3</sup> = One Sestrigintillion</pre>

<p>"tre <sup>(s(x))</sup>"(3) の場合は特殊で、後続が <sup>(sx)</sup> のどちらの文字の場合でも "s" を追加します。例えば、N=83 の場合は、 "tre <sup>(s(x))</sup>"(3) + "<sup>(mx)</sup> octoginta"(80) + "illion" = "Tre<b>s</b>octogintillion" となります。</p>
<pre>10<sup>252</sup> = 10<sup>3*83+3</sup> = One Tresoctogintillion</pre>

<p>N=1,000 以上 (10<sup>3003</sup>以上) のさらに大きな数字については、Nを3桁ごとに上記の手順で名前を導いたうえで最後に結合します。N=1,000,000<b>X</b> + 1,000<b>Y</b> + <b>Z</b> でそれぞれの桁の名前が "<b>X</b>illion", "<b>Y</b>illion", "<b>Z</b>illion" であるとした場合、"<b>X</b>illi<b>y</b>illi<b>z</b>illion"のように結合し、途中の"-illion"の"on"は省略します。例えば、N=1,003 の場合、"Million"(1) + "Trillion"(3) = "Millitrillion" となります。また、N=12,210 の場合、"Duodecillion"(12) + "Deciducentillion"(210) = "Duodecillideciducentillion" となります。</p>
<p>また、3桁の値が0の場合は "Nillion" となるため、例えば、N=1,000,003 の場合、 "Million"(1) + "Nillion"(0) + "Trillion"(3) = "Millinillitrillion" となります。</p>
<pre>10<sup>3012</sup> = 10<sup>3*1003+3</sup> = One Millitrillion
10<sup>36633</sup> = 10<sup>3*12210+3</sup> = One Duodecillideciducentillion
10<sup>3000012</sup> = 10<sup>3*1000003+3</sup> = One Millinillitrillion</pre>

<p>Conway-Wechslerシステムは基本的にラテン語に準じているため、例えば以下の名前は英語辞書で定義された名前と差異が存在します。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Conway-Wechslerシステム</th><th>英語辞書</th><th>ラテン語のワード</th></tr>
		</thead>
		<tbody>
			<tr><td>15</td><td>Quin<b>qua</b>decillion</td><td>Quindecillion</td><td>5は "quinque" だが、15は "quinquadecim" より "quindecim" が一般的。</td></tr>
			<tr><td>16</td><td>Sedecillion</td><td>Se<b>x</b>decillion</td><td>"sexdecim" より "sedecim" が一般的。</td></tr>
			<tr><td>19</td><td>Nove<b>n</b>decillion</td><td>Nove<b>m</b>decillion</td><td>通常は "undeviginti" だが、"novendecim"　または "novemdecim" と書かれる場合もある。同様の同化ルールである N=17 は "septemdecim" より "septendecim" が一般的。</td></tr>
		</tbody>
	</table>
</div>

<p>5 を表す "quinqua" はラテン語では "quinque" ですが、15 はラテン語では "quindecim"、英語においても "quindecillion" と表します。そのため、Conway-Wechslerシステムの "quinqua" のみ "quin" に置き換えて利用されることがあります。この置き換えは、Olivier Miakinen によって提示されました (参考: <cite><a href="http://www.miakinen.net/vrac/zillions" target="_blank">Olivier Miakinen. Les zillions selon Conway, Wechsler... et Miakinen, 2003</a></cite> (フランス語のWebページ))。DenCodeでも、英語辞書の名前により近い "quin" を採用しています。</p>


<h4>CW4ENシステム</h4>
<p>DenCodeでは上記のConway-Wechslerシステムをサポートしますが、より英語辞書に則したシステムを独自に定義してデフォルトの変換システムとして使用しています。ここでは便宜上、"<dfn><abbr title="Conway-Wechsler for English">CW4EN</abbr>システム</dfn>" (Conway-Wechsler for English システム) と呼称します。</p>

<div class="table-responsive">
	<table class="table">
		<caption>CW4ENシステム</caption>
		<thead>
			<tr><th></th><th>Units</th><th>Tens</th><th>Hundreds</th></tr>
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

<p>Conway-Wechslerシステムの "tre <sup>(s(x))</sup>", "se <sup>(sx)</sup>", "septe <sup>(mn)</sup>", "nove <sup>(mn)</sup>" は、CW4ENシステムでは "tre", "se<b>x</b>", "septe<b>n</b>", "nove<b>m</b>" に固定されます。唯一、N=103 の場合のみ、"Trecentillion" ではなく "Tre<b>s</b>centillion" としています。これは、N=300 の "Trecentillion" との重複を避けるためです。</p>
<p>CW4ENシステムと類似するシステムを採用した例はありますが、それらは "Tre<b>s</b>centillion" / "Trecentillion" の違いまでは考慮されていないか言及されていません。(例：<cite><a href="https://www.nasdaq.com/glossary" target="_blank">Glossary of Stock Market Terms &amp; Definitions | Nasdaq</a></cite>)</p>

<p>Conway-Wechslerシステム と CW4ENシステム で異なる名前について、代表的なものを以下に列挙します。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Conway-Wechslerシステム</th><th>CW4ENシステム</th></tr>
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
