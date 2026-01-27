<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于仿射密码 (Affine Cipher)</h3>
<p>仿射密码是一种通过替换文本中的字符来进行加密的单表代换密码。</p>
<p>字符的替换通过以下公式进行。</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> 表示要转换的字符类型的数量。<var>x</var> 是将字符转换为 0 到 m - 1 之间的数字。<var>a</var> 和 <var>b</var> 是加密密钥。</p>

<p>例如，对于“ABCDEFGHIJKLMNOPQRSTUVWXYZ”这 26 个英文字母，<var>m</var> = 26，<var>x</var> 对应 A ~ Z 转换为数字 0 ~ 25。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>文字</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>当 <var>a</var> = 5, <var>b</var> = 3 时，加密流程如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>加密前</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>加密后</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>使用 <var>a</var> = 5, <var>b</var> = 3 加密所有英文字母的结果如下。</p>

<pre>
加密前 : ABCDEFGHIJKLMNOPQRSTUVWXYZ
加密后 : DINSXCHMRWBGLQVAFKPUZEJOTY
</pre>

<p>指定 <var>a</var> = 1, <var>b</var> = -3 等同于凯撒密码，指定 <var>a</var> = 1, <var>b</var> = 13 等同于 ROT13，指定 <var>a</var> = -1, <var>b</var> = -1 等同于阿特巴希密码。</p>

<p><var>a</var> 必须指定为与 <var>m</var> 互质的数值。这意味着 <var>a</var> 和 <var>m</var> 除了 1 以外没有其他公约数。例如，当 <var>m</var> = 26 时，<var>a</var> = 4 是无效的，因为它除了 1 以外还能被 2 整除。在 DenCode 中，如果指定了无效的 <var>a</var>，将不进行转换直接返回原始字符。</p>


<h4>其他语言支持</h4>
<p>除了拉丁字母，还支持西里尔字母和日语的平假名/片假名。</p>

<p>使用 <var>a</var> = 5, <var>b</var> = 3 加密的结果分别如下。</p>

<h5>西里尔字母</h5>
<pre>
加密前 : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
加密后 : ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ
</pre>

<p><var>m</var> = 32 (32个字符)。</p>

<h5>日语平假名/片假名</h5>
<pre>
加密前 : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
加密后 : いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん
</pre>

<pre>
加密前 : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
加密后 : イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン
</pre>

<p>字符顺序遵循 Unicode 定义。“ゕ”“ゖ”“ヵ”“ヶ”以及“ヷ”“ヸ”“ヹ”“ヺ”不属于加密对象，请注意。</p>

<p><var>m</var> = 84 (84个字符)。</p>
