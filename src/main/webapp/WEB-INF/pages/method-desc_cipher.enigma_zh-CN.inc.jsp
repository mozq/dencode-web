<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于恩尼格玛密码 (Enigma Cipher)</h3>
<p>恩尼格玛密码是一种通过替换文本中的字符来进行加密的替换密码。支持“A”到“Z”这 26 个字符的加密。</p>
<p>字符的替换是通过恩尼格玛密码机进行的。DenCode 支持以下恩尼格玛密码机的模拟。</p>

<ul>
	<li>Enigma I</li>
	<li>Enigma M3</li>
	<li>Enigma M4 (U-boat Enigma)</li>
	<li>Norway Enigma "Norenigma"</li>
	<li>Sondermaschine (Special machine)</li>
	<li>Enigma G "Zählwerk Enigma" (A28/G31)</li>
	<li>Enigma G G-312 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-260 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-111 (G31 Hungarian Enigma)</li>
	<li>Enigma D (Commercial Enigma A26)</li>
	<li>Enigma K (Commercial Enigma A27)</li>
	<li>Enigma KD (Enigma K with UKW-D)</li>
	<li>Swiss-K (Swiss Enigma K variant)</li>
	<li>Railway Enigma "Rocket I"</li>
	<li>Enigma T "Tirpitz" (Japanese Enigma)</li>
	<li>Spanish Enigma, wiring D</li>
	<li>Spanish Enigma, wiring F</li>
	<li>Spanish Enigma, Delta (A 16081)</li>
	<li>Spanish Enigma, Sonderschaltung / Delta (A 16101)</li>
</ul>

<p>恩尼格玛密码机的构造如下。从键盘 (Tastatur) 输入的字符，经过插线板 (Steckerbrett)、输入轮 (ETW, Eintrittswalze)、3 或 4 个转子 (Walze)、反射器 (UKW, Umkehrwalze)，然后沿相反路径返回，加密结果显示在灯板 (Lampenfeld) 上。在转子等所有位置都会进行字符替换。</p>

<pre>
 UKW   Walze  Walze  Walze   ETW  (Stecker)
         3      2      1
 ___    ___    ___    ___    ___    ___
|   |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &lt; Tastatur (键盘)
| | |  |   |  |   |  |   |  |   |  |   |
| | |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &gt; Lampenfeld (灯板)
|   |  |   |  |   |  |   |  |   |  |   |
 ---    ---    ---    ---    ---    ---
</pre>

<p>输入轮、转子和反射器内部都有将“A”到“Z”这 26 个字符转换为其他字符的接线，通电后即可进行替换。例如，Enigma I 的转子“I”具有以下接线，“A”被替换为“E”。如果从反射器返回的字符是“J”，则沿相反接线被替换为“Z”。</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Enigma I 的所有接线如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>转子/反射器</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
		<tr><td>ETW</td><td>ABCDEFGHIJKLMNOPQRSTUVWXYZ</td></tr>
		<tr><td>I</td><td>EKMFLGDQVZNTOWYHXUSPAIBRCJ</td></tr>
		<tr><td>II</td><td>AJDKSIRUXBLHWTMCQGZNPYFVOE</td></tr>
		<tr><td>III</td><td>BDFHJLCPRTXVZNYEIWGAKMUSQO</td></tr>
		<tr><td>IV</td><td>ESOVPZJAYQUIRHXLNFTGKDCMWB</td></tr>
		<tr><td>V</td><td>VZBRGITYUPSDNHLXAWMJQOFECK</td></tr>
		<tr><td>UKW-A</td><td>EJMZALYXVBWFCRQUONTSPIKHGD</td></tr>
		<tr><td>UKW-B</td><td>YRUHQSLDPXNGOKMIEBFZCWVJAT</td></tr>
		<tr><td>UKW-C</td><td>FVPJIAOYEDRZXWGCTKUQSBNMHL</td></tr>
	</table>
</div>

<p>插线板允许用户通过接线进行替换。部分恩尼格玛密码机在 ETW 前端有插线板。插线板有“A”到“Z” 26 个字母的输入输出端子，通过电缆连接任意两个字母，可以交换这两个字母。例如，连接“A”和“M”，则“A”换成“M”，“M”换成“A”。未连接电缆的字母不进行替换。</p>
<p>从键盘输入一个字符，转子就会旋转一步。转子从右侧开始旋转，当旋转到转子上的槽口位置时，左侧的转子也会旋转一步。这种旋转改变了每个字符的加密接线，因此即使输入相同的字符，也会被替换为不同的字符。</p>
<p>转子上有环，环的外周刻有“A”到“Z”（或“01”到“26”）的字符。环可以分 26 级设置外周字符与转子内部接线的偏移量。例如，Enigma I 的转子“I”，若环设置由于“A (01)”，“A”换成“E”；若环设置由于“B (02)”，内部接线偏移 1 位，原来的 Z-J 连接使得“A”换成“K”。</p>

