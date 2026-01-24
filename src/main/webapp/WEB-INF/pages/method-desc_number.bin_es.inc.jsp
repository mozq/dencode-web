<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre los números binarios</h3>
<p>El número binario representa un valor numérico utilizando notación de base 2.</p>

<p>En binario, los valores numéricos se expresan utilizando "01" con base 2.</p>

<p>A continuación se muestran ejemplos de conversión en binario. Como referencia, también se incluyen ejemplos de conversión a octal y hexadecimal.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Decimal</th><th>Binario</th><th>Octal</th><th>Hexadecimal</th></tr>
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

<p>Además, los valores decimales después del punto decimal se convierten en binario como la suma de valores posicionales de 2<sup>-1</sup> (1/2), 2<sup>-2</sup> (1/4), 2<sup>-3</sup> (1/8), y así sucesivamente. Si el valor decimal no se puede representar exactamente como una suma de 2<sup>-n</sup>, no se puede convertir completamente a binario y ocurrirá un error de precisión. En ese caso, DenCode lo muestra abreviado añadiendo de "..." al final.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Decimal</th><th>Binario</th><th>Octal</th><th>Hexadecimal</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
