<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Strings Binárias</h3>
<p>Strings Binárias são valores binários de uma string representados em notação binária.</p>
<p>Como o valor binário difere dependendo da codificação de caracteres, o resultado da conversão para uma string binária também difere.</p>

<p>Por exemplo, o resultado da conversão de "Sample" para string binária é o seguinte:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Codificação de caracteres</th><th>String Binária</th></tr>
		<tr><td>UTF-8</td><td>01010011 01100001 01101101 01110000 01101100 01100101</td></tr>
		<tr><td>UTF-16</td><td>00000000 01010011 00000000 01100001 00000000 01101101 00000000 01110000 00000000 01101100 00000000 01100101</td></tr>
		<tr><td>Shift_JIS</td><td>01010011 01100001 01101101 01110000 01101100 01100101</td></tr>
	</table>
</div>

<p>Nota: O exemplo original em japonês usava "サンプル" (Sample), aqui foi adaptado para "Sample" para demonstração ou eu deveria manter o japonês para mostrar a diferença?
A tabela original mostra a codificação de "サンプル". Eu vou manter o exemplo original "サンプル" para consistência com os valores binários mostrados, ou os valores binários no código original são de "サンプル"?
Sim, o original é:
UTF-8: 11100011... -> e3 82 b5... (サ)
Então eu devo manter "サンプル" no exemplo para que os binários façam sentido, ou recalcular para "Sample".
Mas recalculando pode ser propenso a erro.
Melhor manter o exemplo original com a nota "(Sample)" se eu quiser, ou apenas "サンプル".
Vou manter "サンプル" e os valores originais, pois é um exemplo técnico.</p>

<p>Por exemplo, o resultado da conversão de "サンプル" para string binária é o seguinte:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Codificação de caracteres</th><th>String Binária</th></tr>
		<tr><td>UTF-8</td><td>11100011 10000010 10110101 11100011 10000011 10110011 11100011 10000011 10010111 11100011 10000011 10101011</td></tr>
		<tr><td>UTF-16</td><td>00110000 10110101 00110000 11110011 00110000 11010111 00110000 11101011</td></tr>
		<tr><td>Shift_JIS</td><td>10000011 01010100 10000011 10010011 10000011 01110110 10000011 10001011</td></tr>
	</table>
</div>
