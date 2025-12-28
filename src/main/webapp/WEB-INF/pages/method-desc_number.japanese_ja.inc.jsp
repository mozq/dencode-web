<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>漢数字について</h3>
<p>数値を日本語の漢数字で表します。漢数字には、現代の日本で使用されているものと、大字（だいじ）と呼ばれる旧字体による表現の２種類があります。</p>

<p>現代の漢数字と大字の漢数字の例は以下のとおりです。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>算用数字</th><th>漢数字</th><th>漢数字 (大字)</th></tr>
		</thead>
		<tbody>
			<tr><td class="text-right">1234</td><td>千二百三十四</td><td>壱阡弐陌参拾肆</td></tr>
			<tr><td class="text-right">12345.67890</td><td>一万二千三百四十五・六七八九〇</td><td>壱萬弐阡参陌肆拾伍・陸漆捌玖零</td></tr>
			<tr><td class="text-right">1234567890</td><td>十二億三千四百五十六万七千八百九十</td><td>壱拾弐億参阡肆陌伍拾陸萬漆阡捌陌玖拾</td></tr>
			<tr><td class="text-right">500000000000000000 (5 * 10<sup>17</sup>)</td><td>五十京</td><td>伍拾京</td></tr>
		</tbody>
	</table>
</div>

<p>日本語の漢数字では、0 から 9 までの数値を以下の漢字で表します。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>算用数字</th><th>漢数字</th><th>漢数字 (大字)</th></tr>
		</thead>
		<tbody>
			<tr><td class="text-right">0</td><td>〇</td><td>零</td></tr>
			<tr><td class="text-right">1</td><td>一</td><td>壱</td></tr>
			<tr><td class="text-right">2</td><td>二</td><td>弐</td></tr>
			<tr><td class="text-right">3</td><td>三</td><td>参</td></tr>
			<tr><td class="text-right">4</td><td>四</td><td>肆</td></tr>
			<tr><td class="text-right">5</td><td>五</td><td>伍</td></tr>
			<tr><td class="text-right">6</td><td>六</td><td>陸</td></tr>
			<tr><td class="text-right">7</td><td>七</td><td>漆</td></tr>
			<tr><td class="text-right">8</td><td>八</td><td>捌</td></tr>
			<tr><td class="text-right">9</td><td>九</td><td>玖</td></tr>
		</tbody>
	</table>
</div>

<p>10 以上の数字は、各桁ごとに以下の漢字で表します。漢数字では、4桁ごとに桁の名前が繰り上がります。これを「万進」と呼びます。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>桁</th><th>漢数字</th><th>漢数字 (大字)</th></tr>
		</thead>
		<tbody>
			<tr><td>10<sup>1</sup></td><td>十</td><td>拾</td></tr>
			<tr><td>10<sup>2</sup></td><td>百</td><td>陌</td></tr>
			<tr><td>10<sup>3</sup></td><td>千</td><td>阡</td></tr>
			<tr><td>10<sup>4</sup></td><td>万</td><td>萬</td></tr>
			<tr><td>10<sup>8</sup></td><td colspan="2">億</td></tr>
			<tr><td>10<sup>12</sup></td><td colspan="2">兆</td></tr>
			<tr><td>10<sup>16</sup></td><td colspan="2">京</td></tr>
			<tr><td>10<sup>20</sup></td><td colspan="2">垓</td></tr>
			<tr><td>10<sup>24</sup></td><td colspan="2">秭</td></tr>
			<tr><td>10<sup>28</sup></td><td colspan="2">穣</td></tr>
			<tr><td>10<sup>32</sup></td><td colspan="2">溝</td></tr>
			<tr><td>10<sup>36</sup></td><td colspan="2">澗</td></tr>
			<tr><td>10<sup>40</sup></td><td colspan="2">正</td></tr>
			<tr><td>10<sup>44</sup></td><td colspan="2">載</td></tr>
			<tr><td>10<sup>48</sup></td><td colspan="2">極</td></tr>
			<tr><td>10<sup>52</sup></td><td colspan="2">恒河沙</td></tr>
			<tr><td>10<sup>56</sup></td><td colspan="2">阿僧祇</td></tr>
			<tr><td>10<sup>60</sup></td><td colspan="2">那由他</td></tr>
			<tr><td>10<sup>64</sup></td><td colspan="2">不可思議</td></tr>
			<tr><td>10<sup>68</sup></td><td colspan="2">無量大数</td></tr>
		</tbody>
	</table>
</div>

<p>10, 100, 1000 は、それぞれ 「一十」「一百」「一千」ではなく 「十」「百」「千」のように「一」を省略するのが一般的です。ただし、大字の場合は「壱」を明記することがあります。</p>

<p>小数点以下は、「・」の後に位取り記数法で表します。</p>

<p>上記の大字のうち、日本の法令では、「壱」「弐」「参」「拾」のみが定められています。</p>

<p>大字では「億」(10<sup>8</sup>) 以上の桁は定義されていませんが、DenCodeでは通常の漢数字と同じ桁の名前で表します。</p>
