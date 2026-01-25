<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Base45</h3>
<p>Base45 é um método de codificação que utiliza caracteres ASCII imprimíveis de 7 bits.</p>
<p>No Base45, os dados são divididos em 2 bytes cada e convertidos em 3 caracteres ASCII.</p>

<p>Os caracteres ASCII usados no Base45 são os seguintes. Um valor de 2 bytes é tratado como um inteiro sem sinal big-endian, cada dígito na base 45 (3 dígitos) é calculado e o resultado da conversão Base45 é obtido com base nos seguintes caracteres ASCII.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Dígito Base 45</th><th>Caractere ASCII Base45</th></tr>
		<tr><td>0</td><td>0</td></tr>
		<tr><td>1</td><td>1</td></tr>
		<tr><td>2</td><td>2</td></tr>
		<tr><td>3</td><td>3</td></tr>
		<tr><td>4</td><td>4</td></tr>
		<tr><td>5</td><td>5</td></tr>
		<tr><td>6</td><td>6</td></tr>
		<tr><td>7</td><td>7</td></tr>
		<tr><td>8</td><td>8</td></tr>
		<tr><td>9</td><td>9</td></tr>
		<tr><td>10</td><td>A</td></tr>
		<tr><td>11</td><td>B</td></tr>
		<tr><td>12</td><td>C</td></tr>
		<tr><td>13</td><td>D</td></tr>
		<tr><td>14</td><td>E</td></tr>
		<tr><td>15</td><td>F</td></tr>
		<tr><td>16</td><td>G</td></tr>
		<tr><td>17</td><td>H</td></tr>
		<tr><td>18</td><td>I</td></tr>
		<tr><td>19</td><td>J</td></tr>
		<tr><td>20</td><td>K</td></tr>
		<tr><td>21</td><td>L</td></tr>
		<tr><td>22</td><td>M</td></tr>
		<tr><td>23</td><td>N</td></tr>
		<tr><td>24</td><td>O</td></tr>
		<tr><td>25</td><td>P</td></tr>
		<tr><td>26</td><td>Q</td></tr>
		<tr><td>27</td><td>R</td></tr>
		<tr><td>28</td><td>S</td></tr>
		<tr><td>29</td><td>T</td></tr>
		<tr><td>30</td><td>U</td></tr>
		<tr><td>31</td><td>V</td></tr>
		<tr><td>32</td><td>W</td></tr>
		<tr><td>33</td><td>X</td></tr>
		<tr><td>34</td><td>Y</td></tr>
		<tr><td>35</td><td>Z</td></tr>
		<tr><td>36</td><td> [SP]</td></tr>
		<tr><td>37</td><td>$</td></tr>
		<tr><td>38</td><td>%</td></tr>
		<tr><td>39</td><td>*</td></tr>
		<tr><td>40</td><td>+</td></tr>
		<tr><td>41</td><td>-</td></tr>
		<tr><td>42</td><td>.</td></tr>
		<tr><td>43</td><td>/</td></tr>
	</table>
</div>

<p>Por exemplo, converter "Hello" em Base45 resulta no seguinte:</p>

<p>1. Divida a cada 2 bytes.</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. Trate cada 2 bytes como um inteiro sem sinal big-endian e converta o valor para cada 3 dígitos na base 45. Se o final for 1 byte, converta para 2 dígitos na base 45.</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. Converta cada 3 dígitos da base 45 para caracteres ASCII na ordem inversa.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Dígito Base 45</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Caractere ASCII Base45</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. Conecte todos os caracteres para obter o resultado da conversão Base45.</p>

<pre>%69 VDL2</pre>

<h3>Sobre Base45/Zlib/COSE/CBOR</h3>
<p>Base45/Zlib/COSE/CBOR são dados expressos no formato CBOR, assinados no formato COSE, comprimidos no formato Zlib e convertidos para o formato Base45.</p>
<p>É usado como o formato de dados para o código QR do <a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (Certificado Digital COVID da UE)</a>. EUDCC é um formato comum para certificados de vacinação COVID-19 na UE, e também é chamado de DGC (Certificado Verde Digital da UE) ou Green Pass.</p>
<p>O DenCode suporta apenas a decodificação, e o resultado decodificado é expresso no formato JSON. A validade da assinatura não é verificada.</p>
