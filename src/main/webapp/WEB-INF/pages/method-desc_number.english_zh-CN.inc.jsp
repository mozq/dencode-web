<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于英文数字 (English Number)</h3>
<p>用英语单词表示数值。</p>

<p>例如，将 123456789 转换为英文数字的结果如下。</p>
<pre>123456789 = One Hundred Twenty-Three Million Four Hundred Fifty-Six Thousand Seven Hundred Eighty-Nine</pre>

<p>小数点后的值可以用逐位单词或分数表示。例如，0.99 用单词表示为“Zero point Nine Nine”，用分数表示为“Zero and 99/100”。</p>
<pre>0.99 = Zero point Nine Nine
0.99 = Zero and 99/100</pre>


<h4>大数</h4>
<p>对于更大的数字，位数使用短尺度 (Short scale) 或长尺度 (Long scale) 表示，如下所示。在短尺度中，位名每 3 位变化一次；在长尺度中，每 6 位变化一次。此外，长尺度还有使用“Thousand -illion”表示 10<sup>6N+3</sup> 位的 Chuquet 系统和使用“-illiard”表示的 Peletier 系统。</p>
<p>短尺度主要用于美国、加拿大、英国（1974 年以后）等英语圈国家。长尺度中的 Chuquet 系统曾用于 1973 年以前的英国，Peletier 系统则以各语言特有的表示法用于法国、德国、意大利等欧洲非英语圈国家。</p>
<p>DenCode 采用现代英语圈通用的短尺度。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th></th><th colspan="2">短尺度</th><th colspan="2">长尺度 (Chuquet)</th><th colspan="2">长尺度 (Peletier)</th></tr>
			<tr><th>位数</th><th>N (10<sup>3N+3</sup>)</th><th>位名</th><th>N (10<sup>6N</sup>)</th><th>位名</th><th>N (10<sup>6N</sup>)</th><th>位名</th></tr>
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

<p>上述位名是根据当前英语词典的通用名称。</p>
<p>长尺度的 Chuquet 和 Peletier 系统的名称由来是，1484 年法国数学家 Nicolas Chuquet 定义了直到 N=9 的“Nonillion” (法语中为 Byllion, Tryllion, Quadrillion, Quyllion, Sixlion, Septyllion, Ottyllion, Nonyllion)，1549 年 Jacques Peletier du Mans 推广了“Milliard” (Milliart)（“Milliard”作为 10<sup>12</sup> 的意思传播开来，后来在 17 世纪后期减少为 10<sup>9</sup>）。</p>


<h4>Conway-Wechsler 系统</h4>
<p>作为 N=10 以上 (10<sup>33</sup> 以上) 大数位命名的代表性方法，有 John Horton Conway 和 Allan Wechsler 定义的 <dfn>Conway-Wechsler 系统</dfn>。Conway-Wechsler 系统按照以下规则命名位数。</p>

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

<p>Conway-Wechsler 系统是为短尺度定义的，但也适用于长尺度。要通过该系统获得位名，短尺度求 10<sup>3N+3</sup> 中的 N，长尺度求 10<sup>6N</sup> 中的 N，然后根据 N 值基于上表导出名称。</p>
<p>例如，10<sup>96</sup> 在短尺度中是 10<sup>3*31+3</sup>，所以 N=31，将 N 从低位到高位顺序结合：“un”(1) + “triginta”(30) + “illion” = “Untrigintillion”。如果“illion”之前有元音“aeiou”，则去掉元音后结合。</p>
<pre>10<sup>96</sup> = 10<sup>3*31+3</sup> = One Untrigintillion</pre>

<p>此外，上表中括弧内的字符 <sup>(mnsx)</sup> 表示在组合 Units 和 Tens 或 Hundreds 时，如果字符一致，则包含该字符进行结合。这称为同化规则。例如，N=36 时，“se <sup>(sx)</sup>”(6) + “<sup>(ns)</sup> triginta”(30) + “illion” = “Se<b>s</b>trigintillion”。</p>
<pre>10<sup>111</sup> = 10<sup>3*36+3</sup> = One Sestrigintillion</pre>

<p>“tre <sup>(s(x))</sup>”(3) 比较特殊，无论后续是 <sup>(sx)</sup> 中的哪个字符，都追加“s”。例如，N=83 时，“tre <sup>(s(x))</sup>”(3) + “<sup>(mx)</sup> octoginta”(80) + “illion” = “Tre<b>s</b>octogintillion”。</p>
<pre>10<sup>252</sup> = 10<sup>3*83+3</sup> = One Tresoctogintillion</pre>

