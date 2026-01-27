<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於仿射密碼 (Affine Cipher)</h3>
<p>仿射密碼是一種透過替換文本中的字元來進行加密的單表代換密碼。</p>
<p>字元的替換透過以下公式進行。</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> 表示要轉換的字元類型的數量。<var>x</var> 是將字元轉換為 0 到 m - 1 之間的數字。<var>a</var> 和 <var>b</var> 是加密金鑰。</p>

<p>例如，對於「ABCDEFGHIJKLMNOPQRSTUVWXYZ」這 26 個英文字母，<var>m</var> = 26，<var>x</var> 對應 A ~ Z 轉換為數字 0 ~ 25。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>文字</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>當 <var>a</var> = 5, <var>b</var> = 3 時，加密流程如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>加密前</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>加密後</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>使用 <var>a</var> = 5, <var>b</var> = 3 加密所有英文字母的結果如下。</p>

<pre>
加密前 : ABCDEFGHIJKLMNOPQRSTUVWXYZ
加密後 : DINSXCHMRWBGLQVAFKPUZEJOTY
</pre>

<p>指定 <var>a</var> = 1, <var>b</var> = -3 等同於凱撒密碼，指定 <var>a</var> = 1, <var>b</var> = 13 等同於 ROT13，指定 <var>a</var> = -1, <var>b</var> = -1 等同於阿特巴希密碼。</p>

<p><var>a</var> 必須指定為與 <var>m</var> 互質的數值。這意味著 <var>a</var> 和 <var>m</var> 除了 1 以外沒有其他公因數。例如，當 <var>m</var> = 26 時，<var>a</var> = 4 是無效的，因為它除了 1 以外還能被 2 整除。在 DenCode 中，如果指定了無效的 <var>a</var>，將不進行轉換直接傳回原始字元。</p>


<h4>其他語言支援</h4>
<p>除了拉丁字母，還支援西里爾字母和日語的平假名/片假名。</p>

<p>使用 <var>a</var> = 5, <var>b</var> = 3 加密的結果分別如下。</p>

<h5>西里爾字母</h5>
<pre>
加密前 : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
加密後 : ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ
</pre>

<p><var>m</var> = 32 (32個字元)。</p>

<h5>日語平假名/片假名</h5>
<pre>
加密前 : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
加密後 : いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん
</pre>

<pre>
加密前 : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
加密後 : イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン
</pre>

<p>字元順序遵循 Unicode 定義。「ゕ」「ゖ」「ヵ」「ヶ」以及「ヷ」「ヸ」「ヹ」「ヺ」不屬於加密對象，請注意。</p>

<p><var>m</var> = 84 (84個字元)。</p>
