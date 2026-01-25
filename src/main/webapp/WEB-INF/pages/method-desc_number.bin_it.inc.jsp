<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sui Numeri Binari</h3>
<p>I numeri binari rappresentano valori numerici nel sistema di numerazione in base 2.</p>

<p>Nel sistema binario, i numeri sono espressi utilizzando la base 2 con le cifre "0" e "1".</p>

<p>Di seguito sono riportati esempi di conversione in numeri binari. Per riferimento, sono inclusi anche esempi di conversione in ottale ed esadecimale.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Decinale</th><th>Binario</th><th>Ottale</th><th>Esadecimale</th></tr>
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

<p>Inoltre, i valori decimali frazionari sono convertiti in binario come valori posizionali di 2<sup>-1</sup> (1/2), 2<sup>-2</sup> (1/4), 2<sup>-3</sup> (1/8), ... Se il valore decimale non può essere espresso esattamente come somma di potenze 2<sup>-n</sup>, non può essere convertito completamente in binario e si verifica un errore di approssimazione. In tal caso, DenCode aggiunge "..." alla fine per indicare che il valore è troncato.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Decinale</th><th>Binario</th><th>Ottale</th><th>Esadecimale</th></tr>
		</thead>
		<tbody>
			<tr><td>0.5</td><td>0.1</td><td>0.4</td><td>0.8</td></tr>
			<tr><td>0.75</td><td>0.11</td><td>0.6</td><td>0.C</td></tr>
			<tr><td>0.9</td><td>0.11100110011001...</td><td>0.71463...</td><td>0.E666...</td></tr>
		</tbody>
	</table>
</div>
