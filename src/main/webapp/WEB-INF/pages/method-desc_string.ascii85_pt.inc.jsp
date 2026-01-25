<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Ascii85</h3>
<p>Ascii85 é um método de codificação que utiliza caracteres ASCII imprimíveis de 7 bits. Também é chamado de Base85.</p>
<p>No Ascii85, os dados são divididos em 4 bytes cada e convertidos em 5 caracteres ASCII.</p>
<p>Existem várias variantes do Ascii85. O DenCode suporta os três tipos seguintes de Ascii85. O original é btoa, e Adobe e Z85 apareceram depois.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Visão Geral</th></tr>
		<tr><th>Z85</th><td>Usado no ZeroMQ. Projetado para evitar o uso de caracteres que requerem escape, como "\" (barra invertida) e "'" (apóstrofo).</td></tr>
		<tr><th>Adobe</th><td>Usado para codificar imagens, etc., dentro de arquivos Adobe PostScript e PDF (Portable Document Format). É delimitado por "&lt;~" e "~&gt;".</td></tr>
		<tr><th>btoa</th><td>Formato do comando btoa do UNIX. Usado para troca de dados binários no passado, mas não é comum hoje em dia. Delimitado por linhas "xbtoa Begin" e "xbtoa End".</td></tr>
	</table>
</div>

<p>Os caracteres ASCII usados no Ascii85 são os seguintes. Um valor de 4 bytes é tratado como um inteiro sem sinal big-endian, cada dígito na base 85 (5 dígitos) é calculado e o resultado da conversão Ascii85 é obtido com base nos seguintes caracteres ASCII.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Caracteres ASCII</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(Originalmente eram os caracteres de " " (espaço) a "t", mas como alguns mailers removiam espaços finais, eles foram substituídos por caracteres de "!" a "u", excluindo o espaço.)</td></tr>
	</table>
</div>

<p>Por exemplo, converter "Hello" em Ascii85 resulta no seguinte:</p>

<p>1. Divida a cada 4 bytes. Se for menor que 4 bytes, preencha o final com "00".</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. Trate cada 4 bytes como um inteiro sem sinal big-endian e converta o valor para cada dígito na base 85.</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. Converta cada dígito da base 85 em caracteres ASCII. Se o final foi preenchido com "00", exclua o preenchimento no caso de Adobe/Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. Conecte todos os caracteres para obter o resultado da conversão Ascii85. Adobe é delimitado por "&lt;~" &amp; "~&gt;" e quebra a linha a cada 80 caracteres. btoa é delimitado por "xbtoa Begin" &amp; "xbtoa End" (incluindo comprimento de dados, soma de verificação, etc.) e quebra a linha a cada 78 caracteres.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Resultado da conversão</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>Além disso, algumas formas abreviadas são definidas.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Forma abreviada</th></tr>
		<tr><th>Z85</th><td>Nenhuma</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2 ou posterior)<br /></td></tr>
	</table>
</div>
