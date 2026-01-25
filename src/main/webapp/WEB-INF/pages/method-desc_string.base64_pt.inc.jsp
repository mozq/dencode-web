<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Base64</h3>
<p>Base64 é um método de codificação que utiliza caracteres ASCII imprimíveis de 7 bits. É usado principalmente em e-mail para transferir dados de 8 bits através de um caminho de dados de 7 bits.</p>
<p>No Base64, os dados são divididos em 6 bits cada e convertidos em caracteres alfanuméricos (A-Z, a-z, 0-9) e símbolos (+, /). A conversão é feita a cada 4 caracteres, e se o final for menor que 4 caracteres, é preenchido com o sinal de igual (=).</p>
<p>Além disso, a RFC 1421 (PEM: Privacy-Enhanced Mail) especifica uma quebra de linha a cada 64 caracteres, e a RFC 2045 (MIME) a cada 76 caracteres.</p>

<p>A tabela de conversão para caracteres Base64 é a seguinte:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Dados de 6 bits</th><th>Caractere Base64</th></tr>
		<tr><td>000000</td><td>A</td></tr>
		<tr><td>000001</td><td>B</td></tr>
		<tr><td>000010</td><td>C</td></tr>
		<tr><td>000011</td><td>D</td></tr>
		<tr><td>000100</td><td>E</td></tr>
		<tr><td>000101</td><td>F</td></tr>
		<tr><td>000110</td><td>G</td></tr>
		<tr><td>000111</td><td>H</td></tr>
		<tr><td>001000</td><td>I</td></tr>
		<tr><td>001001</td><td>J</td></tr>
		<tr><td>001010</td><td>K</td></tr>
		<tr><td>001011</td><td>L</td></tr>
		<tr><td>001100</td><td>M</td></tr>
		<tr><td>001101</td><td>N</td></tr>
		<tr><td>001110</td><td>O</td></tr>
		<tr><td>001111</td><td>P</td></tr>
		<tr><td>010000</td><td>Q</td></tr>
		<tr><td>010001</td><td>R</td></tr>
		<tr><td>010010</td><td>S</td></tr>
		<tr><td>010011</td><td>T</td></tr>
		<tr><td>010100</td><td>U</td></tr>
		<tr><td>010101</td><td>V</td></tr>
		<tr><td>010110</td><td>W</td></tr>
		<tr><td>010111</td><td>X</td></tr>
		<tr><td>011000</td><td>Y</td></tr>
		<tr><td>011001</td><td>Z</td></tr>
		<tr><td>011010</td><td>a</td></tr>
		<tr><td>011011</td><td>b</td></tr>
		<tr><td>011100</td><td>c</td></tr>
		<tr><td>011101</td><td>d</td></tr>
		<tr><td>011110</td><td>e</td></tr>
		<tr><td>011111</td><td>f</td></tr>
		<tr><td>100000</td><td>g</td></tr>
		<tr><td>100001</td><td>h</td></tr>
		<tr><td>100010</td><td>i</td></tr>
		<tr><td>100011</td><td>j</td></tr>
		<tr><td>100100</td><td>k</td></tr>
		<tr><td>100101</td><td>l</td></tr>
		<tr><td>100110</td><td>m</td></tr>
		<tr><td>100111</td><td>n</td></tr>
		<tr><td>101000</td><td>o</td></tr>
		<tr><td>101001</td><td>p</td></tr>
		<tr><td>101010</td><td>q</td></tr>
		<tr><td>101011</td><td>r</td></tr>
		<tr><td>101100</td><td>s</td></tr>
		<tr><td>101101</td><td>t</td></tr>
		<tr><td>101110</td><td>u</td></tr>
		<tr><td>101111</td><td>v</td></tr>
		<tr><td>110000</td><td>w</td></tr>
		<tr><td>110001</td><td>x</td></tr>
		<tr><td>110010</td><td>y</td></tr>
		<tr><td>110011</td><td>z</td></tr>
		<tr><td>110100</td><td>0</td></tr>
		<tr><td>110101</td><td>1</td></tr>
		<tr><td>110110</td><td>2</td></tr>
		<tr><td>110111</td><td>3</td></tr>
		<tr><td>111000</td><td>4</td></tr>
		<tr><td>111001</td><td>5</td></tr>
		<tr><td>111010</td><td>6</td></tr>
		<tr><td>111011</td><td>7</td></tr>
		<tr><td>111100</td><td>8</td></tr>
		<tr><td>111101</td><td>9</td></tr>
		<tr><td>111110</td><td>+</td></tr>
		<tr><td>111111</td><td>/</td></tr>
	</table>
</div>

<p>Por exemplo, converter "Hello" em Base64 resulta no seguinte:</p>

<p>1. Converta para representação binária.</p>

<pre>01001000 01100101 01101100 01101100 01101111  (No caso de US-ASCII / UTF-8)</pre>

<p>2. Divida a cada 6 bits. Se for menor que 6 bits, preencha o final com "0".</p>

<pre>010010 000110 010101 101100 011011 000110 111100</pre>

<p>3. Converta para caracteres usando a tabela de conversão. Converta a cada 4 caracteres, e se for menor que 4 caracteres, preencha o final com "=".</p>

<pre>SGVs bG8=</pre>

<p>4. Conecte todos os caracteres para obter o resultado da conversão Base64.</p>

<pre>SGVsbG8=</pre>


<h4>Formato de cabeçalho de mensagem MIME de e-mail (RFC 2047)</h4>
<p>O DenCode também suporta a decodificação do seguinte formato de cabeçalho de mensagem MIME (RFC 2047). Este formato é usado quando o assunto ou destinatário do e-mail contém caracteres não ASCII.</p>

<pre>Subject: =?UTF-8?B?44K144Oz44OX44Or?=</pre>

<p>O resultado após a decodificação é o seguinte:</p>

<pre>Subject: サンプル</pre>
