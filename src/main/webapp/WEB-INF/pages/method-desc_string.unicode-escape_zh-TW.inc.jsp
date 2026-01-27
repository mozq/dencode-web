<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 Unicode 跳脫序列 (Unicode Escape Sequence)</h3>
<p>將字串轉換為 Unicode 跳脫序列的格式。</p>
<p>Unicode 跳脫序列將 1 個字元轉換為類似 \uXXXX 的 4 位十六進位碼位格式。例如「あ」轉換為「\u3042」。</p>

<p>DenCode 除了 \uXXXX 格式外，還支援以下格式的表示法的轉換。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">格式</th><th scope="col">「ABC」的轉換結果</th><th scope="col">說明 / 程式語言</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>通用的 Unicode 跳脫序列</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>百分號編碼 (非標準)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>碼位的 Unicode 標準表示 (空格分隔)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>碼位的十六進位表示 (空格分隔)</td></tr>
	</table>
</div>

<p>以上幾種格式在 <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a> 中作為 BEST CURRENT PRACTICE 被提及，但並沒有國際標準。</p>
<p>%uXXXX 格式雖然被 Microsoft IIS 支援，但是是非標準格式。雖然 C# 的 <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> 可以轉換為 %u 格式，但該方法從 .NET Framework 4.5 起已不推薦使用。</p>
<p>請注意 \X 格式作為 <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">CSS 的規範</a>，在解碼時後接的 1 個半形空格會被視為分隔符號而被忽略。在 U+XXXX 或 0xX 格式中，編碼時每個字元用半形空格分隔，解碼時與 \X 格式一樣，後接的 1 個連續半形空格會被忽略。</p>


<h4>通過 Unicode 名稱進行跳脫</h4>

<p>作為 Unicode 跳脫序列，也支援通過 Unicode 名稱進行跳脫。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">格式</th><th scope="col">「A」的轉換結果</th><th scope="col">說明 / 程式語言</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Unicode 名稱可以在 <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> 或 <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a> 中確認。</p>


<h4>Unicode 跳脫序列中的 Unicode BMP 範圍外的字元</h4>

<p>對於 Unicode 的非 BMP 字元，由於碼位無法容納在 4 位中，因此根據程式語言不同，使用以下格式表示。</p>
<p>例如「😀」(U+1F600) 的轉換結果如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">格式</th><th scope="col">「😀」(U+1F600) 的轉換結果</th><th scope="col">程式語言</th></tr>
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

<p>在 \uXXXX 和 %uXXXX 格式中，非 BMP 字元作為 UTF-16 的代理對用 2 個代碼單元表示。在其他格式中，1 個字元用 1 個碼位表示。</p>
