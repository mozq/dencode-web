<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О преобразовании клавиатуры JIS (преобразование Микака)</h3>
<p>Преобразование клавиатуры JIS (преобразование Микака) - это один из единых подстановочных шифров, который шифрует путем замены символов в тексте на другие символы. В основном, он используется для жаргона и обфускации в японском Интернете.</p>
<p>Замена символов осуществляется путем преобразования между английскими символами и японскими символами, напечатанными на японской клавиатуре JIS (JIS X4064 / OADG109A). Первоначально он происходит от интернет-сленга под названием «みかか» (Микака), который является результатом набора «<abbr title="Nippon Telegraph and Telephone corporation">NTT</abbr>», одного из японских телекоммуникационных операторов, на клавиатуре JIS.</p>

<p>
<a title="StuartBrady (the first version) and others., GFDL &lt;http://www.gnu.org/copyleft/fdl.html&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:KB_Japanese.svg"><img width="512" alt="KB Japanese" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/KB_Japanese.svg/512px-KB_Japanese.svg.png"></a>
</p>

<p>Например, «t» шифруется в «か», а «h» - в «く». DenCode конвертирует английские и японские символы одновременно, поэтому шифрование и расшифровка имеют одинаковый смысл.</p>

<pre>Ключ       　: this is a secret message
Криптограмма : かくにと にと ち といそすいか もいととちきい</pre>

<pre>Ключ       　: かくにと にと ち といそすいか もいととちきい
Криптограмма : this is a secret message</pre>

<p>Ниже приведено отображение символов, преобразованных с помощью преобразования клавиатуры JIS. В скобках указаны символы, допустимые в мягком режиме.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<thead>
			<tr><th>Английский</th><th>Японский</th></tr>
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

<p>Японская буква «を» не конвертируется, поскольку не имеет буквенного аналога на клавиатуре JIS.</p>

<p>Обратите внимание, что японский символ «ー» в исключительных случаях отображается как «|». Символ «\» (обратная косая черта или символ йены) отображается как «ろ».</p>

<p>В качестве опции предлагаются два режима конвертации: строгий и мягкий. Строгий режим в основном не конвертирует английские заглавные буквы и японскую катакану, но мягкий режим конвертирует и эти символы. Мягкий режим позволяет переконвертировать в Обратите внимание, что исходный символ может быть не восстановлен, например, «N -&gt; み -&gt; n» или «ミ -&gt; n -&gt; み».</p>
