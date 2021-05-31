<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About binary numbers</h3>
<p>Binary numbers represent numbers in binary notation.</p>

<p>In binary, the number is represented by "01" with 2 as the base.</p>

<p>An example of conversion in binary is as follows. For reference, an example of conversion between octal and hexadecimal numbers is also provided.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<thead>
			<tr><th>Decimal</th><th>Binary</th><th>Octal</th><th>Hexadecimal</th></tr>
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

<p>Also, numbers after the decimal point are converted as 2<sup>-1</sup> (1/2), 2<sup>-2</sup> (1/4), 2<sup>-3</sup> (1/8), ... in hexadecimal numbers. If the number after the decimal point cannot be represented by the total of 2<sup>-n</sup>, it cannot be completely converted to hexadecimal and an error will occur. In that case, DenCode omits it by adding "..." at the end.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<thead>
			<tr><th>Decimal</th><th>Binary</th><th>Octal</th><th>Hexadecimal</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
