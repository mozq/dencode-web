<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於日語漢字數字 (Japanese Numerals)</h3>
<p>用日語的漢字數字表示數值。漢字數字有兩種：一種是現代日本使用的，另一種是稱為大寫數字（大字）的舊字體表示。</p>

<p>現代漢字數字和大寫數字的範例如下。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>阿拉伯數字</th><th>漢字數字</th><th>漢字數字 (大字)</th></tr>
		</thead>
		<tbody>
			<tr><td class="text-right">1234</td><td>千二百三十四</td><td>壱阡弐陌参拾肆</td></tr>
			<tr><td class="text-right">12345.67890</td><td>一万二千三百四十五・六七八九〇</td><td>壱萬弐阡参陌肆拾伍・陸漆捌玖零</td></tr>
			<tr><td class="text-right">1234567890</td><td>十二億三千四百五十六万七千八百九十</td><td>壱拾弐億参阡肆陌伍拾陸萬漆阡捌陌玖拾</td></tr>
			<tr><td class="text-right">500000000000000000 (5 * 10<sup>17</sup>)</td><td>五十京</td><td>伍拾京</td></tr>
		</tbody>
	</table>
</div>

<p>在日語漢字數字中，0 到 9 的數值用以下漢字表示。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>阿拉伯數字</th><th>漢字數字</th><th>漢字數字 (大字)</th></tr>
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

<p>10 以上的數字，各數位用以下漢字表示。在漢字數字中，每 4 位數位名稱進位一次。這稱為「萬進」。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>數位</th><th>漢字數字</th><th>漢字數字 (大字)</th></tr>
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

<p>10, 100, 1000 通常省略「一」，寫作「十」「百」「千」，而不是「一十」「一百」「一千」。但在大寫數字中，有時會明確寫出「壱」。</p>

<p>小數點以下在「・」之後用位值記數法表示。</p>

<p>在上述大寫數字中，日本法律僅規定了「壱」「弐」「参」「拾」。</p>

<p>雖然大寫數字中未定義「億」(10<sup>8</sup>) 以上的數位，但在 DenCode 中使用與普通漢字數字相同的數位名稱表示。</p>
