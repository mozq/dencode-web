<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Base45에 대해서</h3>
<p>Base45는 7비트 인쇄 가능한 ASCII 문자를 사용한 부호화 방식입니다.</p>
<p>Base45에서는 데이터를 2바이트씩 분할하고, 그것들을 3문자의 ASCII 문자로 변환하여 나타냅니다.</p>

<p>Base45에서 사용되는 ASCII 문자는 다음과 같습니다. 2바이트 값을 빅 엔디안 부호 없는 정수로 취급하고, 그것을 45진법의 각 자릿수(3자리)를 계산한 뒤, 다음 ASCII 문자를 바탕으로 Base45 변환 결과를 구합니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>45진법 자릿수</th><th>Base45 ASCII 문자</th></tr>
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

<p>예를 들어, 'Hello'를 Base45로 변환하면 다음과 같습니다.</p>

<p>1. 2바이트마다 구분한다.</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. 2바이트마다 빅 엔디안 부호 없는 정수로 취급하여, 그 값을 45진법의 각 3자리로 변환한다. 말미가 1바이트였던 경우는 45진법의 2자리로 변환한다.</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. 45진법의 각 3자리를 역순으로 ASCII 문자로 변환한다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>45진법 자릿수</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Base45 ASCII 문자</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. 문자를 모두 연결하여 Base45 변환 결과로 한다.</p>

<pre>%69 VDL2</pre>

<h3>Base45/Zlib/COSE/CBOR에 대해서</h3>
<p>Base45/Zlib/COSE/CBOR는 CBOR 형식으로 표현된 데이터를 COSE 형식으로 서명한 후, Zlib 형식으로 압축하고, Base45 형식으로 변환한 것입니다.</p>
<p><a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (EU Digital COVID Certificate)</a>의 QR 코드 데이터 형식으로 사용되고 있습니다. EUDCC는 EU에서의 COVID-19 백신 접종 증명서의 공통 포맷이며, DGC (EU Digital Green Certificate)나 Green Pass라고도 불립니다.</p>
<p>DenCode에서는 디코딩에만 대응하고 있으며, 디코딩한 결과는 JSON 형식으로 나타냅니다. 서명의 유효성은 검증하지 않습니다.</p>
