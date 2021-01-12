<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>UNIX時刻について</h3>
<p>UNIX時刻(POSIX時刻, エポック秒)は、UNIX Epochである 1970年1月1日 0時0分0秒(UTC) からの閏秒を含まない経過秒数です。</p>
<p>UNIX Epoch以前の時刻は、マイナス値で表します。</p>
<p>DenCodeでは、UNIX時刻をミリ秒で扱います。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>日時</th><th>UNIX時刻</th></tr>
		<tr><td>1900-01-01 00:00:00.000 UTC</td><td>-2208988800000</td></tr>
		<tr><td>1970-01-01 00:00:00.000 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625678</td></tr>
	</table>
</div>
