<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>일본어 한자 숫자에 대해서</h3>
<p>수치를 일본어 한자 숫자로 나타냅니다. 한자 숫자에는 현대 일본에서 사용되고 있는 것과, '대자(大字, Daiji)'라고 불리는 구자체(Old character form)에 의한 표현의 2종류가 있습니다.</p>

<p>현대 한자 숫자와 대자 한자 숫자의 예는 다음과 같습니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>산용 숫자</th><th>한자 숫자</th><th>한자 숫자 (대자)</th></tr>
		</thead>
		<tbody>
			<tr><td class="text-right">1234</td><td>千二百三十四</td><td>壱阡弐陌参拾肆</td></tr>
			<tr><td class="text-right">12345.67890</td><td>一万二千三百四十五・六七八九〇</td><td>壱萬弐阡参陌肆拾伍・陸漆捌玖零</td></tr>
			<tr><td class="text-right">1234567890</td><td>十二億三千四百五十六万七千八百九十</td><td>壱拾弐億参阡肆陌伍拾陸萬漆阡捌陌玖拾</td></tr>
			<tr><td class="text-right">500000000000000000 (5 * 10<sup>17</sup>)</td><td>五十京</td><td>伍拾京</td></tr>
		</tbody>
	</table>
</div>

<p>일본어 한자 숫자에서는 0부터 9까지의 수치를 이하의 한자로 나타냅니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>산용 숫자</th><th>한자 숫자</th><th>한자 숫자 (대자)</th></tr>
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

<p>10 이상의 숫자는 각 자릿수마다 이하의 한자로 나타냅니다. 한자 숫자에서는 4자리마다 자릿수 이름이 갱신됩니다. 이를 '만진(万進)'이라고 부릅니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>자릿수</th><th>한자 숫자</th><th>한자 숫자 (대자)</th></tr>
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

<p>10, 100, 1000은 각각 '一十', '一百', '一千'이 아니라 '十', '百', '千'과 같이 '一'을 생략하는 것이 일반적입니다. 단, 대자의 경우는 '壱'을 명기하는 경우가 있습니다.</p>

<p>소수점 이하는 '・' 뒤에 자릿수 기수법으로 표현합니다.</p>

<p>상기 대자 중, 일본 법령에서는 '壱', '弐', '参', '拾'만이 정해져 있습니다.</p>

<p>대자에서는 '億'(10<sup>8</sup>) 이상의 자릿수는 정의되어 있지 않지만, DenCode에서는 통상 한자 숫자와 같은 자릿수 이름으로 나타냅니다.</p>
