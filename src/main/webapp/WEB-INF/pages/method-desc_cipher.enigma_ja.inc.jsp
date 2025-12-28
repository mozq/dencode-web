<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>エニグマ暗号について</h3>
<p>エニグマ暗号は、文字を他の文字に置換することで暗号化する換字式暗号のひとつです。「A」から「Z」までの26文字の暗号化に対応しています。</p>
<p>文字の置換は、エニグマ暗号機を用いて行います。DenCodeでは、以下のエニグマ暗号機のシミュレーションに対応しています。</p>

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

<p>エニグマ暗号機は以下のような構成になっています。キーボード (Tastatur) から入力された文字は、プラグボード (Steckerbrett)、エントリーウィール (ETW, Eintrittswalze)、3つまたは4つのローター (Walze)、リフレクター (UKW, Umkehrwalze) を通り、その後は逆の経路を辿って暗号化された結果がランプボード (Lampenfeld) に表示されます。ローターなど全ての場所で文字の換字が行われます。</p>

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

<p>エントリーウィールやローター、リフレクターは、内部で「A」から「Z」までの26文字を他の文字に変換するための配線がされており、その配線に通電されることで換字が行われます。例えば、 Enigma I のローター「I」は、以下のような配線になっており、「A」の文字は「E」に換字されます。また、リフレクターから戻ってきた文字が「J」の場合は逆の配線を辿り「Z」に換字されます。</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Enigma I の全ての配線は以下の通りです。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>ウィール</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
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

<p>プラグボードは、換字をユーザーによる配線で行える仕組みです。一部のエニグマ暗号機ではETWの前段にプラグボードがあります。プラグボードは「A」から「Z」の26文字のアルファベットの入出力端子を持ち、任意の2つのアルファベットをケーブルで接続することで、その2文字を換字できます。例えば、「A」と「M」をケーブルで接続した場合は、「A」は「M」、「M」は「A」に換字されます。ケーブルで配線しなかった入出力端子の文字は換字されません。</p>
<p>キーボードから文字を1文字入力するとローターが1ステップ回転します。ローターの回転は、右側のローターから回転していき、ローターにあるノッチの位置まで回転すると、左のローターも1ステップ回転します。このローターの回転により、1文字ごとに暗号化するための配線が変わるため、同じ文字を入力した場合も前回とは別の文字に換字されます。</p>
<p>ローターにはリングがあり、リングの外周には「A」から「Z」 (または「01」から「26」) までの文字が刻まれています。リングはその外周の文字とローター内部の配線のオフセットを26段階で設定可能です。例えば「Enigma I」のローター「I」の場合、リング設定が「A (01)」では「A」は「E」に換字されますが、リング設定が「B (02)」では内部配線が1シフトするため元の Z-J の配線として「A」は「K」に換字されます。</p>

<pre>
リング: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

リング: B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>ローターは並び順や回転の初期位置の設定が可能です。例えば、「I」「II」「III」の3種類のローターがある場合、「II」「I」「III」といった並びでエニグマ暗号機に設定でき、またそれぞれのローターの初期位置を「A (01)」から「Z (26)」の間で設定できます。リフレクターについても、配線が異なる複数の種類のリフレクターの中から交換可能なものや、初期位置の設定が可能なエニグマ暗号機もあります。エントリーウィールは固定で、変更できません。プラグボードを持つエニグマ暗号機の場合は、プラグボードの設定も可能です。これらの設定がエニグマ暗号機による暗号化のキーになります。</p>
<p>Enigma I で暗号化する場合の例を以下に示します。</p>

<pre>
ウィール      : UKW-A II I III
リング設定    : X M V  (24 13 22)
ポジション設定: A B L  (01 02 12)
プラグボード  : AM FI NV PS TU WZ

暗号化前の文章: SECRET
暗号化後の文章: LCGODU
</pre>

<p>この場合の1文字目の「S」は以下の流れで換字されていき、最終的に「L」に暗号化されます。</p>

