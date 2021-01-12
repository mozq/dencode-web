<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About UNIX time</h3>
<p>UNIX time (POSIX time, Epoch time) is the number of seconds that have passed since the UNIX Epoch, January 1, 1970, 00:00:00 (UTC), not including leap seconds.</p>
<p>Times prior to UNIX Epoch are represented by negative values.</p>
<p>DenCode handles UNIX time in milliseconds.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>Date and time</th><th>UNIX time</th></tr>
		<tr><td>1900-01-01 00:00:00.000 UTC</td><td>-2208988800000</td></tr>
		<tr><td>1970-01-01 00:00:00.000 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625678</td></tr>
	</table>
</div>
