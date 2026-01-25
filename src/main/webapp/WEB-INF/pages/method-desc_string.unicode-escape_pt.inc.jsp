<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Sequências de Escape Unicode</h3>
<p>Converte strings para o formato de sequência de escape Unicode.</p>
<p>Sequências de escape Unicode convertem um único caractere em um formato de ponto de código hexadecimal de 4 dígitos como \uXXXX. Por exemplo, "あ" torna-se "\u3042".</p>

<p>O DenCode suporta os seguintes formatos de notação além do formato \uXXXX.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Resultado da conversão de "ABC"</th><th scope="col">Descrição / Linguagem de Programação</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>Sequência de escape Unicode comum</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>Codificação percentual (Não padrão)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>Notação padrão Unicode de ponto de código (separado por espaço)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>Notação hexadecimal de ponto de código (separado por espaço)</td></tr>
	</table>
</div>

<p>Alguns dos formatos acima são mencionados na <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a> como MELHORES PRÁTICAS ATUAIS, mas não há padrão internacional.</p>
<p>O formato %uXXXX é suportado pelo Microsoft IIS, mas é um formato não padrão. <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> do C# pode codificar para o formato %u, mas este método está obsoleto desde o .NET Framework 4.5.</p>
<p>Observe que para o formato \X, como uma <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">especificação CSS</a>, um único espaço de meia largura subsequente é tratado como um delimitador e ignorado durante a decodificação. Nos formatos U+XXXX e 0xX, cada caractere é separado por um espaço de meia largura durante a codificação, e um único espaço de meia largura subsequente é ignorado durante a decodificação, assim como no formato \X.</p>


<h4>Escape por nome Unicode</h4>

<p>Como uma sequência de escape Unicode, o escape por nome Unicode também é suportado.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Resultado da conversão de "A"</th><th scope="col">Descrição / Linguagem de Programação</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Nomes Unicode podem ser verificados em <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> ou <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a>.</p>


<h4>Caracteres fora do intervalo BMP Unicode em sequências de escape Unicode</h4>

<p>Para caracteres Unicode não-BMP, como o ponto de código não cabe em 4 dígitos, eles são representados na seguinte notação para cada linguagem de programação.</p>
<p>Por exemplo, o resultado da conversão de "😀" (U+1F600) é o seguinte:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Resultado da conversão de "😀"(U+1F600)</th><th scope="col">Linguagem de Programação</th></tr>
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

<p>Nos formatos \uXXXX e %uXXXX, caracteres não-BMP são representados por dois códigos de unidade como pares substitutos UTF-16. Em outros formatos, um caractere é representado por um ponto de código.</p>
