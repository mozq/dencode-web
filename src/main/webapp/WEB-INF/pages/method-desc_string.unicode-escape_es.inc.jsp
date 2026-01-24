<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre secuencias de escape Unicode</h3>
<p>Convierte cadenas al formato de secuencia de escape Unicode.</p>
<p>La secuencia de escape Unicode convierte un carácter a un formato de punto de código hexadecimal de 4 dígitos como \uXXXX. Por ejemplo, "あ" se convierte en "\u3042".</p>

<p>En DenCode, además del formato \uXXXX, también se soportan las siguientes notaciones:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Resultado de conversión "ABC"</th><th scope="col">Descripción / Lenguaje de programación</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>Secuencia de escape Unicode común</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>Codificación porcentual (no estándar)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>Notación estándar Unicode de punto de código (separado por espacios)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>Notación hexadecimal de punto de código (separado por espacios)</td></tr>
	</table>
</div>

<p>Algunos de los formatos anteriores se mencionan en <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a> como MEJOR PRÁCTICA ACTUAL, pero no existen estándares internacionales.</p>
<p>El formato %uXXXX es soportado por Microsoft IIS, pero es un formato no estándar. Puede codificar al formato %u con <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> de C#, pero este método está obsoleto desde .NET Framework 4.5.</p>
<p>Tenga en cuenta que para el formato \X, como <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">especificación de CSS</a>, un espacio de ancho medio posterior se trata como un delimitador y se ignora durante la decodificación. En los formatos U+XXXX y 0xX, se separan por un espacio de ancho medio para cada carácter durante la codificación, y durante la decodificación, se ignora un espacio de ancho medio consecutivo posterior, al igual que en el formato \X.</p>


<h4>Escape por nombre Unicode</h4>

<p>Como secuencia de escape Unicode, también se soporta el escape por nombre Unicode.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Resultado de conversión "A"</th><th scope="col">Descripción / Lenguaje de programación</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Los nombres Unicode se pueden verificar en <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> o <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a>.</p>


<h4>Caracteres fuera del rango Unicode BMP en secuencias de escape Unicode</h4>

<p>Para caracteres Unicode no BMP, dado que el punto de código no cabe en 4 dígitos, se representan en los siguientes formatos según el lenguaje de programación.</p>
<p>Por ejemplo, el resultado de convertir "😀" (U+1F600) es el siguiente:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Resultado de conversión "😀" (U+1F600)</th><th scope="col">Lenguaje de programación</th></tr>
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

<p>En los formatos \uXXXX y %uXXXX, los caracteres no BMP se representan con dos unidades de código como un par sustituto UTF-16. En otros formatos, un carácter se representa con un solo punto de código.</p>
