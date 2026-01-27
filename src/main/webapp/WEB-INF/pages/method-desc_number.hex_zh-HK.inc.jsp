<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於十六進位 (Hexadecimal)</h3>
<p>十六進位是用十六進位記數法表示的數值。</p>

<p>在十六進位中，數值以 16 為基數，用「0123456789ABCDEF」表示。十進位的 0 到 9 在十六進位中也用 0 到 9 表示，10 到 15 用 A 到 F 表示。</p>

<p>十六進位的轉換範例如下。作為參考，同時也列出了二進位和八進位的轉換範例。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>十進位</th><th>二進位</th><th>八進位</th><th>十六進位</th></tr>
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

<p>此外，小數點後的數值在十六進位中作為 16<sup>-1</sup> (1/16), 16<sup>-2</sup> (1/256), 16<sup>-3</sup> (1/4096), ... 的各位的值進行轉換。如果小數點後的數值不能用 16<sup>-n</sup> 的總和表示，則無法完全轉換為十六進位，會產生誤差。在這種情況下，DenCode 通過在末尾附加「...」來省略表示。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>十進位</th><th>二進位</th><th>八進位</th><th>十六進位</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
