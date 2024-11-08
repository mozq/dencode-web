<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Bin String</h3>
<p>Bin string is the binary value of the string in binary notation.</p>
<p>Since the binary value differs depending on the character encoding, the conversion result to a bin string also differs.</p>

<p>For example, the result of converting "サンプル" to a bin string is as follows.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>Character encoding</th><th>Bin string</th></tr>
		<tr><td>UTF-8</td><td>11100011 10000010 10110101 11100011 10000011 10110011 11100011 10000011 10010111 11100011 10000011 10101011</td></tr>
		<tr><td>UTF-16</td><td>00110000 10110101 00110000 11110011 00110000 11010111 00110000 11101011</td></tr>
		<tr><td>Shift_JIS</td><td>10000011 01010100 10000011 10010011 10000011 01110110 10000011 10001011</td></tr>
	</table>
</div>
