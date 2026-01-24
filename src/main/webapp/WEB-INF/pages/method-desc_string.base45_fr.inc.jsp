<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos de Base45</h3>
<p>Base45 est un schéma de codage utilisant des caractères ASCII imprimables sur 7 bits.</p>
<p>Dans Base45, les données sont divisées en groupes de 2 octets et converties en 3 caractères ASCII.</p>

<p>Les caractères ASCII utilisés dans Base45 sont les suivants. Une valeur de 2 octets est traitée comme un entier non signé big-endian, calculée pour chaque chiffre en base 45 (3 chiffres), et le résultat de la conversion Base45 est déterminé sur la base des caractères ASCII suivants.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Chiffre en base 45</th><th>Caractère ASCII Base45</th></tr>
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

<p>Par exemple, la conversion de "Hello" en Base45 donne ce qui suit.</p>

<p>1. Diviser par 2 octets.</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. Traiter chaque bloc de 2 octets comme un entier non signé big-endian et convertir cette valeur en chaque chiffre de la base 45 (3 chiffres). Si la fin est de 1 octet, convertir en 2 chiffres de la base 45.</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. Convertir chaque chiffre de la base 45 en caractère ASCII dans l'ordre inverse.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Chiffre en base 45</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Caractère ASCII Base45</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. Concaténer tous les caractères pour obtenir le résultat de la conversion Base45.</p>

<pre>%69 VDL2</pre>

<h3>À propos de Base45/Zlib/COSE/CBOR</h3>
<p>Base45/Zlib/COSE/CBOR sont des données au format CBOR, signées au format COSE, puis compressées au format Zlib et converties au format Base45.</p>
<p>Il est utilisé comme format de données pour le code QR du <a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (Certificat numérique COVID de l'UE)</a>. EUDCC est un format commun pour les certificats de vaccination COVID-19 dans l'UE, également appelé DGC (Digital Green Certificate) ou Green Pass.</p>
<p>DenCode ne prend en charge que le décodage, et le résultat décodé est exprimé au format JSON. La validité de la signature n'est pas vérifiée.</p>
