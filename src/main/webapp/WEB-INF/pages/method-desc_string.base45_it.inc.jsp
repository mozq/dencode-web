<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni su Base45</h3>
<p>Base45 è uno schema di codifica che utilizza caratteri ASCII stampabili a 7 bit.</p>
<p>Base45 divide i dati in blocchi di 2 byte e li converte in 3 caratteri ASCII.</p>

<p>I caratteri ASCII utilizzati in Base45 sono i seguenti. Tratta un valore di 2 byte come un intero senza segno big-endian, calcola le cifre in base 45 (3 cifre) e ottiene il risultato della conversione Base45 basato sui seguenti caratteri ASCII.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Cifra Base 45</th><th>Carattere Base45 ASCII</th></tr>
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

<p>Ad esempio, la conversione di "Hello" in Base45 è la seguente.</p>

<p>1. Dividi ogni 2 byte.</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. Tratta ogni 2 byte come un intero senza segno big-endian e converti il valore in 3 cifre in base 45. Se l'ultima parte è di 1 byte, converti in 2 cifre in base 45.</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. Converti ogni cifra in base 45 in un carattere ASCII in ordine inverso.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Cifra Base 45</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Carattere Base45 ASCII</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. Unisci tutti i caratteri per il risultato finale.</p>

<pre>%69 VDL2</pre>

<h3>Informazioni su Base45/Zlib/COSE/CBOR</h3>
<p>Base45/Zlib/COSE/CBOR sono dati in formato CBOR firmati in formato COSE, compressi in formato Zlib e convertiti in formato Base45.</p>
<p>È utilizzato come formato dati per i codici QR del <a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (EU Digital COVID Certificate)</a>. EUDCC è un formato comune per i certificati di vaccinazione COVID-19 nell'UE, chiamato anche DGC (EU Digital Green Certificate) o Green Pass.</p>
<p>DenCode supporta solo la decodifica e mostra il risultato decodificato in formato JSON. Non verifica la validità della firma.</p>
