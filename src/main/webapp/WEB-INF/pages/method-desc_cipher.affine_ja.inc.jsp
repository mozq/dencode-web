<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>アフィン暗号について</h3>
<p>アフィン暗号は、文章の文字を他の文字に置換することで暗号化する単一換字式暗号のひとつです。</p>
<p>文字の置換は、以下の計算式により行います。</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> は変換する文字の種類を表します。 <var>x</var> は文字を 0 から m - 1 までの数字に置き換えたものです。 <var>a</var> と <var>b</var> が暗号化のキーです。</p>

<p>例えば、「ABCDEFGHIJKLMNOPQRSTUVWXYZ」の26文字の英字の場合、 <var>m</var> = 26 、 <var>x</var> は A ~ Z を数字に置き換えた 0 ~ 25 となります。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>文字</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p><var>a</var> = 5, <var>b</var> = 3 とした場合は以下の流れで暗号化されます。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>暗号化前</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>暗号化後</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p><var>a</var> = 5, <var>b</var> = 3 で全ての英字を暗号化した結果は以下の通りです。</p>

<pre>
暗号化前 : ABCDEFGHIJKLMNOPQRSTUVWXYZ
暗号化後 : DINSXCHMRWBGLQVAFKPUZEJOTY
</pre>

<p><var>a</var> = 1, <var>b</var> = -3 を指定するとシーザー暗号、 <var>a</var> = 1, <var>b</var> = 13 を指定するとROT13、<var>a</var> = -1, <var>b</var> = -1 を指定するとアトバシュ暗号と同じ結果が得られます。</p>

<p><var>a</var> は、 <var>m</var> と互いに素の数値を指定する必要があります。これは、 <var>a</var> と <var>m</var> を割り切れる数値は 1 のみである必要があるということです。例えば、 <var>a</var> = 4, <var>m</var> = 26 の場合は、 1 以外に 2 でも割り切れるため、指定できません。DenCodeでは、無効な <var>a</var> が指定された場合は、元の文字を変換せずにそのまま返します。</p>


<h4>その他の言語サポート</h4>
<p>ラテン文字の他に、キリル文字、日本語の平仮名/片仮名をサポートしています。</p>

<p><var>a</var> = 5, <var>b</var> = 3 で暗号化した結果は、それぞれ以下の通りです。</p>

<h5>キリル文字</h5>
<pre>
暗号化前 : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
暗号化後 : ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ
</pre>

<p><var>m</var> = 32 (32文字) です。</p>

<h5>日本語の平仮名/片仮名</h5>
<pre>
暗号化前 : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
暗号化後 : いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん
</pre>

<pre>
暗号化前 : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
暗号化後 : イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン
</pre>

<p>文字の順序は、Unicodeにおける定義順です。「ゕ」「ゖ」「ヵ」「ヶ」や「ヷ」「ヸ」「ヹ」「ヺ」は暗号化の対象ではないことに注意してください。</p>

<p><var>m</var> = 84 (84文字) です。</p>
