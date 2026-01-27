<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 Unicode 正規化 (Unicode Normalization)</h3>
<p>Unicode 正規化是指將字元進行分解或合成。在 Unicode 中，有些字元看起來相同但存在多種表示方法。例如，「â」既可以用一個碼位「â」(U+00E2) 表示，也可以用兩個分解的碼位「a」(U+0061) 和「 ̂」(U+0302)（基底字元 + 結合字元）表示。前者稱為預組字元，後者稱為結合字元序列 (combining character sequence, CCS)。</p>
<p>Unicode 正規化有以下幾種類型。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">正規化形式</th><th scope="col">說明</th><th scope="col">範例</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>規範等價分解</td><td>「â」(U+00E2) -&gt; 「a」(U+0061) + 「 ̂」(U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>相容等價分解</td><td>「ﬁ」(U+FB01) -&gt; 「f」(U+0066) + 「i」(U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>規範等價分解後重組</td><td>「â」(U+00E2) -&gt; 「a」(U+0061) + 「 ̂」(U+0302) -&gt; 「â」(U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>相容等價分解後，規範等價重組</td><td>「ﬁ」(U+FB01) -&gt; 「f」(U+0066) + 「i」(U+0069) -&gt; 「f」(U+0066) + 「i」(U+0069)</td></tr>
	</table>
</div>

<p>規範等價 (Canonical Equivalence) 是在保持視覺和功能等價的狀態下進行正規化。例如，「â」 &lt;-&gt; 「a」 + 「 ̂」</p>
<p>相容等價 (Compatibility Equivalence) 除了規範等價外，還包括語義上不同形式的字元的正規化。例如，「ﬁ」 -&gt; 「f」 + 「i」</p>
