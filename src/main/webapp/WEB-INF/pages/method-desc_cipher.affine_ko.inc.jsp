<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>아핀 암호에 대해서</h3>
<p>아핀 암호는 문장의 문자를 다른 문자로 치환하여 암호화하는 단일 환자 암호 중 하나입니다.</p>
<p>문자 치환은 다음의 계산식에 따라 수행합니다.</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var>은 변환할 문자의 종류를 나타냅니다. <var>x</var>는 문자를 0부터 m - 1까지의 숫자로 치환한 것입니다. <var>a</var>와 <var>b</var>가 암호화 키입니다.</p>

<p>예를 들어, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'의 26문자 영문자의 경우, <var>m</var> = 26, <var>x</var>는 A ~ Z를 숫자로 치환한 0 ~ 25가 됩니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>문자</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p><var>a</var> = 5, <var>b</var> = 3으로 한 경우는 다음과 같은 흐름으로 암호화됩니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>암호화 전</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>암호화 후</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p><var>a</var> = 5, <var>b</var> = 3으로 모든 영문자를 암호화한 결과는 다음과 같습니다.</p>

<pre>
암호화 전 : ABCDEFGHIJKLMNOPQRSTUVWXYZ
암호화 후 : DINSXCHMRWBGLQVAFKPUZEJOTY
</pre>

<p><var>a</var> = 1, <var>b</var> = -3을 지정하면 시저 암호, <var>a</var> = 1, <var>b</var> = 13을 지정하면 ROT13, <var>a</var> = -1, <var>b</var> = -1을 지정하면 아바쉬 암호와 같은 결과를 얻을 수 있습니다.</p>

<p><var>a</var>는 <var>m</var>과 서로소(Coprime)인 수치를 지정해야 합니다. 이는 <var>a</var>와 <var>m</var>을 나눌 수 있는 수치가 1뿐이어야 한다는 것을 의미합니다. 예를 들어 <var>a</var> = 4, <var>m</var> = 26인 경우는 1 이외에 2로도 나누어지기 때문에 지정할 수 없습니다. DenCode에서는 무효한 <var>a</var>가 지정된 경우 원래의 문자를 변환하지 않고 그대로 반환합니다.</p>


<h4>기타 언어 지원</h4>
<p>라틴 문자 외에 키릴 문자, 일본어 히라가나/가타카나를 지원하고 있습니다.</p>

<p><var>a</var> = 5, <var>b</var> = 3으로 암호화한 결과는 각각 다음과 같습니다.</p>

<h5>키릴 문자</h5>
<pre>
암호화 전 : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
암호화 후 : ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ
</pre>

<p><var>m</var> = 32 (32문자)입니다.</p>

<h5>일본어 히라가나/가타카나</h5>
<pre>
암호화 전 : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
암호화 후 : いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん
</pre>

<pre>
암호화 전 : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
암호화 후 : イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン
</pre>

<p>문자 순서는 Unicode 정의 순서입니다. 'ゕ', 'ゖ', 'ヵ', 'ヶ'나 'ヷ', 'ヸ', 'ヹ', 'ヺ'는 암호화 대상이 아닌 점에 주의해 주세요.</p>

<p><var>m</var> = 84 (84문자)입니다.</p>
