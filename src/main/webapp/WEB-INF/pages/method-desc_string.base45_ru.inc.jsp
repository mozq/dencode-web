<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О Base45</h3>
<p>Base45 - это схема кодирования, в которой используются 7-битные печатаемые символы ASCII.</p>
<p>Base45 делит данные на два байта и преобразует их в три символа ASCII для их представления.</p>

<p>Символы ASCII, используемые в Base45, следующие: рассматривайте 2-байтовое значение как big-endian беззнаковое целое число, вычислите каждую цифру (3 разряда) 45-значного числа, а затем найдите результат преобразования Base45 на основе следующих символов ASCII.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Десятичной системы 45</th><th>Base45 ASCII символов</th></tr>
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

<p>Например, если вы преобразуете "Hello" с помощью Base45, вы получите следующее</p>

<p>1. Разделяйте каждые два байта.</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. Каждые два байта рассматриваются как беззнаковое целое число big-endian, и значение преобразуется в три цифры в каждой из 45 десятичных систем. Если конец представляет собой один байт, значение преобразуется в две цифры 45 десятичной системы счисления.</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. Преобразует каждые три цифры десятичной системы 45 в символы ASCII в обратном порядке.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Десятичной системы 45</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Base45 ASCII символов</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. Все символы соединяются вместе и образуют результат преобразования Base45.</p>

<pre>%69 VDL2</pre>

<h3>О Base45/Zlib/COSE/CBOR</h3>
<p>Base45/Zlib/COSE/CBOR - это данные, выраженные в формате CBOR, подписанные в формате COSE, сжатые в формате Zlib и преобразованные в формат Base45.</p>
<p><a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (EU Digital COVID Certificate)</a> используется в качестве формата данных для QR-кодов. EUDCC является общим форматом для сертификатов вакцинации COVID-19 в ЕС и также известен как DGC (EU Digital Green Certificate) или Green Pass.</p>
<p>DenCode поддерживает только декодирование, а результат декодирования представлен в формате JSON. Действительность подписи не проверяется.</p>
