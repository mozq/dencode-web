<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sulla sequenza di escape Unicode</h3>
<p>Converte le stringhe nel formato di sequenza di escape Unicode.</p>
<p>Una sequenza di escape Unicode converte un singolo carattere nel formato di un punto di codice esadecimale a 4 cifre, come \uXXXX. Ad esempio, "あ" diventa "\u3042".</p>

<p>Oltre al formato \uXXXX, DenCode supporta anche le seguenti notazioni:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Risultato per "ABC"</th><th scope="col">Descrizione / Linguaggio di programmazione</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>Sequenza di escape Unicode generale</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>Percent-encoding (Non standard)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>Notazione standard Unicode per punti di codice (separati da spazi)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>Notazione esadecimale per punti di codice (separata da spazi)</td></tr>
	</table>
</div>

<p>Alcuni dei formati sopra citati sono menzionati come BEST CURRENT PRACTICE in <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a>, ma non esiste uno standard internazionale.</p>
<p>Il formato %uXXXX è supportato da Microsoft IIS, ma è un formato non standard. <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> di C# può codificare in formato %u, ma questo metodo è deprecato da .NET Framework 4.5.</p>
<p>Si noti che per il formato \X, come specifica <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">CSS</a>, un singolo spazio successivo viene trattato come delimitatore e ignorato durante la decodifica. Nei formati U+XXXX e 0xX, ogni carattere è separato da uno spazio durante la codifica e, durante la decodifica, un singolo spazio consecutivo viene ignorato, proprio come nel formato \X.</p>


<h4>Escape tramite nomi Unicode</h4>

<p>Supporta anche l'escape tramite nomi Unicode come sequenza di escape Unicode.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Risultato per "A"</th><th scope="col">Descrizione / Linguaggio di programmazione</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>I nomi Unicode possono essere verificati su <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> o <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a>.</p>


<h4>Caratteri fuori dall'intervallo Unicode BMP nelle sequenze di escape Unicode</h4>

<p>Per i caratteri Unicode non-BMP, poiché il punto di codice non rientra in 4 cifre, vengono utilizzati i seguenti formati di notazione per ciascun linguaggio di programmazione.</p>
<p>Ad esempio, il risultato della conversione di "😀" (U+1F600) è il seguente:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Formato</th><th scope="col">Risultato per "😀" (U+1F600)</th><th scope="col">Linguaggio di programmazione</th></tr>
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

<p>Nei formati \uXXXX e %uXXXX, i caratteri non-BMP sono rappresentati da due unità di codice come coppie surrogate UTF-16. Negli altri formati, un carattere è rappresentato da un singolo punto di codice.</p>
