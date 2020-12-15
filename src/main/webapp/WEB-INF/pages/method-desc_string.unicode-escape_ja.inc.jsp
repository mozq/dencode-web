<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Unicodeエスケープシーケンスについて</h3>
<p>文字列をUnicodeエスケープシーケンスの形式に変換します。</p>
<p>Unicodeエスケープシーケンスは、1文字を \uXXXX のような16進数4桁のコードポイントの形式に変換します。例えば「あ」は「\u3042」となります。</p>
<p>サロゲートペアとして表されるUnicodeのBMPの範囲外の文字についてはコードポイントが4桁に収まらないため、プログラミング言語ごとに以下のような形式で表します。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th scope="col">プログラミング言語</th><th scope="col">形式</th><th scope="col">「😀」(U+01F600)の変換結果</th></tr>
		<tr><td>Java, JS(ES5)</td><td>\uXXXX\uXXXX</td><td>\ud83d\ude00</td></tr>
		<tr><td>Swift, JS(ES6+), PHP, Ruby</td><td>\u{XXXXX}</td><td>\u{1f600}</td></tr>
		<tr><td>C, Python</td><td>\U000XXXXX</td><td>\U0001f600</td></tr>
	</table>
</div>
