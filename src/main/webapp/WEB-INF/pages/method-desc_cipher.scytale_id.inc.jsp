<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang sandi Scytale</h3>
<p>Sandi Scytale adalah salah satu sandi transposisi yang mengenkripsi dengan mengatur ulang karakter dalam teks.</p>
<p>Dahulu digunakan di Yunani kuno dengan melilitkan pita kulit panjang pada batang silinder poligon "Scytale" dan menulis karakter di atasnya.</p>
<p>Ketebalan batang Scytale (panjang keliling = jumlah karakter) menjadi kunci sandi.</p>

<p>Sebagai contoh, jika keliling adalah 4 karakter dan Anda mengenkripsi "THIS_IS_A_SECRET_MESSAGE":</p>

<p>1. Susun karakter dengan baris baru setiap 4 karakter.</p>
<pre>
-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------
</pre>

<p>2. Baca karakter dari atas ke bawah.</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>
