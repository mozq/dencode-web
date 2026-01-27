<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於恩尼格瑪密碼 (Enigma Cipher)</h3>
<p>恩尼格瑪密碼是一種透過替換文本中的字符來進行加密的替換密碼。支援「A」到「Z」這 26 個字符的加密。</p>
<p>字符的替換是透過恩尼格瑪密碼機進行的。DenCode 支援以下恩尼格瑪密碼機的模擬。</p>

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

<p>恩尼格瑪密碼機的構造如下。從鍵盤 (Tastatur) 輸入的字符，經過配電盤 (Steckerbrett)、輸入輪 (ETW, Eintrittswalze)、3 或 4 個轉子 (Walze)、反射器 (UKW, Umkehrwalze)，然後沿相反路徑返回，加密結果顯示在燈板 (Lampenfeld) 上。在轉子等所有位置都會進行字符替換。</p>

<pre>
 UKW   Walze  Walze  Walze   ETW  (Stecker)
         3      2      1
 ___    ___    ___    ___    ___    ___
|   |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &lt; Tastatur (鍵盤)
| | |  |   |  |   |  |   |  |   |  |   |
| | |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &gt; Lampenfeld (燈板)
|   |  |   |  |   |  |   |  |   |  |   |
 ---    ---    ---    ---    ---    ---
</pre>

<p>輸入輪、轉子和反射器內部都有將「A」到「Z」這 26 個字符轉換為其他字符的接線，通電後即可進行替換。例如，Enigma I 的轉子「I」具有以下接線，「A」被替換為「E」。如果從反射器返回的字符是「J」，則沿相反接線被替換為「Z」。</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Enigma I 的所有接線如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>轉子/反射器</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
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

<p>配電盤允許使用者透過接線進行替換。部分恩尼格瑪密碼機在 ETW 前端有配電盤。配電盤有「A」到「Z」 26 個字母的輸入輸出端子，透過電纜連接任意兩個字母，可以交換這兩個字母。例如，連接「A」和「M」，則「A」換成「M」，「M」換成「A」。未連接電纜的字母不進行替換。</p>
<p>從鍵盤輸入一個字符，轉子就會旋轉一步。轉子從右側開始旋轉，當旋轉到轉子上的凹槽位置時，左側的轉子也會旋轉一步。這種旋轉改變了每個字符的加密接線，因此即使輸入相同的字符，也會被替換為不同的字符。</p>
<p>轉子上有環，環的外周刻有「A」到「Z」（或「01」到「26」）的字符。環可以分 26 級設定外周字符與轉子內部接線的偏移量。例如，Enigma I 的轉子「I」，若環設定為「A (01)」，「A」換成「E」；若環設定為「B (02)」，內部接線偏移 1 位，原來的 Z-J 連接使得「A」換成「K」。</p>

<pre>
環: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

環: B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>轉子可以設定排列順序和初始旋轉位置。例如，有「I」、「II」、「III」三種轉子，可以按「II」、「I」、「III」的順序設定，每個轉子的初始位置也可以在「A (01)」到「Z (26)」之間設定。反射器也有多種可更換類型，或是可設定初始位置的類型。輸入輪通常是固定的。帶有配電盤的機器還可以設定配電盤。這些設定構成了恩尼格瑪密碼機的加密金鑰。</p>
<p>以下是使用 Enigma I 進行加密的範例。</p>

<pre>
轉子     : UKW-A II I III
環設定   : X M V  (24 13 22)
初始位置 : A B L  (01 02 12)
配電盤   : AM FI NV PS TU WZ

加密前的文章 : SECRET
加密後的文章 : LCGODU
</pre>

<p>這種情況下，第一個字符「S」經過以下流程最終加密為「L」。</p>

<pre>
S -&gt; P  : 配電盤
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : 配電盤
</pre>

<p>如果用環上的字符表示轉子的旋轉位置和輸入 (+)/ 輸出 (-) 位置，則如下所示。（由於轉子在旋轉，上述「被替換的字符」與「環上位置對應的字符」不同。）</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : 配電盤
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

<p>恩尼格瑪密碼機的一個特點是，對加密後的文本使用相同的設定再次加密，可以獲得原本的明文。因此，輸入上述範例中加密的「L」，可以得到原來的「S」。</p>

<pre>
L -&gt; L  : 配電盤
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : 配電盤
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : 配電盤
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


<h3>DenCode 中的設定項目</h3>

<h4>轉子 (Walzenlage)</h4>
<p>設定反射器和轉子的類型以及轉子的順序。</p>
<p>因為輸入是從右側開始的，所以轉子從右向左數 1, 2, 3，但表示轉子順序時通常從左到右書寫。例如「UKW-A II I III」表示轉子 1 是「III」，轉子 2 是「I」，轉子 3 是「II」，反射器是「UKW-A」。</p>
<p>通常包括 1 個反射器和 3 個轉子共 4 個部件，但 Enigma M4 可以在反射器插槽中設定「薄反射器」和「薄轉子」。在 DenCode 中，「薄反射器」被視為普通反射器，「薄轉子」 (Beta, Gamma) 作為額外的轉子 4 顯示，總共 5 個部件。但是，如果反射器是 UKW-D，由於它佔用反射器插槽，因此無法設定轉子 4。</p>

<h4>環設定 (Ringstellung)</h4>
<p>設定轉子的環。此設定會更改轉子內部接線相對於環的位置。部分機器的反射器也可以設定環。</p>

<h4>初始位置 (Grundstellung)</h4>
<p>設定轉子的初始位置。部分機器的反射器也可以設定初始位置。</p>
<p>由於每條訊息都會改變此設定，有時也稱為「訊息金鑰 (Message key)」。</p>

<h4>配電盤連線 (Steckerverbindungen)</h4>
<p>設定配電盤的連線對。</p>
<p>在 DenCode 中，透過用空格分隔並列出要交換的兩個字符對來指定連線，如「AB CD EF GH IJ KL」。此例表示「A」和「B」、「C」和「D」等連線對。</p>

<h4>Uhr</h4>
<p>Uhr 是連接到配電盤並在「00」到「39」的 40 種接線方式中進行選擇的配件。配電盤和 Uhr 透過 20 根電纜連接。電纜兩兩成對，共有 10 對。當 Uhr 設定為「00」時，相當於這些電纜對直接在配電盤上連接。</p>
<p>只有 Enigma I 可以設定 Uhr。設定 Uhr 需要先指定 10 組配電盤連線對。</p>

<h4>UKW-D 連線</h4>
<p>UKW-D 是一種可更改內部接線的反射器。</p>
<p>普通反射器的環標記為「ABCDEFGHIJKLMNOPQRSTUVWXYZ」，但 UKW-D 的標記是「A-ZXWVUTSRQPON-MLKIHGFEDCB」這種特殊順序。標記上的兩個「-」（對應普通標記的 B 和 O）是固定的，始終相互連接且無法更改。您可以設定其他 24 個字符的 12 對連線。</p>

<pre>
UKW-D 標記 : A-ZXWVUTSRQPON-MLKIHGFEDCB
普通標記   : ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-D 可在 Enigma I, Enigma M4, Enigma KD 中設定。</p>
