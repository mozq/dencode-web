<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Hex String</h3>
<p>Hex string is the binary value of the string in hexadecimal notation.</p>
<p>Since the binary value differs depending on the character encoding, the conversion result to a hex string also differs.</p>

<p>For example, the result of converting "サンプル" to a hex string is as follows.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>Character encoding</th><th>Hex string</th></tr>
		<tr><td>UTF-8</td><td>E3 82 B5 E3 83 B3 E3 83 97 E3 83 AB</td></tr>
		<tr><td>UTF-16</td><td>30 B5 30 F3 30 D7 30 EB</td></tr>
		<tr><td>Shift_JIS</td><td>83 54 83 93 83 76 83 8B</td></tr>
	</table>
</div>
