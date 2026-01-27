<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 UNIX 时间 (UNIX Time)</h3>
<p>UNIX 时间 (POSIX 时间，Epoch 秒) 是指从 UNIX Epoch (1970年1月1日 0时0分0秒 (UTC)) 起经过的秒数（不包含闰秒）。</p>
<p>UNIX Epoch 以前的时间用负数表示。</p>
<p>DenCode 以秒为单位处理 UNIX 时间。毫秒和微秒用小数点后的数值表示。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>日期时间</th><th>UNIX 时间</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
