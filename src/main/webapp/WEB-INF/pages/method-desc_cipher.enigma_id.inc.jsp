<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Sandi Enigma</h3>
<p>Sandi Enigma adalah salah satu jenis sandi substitusi yang mengenkripsi dengan mengganti karakter dengan karakter lain. Ini mendukung enkripsi 26 karakter dari "A" hingga "Z".</p>
<p>Substitusi karakter dilakukan menggunakan mesin Enigma. DenCode mendukung simulasi mesin Enigma berikut.</p>

<ul>
	<li>Enigma I</li>
	<li>Enigma M3</li>
	<li>Enigma M4 (U-boat Enigma)</li>
	<li>Norway Enigma "Norenigma"</li>
	<li>Sondermaschine (Special machine)</li>
	<li>Enigma G "Zählwerk Enigma" (A28/G31)</li>
	<li>Enigma G G-312 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-260 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-111 (G31 Hungarian Enigma)</li>
	<li>Enigma D (Commercial Enigma A26)</li>
	<li>Enigma K (Commercial Enigma A27)</li>
	<li>Enigma KD (Enigma K with UKW-D)</li>
	<li>Swiss-K (Swiss Enigma K variant)</li>
	<li>Railway Enigma "Rocket I"</li>
	<li>Enigma T "Tirpitz" (Japanese Enigma)</li>
	<li>Spanish Enigma, wiring D</li>
	<li>Spanish Enigma, wiring F</li>
	<li>Spanish Enigma, Delta (A 16081)</li>
	<li>Spanish Enigma, Sonderschaltung / Delta (A 16101)</li>
</ul>

<p>Mesin Enigma dikonfigurasi sebagai berikut. Karakter yang dimasukkan dari keyboard (Tastatur) melewati papan colokan (Steckerbrett), roda masuk (ETW, Eintrittswalze), 3 atau 4 rotor (Walze), dan reflektor (UKW, Umkehrwalze), lalu mengikuti jalur terbalik dan hasil enkripsi ditampilkan di papan lampu (Lampenfeld). Substitusi karakter dilakukan di semua tempat seperti rotor.</p>

<pre>
 UKW   Walze  Walze  Walze   ETW  (Stecker)
         3      2      1
 ___    ___    ___    ___    ___    ___
|   |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &lt; Tastatur
| | |  |   |  |   |  |   |  |   |  |   |
| | |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &gt; Lampenfeld
|   |  |   |  |   |  |   |  |   |  |   |
 ---    ---    ---    ---    ---    ---
</pre>

<p>Roda masuk, rotor, dan reflektor memiliki kabel internal untuk mengubah 26 karakter dari "A" hingga "Z" menjadi karakter lain, dan substitusi terjadi ketika arus dilewatkan melalui kabel tersebut. Misalnya, rotor "I" dari Enigma I memiliki kabel berikut, dan karakter "A" diganti dengan "E". Juga, jika karakter yang dikembalikan dari reflektor adalah "J", ia mengikuti kabel terbalik dan diganti dengan "Z".</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Semua kabel Enigma I adalah sebagai berikut.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Roda</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
		<tr><td>ETW</td><td>ABCDEFGHIJKLMNOPQRSTUVWXYZ</td></tr>
		<tr><td>I</td><td>EKMFLGDQVZNTOWYHXUSPAIBRCJ</td></tr>
		<tr><td>II</td><td>AJDKSIRUXBLHWTMCQGZNPYFVOE</td></tr>
		<tr><td>III</td><td>BDFHJLCPRTXVZNYEIWGAKMUSQO</td></tr>
		<tr><td>IV</td><td>ESOVPZJAYQUIRHXLNFTGKDCMWB</td></tr>
		<tr><td>V</td><td>VZBRGITYUPSDNHLXAWMJQOFECK</td></tr>
		<tr><td>UKW-A</td><td>EJMZALYXVBWFCRQUONTSPIKHGD</td></tr>
		<tr><td>UKW-B</td><td>YRUHQSLDPXNGOKMIEBFZCWVJAT</td></tr>
		<tr><td>UKW-C</td><td>FVPJIAOYEDRZXWGCTKUQSBNMHL</td></tr>
	</table>
