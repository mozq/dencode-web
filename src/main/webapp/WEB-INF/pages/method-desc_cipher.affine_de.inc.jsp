<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über die Affine-Chiffre</h3>
<p>Die Affine-Chiffre ist eine monoalphabetische Substitutionschiffre, bei der jeder Buchstabe eines Textes auf einen anderen abgebildet wird.</p>
<p>Die Substitution erfolgt nach folgender mathematischer Formel:</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> ist die Größe des Alphabets. <var>x</var> ist der Buchstabe, umgewandelt in eine Zahl von 0 bis m - 1. <var>a</var> und <var>b</var> sind die Schlüssel der Verschlüsselung.</p>

<p>Zum Beispiel, für die 26 Buchstaben des englischen Alphabets "ABCDEFGHIJKLMNOPQRSTUVWXYZ" ist <var>m</var> = 26 und <var>x</var> entspricht A ~ Z als 0 ~ 25.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Buchstabe</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>Wenn <var>a</var> = 5 und <var>b</var> = 3 ist, verläuft die Verschlüsselung wie folgt:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Klartext</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>Geheimtext</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>Das Ergebnis der Verschlüsselung aller Buchstaben mit <var>a</var> = 5, <var>b</var> = 3 ist wie folgt:</p>

<pre>Klartext:   ABCDEFGHIJKLMNOPQRSTUVWXYZ
Geheimtext: DINSXCHMRWBGLQVAFKPUZEJOTY</pre>

<p>Wenn <var>a</var> = 1 und <var>b</var> = -3 gewählt wird, entspricht dies der Caesar-Chiffre. <var>a</var> = 1 und <var>b</var> = 13 entspricht ROT13. <var>a</var> = -1 und <var>b</var> = -1 führt zum gleichen Ergebnis wie die Atbash-Chiffre.</p>

<p><var>a</var> muss teilerfremd (koprim) zu <var>m</var> sein. Das bedeutet, dass der größte gemeinsame Teiler von <var>a</var> und <var>m</var> 1 sein muss. Zum Beispiel ist <var>a</var> = 4 bei <var>m</var> = 26 nicht zulässig, da beide durch 2 teilbar sind. In DenCode wird das ursprüngliche Zeichen unverändert zurückgegeben, wenn ein ungültiges <var>a</var> angegeben wird.</p>

<h4>Unterstützung anderer Sprachen</h4>
<p>Neben lateinischen Buchstaben werden auch Kyrillisch und japanisches Hiragana/Katakana unterstützt.</p>

<p>Die Ergebnisse der Verschlüsselung mit <var>a</var> = 5, <var>b</var> = 3 sind wie folgt:</p>

<h5>Kyrillisch</h5>
<pre>Klartext:   АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Geheimtext: ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ</pre>

<p><var>m</var> = 32 (32 Zeichen).</p>

<h5>Japanisches Hiragana/Katakana</h5>
<pre>Klartext:   ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Geheimtext: いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん</pre>

<pre>Klartext:   ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Geheimtext: イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン</pre>

<p>Die Reihenfolge der Zeichen entspricht der Unicode-Definition. Bitte beachten Sie, dass „ゕ“, „ゖ“, „ヵ“, „ヶ“ sowie „ヷ“, „ヸ“, „ヹ“, „ヺ“ nicht verschlüsselt werden.</p>

<p><var>m</var> = 84 (84 Zeichen).</p>
