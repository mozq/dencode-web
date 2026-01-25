<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>영어 숫자에 대해서</h3>
<p>수치를 영어 단어(Word)로 나타냅니다.</p>

<p>예를 들어, 123456789를 영어 숫자로 변환한 결과는 다음과 같습니다.</p>
<pre>123456789 = One Hundred Twenty-Three Million Four Hundred Fifty-Six Thousand Seven Hundred Eighty-Nine</pre>

<p>소수점 이하의 값은 자릿수마다의 단어, 또는 분수로 나타낼 수 있습니다. 예를 들어 0.99는 단어로는 'Zero point Nine Nine', 분수로는 'Zero and 99/100'으로 나타냅니다.</p>
<pre>0.99 = Zero point Nine Nine
0.99 = Zero and 99/100</pre>


<h4>큰 숫자</h4>
<p>보다 큰 숫자에 대해서는 자릿수를 숏 스케일(Short scale) 또는 롱 스케일(Long scale)로 다음과 같이 나타냅니다. 숏 스케일에서는 3자리씩, 롱 스케일에서는 6자리씩 자릿수 명칭이 변해갑니다. 또한 롱 스케일에는 10<sup>6N+3</sup> 자릿수를 "Thousand -illion"으로 나타내는 Chuquet 시스템과 "-illiard"로 나타내는 Peletier 시스템이 있습니다.</p>
<p>숏 스케일은 주로 영어권인 미국, 캐나다, 영국(1974년 이후) 등에서 사용되고 있습니다. 또한 롱 스케일은 Chuquet 시스템은 1973년 이전의 영국에서 사용되었으며, Peletier 시스템은 프랑스, 독일, 이탈리아 등 주로 비영어권 유럽에서 각 언어 고유의 표기로 사용되고 있습니다.</p>
<p>DenCode에서는 현대 영어권에서 일반적인 숏 스케일을 채용하고 있습니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th></th><th colspan="2">숏 스케일</th><th colspan="2">롱 스케일 (Chuquet)</th><th colspan="2">롱 스케일 (Peletier)</th></tr>
			<tr><th>자릿수</th><th>N (10<sup>3N+3</sup>)</th><th>자릿수 이름</th><th>N (10<sup>6N</sup>)</th><th>자릿수 이름</th><th>N (10<sup>6N</sup>)</th><th>자릿수 이름</th></tr>
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

<p>위의 자릿수 이름은 현재 영어 사전에 의한 일반적인 것입니다.</p>
<p>롱 스케일의 Chuquet 및 Peletier 시스템 호칭의 유래는, 1484년에 프랑스 수학자 Nicolas Chuquet에 의해 N=9인 "Nonillion"까지 (프랑스어로 Byllion, Tryllion, Quadrillion, Quyllion, Sixlion, Septyllion, Ottyllion, Nonyllion)가 정의되고, 1549년에 Jacques Peletier du Mans가 "Milliard" (Milliart)를 넓힌 것에 의합니다("Milliard"는 10<sup>12</sup>의 의미로 퍼졌으며, 나중에 17세기 후반에 10<sup>9</sup>로 감소했습니다).</p>


<h4>Conway-Wechsler 시스템</h4>
<p>N=10 이상 (10<sup>33</sup> 이상)의 큰 자릿수 명명 방법으로 대표적인 것에 John Horton Conway와 Allan Wechsler가 정의한 <dfn>Conway-Wechsler 시스템</dfn>이 있습니다. Conway-Wechsler 시스템은 다음 규칙으로 자릿수를 명명합니다.</p>

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

<p>Conway-Wechsler 시스템은 숏 스케일용으로 정의되었지만, 롱 스케일에서도 사용 가능합니다. 이 시스템에 의해 자릿수 이름을 얻으려면, 숏 스케일에서는 10<sup>3N+3</sup>, 롱 스케일에서는 10<sup>6N</sup>의 N을 구하고, 그 N의 값으로부터 위 표를 바탕으로 이름을 도출합니다.</p>
<p>예를 들어 10<sup>96</sup>은 숏 스케일에서는 10<sup>3*31+3</sup>이기 때문에 N=31이며, N의 낮은 자릿수부터 높은 자릿수 순서로 결합하여 "un"(1) + "triginta"(30) + "illion" = "Untrigintillion"이 됩니다. "illion"의 직전에 모음 "aeiou"가 있는 경우에는 모음을 제외하고 결합합니다.</p>
<pre>10<sup>96</sup> = 10<sup>3*31+3</sup> = One Untrigintillion</pre>

<p>또한, 상기 표의 괄호 내 문자 <sup>(mnsx)</sup>는 Units와 Tens 또는 Hundreds를 조합할 때 문자가 일치하는 경우에는 그 문자를 포함하여 결합합니다. 이를 동화 규칙(Assimilation rule)이라고 부릅니다. 예를 들어 N=36인 경우는 "se <sup>(sx)</sup>"(6) + "<sup>(ns)</sup> triginta"(30) + "illion" = "Se<b>s</b>trigintillion"이 됩니다.</p>
<pre>10<sup>111</sup> = 10<sup>3*36+3</sup> = One Sestrigintillion</pre>

<p>"tre <sup>(s(x))</sup>"(3)의 경우는 특수로, 후속이 <sup>(sx)</sup>의 어느 문자인 경우에도 "s"를 추가합니다. 예를 들어 N=83인 경우는 "tre <sup>(s(x))</sup>"(3) + "<sup>(mx)</sup> octoginta"(80) + "illion" = "Tre<b>s</b>octogintillion"이 됩니다.</p>
<pre>10<sup>252</sup> = 10<sup>3*83+3</sup> = One Tresoctogintillion</pre>