</div>

<p>Papan colokan (plugboard) adalah mekanisme yang memungkinkan pengguna melakukan substitusi dengan kabel. Beberapa mesin Enigma memiliki papan colokan sebelum ETW. Papan colokan memiliki terminal input/output untuk 26 huruf alfabet dari "A" hingga "Z", dan dengan menghubungkan dua huruf alfabet apa pun dengan kabel, kedua huruf tersebut dapat ditukar. Misalnya, jika "A" dan "M" dihubungkan dengan kabel, "A" diganti dengan "M", dan "M" diganti dengan "A". Karakter dari terminal input/output yang tidak dihubungkan dengan kabel tidak diganti.</p>
<p>Memasukkan satu karakter dari keyboard memutar rotor satu langkah. Rotasi rotor dimulai dari rotor kanan, dan ketika mencapai posisi takik pada rotor, rotor kiri juga berputar satu langkah. Rotasi rotor ini mengubah kabel untuk enkripsi setiap karakter, sehingga bahkan jika karakter yang sama dimasukkan, itu akan diganti dengan karakter yang berbeda dari sebelumnya.</p>
<p>Rotor memiliki cincin, dan keliling luar cincin ditandai dengan karakter dari "A" hingga "Z" (atau "01" hingga "26"). Cincin dapat mengatur offset antara karakter pada keliling luar dan kabel internal rotor dalam 26 langkah. Misalnya, dalam kasus rotor "I" dari "Enigma I", jika pengaturan cincin adalah "A (01)", "A" diganti dengan "E", tetapi jika pengaturan cincin adalah "B (02)", kabel internal bergeser 1, sehingga sebagai kabel Z-J asli, "A" diganti dengan "K".</p>

<pre>
Cincin: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

Cincin: B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>Rotor dapat diatur untuk urutan dan posisi awal rotasi. Misalnya, jika ada tiga jenis rotor "I", "II", dan "III", mesin Enigma dapat diatur dalam urutan seperti "II", "I", "III", dan posisi awal setiap rotor dapat diatur antara "A (01)" dan "Z (26)". Adapun reflektor, ada mesin Enigma yang dapat ditukar dari beberapa jenis reflektor dengan kabel yang berbeda, dan beberapa yang memungkinkan posisi awal diatur. Roda masuk tetap dan tidak dapat diubah. Dalam kasus mesin Enigma dengan papan colokan, pengaturan papan colokan juga dimungkinkan. Pengaturan ini menjadi kunci enkripsi oleh mesin Enigma.</p>
<p>Contoh enkripsi dengan Enigma I adalah sebagai berikut.</p>

<pre>
Roda          : UKW-A II I III
Pengaturan Cincin : X M V  (24 13 22)
Pengaturan Posisi : A B L  (01 02 12)
Papan Colokan : AM FI NV PS TU WZ

Sebelum Enkripsi: SECRET
Setelah Enkripsi: LCGODU
</pre>

<p>Dalam kasus ini, karakter pertama "S" diganti melalui aliran berikut dan akhirnya dienkripsi menjadi "L".</p>

<pre>
S -&gt; P  : Papan Colokan
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : Papan Colokan
</pre>

<p>Selain itu, posisi rotasi rotor dan posisi Input (+) / Output (-) direpresentasikan oleh karakter pada cincin adalah sebagai berikut. (Karena rotor berputar, "karakter yang diganti" di atas dan "karakter sebagai posisi pada cincin" berbeda.)</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Papan Colokan
           -   +          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           -   +          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           +  -           
BCDEFGHIJKLMNOPQRSTUVWXYZA  : I
               +-         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          -           +   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>

<p>Mesin Enigma memiliki karakteristik bahwa jikat teks terenkripsi dienkripsi lagi dengan pengaturan yang sama, teks asli sebelum enkripsi diperoleh. Oleh karena itu, jika Anda memasukkan "L" yang dienkripsi dalam contoh di atas, "S" asli diperoleh.</p>

