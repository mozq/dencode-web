<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 Base45</h3>
<p>Base45 是使用 7 位可打印 ASCII 字符的编码方式。</p>
<p>在 Base45 中，数据被每 2 个字节分为一组，并转换为 3 个 ASCII 字符来表示。</p>

<p>Base45 使用的 ASCII 字符如下。将 2 字节的值视为大端无符号整数，计算该值的 45 进制各数位（3 位），然后根据以下 ASCII 字符得出 Base45 转换结果。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>45进制数位</th><th>Base45 ASCII 字符</th></tr>
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

<p>例如，将“Hello”用 Base45 转换如下。</p>

<p>1. 每 2 个字节分隔。</p>

<pre>4865<sub>(16)</sub> 6C6C<sub>(16)</sub> 6F<sub>(16)</sub>  (He ll o)</pre>

<p>2. 将每 2 个字节视为大端无符号整数，转换为 45 进制的各 3 位数位。如果末尾是 1 个字节，则转换为 45 进制的 2 位数位。</p>

<pre>4865<sub>(16)</sub>
= 18533<sub>(10)</sub>
= <b>9</b> * 45<sup>2</sup> + <b>6</b> * 45 + <b>38</b></pre>

<pre>6C6C<sub>(16)</sub>
= 27756<sub>(10)</sub>
= <b>13</b> * 45<sup>2</sup> + <b>31</b> * 45 + <b>36</b></pre>

<pre>6F<sub>(16)</sub>
= 111<sub>(10)</sub>
= <b>2</b> * 45 + <b>21</b></pre>

<p>3. 将 45 进制的各 3 位数位按逆序转换为 ASCII 字符。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>45进制数位</th><td>38</td><td>6</td><td>9</td><td></td><td>36</td><td>31</td><td>13</td><td></td><td>21</td><td>2</td></tr>
		<tr><th>Base45 ASCII 字符</th><td>%</td><td>6</td><td>9</td><td></td><td> [SP]</td><td>V</td><td>D</td><td></td><td>L</td><td>2</td></tr>
	</table>
</div>

<p>4. 连接所有字符作为 Base45 转换结果。</p>

<pre>%69 VDL2</pre>

<h3>关于 Base45/Zlib/COSE/CBOR</h3>
<p>Base45/Zlib/COSE/CBOR 是将 CBOR 格式的数据用 COSE 格式签名后，用 Zlib 格式压缩，再转换为 Base45 格式。</p>
<p>它被用作 <a href="https://ec.europa.eu/info/live-work-travel-eu/coronavirus-response/safe-covid-19-vaccines-europeans/eu-digital-covid-certificate_en" target="_blank">EUDCC (EU Digital COVID Certificate)</a> 的二维码数据格式。EUDCC 是欧盟的 COVID-19 疫苗接种证书通用格式，也被称为 DGC (EU Digital Green Certificate) 或 Green Pass。</p>
<p>DenCode 仅支持解码，解码结果以 JSON 格式表示。不验证签名的有效性。</p>
