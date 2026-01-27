<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 Unicode 正规化 (Unicode Normalization)</h3>
<p>Unicode 正规化是指将字符进行分解或合成。在 Unicode 中，有些字符看起来相同但存在多种表示方法。例如，“â”既可以用一个码点“â”(U+00E2) 表示，也可以用两个分解的码点“a”(U+0061) 和“ ̂”(U+0302)（基字符 + 结合字符）表示。前者称为预组合字符，后者称为结合字符序列 (combining character sequence, CCS)。</p>
<p>Unicode 正规化有以下几种类型。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">正规化形式</th><th scope="col">说明</th><th scope="col">示例</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>规范等价分解</td><td>“â”(U+00E2) -&gt; “a”(U+0061) + “ ̂”(U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>兼容等价分解</td><td>“ﬁ”(U+FB01) -&gt; “f”(U+0066) + “i”(U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>规范等价分解后重组</td><td>“â”(U+00E2) -&gt; “a”(U+0061) + “ ̂”(U+0302) -&gt; “â”(U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>兼容等价分解后，规范等价重组</td><td>“ﬁ”(U+FB01) -&gt; “f”(U+0066) + “i”(U+0069) -&gt; “f”(U+0066) + “i”(U+0069)</td></tr>
	</table>
</div>

<p>规范等价 (Canonical Equivalence) 是在保持视觉和功能等价的状态下进行正规化。例如，“â” &lt;-&gt; “a” + “ ̂”</p>
<p>兼容等价 (Compatibility Equivalence) 除了规范等价外，还包括语义上不同形式的字符的正规化。例如，“ﬁ” -&gt; “f” + “i”</p>
