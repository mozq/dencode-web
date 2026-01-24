<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über Base45</h3>
<p>Base45 ist eine Kodierung, die 7-Bit druckbare ASCII-Zeichen verwendet.</p>
<p>Base45 teilt Daten in 2-Byte-Blöcke und wandelt sie in 3 ASCII-Zeichen um.</p>

<p>Ein 2-Byte-Wert wird als vorzeichenlose Big-Endian-Ganzzahl behandelt, in 3 Stellen zur Basis 45 umgerechnet und dann anhand der folgenden Tabelle in ASCII-Zeichen umgewandelt.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Basis-45-Wert</th><th>Base45 ASCII-Zeichen</th></tr>
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
		<tr><td>36</td><td>[SP]</td></tr>
		<tr><td>37</td><td>$</td></tr>
		<tr><td>38</td><td>%</td></tr>
		<tr><td>39</td><td>*</td></tr>
		<tr><td>40</td><td>+</td></tr>
		<tr><td>41</td><td>-</td></tr>
		<tr><td>42</td><td>.</td></tr>
		<tr><td>43</td><td>/</td></tr>
	</table>
</div>

<p>Beispiel für die Konvertierung von „Hello“ in Base45:</p>

<p>1. In 2-Byte-Blöcke teilen.</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. Als 2-Byte Big-Endian Integer interpretieren und in Basis-45 (3 Stellen) umwandeln. Wenn der letzte Block nur 1 Byte hat, in 2 Stellen umwandeln.</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. Jede Basis-45-Ziffer in umgekehrter Reihenfolge in ein ASCII-Zeichen umwandeln.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Basis-45-Wert</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Base45 ASCII-Zeichen</th><td>%</td><td>6</td><td>9</td><td></td><td>[SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. Zeichen verbinden.</p>

<pre>%69 VDL2</pre>

<h3>Über Base45/Zlib/COSE/CBOR</h3>
<p>Base45/Zlib/COSE/CBOR sind Daten im CBOR-Format, die im COSE-Format signiert, dann mit Zlib komprimiert und schließlich in Base45 kodiert wurden.</p>
<p>Dies wird im QR-Code des <a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (EU Digital COVID Certificate)</a> verwendet. EUDCC ist das Format für COVID-19-Zertifikate in der EU, auch DGC oder Green Pass genannt.</p>
<p>DenCode unterstützt nur die Dekodierung. Das Ergebnis wird als JSON angezeigt. Die Gültigkeit der Signatur wird nicht überprüft.</p>
