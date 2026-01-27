<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 Unicode 转义序列 (Unicode Escape Sequence)</h3>
<p>将字符串转换为 Unicode 转义序列的格式。</p>
<p>Unicode 转义序列将 1 个字符转换为类似 \uXXXX 的 4 位十六进制码点格式。例如“あ”转换为“\u3042”。</p>

<p>DenCode 除了 \uXXXX 格式外，还支持以下格式的表示法的转换。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">格式</th><th scope="col">“ABC”的转换结果</th><th scope="col">说明 / 编程语言</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>通用的 Unicode 转义序列</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>百分号编码 (非标准)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>码点的 Unicode 标准表示 (空格分隔)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>码点的十六进制表示 (空格分隔)</td></tr>
	</table>
</div>

<p>以上几种格式在 <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a> 中作为 BEST CURRENT PRACTICE 被提及，但并没有国际标准。</p>
<p>%uXXXX 格式虽然被 Microsoft IIS 支持，但是是非标准格式。虽然 C# 的 <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> 可以转换为 %u 格式，但该方法从 .NET Framework 4.5 起已不推荐使用。</p>
<p>请注意 \X 格式作为 <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">CSS 的规范</a>，在解码时后接的 1 个半角空格会被视为分隔符而被忽略。在 U+XXXX 或 0xX 格式中，编码时每个字符用半角空格分隔，解码时与 \X 格式一样，后接的 1 个连续半角空格会被忽略。</p>


<h4>通过 Unicode 名称进行转义</h4>

<p>作为 Unicode 转义序列，也支持通过 Unicode 名称进行转义。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">格式</th><th scope="col">“A”的转换结果</th><th scope="col">说明 / 编程语言</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Unicode 名称可以在 <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> 或 <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a> 中确认。</p>


<h4>Unicode 转义序列中的 Unicode BMP 范围外的字符</h4>

<p>对于 Unicode 的非 BMP 字符，由于码点无法容纳在 4 位中，因此根据编程语言不同，使用以下格式表示。</p>
<p>例如“😀”(U+1F600) 的转换结果如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">格式</th><th scope="col">“😀”(U+1F600) 的转换结果</th><th scope="col">编程语言</th></tr>
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

<p>在 \uXXXX 和 %uXXXX 格式中，非 BMP 字符作为 UTF-16 的代理对用 2 个代码单元表示。在其他格式中，1 个字符用 1 个码点表示。</p>
