<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre el Cifrado Afín</h3>
<p>El Cifrado Afín es un tipo de cifrado de sustitución monoalfabética que encripta reemplazando caracteres en un texto con otros caracteres.</p>
<p>La sustitución de caracteres se realiza utilizando la siguiente fórmula:</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> representa la cantidad de caracteres a convertir (el tamaño del alfabeto). <var>x</var> es el carácter convertido a un número de 0 a m - 1. <var>a</var> y <var>b</var> son las claves de cifrado.</p>

<p>Por ejemplo, en el caso de las 26 letras de "ABCDEFGHIJKLMNOPQRSTUVWXYZ", <var>m</var> = 26, y <var>x</var> es un número del 0 al 25 que corresponde a A ~ Z.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Carácter</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>Si <var>a</var> = 5, <var>b</var> = 3, el cifrado se realiza de la siguiente manera:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Antes</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>Después</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>El resultado de cifrar todas las letras con <var>a</var> = 5, <var>b</var> = 3 es el siguiente:</p>

<pre>
Antes   : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Después : DINSXCHMRWBGLQVAFKPUZEJOTY
</pre>

<p>Especificar <var>a</var> = 1, <var>b</var> = -3 da el mismo resultado que el Cifrado César, <var>a</var> = 1, <var>b</var> = 13 da ROT13, y <var>a</var> = -1, <var>b</var> = -1 da Cifrado Atbash.</p>

<p><var>a</var> debe ser un número coprimo con <var>m</var>. Esto significa que el único divisor común de <var>a</var> y <var>m</var> debe ser 1. Por ejemplo, si <var>a</var> = 4, <var>m</var> = 26, no se puede especificar porque es divisible por 2 además de 1. En DenCode, si se especifica un <var>a</var> inválido, el carácter original se devuelve tal cual sin conversión.</p>


<h4>Soporte para otros idiomas</h4>
<p>Además del alfabeto latino, se soportan el alfabeto cirílico y Hiragana/Katakana japonés.</p>

<p>Los resultados del cifrado con <var>a</var> = 5, <var>b</var> = 3 son los siguientes:</p>

<h5>Cirílico</h5>
<pre>
Antes   : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Después : ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ
</pre>

<p><var>m</var> = 32 (32 caracteres).</p>

<h5>Hiragana/Katakana Japonés</h5>
<pre>
Antes   : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Después : いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん
</pre>

<pre>
Antes   : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Después : イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン
</pre>

<p>El orden de los caracteres se basa en el orden de definición de Unicode. Tenga en cuenta que "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", y "ヺ" no están sujetos a cifrado.</p>

<p><var>m</var> = 84 (84 caracteres).</p>
