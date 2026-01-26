<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang waktu W3C-DTF</h3>
<p>W3C-DTF adalah format representasi tanggal dan waktu yang didefinisikan dalam <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3C NOTE-datetime</a>. Ini adalah subset yang terbatas pada beberapa format ISO 8601.</p>
<p>Tanggal dan waktu dihubungkan dengan "T". Zona waktu direpresentasikan sebagai selisih dari UTC, seperti "+09:00", dan "Z" untuk UTC.</p>
<p>Detik dan milidetik dipisahkan dengan titik (.).</p>

<p>W3C-DTF digunakan sebagai representasi tanggal dan waktu di tajuk HTTP dan RSS.</p>

<p>Sebagai contoh, jika Anda mengonversi 23 Januari 2000, 01:23:45.678 (JST; +09:00) ke W3C-DTF, hasilnya adalah sebagai berikut.</p>

<pre>2000-01-23T01:23:45.678+09:00</pre>
