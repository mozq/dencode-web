<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Unicodeエスケープシーケンスについて</h3>
<p>文字列をUnicodeエスケープシーケンスの形式に変換します。</p>
<p>Unicodeエスケープシーケンスは、1文字を \uXXXX のような16進数4桁のコードポイントの形式に変換します。例えば「あ」は「\u3042」となります。</p>

<p>DenCodeでは、 \uXXXX の形式のほかに、以下の形式の表記法にも対応しています。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">形式</th><th scope="col">「ABC」の変換結果</th><th scope="col">説明 / プログラミング言語</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>一般的なUnicodeエスケープシーケンス</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>パーセント・エンコーディング (非標準)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>コードポイントのUnicode標準表記 (スペース区切り)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>コードポイントの16進法表記 (スペース区切り)</td></tr>
	</table>
</div>

<p>上記のいくつかの形式は、<a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a> で BEST CURRENT PRACTICE として言及されていますが、国際標準等はありません。</p>
<p>%uXXXX 形式は Microsoft IIS がサポートしていますが、非標準の形式です。C# の <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> で %u 形式にエンコードできますが、このメソッドは .NET Framework 4.5 からは非推奨となっています。</p>
<p>\X 形式は、<a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">CSSの仕様</a>としてデコードの際に後続の半角スペース1つはデリミターとして扱われ無視されることに注意してください。 U+XXXX や 0xX 形式では、エンコードの際には1文字ごとに半角スペースで区切られ、デコードの際には \X 形式と同じく後続の連続する半角スペース1つは無視されます。</p>


<h4>Unicodeの名前によるエスケープ</h4>

<p>Unicodeエスケープシーケンスとして、Unicodeの名前によるエスケープにも対応しています。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">形式</th><th scope="col">「A」の変換結果</th><th scope="col">説明 / プログラミング言語</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Unicodeの名前は、<a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> または <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a> で確認できます。</p>


<h4>UnicodeエスケープシーケンスにおけるUnicode BMP範囲外の文字</h4>

<p>Unicodeの非BMPの文字については、コードポイントが4桁に収まらないため、プログラミング言語ごとに以下の形式の表記法で表します。</p>
<p>例えば「😀」(U+1F600)を変換した結果は以下の通りです。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">形式</th><th scope="col">「😀」(U+1F600)の変換結果</th><th scope="col">プログラミング言語</th></tr>
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

<p>\uXXXX と %uXXXX 形式では、非BMPの文字はUTF-16のサロゲートペアとして2つのコードユニットで表します。その他の形式では、1文字は1つのコードポイントで表します。</p>
