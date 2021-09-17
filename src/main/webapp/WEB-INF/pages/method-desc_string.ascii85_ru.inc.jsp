<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О Ascii85</h3>
<p>Ascii85 - это схема кодирования с использованием 7-битных печатных символов ASCII, также известная как Base85.</p>
<p>Ascii85 делит данные на четыре байта каждый, которые затем преобразуются в пять символов ASCII.</p>
<p>Существует множество различных вариантов Ascii85, и DenCode поддерживает следующие три типа Ascii85. Первоначально был btoa, затем Adobe и Z85.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><th>Резюме</th></tr>
		<tr><th>Z85</th><td>Используется в ZeroMQ. "\" (обратная косая черта) и "'" (апостроф) символы, требующие экранирования, не используются.</td></tr>
		<tr><th>Adobe</th><td>Он используется для кодирования изображений и других данных в файлах Adobe PostScript и PDF (Portable Document Format). Он заключен в "<~" и "~>".</td></tr>
		<tr><th>btoa</th><td>Форма команды UNIX btoa. В прошлом он использовался для обмена двоичными данными, но сейчас уже не распространен. Охватывается линиями "xbtoa Начало" и "xbtoa Конец".</td></tr>
	</table>
</div>

<p>Символы ASCII, используемые в Ascii85, следующие: рассматривайте 4-байтовое значение как big-endian беззнаковое целое число, вычислите каждую из 85 десятичных цифр (5 разрядов) этого значения, а затем найдите результат преобразования Ascii85 на основе следующих символов ASCII</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><th>ASCII символы</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;<>()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(Первоначально это были символы " " (пробел) - "t", но поскольку некоторые почтовые службы исключали пробелы, позже они были заменены символами "!" до "u", исключая пробелы.)</td></tr>
	</table>
</div>

<p>Например, если вы преобразуете "Hello" с помощью Ascii85, вы получите следующее.</p>

<p>1. Разделяйте каждые 4 байта; если меньше 4 байт, заканчивайте "00" для подстановки.</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. Каждые четыре байта рассматриваются как беззнаковое целое число big-endian, и значение преобразуется в каждую цифру 85 десятичной системы.</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. Преобразуйте каждую цифру 85 десятичной системы в символ ASCII. Если в конце стоит "00", то для Adobe/Z85 это исключено.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. Все символы объединяются в результат преобразования Ascii85; Adobe заключен в "<~" и "~>", с новой строкой через каждые 80 символов; btoa заключен в "xbtoa Begin" и "xbtoa End" (включая длину данных и контрольную сумму), с новой строкой через каждые 78 символов.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><th>Результаты конверсии</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td><~87cURDZ~></td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />
87cURDZBb;<br />
xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>Определены и некоторые другие сокращения.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><th>Cокращения</th></tr>
		<tr><th>Z85</th><td>Нет</td></tr>
		<tr><td>Adobe</th><td>00000000<sub>(16)</sub> -> z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -> z<br />20202020<sub>(16)</sub> -> y (btoa v4.2 или более поздняя версия)<br /></td></tr>
	</table>
</div>
