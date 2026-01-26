<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang ROT47</h3>
<p>ROT47 adalah salah satu cipher substitusi monoalfabetik yang mengenkripsi dengan mengganti karakter dalam teks dengan karakter lain.</p>
<p>Penggantian karakter dilakukan dengan menggeser karakter "!" hingga "~" sejauh 47 karakter dalam 94 karakter "!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~".</p>
<p>Sebagai contoh, "!" dienkripsi menjadi "P", "A" menjadi "p", dan "0" menjadi "_".</p>

<pre>
Sebelum enkripsi : !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
Setelah enkripsi : PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO
</pre>

<pre>
Teks sebelum enkripsi : THIS IS A SECRET MESSAGE 123!
Teks setelah enkripsi : %wx$ x$ p $tr#t% |t$$pvt `abP
</pre>

<p>Karena memiliki sifat resiprokal di mana teks asli dapat diperoleh dengan mengenkripsi kembali teks sandi, dekripsi juga dapat dilakukan dengan alur yang sama seperti enkripsi.</p>
