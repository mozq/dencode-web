<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 UNIX 時間 (UNIX Time)</h3>
<p>UNIX 時間 (POSIX 時間，Epoch 秒) 是指從 UNIX Epoch (1970年1月1日 0時0分0秒 (UTC)) 起經過的秒數（不包含閏秒）。</p>
<p>UNIX Epoch 以前的時間用負數表示。</p>
<p>DenCode 以秒為單位處理 UNIX 時間。毫秒和微秒用小數點後的數值表示。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>日期時間</th><th>UNIX 時間</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
