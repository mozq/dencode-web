<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang sandi Rail Fence</h3>
<p>Sandi Rail Fence adalah salah satu sandi transposisi yang mengenkripsi dengan mengatur ulang karakter dalam teks.</p>
<p>Rail Fence berarti pagar rel, mengenkripsi dengan menempatkan karakter dalam pola zig-zag pada rel dan akhirnya menghubungkan karakter dalam satuan rel.</p>
<p>Jumlah rel menjadi kunci sandi.</p>

<p>Misalnya, mengenkripsi "THIS_IS_A_SECRET_MESSAGE" dengan 4 rel adalah sebagai berikut.</p>

<p>1. Siapkan 4 rel (tinggi 4) dan tempatkan karakter dalam pola zig-zag dari kiri atas.</p>
<pre>-----------------------------------------------
T           S           C           E          
-----------------------------------------------
  H       I   _       E   R       M   S       E
-----------------------------------------------
    I   _       A   S       E   _       S   G  
-----------------------------------------------
      S           _           T           A    
-----------------------------------------------</pre>

<p>2. Ambil karakter yang ditempatkan per rel.</p>
<pre>TSCE
HI_ERMSE
I_ASE_SG
S_TA</pre>

<p>3. Hubungkan karakter dari rel.</p>
<pre>TSCEHI_ERMSEI_ASE_SGS_TA</pre>
