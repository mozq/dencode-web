<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>16進数について</h3>
<p>16進数は、数値を16進記数法で表します。</p>

<p>16進数では、数値を16を底として「0123456789ABCDEF」で表します。10進数の 0 から 9 は16進数でも 0 から 9 で表し、 10 から 15 は A から F で表します。</p>

<p>16進数での変換例は以下の通りです。参考として、2進数と8進数の変換例も記載しています。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<thead>
			<tr><th>10進数</th><th>2進数</th><th>8進数</th><th>16進数</th></tr>
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

<p>また、小数点以下の数値は16進数では 16<sup>-1</sup> (1/16), 16<sup>-2</sup> (1/256), 16<sup>-3</sup> (1/4096), ... の各位の値として変換します。小数点以下の数値が16<sup>-n</sup>の合計で表せない場合は、完全には16進数に変換できず誤差が発生します。その場合、DenCodeでは末尾に"..."を付加することで省略して表します。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<thead>
			<tr><th>10進数</th><th>2進数</th><th>8進数</th><th>16進数</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