<pre>
环: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

环: B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>转子可以设置排列顺序和初始旋转位置。例如，有“I”、“II”、“III”三种转子，可以按“II”、“I”、“III”的顺序设置，每个转子的初始位置也可以在“A (01)”到“Z (26)”之间设置。反射器也有多种可更换类型，或是可设置初始位置的类型。输入轮通常是固定的。带有插线板的机器还可以设置插线板。这些设置构成了恩尼格玛密码机的加密密钥。</p>
<p>以下是使用 Enigma I 进行加密的示例。</p>

<pre>
转子     : UKW-A II I III
环设置   : X M V  (24 13 22)
初始位置 : A B L  (01 02 12)
插线板   : AM FI NV PS TU WZ

加密前的文章 : SECRET
加密后的文章 : LCGODU
</pre>

<p>这种情况下，第一个字符“S”经过以下流程最终加密为“L”。</p>

<pre>
S -&gt; P  : 插线板
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : 插线板
</pre>

<p>如果用环上的字符表示转子的旋转位置和输入 (+)/ 输出 (-) 位置，则如下所示。（由于转子在旋转，上述“被替换的字符”与“环上位置对应的字符”不同。）</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : 插线板
           -   +          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           -   +          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           +  -           
BCDEFGHIJKLMNOPQRSTUVWXYZA  : I
               +-         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          -           +   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>

<p>恩尼格玛密码机的一个特点是，对加密后的文本使用相同的设置再次加密，可以获得原本的明文。因此，输入上述示例中加密的“L”，可以得到原来的“S”。</p>

<pre>
L -&gt; L  : 插线板
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : 插线板
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : 插线板
           +   -          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           +   -          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           -  +           
BCDEFGHIJKLMNOPQRSTUVWXYZA  : I
               -+         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          +           -   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>


<h3>DenCode 中的设置项目</h3>

<h4>转子 (Walzenlage)</h4>
<p>设置反射器和转子的类型以及转子的顺序。</p>
<p>因为输入是从右侧开始的，所以转子从右向左数 1, 2, 3，但表示转子顺序时通常从左到右书写。例如“UKW-A II I III”表示转子 1 是“III”，转子 2 是“I”，转子 3 是“II”，反射器是“UKW-A”。</p>
<p>通常包括 1 个反射器和 3 个转子共 4 个部件，但 Enigma M4 可以在反射器插槽中设置“薄反射器”和“薄转子”。在 DenCode 中，“薄反射器”被视为普通反射器，“薄转子” (Beta, Gamma) 作为额外的转子 4 显示，总共 5 个部件。但是，如果反射器是 UKW-D，由于它占用反射器插槽，因此无法设置转子 4。</p>

<h4>环设置 (Ringstellung)</h4>
<p>设置转子的环。此设置会更改转子内部接线相对于环的位置。部分机器的反射器也可以设置环。</p>

<h4>初始位置 (Grundstellung)</h4>
<p>设置转子的初始位置。部分机器的反射器也可以设置初始位置。</p>
<p>由于每条消息都会改变此设置，有时也称为“消息密钥 (Message key)”。</p>

<h4>插线板连线 (Steckerverbindungen)</h4>
<p>设置插线板的连线对。</p>
<p>在 DenCode 中，通过用空格分隔并列出要交换的两个字符对来指定连线，如“AB CD EF GH IJ KL”。此例表示“A”和“B”、“C”和“D”等连线对。</p>

<h4>Uhr</h4>
<p>Uhr 是连接到插线板并在“00”到“39”的 40 种接线方式中进行选择的配件。插线板和 Uhr 通过 20 根电缆连接。电缆两两成对，共有 10 对。当 Uhr 设置为“00”时，相当于这些电缆对直接在插线板上连接。</p>
<p>只有 Enigma I 可以设置 Uhr。设置 Uhr 需要先指定 10 组插线板连线对。</p>

<h4>UKW-D 连线</h4>
<p>UKW-D 是一种可更改内部接线的反射器。</p>
<p>普通反射器的环标记为“ABCDEFGHIJKLMNOPQRSTUVWXYZ”，但 UKW-D 的标记是“A-ZXWVUTSRQPON-MLKIHGFEDCB”这种特殊顺序。标记上的两个“-”（对应普通标记的 B 和 O）是固定的，始终相互连接且无法更改。您可以设置其他 24 个字符的 12 对连线。</p>

<pre>
UKW-D 标记 : A-ZXWVUTSRQPON-MLKIHGFEDCB
普通标记   : ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-D 可在 Enigma I, Enigma M4, Enigma KD 中设置。</p>
