<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>JIS 키보드 변환 (미카카 변환)에 대해서</h3>
<p>JIS 키보드 변환(미카카 변환)은 문장의 문자를 다른 문자로 치환하여 암호화하는 단일 환자 암호 중 하나입니다. 기본적으로 일본 인터넷에서 은어(Jargon)나 난독화를 위해 사용됩니다.</p>
<p>문자 치환은 영문자와, 일본어 JIS 키보드(JIS X4064 / OADG109A)에 인쇄된 일본어 문자 사이를 변환하여 수행합니다. 원래는 일본 통신 사업자 중 하나인 'NTT'를 JIS 키보드로 쳤을 때의 결과인 '미카카(みかか)'라는 인터넷 속어(Slang)에서 유래했습니다.</p>

<p>
<a title="StuartBrady (the first version) and others., GFDL &lt;http://www.gnu.org/copyleft/fdl.html&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:KB_Japanese.svg"><img width="512" alt="KB Japanese" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/KB_Japanese.svg/512px-KB_Japanese.svg.png"></a>
</p>

<p>예를 들어 't'는 'か'로, 'h'는 'く'로 암호화됩니다. DenCode는 영문자와 일본어 문자를 동시에 변환하므로, 암호화와 복호화는 같은 의미를 가집니다.</p>

<pre>평문          : this is a secret message
암호문        : かくにと にと ち といそすいか もいととちきい</pre>

<pre>암호문        : かくにと にと ち といそすいか もいととちきい
재암호문      : this is a secret message</pre>

<p>JIS 키보드 변환으로 변환되는 문자 매핑은 다음과 같습니다. 괄호 안의 문자는 관용 모드(Lenient-mode)에서 허용되는 문자입니다.</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>영어</th><th>일본어</th></tr>
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

<p>일본어 'を'는 JIS 키보드 상에 대응하는 알파벳이 없기 때문에 변환되지 않습니다.</p>

<p>일본어 'ー'는 예외적으로 '|'에 매핑됩니다. '\'(백슬래시 또는 엔 기호)는 'ろ'에 매핑됩니다.</p>

<p>관용(Lenient)과 엄격(Strict) 2가지 변환 모드가 제공됩니다. 엄격 모드는 기본적으로 대문자 알파벳과 일본어 가타카나 문자를 변환하지 않지만, 관용 모드는 이러한 문자도 변환합니다. 관용 모드에서는 'N -&gt; み -&gt; n' 또는 'ミ -&gt; n -&gt; み'와 같이 재변환 시 원래 문자로 돌아오지 않을 수 있음에 주의해 주세요.</p>
