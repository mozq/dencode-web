<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О двоичных числах</h3>
<p>Двоичные числа представляют числа в двоичной записи.</p>

<p>В двоичном формате число представлено как «01» с 2 в качестве основания.</p>

<p>Пример преобразования в двоичную форму выглядит следующим образом. Для справки также предоставляется пример преобразования восьмеричных и шестнадцатеричных чисел.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<thead>
			<tr><th>Десятичное</th><th>Двоичные</th><th>Восьмеричные</th><th>Десятичные</th></tr>
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

<p>Кроме того, числа после десятичной точки преобразуются как 2<sup>-1</sup> (1/2), 2<sup>-2</sup> (1/4), 2<sup>-3</sup> (1/8), ... в шестнадцатеричные числа. Если число после десятичной точки не может быть представлено суммой 2<sup>-n</sup>, его невозможно полностью преобразовать в шестнадцатеричное, и возникнет ошибка. В этом случае DenCode опускает его, добавляя "..." в конце.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<thead>
			<tr><th>Десятичное</th><th>Двоичные</th><th>Восьмеричные</th><th>Десятичные</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
