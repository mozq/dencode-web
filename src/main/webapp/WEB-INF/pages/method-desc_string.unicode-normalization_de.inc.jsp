<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über Unicode-Normalisierung</h3>
<p>Unicode-Normalisierung bezeichnet das Zerlegen und Zusammensetzen von Zeichen. In Unicode können Zeichen, die identisch aussehen, auf verschiedene Weisen dargestellt werden. Zum Beispiel kann „â“ als einzelner Codepoint „â“ (U+00E2) oder als zwei zerlegte Codepoints „a“ (U+0061) + „ ̂“ (U+0302) dargestellt werden (Basiszeichen + kombinierendes Zeichen). Ersteres nennt man precomposed character (zusammengesetztes Zeichen), letzteres combining character sequence (kombinierende Zeichenfolge, CCS).</p>
<p>Es gibt folgende Arten der Unicode-Normalisierung:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Normalisierungsform</th><th scope="col">Beschreibung</th><th scope="col">Beispiel</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>Kanonische Zerlegung</td><td>„â“(U+00E2) -&gt; „a“(U+0061) + „ ̂“(U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>Kompatibilitäts-Zerlegung</td><td>„ﬁ“(U+FB01) -&gt; „f“(U+0066) + „i“(U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>Kanonische Zerlegung, gefolgt von kanonischer Zusammensetzung</td><td>„â“(U+00E2) -&gt; „a“(U+0061) + „ ̂“(U+0302) -&gt; „â“(U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>Kompatibilitäts-Zerlegung, gefolgt von kanonischer Zusammensetzung</td><td>„ﬁ“(U+FB01) -&gt; „f“(U+0066) + „i“(U+0069) -&gt; „f“(U+0066) + „i“(U+0069)</td></tr>
	</table>
</div>

<p>Kanonische Äquivalenz normalisiert Zeichen, die visuell und funktionell gleichwertig sind. Bsp.: „â“ &lt;-&gt; „a“ + „ ̂“</p>
<p>Kompatibilitäts-Äquivalenz normalisiert neben der kanonischen Äquivalenz auch Zeichen, die semantisch unterschiedlich sein können. Bsp.: „ﬁ“ -&gt; „f“ + „i“</p>
