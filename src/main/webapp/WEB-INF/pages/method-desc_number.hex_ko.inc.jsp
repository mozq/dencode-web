<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>16진수에 대해서</h3>
<p>16진수는 수치를 16진 기수법으로 표현합니다.</p>

<p>16진수에서는 수치를 16을 밑으로 하여 '0123456789ABCDEF'로 나타냅니다. 10진수의 0부터 9는 16진수에서도 0부터 9로 나타내고, 10부터 15는 A부터 F로 나타냅니다.</p>

<p>16진수 변환 예는 다음과 같습니다. 참고로 2진수와 8진수 변환 예도 기재하고 있습니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>10진수</th><th>2진수</th><th>8진수</th><th>16진수</th></tr>
		</thead>
		<tbody>
			<tr><td class="text-right">0</td><td class="text-right">0</td><td class="text-right">0</td><td class="text-right">0</td></tr>
			<tr><td class="text-right">1</td><td class="text-right">1</td><td class="text-right">1</td><td class="text-right">1</td></tr>
			<tr><td class="text-right">2</td><td class="text-right">10</td><td class="text-right">2</td><td class="text-right">2</td></tr>
			<tr><td class="text-right">7</td><td class="text-right">111</td><td class="text-right">7</td><td class="text-right">7</td></tr>
			<tr><td class="text-right">8</td><td class="text-right">1000</td><td class="text-right">10</td><td class="text-right">8</td></tr>
			<tr><td class="text-right">9</td><td class="text-right">1001</td><td class="text-right">11</td><td class="text-right">9</td></tr>
			<tr><td class="text-right">10</td><td class="text-right">1010</td><td class="text-right">12</td><td class="text-right">A</td></tr>
			<tr><td class="text-right">15</td><td class="text-right">1111</td><td class="text-right">17</td><td class="text-right">F</td></tr>
			<tr><td class="text-right">16</td><td class="text-right">10000</td><td class="text-right">20</td><td class="text-right">10</td></tr>
			<tr><td class="text-right">17</td><td class="text-right">10001</td><td class="text-right">21</td><td class="text-right">11</td></tr>
		</tbody>
	</table>
</div>

<p>또한 소수점 이하의 수치는 16진수에서는 16<sup>-1</sup> (1/16), 16<sup>-2</sup> (1/256), 16<sup>-3</sup> (1/4096), ... 의 각 자릿수 값으로서 변환합니다. 소수점 이하의 수치가 16<sup>-n</sup>의 합계로 나타낼 수 없는 경우는, 완전하게는 16진수로 변환할 수 없어 오차가 발생합니다. 그 경우 DenCode에서는 끝에 "..."을 붙임으로써 생략하여 나타냅니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>10진수</th><th>2진수</th><th>8진수</th><th>16진수</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
