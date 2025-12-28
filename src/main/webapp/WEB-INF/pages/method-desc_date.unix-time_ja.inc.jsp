<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>UNIXタイムについて</h3>
<p>UNIXタイム(POSIXタイム, エポック秒)は、UNIX Epochである 1970年1月1日 0時0分0秒(UTC) からの閏秒を含まない経過秒数です。</p>
<p>UNIX Epoch以前の時刻は、マイナス値で表します。</p>
<p>DenCodeでは、UNIX時刻を秒単位で扱います。ミリ秒やマイクロ秒は小数点以下の数値で表します。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>日時</th><th>UNIXタイム</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
