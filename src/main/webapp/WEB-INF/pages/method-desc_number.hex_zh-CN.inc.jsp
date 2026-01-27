<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于十六进制 (Hexadecimal)</h3>
<p>十六进制是用十六进制记数法表示的数值。</p>

<p>在十六进制中，数值以 16 为基数，用“0123456789ABCDEF”表示。十进制的 0 到 9 在十六进制中也用 0 到 9 表示，10 到 15 用 A 到 F 表示。</p>

<p>十六进制的转换示例如下。作为参考，同时也列出了二进制和八进制的转换示例。</p>

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

<p>此外，小数点后的数值在十六进制中作为 16<sup>-1</sup> (1/16), 16<sup>-2</sup> (1/256), 16<sup>-3</sup> (1/4096), ... 的各位的值进行转换。如果小数点后的数值不能用 16<sup>-n</sup> 的总和表示，则无法完全转换为十六进制，会产生误差。在这种情况下，DenCode 通过在末尾附加“...”来省略表示。</p>

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
