<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 Base45</h3>
<p>Base45 是使用 7 位元可列印 ASCII 字元的編碼方式。</p>
<p>在 Base45 中，資料被每 2 個位元組分為一組，並轉換為 3 個 ASCII 字元來表示。</p>

<p>Base45 使用的 ASCII 字元如下。將 2 位元組的值視為大端無號整數，計算該值的 45 進位各數位（3 位），然後根據以下 ASCII 字元得出 Base45 轉換結果。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>45進位數位</th><th>Base45 ASCII 字元</th></tr>
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

<p>例如，將「Hello」用 Base45 轉換如下。</p>

<p>1. 每 2 個位元組分隔。</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. 將每 2 個位元組視為大端無號整數，轉換為 45 進位的各 3 位數位。如果末尾是 1 個位元組，則轉換為 45 進位的 2 位數位。</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. 將 45 進位的各 3 位數位按逆序轉換為 ASCII 字元。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>45進位數位</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Base45 ASCII 字元</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. 連接所有字元作為 Base45 轉換結果。</p>

<pre>%69 VDL2</pre>

<h3>關於 Base45/Zlib/COSE/CBOR</h3>
<p>Base45/Zlib/COSE/CBOR 是將 CBOR 格式的資料用 COSE 格式簽章後，用 Zlib 格式壓縮，再轉換為 Base45 格式。</p>
<p>它被用作 <a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (EU Digital COVID Certificate)</a> 的 QR 碼資料格式。EUDCC 是歐盟的 COVID-19 疫苗接種證書通用格式，也被稱為 DGC (EU Digital Green Certificate) 或 Green Pass。</p>
<p>DenCode 僅支援解碼，解碼結果以 JSON 格式表示。不驗證簽章的有效性。</p>
