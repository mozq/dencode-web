<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Normalização Unicode</h3>
<p>Normalização Unicode refere-se à decomposição e composição de caracteres. Alguns caracteres Unicode têm a mesma aparência, mas várias representações. Por exemplo, "â" pode ser representado como um único ponto de código "â" (U+00E2), ou como dois pontos de código decompostos (caractere base + caractere de combinação) "a" (U+0061) e " ̂" (U+0302). O primeiro é chamado de caractere pré-composto e o último é chamado de sequência de caracteres de combinação (CCS).</p>
<p>Os seguintes tipos de normalização Unicode estão disponíveis.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Forma de Normalização</th><th scope="col">Descrição</th><th scope="col">Exemplo</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>Decomposição canônica</td><td>"â"(U+00E2) -&gt; "a"(U+0061) + " ̂"(U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>Decomposição de compatibilidade</td><td>"ﬁ"(U+FB01) -&gt; "f"(U+0066) + "i"(U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>Decomposição canônica seguida de composição canônica</td><td>"â"(U+00E2) -&gt; "a"(U+0061) + " ̂"(U+0302) -&gt; "â"(U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>Decomposição de compatibilidade seguida de composição canônica</td><td>"ﬁ"(U+FB01) -&gt; "f"(U+0066) + "i"(U+0069) -&gt; "f"(U+0066) + "i"(U+0069)</td></tr>
	</table>
</div>

<p>A equivalência canônica normaliza preservando caracteres visualmente e funcionalmente equivalentes. Ex. "â" &lt;-&gt; "a" + " ̂"</p>
<p>A equivalência de compatibilidade inclui caracteres que tomam formas semanticamente diferentes além da equivalência canônica para normalização. Ex. "ﬁ" -&gt; "f" + "i"</p>
