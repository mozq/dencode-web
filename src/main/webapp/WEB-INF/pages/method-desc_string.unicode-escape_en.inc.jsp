<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Unicode escape sequence</h3>
<p>Unicode escape sequence convert a single character to the format of a 4-digit hexadecimal code point, such as \uXXXX. For example, "A" becomes "\u0041".</p>

<p>In DenCode, in addition to the \uXXXX format, the following notation formats are also supported.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th scope="col">Format</th><th scope="col">Conversion result of "ABC"</th><th scope="col">Description / Programming language</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>Common Unicode escape sequences</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>Percent-encoding (Non-standard)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>Unicode standard notation for code points (Space separated)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>Hexadecimal notation of code points (Space separated)</td></tr>
	</table>
</div>

<p>Some of the above formats are mentioned in <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a> as BEST CURRENT PRACTICE, but there is no international standard.</p>
<p>The %uXXXX format is supported by Microsoft IIS, but is a non-standard format. It can be encoded in %u format with <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> in C#, but this method has been obsoleted since .NET Framework 4.5.</p>
<p>Please note that in the \X format, a trailing single space is treated as a delimiter and ignored when decoding, <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">as specified by CSS</a>. In the U+XXXX and 0xX formats, each character is separated by a single space when encoded, and a trailing single space is ignored when decoded, as in the \X format.</p>


<h4>Escaping by Unicode Name</h4>

<p>As Unicode escape sequences, escaping by Unicode name is also supported.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th scope="col">Format</th><th scope="col">Conversion result of "A"</th><th scope="col">Description / Programming language</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Unicode names can be found at <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> or <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a>.</p>


<h4>Unicode non-BMP characters in Unicode escape sequence</h4>

<p>Unicode non-BMP characters do not fit in the 4-digit code point, so they are represented in the following notation formats for each programming language.</p>
<p>The result of converting "😀" (U+1F600), which is a Unicode non-BMP character, is as follows.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th scope="col">Format</th><th scope="col">Conversion result of "😀" (U+1F600)</th><th scope="col">Programming language</th></tr>
		<tr><td>\uXXXX</td><td>\uD83D\uDE00</td><td>Java, Kotlin, Scala</td></tr>
		<tr><td>\u{X}</td><td>\u{1F600}</td><td>C++23, Rust, Swift, JavaScript, PHP, Ruby, Dart, Lua</td></tr>
		<tr><td>\U00XXXXXX</td><td>\U0001F600</td><td>C, C++, Objective-C, C#, Go, Python, R</td></tr>
		<tr><td>\x{X}</td><td>\x{1F600}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\1F600</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x1F600;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%uD83D%uDE00</td><td>-</td></tr>
		<tr><td>U+XXXX</td><td>U+1F600</td><td>-</td></tr>
		<tr><td>0xX</td><td>0x1F600</td><td>-</td></tr>
		<tr><td>\N{name}</td><td>\N{GRINNING FACE}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>In the \uXXXX and %uXXXX formats, non-BMP characters are represented by two code units as UTF-16 surrogate pairs. In other formats, a character is represented by a single code point.</p>
