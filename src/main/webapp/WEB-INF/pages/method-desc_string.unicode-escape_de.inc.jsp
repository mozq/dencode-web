<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über Unicode-Escape-Sequenzen</h3>
<p>Konvertiert Zeichenfolgen in Unicode-Escape-Sequenzen.</p>
<p>Unicode-Escape-Sequenzen wandeln ein Zeichen in das Format \uXXXX um, wobei XXXX der vierstellige hexadezimale Codepoint ist. Zum Beispiel wird „あ“ zu „\u3042“.</p>

<p>DenCode unterstützt neben dem Format \uXXXX auch die folgenden Schreibweisen:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Format</th><th scope="col">Ergebnis für „ABC“</th><th scope="col">Beschreibung / Programmiersprache</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>Allgemeine Unicode-Escape-Sequenz</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>Prozentkodierung (nicht standardisiert)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>Unicode-Standardnotation für Codepoints (durch Leerzeichen getrennt)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>Hexadezimale Notation für Codepoints (durch Leerzeichen getrennt)</td></tr>
	</table>
</div>

<p>Einige der oben genannten Formate werden in <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a> als BEST CURRENT PRACTICE erwähnt, es gibt jedoch keinen internationalen Standard.</p>
<p>Das Format %uXXXX wird von Microsoft IIS unterstützt, ist aber nicht standardisiert. In C# kann <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> in das %u-Format kodieren, diese Methode ist jedoch ab .NET Framework 4.5 veraltet.</p>
<p>Beachten Sie, dass beim Format \X gemäß der <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">CSS-Spezifikation</a> ein nachfolgendes Leerzeichen beim Dekodieren als Trennzeichen behandelt und ignoriert wird. Bei den Formaten U+XXXX und 0xX werden Zeichen beim Kodieren durch ein Leerzeichen getrennt, und beim Dekodieren wird, wie beim \X-Format, ein nachfolgendes Leerzeichen ignoriert.</p>

<h4>Unicode-Escape mit Namen</h4>

<p>Es wird auch das Escapen mit Unicode-Namen unterstützt.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Format</th><th scope="col">Ergebnis für „A“</th><th scope="col">Beschreibung / Programmiersprache</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Unicode-Namen können in <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> oder <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a> nachgeschlagen werden.</p>

<h4>Zeichen außerhalb der BMP (Basic Multilingual Plane)</h4>

<p>Für Unicode-Zeichen außerhalb der BMP reicht ein 4-stelliger Codepoint nicht aus. Je nach Programmiersprache werden folgende Schreibweisen verwendet:</p>
<p>Beispiel für die Konvertierung von „😀“ (U+1F600):</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Format</th><th scope="col">Ergebnis für „😀“(U+1F600)</th><th scope="col">Programmiersprache</th></tr>
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

<p>Bei den Formaten \uXXXX und %uXXXX werden Zeichen außerhalb der BMP als Surrogate Pairs in UTF-16 (zwei Code-Einheiten) dargestellt. Bei den anderen Formaten wird ein Zeichen durch einen einzigen Codepoint dargestellt.</p>
