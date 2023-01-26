<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Affine Cipher</h3>
<p>Affine cipher is one of the single transliteration ciphers that encrypts by replacing the characters in the text with other characters.</p>
<p>Character replacement is performed using the following formula.</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> represents the type of character to convert. <var>x</var> is a letter replaced by a number from 0 to <var>m</var> - 1. <var>a</var> and <var>bb</var> are the encryption keys.</p>

<p>For example, for the 26 alphabetic characters "ABCDEFGHIJKLMNOPQRSTUVWXYZ", <var>m</var> = 26 and <var>x</var> is 0 to 25 with A to Z replaced by numbers.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>Character</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>If <var>a</var> = 5, <var>b</var> = 3, it will be encrypted in the following flow.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>Plain text</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>Cipher text</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>The result of encrypting all letters with <var>a</var> = 5, <var>b</var> = 3 is as follows.</p>

<pre>Plain : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Cipher: DINSXCHMRWBGLQVAFKPUZEJOTY</pre>

<p>Specifying <var>a</var> = 1, <var>b</var> = -3 gives the Caesar cipher, specifying <var>a</var> = 1, <var>b</var> = 13 gives the same result as ROT13, and specifying <var>a</var> = -1, <var>b</var> = -1 gives the same result as the Atbash cipher.</p>

<p><var>a</var> must specify a number of co-prime with <var>m</var> . This means that the only number that divides <var>a</var> and <var>m</var> must be 1. For example, <var>a</var> = 4, <var>m</var> = 26 cannot be specified because it is divisible by 2 as well as 1. In DenCode, if given an invalid <var>a</var> , it returns the original character without conversion.</p>


<h4>Other language support</h4>
<p>In addition to Latin letters, Cyrillic and Japanese Hiragana / Katakana are supported.</p>

<p>The results of encryption with <var>a</var> = 5 and <var>b</var> = 3 are as follows.</p>

<h5>Cyrillic</h5>
<pre>Plain : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Cipher: ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ</pre>

<p><var>m</var> = 32 (32 characters). </p>

<h5>Japanese Hiragana / Katakana</h5>
<pre>Plain : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Cipher: いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん</pre>

<pre>Plain : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Cipher: イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン</pre>

<p>The character order is the Unicode definition order. Please note that "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", and "ヺ" are not subject to encryption.</p>

<p><var>m</var> = 84 (84 characters). </p>
