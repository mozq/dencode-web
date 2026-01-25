<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Números Hexadecimais</h3>
<p>Números hexadecimais representam valores em notação hexadecimal.</p>

<p>Em hexadecimal, números são representados usando a base 16 com "0123456789ABCDEF". Os números decimais de 0 a 9 são representados como 0 a 9 em hexadecimal, e 10 a 15 são representados como A a F.</p>

<p>Exemplos de conversão em hexadecimal são os seguintes. Para referência, exemplos de conversão para binário e octal também estão listados.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Decimal</th><th>Binário</th><th>Octal</th><th>Hexadecimal</th></tr>
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

<p>Além disso, números após o ponto decimal são convertidos como valores de cada posição: 16<sup>-1</sup> (1/16), 16<sup>-2</sup> (1/256), 16<sup>-3</sup> (1/4096), ... Se o valor após o ponto decimal não puder ser representado pela soma de 16<sup>-n</sup>, ele não pode ser convertido completamente para hexadecimal e ocorrerá um erro. Nesse caso, o DenCode o representa abreviado adicionando "..." ao final.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Decimal</th><th>Binário</th><th>Octal</th><th>Hexadecimal</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
