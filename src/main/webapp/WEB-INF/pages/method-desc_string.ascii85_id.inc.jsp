<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Ascii85</h3>
<p>Ascii85 adalah skema pengkodean yang menggunakan karakter ASCII 7-bit yang dapat dicetak. Ini juga disebut Base85.</p>
<p>Dalam Ascii85, data dibagi menjadi 4 byte dan dikonversi menjadi 5 karakter ASCII.</p>
<p>Ada berbagai varian Ascii85. DenCode mendukung tiga jenis Ascii85 berikut. Yang asli adalah btoa, diikuti oleh Adobe dan Z85.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th></th><th>Ringkasan</th></tr>
                <tr><th>Z85</th><td>Digunakan dalam ZeroMQ. Menghindari karakter yang memerlukan escaping seperti "\" (backslash) dan "'" (apostrof).</td></tr>
                <tr><th>Adobe</th><td>Digunakan untuk penyandian gambar dalam file Adobe PostScript dan PDF (Portable Document Format). Diapit oleh "&lt;~" dan "~&gt;".</td></tr>
                <tr><th>btoa</th><td>Format perintah btoa UNIX. Digunakan untuk pertukaran data biner di masa lalu, tetapi sekarang tidak umum. Diapit oleh baris "xbtoa Begin" dan "xbtoa End".</td></tr>
        </table>
</div>

<p>Karakter ASCII yang digunakan dalam Ascii85 adalah sebagai berikut. Nilai 4-byte diperlakukan sebagai unsigned integer big-endian, dan setiap digit basis 85 (5 digit) dihitung untuk mendapatkan hasil konversi Ascii85 berdasarkan karakter ASCII berikut.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th></th><th>Karakter ASCII</th></tr>
                <tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
                <tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
                <tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(Aslinya adalah karakter dari " " (spasi) hingga "t", tetapi diganti dengan "!" hingga "u" mengecualikan spasi karena beberapa mailer menghapus spasi di akhir.)</td></tr>
        </table>
</div>

<p>Sebagai contoh, jika Anda mengonversi "Hello" dengan Ascii85:</p>

<p>1. Bagi setiap 4 byte. Jika kurang dari 4 byte, padding dengan "00" di akhir.</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. Perlakukan setiap 4 byte sebagai unsigned integer big-endian dan konversi nilainya ke setiap digit basis 85.</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. Konversi setiap digit basis 85 ke karakter ASCII. Jika dipadding dengan "00" di akhir, hapus bagian padding untuk Adobe/Z85.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
                <tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
                <tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
                <tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
        </table>
</div>

<p>4. Gabungkan semua karakter untuk mendapatkan hasil konversi Ascii85. Adobe diapit dengan "&lt;~" &amp; "~&gt;" dan baris baru setiap 80 karakter. btoa diapit dengan "xbtoa Begin" &amp; "xbtoa End" (termasuk panjang data dan checksum) dan baris baru setiap 78 karakter.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th></th><th>Hasil Konversi</th></tr>
                <tr><th>Z85</th><td>nm=QNzV</td></tr>
                <tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
                <tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
        </table>
</div>

<p>Selain itu, beberapa singkatan didefinisikan.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th></th><th>Singkatan</th></tr>
                <tr><th>Z85</th><td>Tidak ada</td></tr>
                <tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
                <tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2 atau lebih baru)<br /></td></tr>
        </table>
</div>