<p>N=1,000 이상 (10<sup>3003</sup> 이상)의 더욱 큰 숫자에 대해서는, N을 3자리마다 상기 절차로 이름을 도출한 뒤에 마지막에 결합합니다. N=1,000,000<b>X</b> + 1,000<b>Y</b> + <b>Z</b>에서 각각의 자릿수 이름이 "<b>X</b>illion", "<b>Y</b>illion", "<b>Z</b>illion"이라 할 경우, "<b>X</b>illi<b>y</b>illi<b>z</b>illion"과 같이 결합하고 중간의 "-illion"의 "on"은 생략합니다. 예를 들어 N=1,003인 경우 "Million"(1) + "Trillion"(3) = "Millitrillion"이 됩니다. 또한 N=12,210인 경우 "Duodecillion"(12) + "Deciducentillion"(210) = "Duodecillideciducentillion"이 됩니다.</p>
<p>또한 3자리 값이 0인 경우는 "Nillion"이 되므로, 예를 들어 N=1,000,003인 경우 "Million"(1) + "Nillion"(0) + "Trillion"(3) = "Millinillitrillion"이 됩니다.</p>
<pre>10<sup>3012</sup> = 10<sup>3*1003+3</sup> = One Millitrillion
10<sup>36633</sup> = 10<sup>3*12210+3</sup> = One Duodecillideciducentillion
10<sup>3000012</sup> = 10<sup>3*1000003+3</sup> = One Millinillitrillion</pre>

<p>Conway-Wechsler 시스템은 기본적으로 라틴어에 준거하고 있기 때문에, 예를 들어 이하의 이름은 영어 사전에서 정의된 이름과 차이가 존재합니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Conway-Wechsler 시스템</th><th>영어 사전</th><th>라틴어 단어</th></tr>
		</thead>
		<tbody>
			<tr><td>15</td><td>Quin<b>qua</b>decillion</td><td>Quindecillion</td><td>5는 "quinque"이지만, 15는 "quinquadecim"보다 "quindecim"이 일반적.</td></tr>
			<tr><td>16</td><td>Sedecillion</td><td>Se<b>x</b>decillion</td><td>"sexdecim"보다 "sedecim"이 일반적.</td></tr>
			<tr><td>19</td><td>Nove<b>n</b>decillion</td><td>Nove<b>m</b>decillion</td><td>통상은 "undeviginti"이지만 "novendecim" 또는 "novemdecim"으로 쓰이는 경우도 있음. 같은 동화 규칙인 N=17은 "septemdecim"보다 "septendecim"이 일반적.</td></tr>
		</tbody>
	</table>
</div>

<p>5를 나타내는 "quinqua"는 라틴어에서는 "quinque"이지만, 15는 라틴어에서는 "quindecim", 영어에서도 "quindecillion"이라고 표현합니다. 그 때문에 Conway-Wechsler 시스템의 "quinqua"만 "quin"으로 겹쳐서 이용되는 경우가 있습니다. 이 대체는 Olivier Miakinen에 의해 제시되었습니다(참고: <cite><a href="http://www.miakinen.net/vrac/zillions" target="_blank">Olivier Miakinen. Les zillions selon Conway, Wechsler... et Miakinen, 2003</a></cite> (프랑스어 웹 페이지)). DenCode에서도 영어 사전에 보다 가까운 "quin"을 채용하고 있습니다.</p>


<h4>CW4EN 시스템</h4>
<p>DenCode에서는 상기의 Conway-Wechsler 시스템을 지원하지만, 보다 영어 사전에 입각한 시스템을 독자적으로 정의하여 기본 변환 시스템으로 사용하고 있습니다. 여기에서는 편의상 "<dfn><abbr title="Conway-Wechsler for English">CW4EN</abbr> 시스템</dfn>" (Conway-Wechsler for English 시스템)이라고 호칭합니다.</p>

<div class="table-responsive">
	<table class="table">
		<caption>CW4EN 시스템</caption>
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

<p>Conway-Wechsler 시스템의 "tre <sup>(s(x))</sup>", "se <sup>(sx)</sup>", "septe <sup>(mn)</sup>", "nove <sup>(mn)</sup>"는 CW4EN 시스템에서는 "tre", "se<b>x</b>", "septe<b>n</b>", "nove<b>m</b>"에 고정됩니다. 유일하게 N=103인 경우만 "Trecentillion"이 아니라 "Tre<b>s</b>centillion"으로 하고 있습니다. 이는 N=300인 "Trecentillion"과의 중복을 피하기 위해서입니다.</p>
<p>CW4EN 시스템과 유사한 시스템을 채용한 예는 있지만, 그것들은 "Tre<b>s</b>centillion" / "Trecentillion"의 차이까지는 고려되지 않았거나 언급되어 있지 않습니다. (예: <cite><a href="https://www.nasdaq.com/glossary" target="_blank">Glossary of Stock Market Terms &amp; Definitions | Nasdaq</a></cite>)</p>

<p>Conway-Wechsler 시스템과 CW4EN 시스템에서 다른 이름에 대해, 대표적인 것을 아래에 열거합니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>N</th><th>Conway-Wechsler 시스템</th><th>CW4EN 시스템</th></tr>
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
