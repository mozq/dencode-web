<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Ascii85について</h3>
<p>Ascii85は、7ビットの印字可能なASCII文字を使用した符号化方式です。Base85とも呼ばれます。</p>
<p>Ascii85では、データを4バイトずつに分割し、それらを5文字のASCII文字に変換して表します。</p>
<p>Ascii85には様々な亜種が存在します。DenCodeでは、以下の３種類のAscii85に対応しています。オリジナルは btoa で、その後に Adobe や Z85 が登場しました。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><th>概要</th></tr>
		<tr><th>Z85</th><td>ZeroMQで使用される。"\"(バックスラッシュ)や"'"(アポストロフィー)のようなエスケープが必要な文字を使用しないようにしたもの。</td></tr>
		<tr><th>Adobe</th><td>AdobeのPostScriptやPDF(Portable Document Format)ファイル内での画像等のエンコードに使用されている。 "&lt;~" と "~&gt;" で囲まれる。</td></tr>
		<tr><th>btoa</th><td>UNIXのbtoaコマンドの形式。過去にバイナリーデータの交換に使用されていたが、現在は一般的ではない。 "xbtoa Begin" と "xbtoa End" の行で囲まれる。</td></tr>
	</table>
</div>

<p>Ascii85で使用されるASCII文字は以下のとおりです。4バイトの値をビッグエンディアンの符号なし整数として扱い、それを85進法の各桁(5桁)を計算したうえで、以下のASCII文字をもとにAscii85の変換結果を求めます。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><th>ASCII文字</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(オリジナルは " "(スペース)から "t" までの文字だったが、末尾のスペースを除外するメーラーがあったため、後にスペースを除いた "!" から "u" の文字に置き換えられた。)</td></tr>
	</table>
</div>

<p>例えば、「Hello」をAscii85で変換すると以下のようになります。</p>

<p>1. 4バイトごとに区切る。4バイトに満たない場合は末尾を「00」でパディングする。</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. 4バイトごとにビッグエンディアンの符号なし整数として扱い、その値を85進法の各桁に変換する。</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. 85進法の各桁をASCII文字に変換する。末尾を「00」でパディングした場合は、Adobe/Z85の場合はパディング分を除外する。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. 文字を全て繋げてAscii85の変換結果とする。Adobeは、 "&lt;~" &amp; "~&gt;" で括り、80文字ごとに改行する。btoaは "xbtoa Begin" &amp; "xbtoa End" (データ長やチェックサムなども含む)で括り、78文字ごとに改行する。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><th>変換結果</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />
87cURDZBb;<br />
xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>その他、いくつかの短縮形が定義されています。</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th></th><th>短縮形</th></tr>
		<tr><th>Z85</th><td>なし</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2以降)<br /></td></tr>
	</table>
</div>
