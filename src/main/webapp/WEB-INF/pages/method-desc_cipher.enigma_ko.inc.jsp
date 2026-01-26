<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>에니그마 암호에 대해서</h3>
<p>에니그마 암호는 문자를 다른 문자로 치환하여 암호화하는 환자 암호 중 하나입니다. 'A'부터 'Z'까지의 26문자 암호화에 대응하고 있습니다.</p>
<p>문자 치환은 에니그마 암호기를 사용하여 수행합니다. DenCode에서는 다음 에니그마 암호기의 시뮬레이션에 대응하고 있습니다.</p>

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

<p>에니그마 암호기는 다음과 같은 구성으로 되어 있습니다. 키보드(Tastatur)에서 입력된 문자는 플러그보드(Steckerbrett), 엔트리 휠(ETW, Eintrittswalze), 3개 또는 4개의 로터(Walze), 리플렉터(UKW, Umkehrwalze)를 통과하고, 그 후에는 역순의 경로를 따라 암호화된 결과가 램프보드(Lampenfeld)에 표시됩니다. 로터 등 모든 장소에서 문자의 환자가 이루어집니다.</p>

<pre>
 UKW   Walze  Walze  Walze   ETW  (Stecker)
         3      2      1
 ___    ___    ___    ___    ___    ___
|   |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &lt; Tastatur
| | |  |   |  |   |  |   |  |   |  |   |
| | |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &gt; Lampenfeld
|   |  |   |  |   |  |   |  |   |  |   |
 ---    ---    ---    ---    ---    ---
</pre>

<p>엔트리 휠이나 로터, 리플렉터는 내부에서 'A'부터 'Z'까지의 26문자를 다른 문자로 변환하기 위한 배선이 되어 있으며, 그 배선에 통전되는 것으로 환자가 이루어집니다. 예를 들어 Enigma I의 로터 'I'는 다음과 같은 배선으로 되어 있어 'A' 문자는 'E'로 환자됩니다. 또한 리플렉터에서 돌아온 문자가 'J'인 경우는 반대 배선을 따라 'Z'로 환자됩니다.</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Enigma I의 모든 배선은 다음과 같습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>휠</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
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

<p>플러그보드는 환자를 사용자에 의한 배선으로 수행할 수 있는 구조입니다. 일부 에니그마 암호기에서는 ETW 전단에 플러그보드가 있습니다. 플러그보드는 'A'부터 'Z'의 26문자 알파벳 입출력 단자를 가지고, 임의의 2개 알파벳을 케이블로 연결함으로써 그 2문자를 환자할 수 있습니다. 예를 들어 'A'와 'M'을 케이블로 연결한 경우는 'A'는 'M', 'M'은 'A'로 환자됩니다. 케이블로 배선하지 않은 입출력 단자의 문자는 환자되지 않습니다.</p>
<p>키보드에서 문자를 1문자 입력하면 로터가 1스텝 회전합니다. 로터의 회전은 오른쪽 로터부터 회전해 나가고, 로터에 있는 노치(Notch) 위치까지 회전하면 왼쪽 로터도 1스텝 회전합니다. 이 로터의 회전에 의해 1문자마다 암호화하기 위한 배선이 바뀌기 때문에, 같은 문자를 입력한 경우에도 이전과는 다른 문자로 환자됩니다.</p>
<p>로터에는 링이 있고, 링의 외주에는 'A'부터 'Z'(또는 '01'부터 '26')까지의 문자가 새겨져 있습니다. 링은 그 외주의 문자와 로터 내부 배선의 오프셋을 26단계로 설정 가능합니다. 예를 들어 'Enigma I'의 로터 'I'인 경우, 링 설정이 'A (01)'이면 'A'는 'E'로 환자되지만, 링 설정이 'B (02)'이면 내부 배선이 1시프트하기 때문에 원래의 Z-J 배선으로서 'A'는 'K'로 환자됩니다.</p>

<pre>
링: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

링: B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>로터는 배열 순서나 회전 초기 위치 설정이 가능합니다. 예를 들어 'I', 'II', 'III'의 3종류 로터가 있는 경우, 'II', 'I', 'III'와 같은 순서로 에니그마 암호기에 설정할 수 있고, 또한 각각의 로터 초기 위치를 'A (01)'부터 'Z (26)' 사이에서 설정할 수 있습니다. 리플렉터에 대해서도 배선이 다른 복수 종류의 리플렉터 중에서 교환 가능한 것이나, 초기 위치 설정이 가능한 에니그마 암호기도 있습니다. 엔트리 휠은 고정으로 변경할 수 없습니다. 플러그보드를 가진 에니그마 암호기의 경우는 플러그보드 설정도 가능합니다. 이러한 설정이 에니그마 암호기에 의한 암호화 키가 됩니다.</p>
<p>Enigma I로 암호화하는 경우의 예를 다음에 나타냅니다.</p>

<pre>
휠        : UKW-A II I III
링 설정    : X M V  (24 13 22)
포지션 설정 : A B L  (01 02 12)
플러그보드  : AM FI NV PS TU WZ