<pre>
L -&gt; L  : Papan Colokan
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : Papan Colokan
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Papan Colokan
           +   -          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           +   -          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           -  +           
BCDEFGHIJKLMNOPQRSTUVWXYZA  : I
               -+         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          +           -   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>


<h3>Item Pengaturan di DenCode</h3>

<h4>Pesanan Roda (Walzenlage)</h4>
<p>Mengatur jenis reflektor dan rotor, serta urutan rotor.</p>
<p>Karena input dari sisi kanan mesin Enigma, rotor dihitung 1, 2, 3 dari rotor kanan, tetapi saat menulis pengaturan pesanan roda, umumnya ditulis urut dari kiri. Misalnya, dalam kasus pesanan roda "UKW-A II I III", ini mewakili pengaturan rotor 1 "III", rotor 2 "I", rotor 3 "II", dan reflektor "UKW-A".</p>
<p>Biasanya ada total 4 item: 1 reflektor dan 3 rotor, tetapi Enigma M4 dapat mengatur "reflektor tipis" dan "rotor tipis" di slot reflektor. Di DenCode, "reflektor tipis" diperlakukan sama dengan reflektor normal, dan "rotor tipis" (Beta, Gamma) ditampilkan tambahan sebagai rotor 4, membuat total 5 pengaturan. Namun, jika reflektor adalah UKW-D, rotor 4 tidak dapat diatur karena menempati slot reflektor.</p>

<h4>Pengaturan Cincin (Ringstellung)</h4>
<p>Mengatur cincin rotor. Pengaturan ini mengubah posisi kabel internal rotor relatif terhadap cincin. Pada beberapa mesin Enigma, reflektor juga dapat mengatur cincin.</p>

<h4>Pengaturan Posisi (Grundstellung)</h4>
<p>Mengatur posisi awal rotor. Pada beberapa mesin Enigma, reflektor juga dapat mengatur posisi awal.</p>
<p>Karena pengaturan diubah untuk setiap pesan, kadang-kadang disebut "Kunci pesan" (Message key).</p>

<h4>Koneksi Papan Colokan (Steckerverbindungen)</h4>
<p>Mengatur pasangan kabel papan colokan.</p>
<p>Di DenCode, kabel ditentukan dengan mendaftar pasangan 2 karakter untuk diganti dipisahkan oleh spasi, seperti "AB CD EF GH IJ KL". Contoh ini mewakili pasangan kabel "A" dan "B", "C" dan "D", dll.</p>

<h4>Uhr</h4>
<p>Uhr adalah aksesori yang terhubung ke papan colokan untuk memilih kabel dari 40 cara mulai dari "00" hingga "39". Papan colokan dan Uhr dihubungkan dengan 20 kabel. Kabel berpasangan dua-dua, dan ada 10 pasang. Jika pengaturan Uhr adalah "00", itu sama dengan pasangan kabel yang dihubungkan langsung pada papan colokan.</p>
<p>Uhr hanya dapat diatur untuk Enigma I. Pengaturan Uhr dimungkinkan dengan menentukan 10 set pasangan kabel papan colokan terlebih dahulu.</p>

<h4>Kabel UKW-D</h4>
<p>UKW-D adalah reflektor dengan kabel internal yang dapat diubah.</p>
<p>Notasi cincin reflektor normal adalah "ABCDEFGHIJKLMNOPQRSTUVWXYZ", tetapi notasi UKW-D adalah urutan khusus "A-ZXWVUTSRQPON-MLKIHGFEDCB". Dua "-" dalam notasi (BO dalam notasi normal) tetap, selalu terhubung satu sama lain dan tidak dapat diubah. Atur kabel untuk 12 pasang dari 24 karakter lainnya.</p>

<pre>
Notasi UKW-D : A-ZXWVUTSRQPON-MLKIHGFEDCB
Notasi Normal: ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-D dapat diatur dalam kasus Enigma I, Enigma M4, dan Enigma KD.</p>
