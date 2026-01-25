<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Base64에 대해서</h3>
<p>Base64는 7비트 인쇄 가능한 ASCII 문자를 사용한 부호화 방식입니다. 주로 전자 메일에서 8비트 데이터를 7비트 데이터 경로로 전송하기 위해 사용합니다.</p>
<p>Base64에서는 데이터를 6비트씩 분할하고, 그것들을 영숫자(A-Z, a-z, 0-9)나 기호(+, /) 문자로 변환하여 나타냅니다. 4문자마다 변환하고, 마지막이 4문자에 미치지 못하는 경우는 등호 기호(=)로 패딩합니다.</p>
<p>또한 RFC 1421 (PEM: Privacy-Enhanced Mail)에서는 64문자마다 개행, RFC 2045 (MIME)에서는 76문자마다 개행하는 것이 규정되어 있습니다.</p>

<p>Base64 문자 변환표는 다음과 같습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>6비트 데이터</th><th>Base64 문자</th></tr>
		<tr><td>000000</td><td>A</td></tr>
		<tr><td>000001</td><td>B</td></tr>
		<tr><td>000010</td><td>C</td></tr>
		<tr><td>000011</td><td>D</td></tr>
		<tr><td>000100</td><td>E</td></tr>
		<tr><td>000101</td><td>F</td></tr>
		<tr><td>000110</td><td>G</td></tr>
		<tr><td>000111</td><td>H</td></tr>
		<tr><td>001000</td><td>I</td></tr>
		<tr><td>001001</td><td>J</td></tr>
		<tr><td>001010</td><td>K</td></tr>
		<tr><td>001011</td><td>L</td></tr>
		<tr><td>001100</td><td>M</td></tr>
		<tr><td>001101</td><td>N</td></tr>
		<tr><td>001110</td><td>O</td></tr>
		<tr><td>001111</td><td>P</td></tr>
		<tr><td>010000</td><td>Q</td></tr>
		<tr><td>010001</td><td>R</td></tr>
		<tr><td>010010</td><td>S</td></tr>
		<tr><td>010011</td><td>T</td></tr>
		<tr><td>010100</td><td>U</td></tr>
		<tr><td>010101</td><td>V</td></tr>
		<tr><td>010110</td><td>W</td></tr>
		<tr><td>010111</td><td>X</td></tr>
		<tr><td>011000</td><td>Y</td></tr>
		<tr><td>011001</td><td>Z</td></tr>
		<tr><td>011010</td><td>a</td></tr>
		<tr><td>011011</td><td>b</td></tr>
		<tr><td>011100</td><td>c</td></tr>
		<tr><td>011101</td><td>d</td></tr>
		<tr><td>011110</td><td>e</td></tr>
		<tr><td>011111</td><td>f</td></tr>
		<tr><td>100000</td><td>g</td></tr>
		<tr><td>100001</td><td>h</td></tr>
		<tr><td>100010</td><td>i</td></tr>
		<tr><td>100011</td><td>j</td></tr>
		<tr><td>100100</td><td>k</td></tr>
		<tr><td>100101</td><td>l</td></tr>
		<tr><td>100110</td><td>m</td></tr>
		<tr><td>100111</td><td>n</td></tr>
		<tr><td>101000</td><td>o</td></tr>
		<tr><td>101001</td><td>p</td></tr>
		<tr><td>101010</td><td>q</td></tr>
		<tr><td>101011</td><td>r</td></tr>
		<tr><td>101100</td><td>s</td></tr>
		<tr><td>101101</td><td>t</td></tr>
		<tr><td>101110</td><td>u</td></tr>
		<tr><td>101111</td><td>v</td></tr>
		<tr><td>110000</td><td>w</td></tr>
		<tr><td>110001</td><td>x</td></tr>
		<tr><td>110010</td><td>y</td></tr>
		<tr><td>110011</td><td>z</td></tr>
		<tr><td>110100</td><td>0</td></tr>
		<tr><td>110101</td><td>1</td></tr>
		<tr><td>110110</td><td>2</td></tr>
		<tr><td>110111</td><td>3</td></tr>
		<tr><td>111000</td><td>4</td></tr>
		<tr><td>111001</td><td>5</td></tr>
		<tr><td>111010</td><td>6</td></tr>
		<tr><td>111011</td><td>7</td></tr>
		<tr><td>111100</td><td>8</td></tr>
		<tr><td>111101</td><td>9</td></tr>
		<tr><td>111110</td><td>+</td></tr>
		<tr><td>111111</td><td>/</td></tr>
	</table>
</div>

<p>예를 들어, 'Hello'를 Base64로 변환하면 다음과 같습니다.</p>

<p>1. 2진수 표현으로 한다.</p>

<pre>01001000 01100101 01101100 01101100 01101111  (US-ASCII / UTF-8인 경우)</pre>

<p>2. 6비트마다 구분한다. 6비트에 미치지 못하는 경우는 끝을 '0'으로 패딩한다.</p>

<pre>010010 000110 010101 101100 011011 000110 111100</pre>

<p>3. 변환표를 사용하여 문자로 변환한다. 4문자마다 변환하고, 4문자에 미치지 못하는 경우는 끝을 '='로 패딩한다.</p>

<pre>SGVs bG8=</pre>

<p>4. 문자를 모두 연결하여 Base64 변환 결과로 한다.</p>

<pre>SGVsbG8=</pre>


<h4>이메일의 MIME 메시지 헤더 형식 (RFC 2047)</h4>
<p>DenCode에서는 다음과 같은 MIME 메시지 헤더 형식(RFC 2047)의 디코딩도 지원합니다. 이 형식은 이메일의 제목이나 수신처 등에 ASCII 문자 이외가 포함되는 경우에 사용됩니다.</p>

<pre>Subject: =?UTF-8?B?44K144Oz44OX44Or?=</pre>

<p>디코딩 후의 결과는 다음과 같습니다.</p>

<pre>Subject: 샘플(サンプル)</pre>
