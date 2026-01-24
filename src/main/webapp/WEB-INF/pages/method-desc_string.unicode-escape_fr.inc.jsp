<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos des séquences d'échappement Unicode</h3>
<p>Convertit une chaîne au format de séquence d'échappement Unicode.</p>
<p>Les séquences d'échappement Unicode convertissent un caractère en un point de code hexadécimal à 4 chiffres, tel que \uXXXX. Par exemple, "あ" devient "\u3042".</p>

<p>DenCode prend également en charge les formats de notation suivants en plus du format \uXXXX.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Format</th><th scope="col">Résultat de la conversion de "ABC"</th><th scope="col">Description / Langage de programmation</th></tr>
		<tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>Séquence d'échappement Unicode générale</td></tr>
		<tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
		<tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
		<tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
		<tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
		<tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>Encodage en pourcentage (non standard)</td></tr>
		<tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>Notation standard Unicode du point de code (séparé par des espaces)</td></tr>
		<tr><td>0xX</td><td>0x41 0x42 0x43</td><td>Notation hexadécimale du point de code (séparée par des espaces)</td></tr>
	</table>
</div>

<p>Certains des formats ci-dessus sont mentionnés comme BEST CURRENT PRACTICE dans la <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a>, mais il n'y a pas de norme internationale.</p>
<p>Le format %uXXXX est pris en charge par Microsoft IIS, mais c'est un format non standard. C# permet d'encoder au format %u avec <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a>, mais cette méthode est obsolète depuis .NET Framework 4.5.</p>
<p>Notez que pour le format \X, selon la <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">spécification CSS</a>, un espace demi-chasse suivant lors du décodage est traité comme un délimiteur et ignoré. Pour les formats U+XXXX et 0xX, chaque caractère est séparé par un espace demi-chasse lors de l'encodage, et lors du décodage, un espace demi-chasse consécutif suivant est ignoré, tout comme pour le format \X.</p>


<h4>Échappement par nom Unicode</h4>

<p>L'échappement par nom Unicode est également pris en charge comme séquence d'échappement Unicode.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Format</th><th scope="col">Résultat de la conversion de "A"</th><th scope="col">Description / Langage de programmation</th></tr>
		<tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
	</table>
</div>

<p>Les noms Unicode peuvent être vérifiés sur <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> ou <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a>.</p>


<h4>Caractères hors de la plage BMP Unicode dans les séquences d'échappement Unicode</h4>

<p>Pour les caractères non-BMP Unicode, le point de code ne tient pas sur 4 chiffres, ils sont donc représentés dans les formats suivants selon le langage de programmation.</p>
<p>Par exemple, le résultat de la conversion de "😀" (U+1F600) est le suivant.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Format</th><th scope="col">Résultat de la conversion de "😀" (U+1F600)</th><th scope="col">Langage de programmation</th></tr>
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

<p>Dans les formats \uXXXX et %uXXXX, les caractères non-BMP sont représentés par deux unités de code en tant que paire de substitution UTF-16 (surrogate pair). Dans les autres formats, un caractère est représenté par un seul point de code.</p>
