<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Unicode 정규화에 대해서</h3>
<p>Unicode 정규화란 문자를 분해·합성하는 것을 말합니다. Unicode 문자는 겉보기에는 같아도 복수의 표현 방법이 존재하는 것이 있습니다. 예를 들어 'â'는 'â'(U+00E2)의 1개 코드 포인트로도 나타낼 수 있고, 'a'(U+0061)와 ' ̂'(U+0302)의 2개 분해된 코드 포인트(기저 문자 + 결합 문자)로도 나타낼 수 있습니다. 전자를 합성된 문자(Precomposed character), 후자를 결합 문자열(Combining character sequence, CCS)이라고 부릅니다.</p>
<p>Unicode 정규화에는 다음 종류가 있습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">정규화 형식</th><th scope="col">설명</th><th scope="col">예</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>정준 등가(Canonical Equivalence)로 분해</td><td>「â」(U+00E2) -&gt; 「a」(U+0061) + 「 ̂」(U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>호환 등가(Compatibility Equivalence)로 분해</td><td>「ﬁ」(U+FB01) -&gt; 「f」(U+0066) + 「i」(U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>정준 등가로 분해 후 다시 합성</td><td>「â」(U+00E2) -&gt; 「a」(U+0061) + 「 ̂」(U+0302) -&gt; 「â」(U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>호환 등가로 분해 후, 정준 등가로 다시 합성</td><td>「ﬁ」(U+FB01) -&gt; 「f」(U+0066) + 「i」(U+0069) -&gt; 「f」(U+0066) + 「i」(U+0069)</td></tr>
	</table>
</div>

<p>정준 등가는 시각적 및 기능적으로 등가인 문자를 유지한 상태에서 정규화합니다. 예. 「â」 &lt;-&gt; 「a」 + 「 ̂」</p>
<p>호환 등가는 정준 등가 외에, 의미적으로 다른 형태를 취하는 문자도 정규화 대상이 됩니다. 예. 「ﬁ」 -&gt; 「f」 + 「i」</p>