암호화 전 문장 : SECRET
암호화 후 문장 : LCGODU
</pre>

<p>이 경우 1문자째 'S'는 다음의 흐름으로 환자되어 가고, 최종적으로 'L'로 암호화됩니다.</p>

<pre>
S -&gt; P  : 플러그보드
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : 플러그보드
</pre>

<p>또한 로터의 회전 위치와 입력(+)/출력(-)의 위치를 링 위의 문자로 나타낸 경우는 다음과 같습니다. (로터는 회전하고 있기 때문에 상기의 '환자된 문자'와 '링 위의 위치로서의 문자'는 다릅니다.)</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : 플러그보드
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

<p>에니그마 암호기는 암호화된 문장에 대해 같은 설정으로 다시 암호화를 수행하면, 암호화 전의 평문을 얻을 수 있는 특징이 있습니다. 그 때문에 상기 예에서 암호화된 'L'을 입력하면 원래 'S'를 얻을 수 있습니다.</p>

<pre>
L -&gt; L  : 플러그보드
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : 플러그보드
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : 플러그보드
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


<h3>DenCode에서의 설정 항목</h3>

<h4>휠 (Walzenlage)</h4>
<p>리플렉터와 로터의 종류 및 로터의 순서를 설정합니다.</p>
<p>입력이 에니그마 암호기 오른쪽이기 때문에 로터는 오른쪽 로터부터 1, 2, 3으로 세지만, 휠 오더 설정을 표기할 때는 일반적으로 왼쪽부터 순서대로 씁니다. 예를 들어 'UKW-A II I III'의 휠 오더인 경우는 로터 1 'III', 로터 2 'I', 로터 3 'II', 리플렉터 'UKW-A' 설정을 나타냅니다.</p>
<p>보통은 리플렉터 1개와 로터 3개 합계 4개지만, Enigma M4는 리플렉터 슬롯에 '얇은 리플렉터'와 '얇은 로터'를 설정 가능합니다. DenCode에서는 '얇은 리플렉터'는 통상 리플렉터와 동일하게 취급하고, '얇은 로터'(Beta, Gamma)는 로터 4로서 추가로 표시하여 합계 5개 설정이 됩니다. 단, 리플렉터가 UKW-D인 경우는 리플렉터 슬롯을 점유하기 때문에 로터 4는 설정할 수 없습니다.</p>

<h4>링 설정 (Ringstellung)</h4>
<p>로터의 링을 설정합니다. 이 설정은 링에 대한 로터 내부 배선의 위치를 변경합니다. 일부 에니그마 암호기에서는 리플렉터도 링을 설정할 수 있습니다.</p>

<h4>포지션 설정 (Grundstellung)</h4>
<p>로터의 초기 위치를 설정합니다. 일부 에니그마 암호기에서는 리플렉터도 초기 위치를 설정할 수 있습니다.</p>
<p>메시지마다 설정을 바꾸고 있었기 때문에 "Message key"로 불리기도 합니다.</p>

<h4>플러그보드 배선 (Steckerverbindungen)</h4>
<p>플러그보드 배선 쌍을 설정합니다.</p>
<p>DenCode에서는 'AB CD EF GH IJ KL'과 같이 환자할 2문자 쌍을 공백으로 구분하여 나열함으로써 배선을 지정합니다. 이 예에서는 'A'와 'B', 'C'와 'D' 같은 배선 쌍을 나타냅니다.</p>

<h4>Uhr</h4>
<p>Uhr는 플러그보드에 연결하여 '00'부터 '39'까지 40가지 중에서 배선을 선택하는 액세서리입니다. 플러그보드와 Uhr는 20개 케이블로 연결합니다. 케이블이 2개씩 쌍으로 되어 있으며, 그것이 10쌍 있습니다. Uhr 설정이 '00'인 경우, 그 케이블 쌍이 플러그보드상에서 직접 배선된 경우와 같아집니다.</p>
<p>Uhr는 Enigma I만 설정할 수 있습니다. Uhr 설정은 먼저 플러그보드 배선 쌍을 10세트 지정함으로써 가능해집니다.</p>

<h4>UKW-D 배선</h4>
<p>UKW-D는 내부 배선을 변경 가능한 리플렉터입니다.</p>
<p>통상 리플렉터의 링 표기는 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'이지만, UKW-D 표기는 'A-ZXWVUTSRQPON-MLKIHGFEDCB'라는 특수한 순서로 되어 있습니다. 표기상의 2개 '-'(통상 표기에서 말하는 BO)는 고정이며 항상 서로 배선되어 있어 변경할 수 없습니다. 그 외 24문자 12쌍의 배선을 설정합니다.</p>

<pre>
UKW-D 표기 : A-ZXWVUTSRQPON-MLKIHGFEDCB
통상 표기   : ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-D는 Enigma I, Enigma M4, Enigma KD인 경우에 설정할 수 있습니다.</p>
