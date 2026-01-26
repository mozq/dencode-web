<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Sandi Affine</h3>
<p>Sandi Affine adalah salah satu sandi substitusi tunggal yang mengenkripsi dengan mengganti karakter dalam teks dengan karakter lain.</p>
<p>Substitusi karakter dilakukan menggunakan rumus perhitungan berikut.</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> mewakili jenis karakter yang akan dikonversi. <var>x</var> adalah karakter yang digantikan oleh angka dari 0 hingga m - 1. <var>a</var> dan <var>b</var> adalah kunci enkripsi.</p>

<p>Sebagai contoh, dalam kasus 26 huruf alfabet "ABCDEFGHIJKLMNOPQRSTUVWXYZ", <var>m</var> = 26, dan <var>x</var> adalah 0 hingga 25 di mana A hingga Z diganti dengan angka.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Karakter</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>Jika <var>a</var> = 5 dan <var>b</var> = 3, enkripsi dilakukan sebagai berikut.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Sebelum Enkripsi</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>Setelah Enkripsi</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>Hasil enkripsi semua huruf alfabet dengan <var>a</var> = 5, <var>b</var> = 3 adalah sebagai berikut.</p>

<pre>
Sebelum : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Sesudah : DINSXCHMRWBGLQVAFKPUZEJOTY
</pre>

<p>Jika <var>a</var> = 1, <var>b</var> = -3 ditentukan, hasilnya sama dengan sandi Caesar. Jika <var>a</var> = 1, <var>b</var> = 13 ditentukan, hasilnya sama dengan ROT13. Jika <var>a</var> = -1, <var>b</var> = -1 ditentukan, hasilnya sama dengan sandi Atbash.</p>

<p><var>a</var> harus berupa angka yang relatif prima dengan <var>m</var>. Ini berarti satu-satunya angka yang dapat membagi <var>a</var> dan <var>m</var> adalah 1. Misalnya, jika <var>a</var> = 4 dan <var>m</var> = 26, itu tidak dapat ditentukan karena dapat dibagi dengan 2 selain 1. Di DenCode, jika <var>a</var> yang tidak valid ditentukan, karakter asli dikembalikan apa adanya tanpa konversi.</p>


<h4>Dukungan Bahasa Lain</h4>
<p>Selain huruf Latin, huruf Sirilik dan Hiragana/Katakana Jepang juga didukung.</p>

<p>Hasil enkripsi dengan <var>a</var> = 5, <var>b</var> = 3 masing-masing adalah sebagai berikut.</p>

<h5>Huruf Sirilik</h5>
<pre>
Sebelum : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Sesudah : ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ
</pre>

<p><var>m</var> = 32 (32 karakter).</p>

<h5>Hiragana/Katakana Jepang</h5>
<pre>
Sebelum : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Sesudah : いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん
</pre>

<pre>
Sebelum : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Sesudah : イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン
</pre>

<p>Urutan karakter didasarkan pada urutan definisi di Unicode. Harap dicatat bahwa "ゕ", "ゖ", "ヵ", "ヶ" dan "ヷ", "ヸ", "ヹ", "ヺ" tidak dikenakan enkripsi.</p>

<p><var>m</var> = 84 (84 karakter).</p>
