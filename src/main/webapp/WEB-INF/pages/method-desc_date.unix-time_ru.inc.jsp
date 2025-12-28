<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О времени UNIX</h3>
<p>Время UNIX (время POSIX, время Epoch) - это количество секунд, прошедших с UNIX Epoch, 1 января 1970 г., 00:00:00 (UTC), не включая секунды простоя.</p>
<p>Времена до UNIX Epoch представлены отрицательными значениями.</p>
<p>DenCode обрабатывает время UNIX в секундах. Миллисекунды и микросекунды выражаются десятичными числами.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Дата и время</th><th>Время UNIX</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
