<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Waktu UNIX</h3>
<p>Waktu UNIX (Waktu POSIX, detik epoch) adalah jumlah detik yang telah berlalu sejak UNIX Epoch pada 1 Januari 1970 00:00:00 (UTC), tidak termasuk detik kabisat.</p>
<p>Waktu sebelum UNIX Epoch direpresentasikan dengan nilai negatif.</p>
<p>Di DenCode, Waktu UNIX diperlakukan dalam satuan detik. Milidetik dan mikrodetik direpresentasikan sebagai angka desimal.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Tanggal & Waktu</th><th>Waktu UNIX</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