<p>对于 N=1,000 以上 (10<sup>3003</sup> 以上) 的更大数字，按上述步骤每 3 位导出名称后最后结合。假设 N=1,000,000<b>X</b> + 1,000<b>Y</b> + <b>Z</b>，各位的名称为“<b>X</b>illion”、“<b>Y</b>illion”、“<b>Z</b>illion”，则结合为“<b>X</b>illi<b>y</b>illi<b>z</b>illion”，中间“-illion”的“on”省略。例如，N=1,003 时，“Million”(1) + “Trillion”(3) = “Millitrillion”。N=12,210 时，“Duodecillion”(12) + “Deciducentillion”(210) = “Duodecillideciducentillion”。</p>
<p>另外，当 3 位数值为 0 时变成“Nillion”，所以例如 N=1,000,003 时，“Million”(1) + “Nillion”(0) + “Trillion”(3) = “Millinillitrillion”。</p>
<pre>10<sup>3012</sup> = 10<sup>3*1003+3</sup> = One Millitrillion
10<sup>36633</sup> = 10<sup>3*12210+3</sup> = One Duodecillideciducentillion
10<sup>3000012</sup> = 10<sup>3*1000003+3</sup> = One Millinillitrillion</pre>

<p>Conway-Wechsler 系统基本遵循拉丁语，因此例如以下名称与英语词典中定义的名称存在差异。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Conway-Wechsler 系统</th><th>英语词典</th><th>拉丁语单词</th></tr>
		</thead>
		<tbody>
			<tr><td>15</td><td>Quin<b>qua</b>decillion</td><td>Quindecillion</td><td>5 是“quinque”，但 15 用“quindecim”比“quinquadecim”更通用。</td></tr>
			<tr><td>16</td><td>Sedecillion</td><td>Se<b>x</b>decillion</td><td>“sedecim”比“sexdecim”更通用。</td></tr>
			<tr><td>19</td><td>Nove<b>n</b>decillion</td><td>Nove<b>m</b>decillion</td><td>通常是“undeviginti”，但也有写成“novendecim”或“novemdecim”的情况。类似的同化规则，N=17 用“septendecim”比“septemdecim”更通用。</td></tr>
		</tbody>
	</table>
</div>

<p>表示 5 的“quinqua”在拉丁语中是“quinque”，但在拉丁语中 15 是“quindecim”，英语中也表示为“quindecillion”。因此，有时会将 Conway-Wechsler 系统的“quinqua”替换为“quin”使用。这种替换由 Olivier Miakinen 提出 (参考: <cite><a href="http://www.miakinen.net/vrac/zillions" target="_blank">Olivier Miakinen. Les zillions selon Conway, Wechsler... et Miakinen, 2003</a></cite> (法语网页))。DenCode 也采用了更接近英语词典名称的“quin”。</p>


<h4>CW4EN 系统</h4>
<p>DenCode 支持上述 Conway-Wechsler 系统，但也定义了更符合英语词典的独特系统作为默认转换系统。为了方便起见，这里称为“<dfn><abbr title="Conway-Wechsler for English">CW4EN</abbr> 系统</dfn>” (Conway-Wechsler for English 系统)。</p>

<div class="table-responsive">
	<table class="table">
		<caption>CW4EN 系统</caption>
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

<p>Conway-Wechsler 系统的“tre <sup>(s(x))</sup>”、“se <sup>(sx)</sup>”、“septe <sup>(mn)</sup>”、“nove <sup>(mn)</sup>”在 CW4EN 系统中固定为“tre”、“se<b>x</b>”、“septe<b>n</b>”、“nove<b>m</b>”。唯一例外是 N=103 时，为了避免与 N=300 的“Trecentillion”重复，使用“Tre<b>s</b>centillion”而不是“Trecentillion”。</p>
<p>虽然有采用类似于 CW4EN 系统的例子，但它们并没有考虑到或提及“Tre<b>s</b>centillion”/“Trecentillion”的区别。(例如：<cite><a href="https://www.nasdaq.com/glossary" target="_blank">Glossary of Stock Market Terms &amp; Definitions | Nasdaq</a></cite>)</p>

<p>以下列举了 Conway-Wechsler 系统和 CW4EN 系统中名称不同的代表性例子。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Conway-Wechsler 系统</th><th>CW4EN 系统</th></tr>
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
