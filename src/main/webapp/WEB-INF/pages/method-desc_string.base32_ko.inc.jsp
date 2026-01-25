<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Base32에 대해서</h3>
<p>Base32는 인쇄 가능한 ASCII 문자를 사용한 부호화 방식입니다.</p>
<p>Base32에서는 데이터를 5비트씩 분할하고, 그것들을 영숫자(A-Z, 2-7) 문자로 변환하여 나타냅니다. 8문자마다 변환하고, 마지막이 8문자에 미치지 못하는 경우는 등호 기호(=)로 패딩합니다.</p>

<p>Base32 문자 변환표는 다음과 같습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>5비트 데이터</th><th>Base32 문자</th></tr>
		<tr><td>00000</td><td>A</td></tr>
		<tr><td>00001</td><td>B</td></tr>
		<tr><td>00010</td><td>C</td></tr>
		<tr><td>00011</td><td>D</td></tr>
		<tr><td>00100</td><td>E</td></tr>
		<tr><td>00101</td><td>F</td></tr>
		<tr><td>00110</td><td>G</td></tr>
		<tr><td>00111</td><td>H</td></tr>
		<tr><td>01000</td><td>I</td></tr>
		<tr><td>01001</td><td>J</td></tr>
		<tr><td>01010</td><td>K</td></tr>
		<tr><td>01011</td><td>L</td></tr>
		<tr><td>01100</td><td>M</td></tr>
		<tr><td>01101</td><td>N</td></tr>
		<tr><td>01110</td><td>O</td></tr>
		<tr><td>01111</td><td>P</td></tr>
		<tr><td>10000</td><td>Q</td></tr>
		<tr><td>10001</td><td>R</td></tr>
		<tr><td>10010</td><td>S</td></tr>
		<tr><td>10011</td><td>T</td></tr>
		<tr><td>10100</td><td>U</td></tr>
		<tr><td>10101</td><td>V</td></tr>
		<tr><td>10110</td><td>W</td></tr>
		<tr><td>10111</td><td>X</td></tr>
		<tr><td>11000</td><td>Y</td></tr>
		<tr><td>11001</td><td>Z</td></tr>
		<tr><td>11010</td><td>2</td></tr>
		<tr><td>11011</td><td>3</td></tr>
		<tr><td>11100</td><td>4</td></tr>
		<tr><td>11101</td><td>5</td></tr>
		<tr><td>11110</td><td>6</td></tr>
		<tr><td>11111</td><td>7</td></tr>
	</table>
</div>

<p>예를 들어, 'Hello!'를 Base32로 변환하면 다음과 같습니다.</p>

<p>1. 2진수 표현으로 한다.</p>

<pre>01001000 01100101 01101100 01101100 01101111 00100001  (US-ASCII / UTF-8인 경우)</pre>

<p>2. 5비트마다 구분한다. 5비트에 미치지 못하는 경우는 끝을 '0'으로 패딩한다.</p>

<pre>01001 00001 10010 10110 11000 11011 00011 01111 00100 00100</pre>

<p>3. 변환표를 사용하여 문자로 변환한다. 8문자마다 변환하고, 8문자에 미치지 못하는 경우는 끝을 '='로 패딩한다.</p>

<pre>JBSWY3DP EE======</pre>

<p>4. 문자를 모두 연결하여 Base32 변환 결과로 한다.</p>

<pre>JBSWY3DPEE======</pre>
