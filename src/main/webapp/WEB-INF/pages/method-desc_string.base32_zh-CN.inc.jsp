<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 Base32</h3>
<p>Base32 是使用可打印 ASCII 字符的编码方式。</p>
<p>在 Base32 中，数据被每 5 个比特分为一组，并转换为英数字 (A-Z, 2-7) 来表示。每 8 个字符转换一次，如果最后不足 8 个字符，则用等号 (=) 填充。</p>

<p>Base32 字符转换表如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>5比特数据</th><th>Base32 字符</th></tr>
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

<p>例如，将“Hello!”用 Base32 转换如下。</p>

<p>1. 转换为二进制表示。</p>

<pre>01001000 01100101 01101100 01101100 01101111 00100001  (US-ASCII / UTF-8)</pre>

<p>2. 每 5 个比特分隔。不足 5 比特的在末尾用“0”填充。</p>

<pre>01001 00001 10010 10110 11000 11011 00011 01111 00100 00100</pre>

<p>3. 使用转换表转换为字符。每 8 个字符转换一次，不足 8 个字符的在末尾用“=”填充。</p>

<pre>JBSWY3DP EE======</pre>

<p>4. 连接所有字符作为 Base32 转换结果。</p>

<pre>JBSWY3DPEE======</pre>
