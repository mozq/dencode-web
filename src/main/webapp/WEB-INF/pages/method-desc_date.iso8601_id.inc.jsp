<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang waktu ISO 8601</h3>
<p>ISO 8601 adalah format representasi tanggal dan waktu yang didefinisikan sebagai standar internasional oleh ISO.</p>
<p>Tanggal dan waktu dihubungkan dengan "T". Zona waktu direpresentasikan sebagai selisih dari UTC, seperti "+09:00", dan "Z" untuk UTC.</p>
<p>Detik dan milidetik dipisahkan dengan koma (,) atau titik (.). Di DenCode, milidetik dihilangkan jika 000.</p>

<p>ISO 8601 memiliki beberapa format.</p>
<p>Sebagai contoh, jika Anda mengonversi 23 Januari 2000, 01:23:45.678 (JST; +09:00) ke ISO 8601, hasilnya adalah sebagai berikut.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th>Format</th><th>Hasil Konversi</th></tr>
                <tr><td>Format dasar</td><td>20000123T012345.678+0900</td></tr>
                <tr><td>Format diperpanjang</td><td>2000-01-23T01:23:45.678+09:00</td></tr>
                <tr><td>Minggu (Tahun-Minggu-Hari)</td><td>2000-W03-7T01:23:45.678+09:00</td></tr>
                <tr><td>Hari (Tahun-Hari dalam setahun)</td><td>2000-023T01:23:45.678+09:00</td></tr>
        </table>
</div>