<pre>
S -&gt; P  : プラグボード
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : プラグボード
</pre>

<p>また、ローターの回転位置と 入力 (+) / 出力 (-) の位置をリング上の文字で表した場合は以下の通りです。（ローターは回転しているため、上記の「換字された文字」と「リング上の位置としての文字」は異なります。）</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : プラグボード
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

<p>エニグマ暗号機は、暗号化された文章に対して同じ設定で再度暗号化を行うと、暗号化前の平文が得られるという特徴があります。そのため、上記の例で暗号化された「L」を入力すると、元の「S」が得られます。</p>

<pre>
L -&gt; L  : プラグボード
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : プラグボード
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : プラグボード
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


<h3>DenCodeでの設定項目</h3>

<h4>ウィール (Walzenlage)</h4>
<p>リフレクターとローターの種類、およびローターの順序を設定します。</p>
<p>入力がエニグマ暗号機の右側からのためローターは右のローターから1, 2, 3と数えますが、ウィールオーダーの設定を表記する場合は一般的に左から順に書きます。例えば「UKW-A II I III」のウィールオーダーの場合は、ローター1「III」、ローター2「I」、ローター3「II」、リフレクター「UKW-A」の設定を表しています。</p>
<p>通常はリフレクター1つとローター3つの合計4つですが、Enigma M4はリフレクターのスロットに「薄いリフレクター」と「薄いローター」を設定可能です。DenCodeでは、「薄いリフレクター」は通常のリフレクターと同様に扱い、「薄いローター」 (Beta, Gamma) はローター4として追加で表示し、合計5つの設定となります。ただし、リフレクターがUKW-Dの場合はリフレクターのスロットを占有するため、ローター4は設定できません。</p>

<h4>リング設定 (Ringstellung)</h4>
<p>ローターのリングを設定します。この設定はリングに対するローターの内部配線の位置を変更します。一部のエニグマ暗号機では、リフレクターもリングを設定可能です。</p>

<h4>ポジション設定 (Grundstellung)</h4>
<p>ローターの初期位置を設定します。一部のエニグマ暗号機では、リフレクターも初期位置を設定可能です。</p>
<p>メッセージごとに設定を変えていたため、"Message key"と呼ばれることもあります。</p>

<h4>プラグボード配線 (Steckerverbindungen)</h4>
<p>プラグボードの配線のペアを設定します。</p>
<p>DenCodeでは、「AB CD EF GH IJ KL」のように換字する2文字のペアをスペースで区切って列挙することで配線を指定します。この例では「A」と「B」、「C」と「D」、といった配線のペアを表します。</p>

<h4>Uhr</h4>
<p>Uhrは、プラグボードに接続して「00」から「39」までの40通りから配線を選択するアクセサリーです。プラグボードとUhrは20本のケーブルで接続します。ケーブルが2本ずつでペアになっており、それが10ペアあります。Uhrの設定が「00」の場合、そのケーブルのペアがプラグボード上で直接配線された場合と等しくなります。</p>
<p>Uhrは Enigma I のみが設定できます。Uhrの設定は、まずプラグボードの配線のペアを10セット指定することで可能となります。</p>

<h4>UKW-D配線</h4>
<p>UKW-Dは、内部の配線を変更可能なリフレクターです。</p>
<p>通常のリフレクターのリングの表記は「ABCDEFGHIJKLMNOPQRSTUVWXYZ」ですが、UKW-Dの表記は「A-ZXWVUTSRQPON-MLKIHGFEDCB」という特殊な並び順となっています。表記上の2つの「-」（通常の表記でいうBO）は固定であり、常にお互いが配線されていて変更できません。その他の24文字12ペアの配線を設定します。</p>

<pre>
UKW-D表記: A-ZXWVUTSRQPON-MLKIHGFEDCB
通常の表記: ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-Dは、 Enigma I, Enigma M4, Enigma KD の場合に設定できます。</p>
