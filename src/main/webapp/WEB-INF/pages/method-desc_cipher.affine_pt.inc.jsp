<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre a Cifra Afim</h3>
<p>A Cifra Afim é um tipo de cifra de substituição monoalfabética que criptografa substituindo caracteres no texto por outros caracteres.</p>
<p>A substituição de caracteres é realizada usando a seguinte fórmula:</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> representa o número de tipos de caracteres a serem convertidos. <var>x</var> é o caractere substituído por um número de 0 a m - 1. <var>a</var> e <var>b</var> são as chaves de criptografia.</p>

<p>Por exemplo, no caso de 26 letras "ABCDEFGHIJKLMNOPQRSTUVWXYZ", <var>m</var> = 26, e <var>x</var> torna-se 0 a 25 substituindo A a Z por números.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Caractere</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>Se <var>a</var> = 5 e <var>b</var> = 3, a criptografia prossegue da seguinte forma:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Antes da Criptografia</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>Depois da Criptografia</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>O resultado da criptografia de todas as letras do inglês com <var>a</var> = 5 e <var>b</var> = 3 é o seguinte:</p>

<pre>
Antes da Criptografia  : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Depois da Criptografia : DINSXCHMRWBGLQVAFKPUZEJOTY
</pre>

<p>Especificar <var>a</var> = 1, <var>b</var> = -3 resulta na Cifra de César, especificar <var>a</var> = 1, <var>b</var> = 13 resulta em ROT13, e especificar <var>a</var> = -1, <var>b</var> = -1 resulta no mesmo que a Cifra Atbash.</p>

<p><var>a</var> deve ser um número coprimo de <var>m</var>. Isso significa que o único número que pode dividir <var>a</var> e <var>m</var> é 1. Por exemplo, se <var>a</var> = 4 e <var>m</var> = 26, ele não pode ser especificado porque é divisível por 2 além de 1. No DenCode, se um <var>a</var> inválido for especificado, o caractere original é retornado como está sem conversão.</p>


<h4>Suporte a outros idiomas</h4>
<p>Além dos caracteres latinos, caracteres cirílicos e Hiragana/Katakana japoneses são suportados.</p>

<p>Os resultados da criptografia com <var>a</var> = 5 e <var>b</var> = 3 são os seguintes:</p>

<h5>Cirílico</h5>
<pre>
Antes da Criptografia  : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Depois da Criptografia : ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ
</pre>

<p><var>m</var> = 32 (32 caracteres).</p>

<h5>Hiragana / Katakana Japonês</h5>
<pre>
Antes da Criptografia  : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Depois da Criptografia : いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん
</pre>

<pre>
Antes da Criptografia  : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Depois da Criptografia : イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン
</pre>

<p>A ordem dos caracteres é baseada na definição Unicode. Note que "ゕ", "ゖ", "ヵ", "ヶ", "ヷ", "ヸ", "ヹ", e "ヺ" não estão sujeitos a criptografia.</p>

<p><var>m</var> = 84 (84 caracteres).</p>
