<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Unicode escape sequence</h3>
<p>Unicode escape sequences convert a single character to the format of a 4-digit hexadecimal code point, such as \uXXXX. For example, "A" becomes "\u0041".</p>
<p>Unicode non-BMP characters represented as surrogate pairs do not fit in the 4-digit code point, so they are represented in the following format for each programming language.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th scope="col">Programming language</th><th scope="col">Format</th><th scope="col">Conversion result of "😀"(U+01F600)</th></tr>
		<tr><td>Java, JS(ES5)</td><td>\uXXXX\uXXXX</td><td>\ud83d\ude00</td></tr>
		<tr><td>Swift, JS(ES6+), PHP, Ruby</td><td>\u{XXXXX}</td><td>\u{1f600}</td></tr>
		<tr><td>C, Python</td><td>\U000XXXXX</td><td>\U0001f600</td></tr>
	</table>
</div>
