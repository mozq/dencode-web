<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Urutan Escape Unicode</h3>
<p>Mengonversi string ke format urutan escape Unicode.</p>
<p>Urutan escape Unicode mengonversi 1 karakter ke format titik kode heksadesimal 4 digit seperti \uXXXX. Misalnya "あ" menjadi "\u3042".</p>

<p>Di DenCode, selain format \uXXXX, notasi format berikut juga didukung.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th scope="col">Format</th><th scope="col">Hasil konversi "ABC"</th><th scope="col">Deskripsi / Bahasa Pemrograman</th></tr>
                <tr><td>\uXXXX</td><td>\u0041\u0042\u0043</td><td>Urutan escape Unicode umum</td></tr>
                <tr><td>\u{X}</td><td>\u{41}\u{42}\u{43}</td><td>Lua</td></tr>
                <tr><td>\x{X}</td><td>\x{41}\x{42}\x{43}</td><td>Perl</td></tr>
                <tr><td>\X</td><td>\41\42\43</td><td>CSS</td></tr>
                <tr><td>&amp;#xX;</td><td>&amp;#x41;&amp;#x42;&amp;#x43;</td><td>HTML, XML</td></tr>
                <tr><td>%uXXXX</td><td>%u0041%u0042%u0043</td><td>Percent-encoding (Non-standar)</td></tr>
                <tr><td>U+XXXX</td><td>U+0041 U+0042 U+0043</td><td>Notasi standar Unicode titik kode (dipisahkan spasi)</td></tr>
                <tr><td>0xX</td><td>0x41 0x42 0x43</td><td>Notasi heksadesimal titik kode (dipisahkan spasi)</td></tr>
        </table>
</div>

<p>Beberapa format di atas disebutkan sebagai BEST CURRENT PRACTICE dalam <a href="https://www.rfc-editor.org/rfc/rfc5137" target="_blank">RFC 5137 (ASCII Escaping of Unicode Characters)</a>, tetapi tidak ada standar internasional, dll.</p>
<p>Format %uXXXX didukung oleh Microsoft IIS, tetapi merupakan format non-standar. Anda dapat mengkodekan ke format %u dengan <a href="https://learn.microsoft.com/en-us/dotnet/api/system.web.httputility.urlencodeunicode" target="_blank">System.Web.HttpUtility.UrlEncodeUnicode</a> di C#, tetapi metode ini tidak lagi disarankan sejak .NET Framework 4.5.</p>
<p>Perhatikan bahwa format \X diperlakukan sebagai pembatas dan diabaikan jika diikuti oleh satu spasi half-width saat mendekode, sebagai <a href="https://www.w3.org/International/questions/qa-escapes" target="_blank">spesifikasi CSS</a>. Dalam format U+XXXX atau 0xX, setiap karakter dipisahkan oleh spasi half-width saat mengkodekan, dan satu spasi half-width yang berurutan diabaikan saat mendekode, sama seperti format \X.</p>


<h4>Escape dengan Nama Unicode</h4>

<p>Sebagai urutan escape Unicode, escape dengan nama Unicode juga didukung.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th scope="col">Format</th><th scope="col">Hasil konversi "A"</th><th scope="col">Deskripsi / Bahasa Pemrograman</th></tr>
                <tr><td>\N{name}</td><td>\N{LATIN CAPITAL LETTER A}</td><td>C++23, Python, Perl</td></tr>
        </table>
</div>

<p>Nama Unicode dapat dikonfirmasi di <a href="https://unicode.org/charts/nameslist/" target="_blank">Names List Charts - Unicode</a> atau <a href="https://www.unicode.org/Public/15.0.0/ucd/NamesList.txt" target="_blank">NamesList.txt - Unicode</a>.</p>


<h4>Karakter di luar rentang BMP Unicode dalam urutan escape Unicode</h4>

<p>Untuk karakter non-BMP Unicode, karena titik kode tidak muat dalam 4 digit, mereka direpresentasikan dalam notasi format berikut untuk setiap bahasa pemrograman.</p>
<p>Misalnya, hasil konversi "😀" (U+1F600) adalah sebagai berikut.</p>

<div class="table-responsive">
        <table class="table">
                <tr><th scope="col">Format</th><th scope="col">Hasil konversi "😀" (U+1F600)</th><th scope="col">Bahasa Pemrograman</th></tr>
                <tr><td>\uXXXX</td><td>\uD83D\uDE00</td><td>Java, Kotlin, Scala</td></tr>
                <tr><td>\u{X}</td><td>\u{1F600}</td><td>C++23, Rust, Swift, JavaScript, PHP, Ruby, Dart, Lua</td></tr>
                <tr><td>\U00XXXXXX</td><td>\U0001F600</td><td>C, C++, Objective-C, C#, Go, Python, R</td></tr>
                <tr><td>\x{X}</td><td>\x{1F600}</td><td>Perl</td></tr>
                <tr><td>\X</td><td>\1F600</td><td>CSS</td></tr>
                <tr><td>&amp;#xX;</td><td>&amp;#x1F600;</td><td>HTML, XML</td></tr>
                <tr><td>%uXXXX</td><td>%uD83D%uDE00</td><td>-</td></tr>
                <tr><td>U+XXXX</td><td>U+1F600</td><td>-</td></tr>
                <tr><td>0xX</td><td>0x1F600</td><td>-</td></tr>
                <tr><td>\N{name}</td><td>\N{GRINNING FACE}</td><td>C++23, Python, Perl</td></tr>
        </table>
</div>

<p>Dalam format \uXXXX dan %uXXXX, karakter non-BMP direpresentasikan oleh dua unit kode sebagai pasangan pengganti UTF-16. Dalam format lain, 1 karakter direpresentasikan oleh 1 titik kode.</p>
