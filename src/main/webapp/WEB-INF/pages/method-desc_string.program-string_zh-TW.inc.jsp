<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於程式字串 (Program String)</h3>
<p>程式字串是程式語言中用於定義字串的表示形式。</p>
<p>用引號 ("" 或 '') 將字串括起來，以下字元用 \ 符號進行跳脫。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>字元</th><th>字元的 ASCII 碼</th><th>跳脫結果</th></tr>
		<tr><td>(NUL)</td><td>0x00</td><td>\0</td></tr>
		<tr><td>(BEL)</td><td>0x07</td><td>\a</td></tr>
		<tr><td>(BS)</td><td>0x08</td><td>\b</td></tr>
		<tr><td>(HT)</td><td>0x09</td><td>\t</td></tr>
		<tr><td>(LF)</td><td>0x0A</td><td>\n</td></tr>
		<tr><td>(VT)</td><td>0x0B</td><td>\v</td></tr>
		<tr><td>(FF)</td><td>0x0C</td><td>\f</td></tr>
		<tr><td>(CR)</td><td>0x0D</td><td>\r</td></tr>
		<tr><td>"</td><td>0x22</td><td>\"</td></tr>
		<tr><td>'</td><td>0x27</td><td>\'</td></tr>
		<tr><td>\</td><td>0x5C</td><td>\\</td></tr>
	</table>
</div>
