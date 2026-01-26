<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Sandi ROT47</h3>
<p>Sandi ROT47 adalah sandi yang menggunakan rentang karakter lebih luas daripada <a href="rot13">ROT13</a>.</p>
<p>Ini mengenkripsi karakter dalam rentang kode ASCII 33 "!" hingga 126 "~" dengan menggesernya 47 karakter.</p>
<p>Misalnya, "A" dienkripsi menjadi "p", dan "a" menjadi "2".</p>

<pre>Sebelum: !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
Sesudah: PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO</pre>

<p>Karena karakter yang dapat dicetak dalam kode ASCII adalah 94 karakter (33 hingga 126), menggeser 47 karakter dua kali akan kembali ke aslinya. Artinya, proses yang sama dapat digunakan untuk enkripsi dan dekripsi.</p>
