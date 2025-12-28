<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Unicode正規化について</h3>
<p>Unicode正規化とは、文字を分解・合成することをいいます。Unicodeの文字は、見た目は同じでも複数の表現方法が存在するものがあります。例えば、「â」は「â」(U+00E2)の1つのコードポイントとしても表せますし、「a」(U+0061)と「 ̂」(U+0302)の2つの分解されたコードポイント（基底文字＋結合文字）でも表せます。前者を合成済み文字、後者を結合文字列(combining character sequence, CCS)と呼びます。</p>
<p>Unicode正規化には、以下の種類があります。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">正規化形式</th><th scope="col">説明</th><th scope="col">例</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>正準等価で分解</td><td>「â」(U+00E2) -&gt; 「a」(U+0061) + 「 ̂」(U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>互換等価で分解</td><td>「ﬁ」(U+FB01) -&gt; 「f」(U+0066) + 「i」(U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>正準等価で分解し再度合成</td><td>「â」(U+00E2) -&gt; 「a」(U+0061) + 「 ̂」(U+0302) -&gt; 「â」(U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>互換等価で分解し、正準等価で再度合成</td><td>「ﬁ」(U+FB01) -&gt; 「f」(U+0066) + 「i」(U+0069) -&gt; 「f」(U+0066) + 「i」(U+0069)</td></tr>
	</table>
</div>

<p>正準等価は、視覚的および機能的に等価な文字を保った状態で正規化します。 例. 「â」 &lt;-&gt; 「a」 + 「 ̂」</p>
<p>互換等価は、正準等価の他に、意味的に異なる形をとる文字も正規化の対象となります。 例. 「ﬁ」 -&gt; 「f」 + 「i」</p>
