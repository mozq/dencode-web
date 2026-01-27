<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于二进制 (Binary)</h3>
<p>二进制是用二进制记数法表示的数值。</p>

<p>在二进制中，数值以 2 为基数，用“01”表示。</p>

<p>二进制转换示例如下。作为参考，也列出了八进制和十六进制的转换示例。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>十进制</th><th>二进制</th><th>八进制</th><th>十六进制</th></tr>
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

<p>此外，小数部分的数值在二进制中转换为 2<sup>-1</sup> (1/2), 2<sup>-2</sup> (1/4), 2<sup>-3</sup> (1/8), ... 各位的和。如果小数部分的数值无法用 2<sup>-n</sup> 的总和精确表示，则无法完全转换为二进制，会产生误差。在这种情况下，DenCode 会在末尾附加“...”表示省略。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>十进制</th><th>二进制</th><th>八进制</th><th>十六进制</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
