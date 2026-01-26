<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang String Biner</h3>
<p>String biner adalah representasi nilai biner string dalam notasi biner.</p>
<p>Karena nilai biner berbeda tergantung pada pengkodean karakter, hasil konversi ke string biner juga berbeda.</p>

<p>Sebagai contoh, hasil konversi "サンプル" ke string biner adalah sebagai berikut.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th>Pengkodean Karakter</th><th>String Biner</th></tr>
                <tr><td>UTF-8</td><td>11100011 10000010 10110101 11100011 10000011 10110011 11100011 10000011 10010111 11100011 10000011 10101011</td></tr>
                <tr><td>UTF-16</td><td>00110000 10110101 00110000 11110011 00110000 11010111 00110000 11101011</td></tr>
                <tr><td>Shift_JIS</td><td>10000011 01010100 10000011 10010011 10000011 01110110 10000011 10001011</td></tr>
        </table>
</div>
