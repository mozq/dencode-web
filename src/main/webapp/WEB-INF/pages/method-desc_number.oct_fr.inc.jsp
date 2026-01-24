<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos des nombres octaux</h3>
<p>Les nombres octaux représentent les valeurs numériques dans le système de numération octal.</p>

<p>En octal, les nombres sont représentés en base 8 avec "01234567".</p>

<p>Des exemples de conversion octale sont présentés ci-dessous. Pour référence, des exemples de conversion binaire et hexadécimale sont également inclus.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Décimal</th><th>Binaire</th><th>Octal</th><th>Hexadécimal</th></tr>
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

<p>De plus, les nombres après la virgule sont convertis en octal comme valeurs de chaque position : 8<sup>-1</sup> (1/8), 8<sup>-2</sup> (1/64), 8<sup>-3</sup> (1/512), ... Si la partie fractionnaire ne peut pas être représentée par la somme de 8<sup>-n</sup>, elle ne peut pas être convertie complètement en octal et une erreur se produit. Dans ce cas, DenCode l'exprime en ajoutant "..." à la fin pour indiquer l'omission.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Décimal</th><th>Binaire</th><th>Octal</th><th>Hexadécimal</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
