<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Base32</h3>
<p>Base32 is an encoding method that uses printable ASCII characters.</p>
<p>In Base32, data is divided into 5 bits and converted into alphanumeric characters (A-Z, 2-7). Converts every 8 characters, and if the last is less than 8 characters, pad with the equal symbol (=).</p>

<p>The conversion table for Base32 characters is as follows.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>5-bit data</th><th>Base32 character</th></tr>
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

<p>For example, if you convert "Hello!" with Base32, it will be as follows.</p>

<p>1. Make it a binary representation.</p>

<pre>01001000 01100101 01101100 01101100 01101111 00100001  (For US-ASCII / UTF-8)</pre>

<p>2. Separate every 5 bits. If it is less than 5 bits, pad it with "0" at the end.</p>

<pre>01001 00001 10010 10110 11000 11011 00011 01111 00100 00100</pre>

<p>3. Convert to characters using a conversion table. Convert every 8 characters, and if it is less than 8 characters, pad the end with "=".</p>

<pre>JBSWY3DP EE======</pre>

<p>4. Connect all the characters to get the Base32 conversion result.</p>

<pre>JBSWY3DPEE======</pre>
