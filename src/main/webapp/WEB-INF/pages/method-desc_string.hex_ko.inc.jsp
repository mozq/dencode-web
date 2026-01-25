<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>16진수 문자열에 대해서</h3>
<p>16진수 문자열은 문자열의 바이너리 값을 16진수 표기로 나타낸 것입니다.</p>
<p>문자 인코딩에 따라 바이너리 값은 다르기 때문에, 16진수 문자열로의 변환 결과도 다릅니다.</p>

<p>예를 들어, '샘플(サンプル)'을 16진수 문자열로 변환한 결과는 다음과 같습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>문자 인코딩</th><th>16진수 문자열</th></tr>
		<tr><td>UTF-8</td><td>E3 82 B5 E3 83 B3 E3 83 97 E3 83 AB</td></tr>
		<tr><td>UTF-16</td><td>30 B5 30 F3 30 D7 30 EB</td></tr>
		<tr><td>Shift_JIS</td><td>83 54 83 93 83 76 83 8B</td></tr>
	</table>
</div>
