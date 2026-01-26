<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Base45</h3>
<p>Base45 es un método de codificación que utiliza caracteres ASCII imprimibles de 7 bits.</p>
<p>En Base45, los datos se dividen en 2 bytes cada uno y se convierten en 3 caracteres ASCII.</p>

<p>Los caracteres ASCII utilizados en Base45 son los siguientes. Se trata un valor de 2 bytes como un entero sin signo big-endian, se calcula cada dígito (3 dígitos) en base 45, y se obtiene el resultado de conversión Base45 basado en los siguientes caracteres ASCII.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Dígito Base 45</th><th>Carácter ASCII Base45</th></tr>
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

<p>Por ejemplo, convertir "Hello" en Base45 da el siguiente resultado:</p>

<p>1. Dividir en grupos de 2 bytes.</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. Tratar cada 2 bytes como un entero sin signo big-endian y convertir ese valor a 3 dígitos en base 45. Si el último es 1 byte, convertir a 2 dígitos en base 45.</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. Convertir cada 3 dígitos base 45 a caracteres ASCII en orden inverso.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Dígito Base 45</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Carácter ASCII Base45</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. Unir todos los caracteres para obtener el resultado de la conversión Base45.</p>

<pre>%69 VDL2</pre>

<h3>Sobre Base45/Zlib/COSE/CBOR</h3>
<p>Base45/Zlib/COSE/CBOR son datos representados en formato CBOR, firmados en formato COSE, comprimidos en formato Zlib y convertidos a formato Base45.</p>
<p>Se utiliza como formato de datos para el código QR del <a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (Certificado COVID Digital de la UE)</a>. EUDCC es un formato común para certificados de vacunación COVID-19 en la UE, también conocido como DGC (Certificado Verde Digital de la UE) o Green Pass.</p>
<p>DenCode solo soporta la decodificación, y el resultado decodificado se representa en formato JSON. No se verifica la validez de la firma.</p>
