<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du chiffre Affine</h3>
<p>Le chiffre Affine est l'un des chiffres de substitution monoalphabétique qui chiffre en remplaçant les caractères du texte par d'autres caractères.</p>
<p>Le remplacement des caractères est effectué à l'aide de la formule suivante.</p>

<pre>E(<var>x</var>) = (<var>a</var><var>x</var> + <var>b</var>) mod <var>m</var></pre>

<p><var>m</var> représente le type de caractère à convertir. <var>x</var> est un caractère remplacé par un nombre de 0 à <var>m</var> - 1. <var>a</var> et <var>b</var> sont les clés de chiffrement.</p>

<p>Par exemple, pour les 26 lettres de l'alphabet "ABCDEFGHIJKLMNOPQRSTUVWXYZ", <var>m</var> = 26 et <var>x</var> va de 0 à 25, A à Z étant remplacés par des nombres.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Caractère</th><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N</td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td></tr>
		<tr><th><var>x</var></th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
	</table>
</div>

<p>Si <var>a</var> = 5, <var>b</var> = 3, le chiffrement se déroulera selon le flux suivant.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Texte clair</th><td>S</td><td>E</td><td>C</td><td>R</td><td>E</td><td>T</td></tr>
		<tr><th><var>x</var></th><td>18</td><td>4</td><td>2</td><td>17</td><td>4</td><td>19</td></tr>
		<tr><th>(5<var>x</var> + 3)</th><td>93</td><td>23</td><td>13</td><td>88</td><td>23</td><td>98</td></tr>
		<tr><th>(5<var>x</var> + 3) mod 26</th><td>15</td><td>23</td><td>13</td><td>10</td><td>23</td><td>20</td></tr>
		<tr><th>Texte chiffré</th><td>P</td><td>X</td><td>N</td><td>K</td><td>X</td><td>U</td></tr>
	</table>
</div>

<p>Le résultat du chiffrement de toutes les lettres avec <var>a</var> = 5, <var>b</var> = 3 est le suivant.</p>

<pre>Texte clair  : ABCDEFGHIJKLMNOPQRSTUVWXYZ
Texte chiffré: DINSXCHMRWBGLQVAFKPUZEJOTY</pre>

<p>Spécifier <var>a</var> = 1, <var>b</var> = -3 donne le chiffre de César, spécifier <var>a</var> = 1, <var>b</var> = 13 donne le même résultat que ROT13, et spécifier <var>a</var> = -1, <var>b</var> = -1 donne le même résultat que le chiffre Atbash.</p>

<p><var>a</var> doit être un nombre premier avec <var>m</var>. Cela signifie que le seul nombre qui divise à la fois <var>a</var> et <var>m</var> doit être 1. Par exemple, <var>a</var> = 4, <var>m</var> = 26 ne peut pas être spécifié car il est divisible par 2 ainsi que par 1. Dans DenCode, si un <var>a</var> invalide est donné, il renvoie le caractère original sans conversion.</p>


<h4>Support d'autres langues</h4>
<p>En plus des lettres latines, le cyrillique et les Hiragana / Katakana japonais sont supportés.</p>

<p>Les résultats du chiffrement avec <var>a</var> = 5 et <var>b</var> = 3 sont les suivants.</p>

<h5>Cyrillique</h5>
<pre>Texte clair  : АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Texte chiffré: ГИНТЧЬБЖЛРХЪЯДЙОУШЭВЗМСЦЫАЕКПФЩЮ</pre>

<p><var>m</var> = 32 (32 caractères).</p>

<h5>Hiragana / Katakana japonais</h5>
<pre>Texte clair  : ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔ
Texte chiffré: いぉぎこじそぢでぬぱぶほむゅりわゔぅおくごすぞっとねひぷぼめゆるゐぁうかぐさずたつどのびへぽもょれゑあぇがけざせだづなはぴべまゃよろをぃえきげしぜちてにばふぺみやらゎん</pre>

<pre>Texte clair  : ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ
Texte chiffré: イォギコジソヂデヌパブホムュリワヴゥオクゴスゾットネヒプボメユルヰァウカグサズタツドノビヘポモョレヱアェガケザセダヅナハピベマャヨロヲィエキゲシゼチテニバフペミヤラヮン</pre>

<p>L'ordre des caractères est l'ordre de définition Unicode. Veuillez noter que «ゕ», «ゖ», «ヵ», «ヶ», «ヷ», «ヸ», «ヹ», et «ヺ» ne sont pas sujets au chiffrement.</p>

<p><var>m</var> = 84 (84 caractères).</p>
