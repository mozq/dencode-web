<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>16進数文字列について</h3>
<p>16進数文字列は、文字列のバイナリー値を16進数表記で表したものです。</p>
<p>文字エンコーディングによって、バイナリー値は異なるため、16進数文字列への変換結果も異なります。</p>

<p>例えば、「サンプル」を16進数文字列へ変換した結果は以下のとおりです。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>文字エンコーディング</th><th>16進数文字列</th></tr>
		<tr><td>UTF-8</td><td>E3 82 B5 E3 83 B3 E3 83 97 E3 83 AB</td></tr>
		<tr><td>UTF-16</td><td>30 B5 30 F3 30 D7 30 EB</td></tr>
		<tr><td>Shift_JIS</td><td>83 54 83 93 83 76 83 8B</td></tr>
	</table>
</div>
