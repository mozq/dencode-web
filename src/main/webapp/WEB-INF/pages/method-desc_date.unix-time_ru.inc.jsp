<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О времени UNIX</h3>
<p>Время UNIX (время POSIX, время Epoch) - это количество секунд, прошедших с UNIX Epoch, 1 января 1970 г., 00:00:00 (UTC), не включая секунды простоя.</p>
<p>Времена до UNIX Epoch представлены отрицательными значениями.</p>
<p>DenCode обрабатывает время UNIX в миллисекундах.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>Дата и время</th><th>Время UNIX</th></tr>
		<tr><td>1900-01-01 00:00:00.000 UTC</td><td>-2208988800000</td></tr>
		<tr><td>1970-01-01 00:00:00.000 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625678</td></tr>
	</table>
</div>
