<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang ROT18</h3>
<p>ROT18 adalah salah satu cipher substitusi monoalfabetik yang mengenkripsi dengan mengganti karakter dalam teks dengan karakter lain.</p>
<p>Penggantian karakter dilakukan dengan menggeser karakter "A" hingga "Z" sejauh 13 karakter dalam 26 karakter "ABCDEFGHIJKLMNOPQRSTUVWXYZ". Selain itu, angka "0" hingga "9" digeser sejauh 5 karakter dalam 10 karakter "0123456789".</p>
<p>Sebagai contoh, "A" dienkripsi menjadi "N", dan "0" menjadi "5".</p>

<pre>
Sebelum enkripsi : ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
Setelah enkripsi : NOPQRSTUVWXYZABCDEFGHIJKLM5678901234
</pre>

<pre>
Teks sebelum enkripsi : THIS IS A SECRET MESSAGE 123
Teks setelah enkripsi : GUVF VF N FRPERG ZRFFNTR 567
</pre>

<p>Karena memiliki sifat resiprokal di mana teks asli dapat diperoleh dengan mengenkripsi kembali teks sandi, dekripsi juga dapat dilakukan dengan alur yang sama seperti enkripsi.</p>
