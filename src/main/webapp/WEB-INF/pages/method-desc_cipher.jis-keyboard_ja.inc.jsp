<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>みかか変換について</h3>
<p>みかか変換は、文章の文字を他の文字に置換することで暗号化する単一換字式暗号のひとつです。基本的には日本のインターネット上において、隠語や難読化のために利用されています。</p>
<p>文字の置換は、日本語のJISキーボード(JIS X4064 / OADG109A)に印字された英字とカナ文字を相互に変換することで行います。もとは日本の通信事業者のひとつである「<abbr title="Nippon Telegraph and Telephone corporation">NTT</abbr>」をJISキーボードでカナ入力した結果の「みかか」と呼んでいたネットスラングに由来します。</p>

<p><a title="StuartBrady (the first version) and others., GFDL &lt;http://www.gnu.org/copyleft/fdl.html&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:KB_Japanese.svg"><img width="512" alt="KB Japanese" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/KB_Japanese.svg/512px-KB_Japanese.svg.png"></a></p>

<p>例えば、「t」は「か」、「h」は「く」に暗号化されます。DenCodeでは英字とカナ文字の変換を同時に行うため、暗号化と復号化は同じ意味となります。</p>

<pre>
暗号化前の文章 : this is a secret message
暗号化後の文章 : かくにと にと ち といそすいか もいととちきい
</pre>

<pre>
暗号化後の文章   : かくにと にと ち といそすいか もいととちきい
再暗号化後の文章 : this is a secret message
</pre>

<p>みかか変換で変換される文字のマッピングは以下の通りです。括弧内は寛容モードにおいて許容される文字です。</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>英字</th><th>カナ文字</th></tr>
		</thead>
		<tbody>
			<tr><td>1</td><td>ぬ (ヌ)</td></tr>
			<tr><td>2</td><td>ふ (フ)</td></tr>
			<tr><td>3</td><td>あ (ア)</td></tr>
			<tr><td>#</td><td>ぁ (ァ)</td></tr>
			<tr><td>4</td><td>う (ウ)</td></tr>
			<tr><td>$</td><td>ぅ (ゥ)</td></tr>
			<tr><td>5</td><td>え (エ)</td></tr>
			<tr><td>%</td><td>ぇ (ェ)</td></tr>
			<tr><td>6</td><td>お (オ)</td></tr>
			<tr><td>&amp;</td><td>ぉ (ォ)</td></tr>
			<tr><td>7</td><td>や (ヤ)</td></tr>
			<tr><td>'</td><td>ゃ (ャ)</td></tr>
			<tr><td>8</td><td>ゆ (ユ)</td></tr>
			<tr><td>(</td><td>ゅ (ュ)</td></tr>
			<tr><td>9</td><td>よ (ヨ)</td></tr>
			<tr><td>)</td><td>ょ (ョ)</td></tr>
			<tr><td>0</td><td>わ (ワ)</td></tr>
			<tr><td>-</td><td>ほ (ホ)</td></tr>
			<tr><td>^</td><td>へ (ヘ)</td></tr>
			<tr><td>|</td><td>ー</td></tr>
		</tbody>
		<tbody>
			<tr><td>q (Q)</td><td>た (タ)</td></tr>
			<tr><td>w (W)</td><td>て (テ)</td></tr>
			<tr><td>e</td><td>い (イ)</td></tr>
			<tr><td>E</td><td>ぃ (ィ)</td></tr>
			<tr><td>r (R)</td><td>す (ス)</td></tr>
			<tr><td>t (T)</td><td>か (カ)</td></tr>
			<tr><td>y (Y)</td><td>ん (ン)</td></tr>
			<tr><td>u (U)</td><td>な (ナ)</td></tr>
			<tr><td>i (I)</td><td>に (ニ)</td></tr>
			<tr><td>o (O)</td><td>ら (ラ)</td></tr>
			<tr><td>p (P)</td><td>せ (セ)</td></tr>
			<tr><td>@</td><td>゛</td></tr>
			<tr><td>[</td><td>゜</td></tr>
			<tr><td>{</td><td>「</td></tr>
		</tbody>
		<tbody>
			<tr><td>a (A)</td><td>ち (チ)</td></tr>
			<tr><td>s (S)</td><td>と (ト)</td></tr>
			<tr><td>d (D)</td><td>し (シ)</td></tr>
			<tr><td>f (F)</td><td>は (ハ)</td></tr>
			<tr><td>g (G)</td><td>き (キ)</td></tr>
			<tr><td>h (H)</td><td>く (ク)</td></tr>
			<tr><td>j (J)</td><td>ま (マ)</td></tr>
			<tr><td>k (K)</td><td>の (ノ)</td></tr>
			<tr><td>l (L)</td><td>り (リ)</td></tr>
			<tr><td>;</td><td>れ (レ)</td></tr>
			<tr><td>:</td><td>け (ケ)</td></tr>
			<tr><td>]</td><td>む (ム)</td></tr>
			<tr><td>}</td><td>」</td></tr>
		</tbody>
		<tbody>
			<tr><td>z</td><td>つ (ツ)</td></tr>
			<tr><td>Z</td><td>っ (ッ)</td></tr>
			<tr><td>x (X)</td><td>さ (サ)</td></tr>
			<tr><td>c (C)</td><td>そ (ソ)</td></tr>
			<tr><td>v (V)</td><td>ひ (ヒ)</td></tr>
			<tr><td>b (B)</td><td>こ (コ)</td></tr>
			<tr><td>n (N)</td><td>み (ミ)</td></tr>
			<tr><td>m (M)</td><td>も (モ)</td></tr>
			<tr><td>,</td><td>ね (ネ)</td></tr>
			<tr><td>&lt;</td><td>、</td></tr>
			<tr><td>.</td><td>る (ル)</td></tr>
			<tr><td>&gt;</td><td>。</td></tr>
			<tr><td>/</td><td>め (メ)</td></tr>
			<tr><td>?</td><td>・</td></tr>
			<tr><td>\</td><td>ろ (ロ)</td></tr>
		</tbody>
	</table>
</div>

<p>カナ文字の「を」はJISキーボード上で英字の対応がないため、変換されません。</p>

<p>カナ文字の「ー」には例外的に「|」がマッピングされていることに注意してください。「\」(バックスラッシュまたは円記号)は「ろ」にマッピングされています。</p>

<p>オプションとして、厳格モードと寛容モードの2種類の変換モードを提供しています。厳格モードでは、英字の大文字や日本語のカタカナは基本的には変換しませんが、寛容モードではそれらの文字も変換します。寛容モードでは、再変換で「N -&gt; み -&gt; n」や「ミ -&gt; n -&gt; み」のように、元の文字に戻らないことがある点に注意してください。</p>
