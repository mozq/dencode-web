<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Unicode Normalization</h3>
<p>Unicode normalization is the decomposition and composition of characters. Some Unicode characters have the same appearance but multiple representations. For example, "â" can be represented as one code point for "â" (U+00E2), and two decomposed code points for "a" (U+0061) and " ̂" (U+0302). It can also be expressed as (base character + combining character). The former is called a precomposed character and the latter is called a combining character sequence (CCS).</p>
<p>There are the following types of Unicode normalization:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Normalization Form</th><th scope="col">Description</th><th scope="col">Example</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>Characters are decomposed by canonical equivalence</td><td>"â" (U+00E2) -&gt; "a" (U+0061) + " ̂" (U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>Characters are decomposed by compatibility</td><td>"ﬁ" (U+FB01) -&gt; "f" (U+0066) + "i" (U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>Characters are decomposed and then re-composed by canonical equivalence</td><td>"â" (U+00E2) -&gt; "a" (U+0061) + " ̂" (U+0302) -&gt; "â" (U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>Characters are decomposed by compatibility, then re-composed by canonical equivalence</td><td>"ﬁ" (U+FB01) -&gt; "f" (U+0066) + "i" (U+0069) -&gt; "f" (U+0066) + "i" (U+0069)</td></tr>
	</table>
</div>

<p>Canonical equivalence normalizes while preserving visually and functionally equivalent characters. e.g. "â" &lt;-&gt; "a" + " ̂"</p>
<p>In addition to canonical equivalence, compatibility equivalence also normalizes characters that have different semantic shapes. e.g. "ﬁ" -&gt; "f" + "i"</p>
