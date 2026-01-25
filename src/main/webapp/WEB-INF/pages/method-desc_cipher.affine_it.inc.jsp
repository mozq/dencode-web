<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sul Cifrario Affine</h3>
<p>Il Cifrario Affine è un tipo di cifrario a sostituzione monoalfabetica che crittografa sostituendo i caratteri del testo con altri caratteri.</p>
<p>La sostituzione dei caratteri viene eseguita utilizzando la seguente formula:</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> rappresenta il numero di tipi di caratteri da convertire. <var>x</var> è il carattere sostituito da un numero da 0 a m - 1. <var>a</var> e <var>b</var> sono le chiavi di crittografia.</p>

<p>Ad esempio, nel caso delle 26 lettere dell'alfabeto "ABCDEFGHIJKLMNOPQRSTUVWXYZ", <var>m</var> = 26, e <var>x</var> diventa un numero da 0 a 25 che sostituisce A ~ Z.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Carattere</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>Se impostiamo <var>a</var> = 5 e <var>b</var> = 3, la crittografia avviene come segue:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Prima (Chiaro)</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>Dopo (Cifrato)</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>Il risultato della crittografia di tutte le lettere inglesi con <var>a</var> = 5 e <var>b</var> = 3 è il seguente:</p>

<pre>Prima: ABCDEFGHIJKLMNOPQRSTUVWXYZ
Dopo : DINSXCHMRWBGLQVAFKPUZEJOTY</pre>

<p>Specificando <var>a</var> = 1, <var>b</var> = -3 si ottiene lo stesso risultato del Cifrario di Cesare, con <var>a</var> = 1, <var>b</var> = 13 si ottiene ROT13, e con <var>a</var> = -1, <var>b</var> = -1 si ottiene lo stesso risultato del Cifrario Atbash.</p>

<p><var>a</var> deve essere un numero coprimo con <var>m</var>. Ciò significa che l'unico numero che divide sia <var>a</var> che <var>m</var> deve essere 1. Ad esempio, nel caso di <var>a</var> = 4 e <var>m</var> = 26, non può essere specificato perché è divisibile anche per 2 oltre che per 1. In DenCode, se viene specificato un <var>a</var> non valido, il carattere originale viene restituito senza conversione.</p>


<h4>Supporto per altre lingue</h4>
<p>Oltre ai caratteri latini, sono supportati i caratteri cirillici e i caratteri giapponesi Hiragana/Katakana.</p>

<p>I risultati della crittografia con <var>a</var> = 5 e <var>b</var> = 3 sono i seguenti:</p>

<h5>Cirillico</h5>
<pre>Prima: АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Dopo : ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ</pre>

<p><var>m</var> = 32 (32 caratteri).</p>

<h5>Giapponese Hiragana/Katakana</h5>
<pre>Prima: ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Dopo : いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん</pre>

<pre>Prima: ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Dopo : イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン</pre>

<p>L'ordine dei caratteri è quello definito in Unicode. Si noti che "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", e "ヺ" non sono soggetti a crittografia.</p>

<p><var>m</var> = 84 (84 caratteri).</p>
