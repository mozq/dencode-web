<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Normalisasi Unicode</h3>
<p>Normalisasi Unicode adalah proses penguraian dan penggabungan karakter. Beberapa karakter Unicode memiliki beberapa representasi meskipun terlihat sama. Misalnya, "â" dapat direpresentasikan sebagai satu titik kode "â" (U+00E2), atau sebagai dua titik kode terurai (karakter dasar + karakter penggabung) "a" (U+0061) dan " ̂" (U+0302). Yang pertama disebut karakter prakomposisi, dan yang terakhir disebut urutan karakter penggabung (combining character sequence, CCS).</p>
<p>Ada jenis normalisasi Unicode berikut.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th scope="col">Bentuk Normalisasi</th><th scope="col">Deskripsi</th><th scope="col">Contoh</th></tr>
                <tr><td>Normalization Form D (NFD)</td><td>Penguraian dengan ekuivalensi kanonik</td><td>"â"(U+00E2) -&gt; "a"(U+0061) + " ̂"(U+0302)</td></tr>
                <tr><td>Normalization Form KD (NFKD)</td><td>Penguraian dengan ekuivalensi kompatibilitas</td><td>"ﬁ"(U+FB01) -&gt; "f"(U+0066) + "i"(U+0069)</td></tr>
                <tr><td>Normalization Form C (NFC)</td><td>Penguraian dengan ekuivalensi kanonik dan penggabungan kembali</td><td>"â"(U+00E2) -&gt; "a"(U+0061) + " ̂"(U+0302) -&gt; "â"(U+00E2)</td></tr>
                <tr><td>Normalization Form KC (NFKC)</td><td>Penguraian dengan ekuivalensi kompatibilitas dan penggabungan kembali dengan ekuivalensi kanonik</td><td>"ﬁ"(U+FB01) -&gt; "f"(U+0066) + "i"(U+0069) -&gt; "f"(U+0066) + "i"(U+0069)</td></tr>
        </table>
</div>

<p>Ekuivalensi kanonik menormalkan sambil mempertahankan karakter yang ekuivalen secara visual dan fungsional. Contoh: "â" &lt;-&gt; "a" + " ̂"</p>
<p>Ekuivalensi kompatibilitas menargetkan karakter yang memiliki bentuk berbeda secara semantik selain ekuivalensi kanonik. Contoh: "ﬁ" -&gt; "f" + "i"</p>
