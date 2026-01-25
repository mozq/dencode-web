<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Unicode 이스케이프 시퀀스에 대해서</h3>
<p>문자열을 Unicode 이스케이프 시퀀스 형식으로 변환합니다.</p>
<p>Unicode 이스케이프 시퀀스는 1문자를 \uXXXX와 같은 16진수 4자리 코드 포인트 형식으로 변환합니다. 예를 들어 'あ'는 '\u3042'가 됩니다.</p>

<p>DenCode에서는 \uXXXX 형식 외에도, 다음 형식의 표기법에도 대응하고 있습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">형식</th><th scope="col">「ABC」의 변환 결과</th><th scope="col">설명 / 프로그래밍 언어</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>일반적인 Unicode 이스케이프 시퀀스</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>퍼센트 인코딩 (비표준)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>코드 포인트의 Unicode 표준 표기 (스페이스 구분)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>코드 포인트의 16진법 표기 (스페이스 구분)</td></tr>
	</table>
</div>

<p>상기 몇 가지 형식은 <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a>에서 BEST CURRENT PRACTICE로서 언급되고 있지만, 국제 표준 등은 없습니다.</p>
<p>%uXXXX 형식은 Microsoft IIS가 지원하고 있지만, 비표준 형식입니다. C#의 <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a>에서 %u 형식으로 인코딩할 수 있지만, 이 메서드는 .NET Framework 4.5부터는 비권장(Deprecated)되었습니다.</p>
<p>\X 형식은 <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">CSS 사양</a>으로서 디코딩 시 후속 반각 스페이스 1개는 구분자(Delimiter)로 취급되어 무시되는 것에 주의해 주세요. U+XXXX나 0xX 형식에서는 인코딩 시 1문자마다 반각 스페이스로 구분되고, 디코딩 시에는 \X 형식과 마찬가지로 후속 연속 반각 스페이스 1개는 무시됩니다.</p>


<h4>Unicode 이름에 의한 이스케이프</h4>

<p>Unicode 이스케이프 시퀀스로서, Unicode 이름에 의한 이스케이프에도 대응하고 있습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">형식</th><th scope="col">「A」의 변환 결과</th><th scope="col">설명 / 프로그래밍 언어</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Unicode 이름은 <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> 또는 <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a>에서 확인할 수 있습니다.</p>


<h4>Unicode 이스케이프 시퀀스에서의 Unicode BMP 범위 외 문자</h4>

<p>Unicode의 비BMP 문자에 대해서는, 코드 포인트가 4자리에 들어가지 않기 때문에, 프로그래밍 언어마다 다음 형식의 표기법으로 나타냅니다.</p>
<p>예를 들어 '😀'(U+1F600)을 변환한 결과는 다음과 같습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">형식</th><th scope="col">「😀」(U+1F600)의 변환 결과</th><th scope="col">프로グラミング 언어</th></tr>
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

<p>\uXXXX와 %uXXXX 형식에서는, 비BMP 문자는 UTF-16의 서로게이트 페어(Surrogate Fair)로서 2개의 코드 유닛으로 나타냅니다. 그 외의 형식에서는 1문자는 1개의 코드 포인트로 나타냅니다.</p>
