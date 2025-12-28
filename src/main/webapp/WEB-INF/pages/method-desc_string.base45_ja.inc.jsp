<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Base45について</h3>
<p>Base45は、7ビットの印字可能なASCII文字を使用した符号化方式です。</p>
<p>Base45では、データを2バイトずつに分割し、それらを3文字のASCII文字に変換して表します。</p>

<p>Base45で使用されるASCII文字は以下のとおりです。2バイトの値をビッグエンディアンの符号なし整数として扱い、それを45進法の各桁(3桁)を計算したうえで、以下のASCII文字をもとにBase45の変換結果を求めます。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>45進法の桁</th><th>Base45 ASCII文字</th></tr>
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

<p>例えば、「Hello」をBase45で変換すると以下のようになります。</p>

<p>1. 2バイトごとに区切る。</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. 2バイトごとにビッグエンディアンの符号なし整数として扱い、その値を45進法の各3桁に変換する。末尾が1バイトだった場合は45進法の2桁に変換する。</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. 45進法の各3桁を逆順でASCII文字に変換する。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>45進法の桁</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Base45 ASCII文字</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. 文字を全て繋げてBase45の変換結果とする。</p>

<pre>%69 VDL2</pre>

<h3>Base45/Zlib/COSE/CBORについて</h3>
<p>Base45/Zlib/COSE/CBORは、CBOR形式で表されたデータをCOSE形式で署名したのち、Zlib形式で圧縮し、Base45形式に変換したものです。</p>
<p><a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (EU Digital COVID Certificate)</a> のQRコードのデータ形式として使用されています。EUDCCはEUにおけるCOVID-19のワクチン接種証明書の共通フォーマットであり、DGC (EU Digital Green Certificate) や Green Pass とも呼ばれています。</p>
<p>DenCodeではデコードのみに対応しており、デコードした結果はJSON形式で表しています。署名の有効性は検証していません。</p>
