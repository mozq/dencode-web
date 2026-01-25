<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Ascii85에 대해서</h3>
<p>Ascii85는 7비트 인쇄 가능한(Printable) ASCII 문자를 사용한 부호화(Encoding) 방식입니다. Base85라고도 불립니다.</p>
<p>Ascii85에서는 데이터를 4바이트씩 분할하고, 그것들을 5문자의 ASCII 문자로 변환하여 나타냅니다.</p>
<p>Ascii85에는 다양한 아류(Variant)가 존재합니다. DenCode에서는 이하 3종류의 Ascii85에 대응하고 있습니다. 오리지널은 btoa이며, 그 후에 Adobe나 Z85가 등장했습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>개요</th></tr>
		<tr><th>Z85</th><td>ZeroMQ에서 사용된다. 백슬래시(\)나 아포스트로피(')와 같이 이스케이프가 필요한 문자를 사용하지 않도록 한 것.</td></tr>
		<tr><th>Adobe</th><td>Adobe의 PostScript나 PDF(Portable Document Format) 파일 내에서의 이미지 등의 인코딩에 사용되고 있다. "&lt;~" 와 "~&gt;" 로 둘러싸인다.</td></tr>
		<tr><th>btoa</th><td>UNIX의 btoa 커맨드 형식. 과거에 바이너리 데이터의 교환에 사용되었지만, 현재는 일반적이지 않다. "xbtoa Begin" 과 "xbtoa End" 행으로 둘러싸인다.</td></tr>
	</table>
</div>

<p>Ascii85에서 사용되는 ASCII 문자는 다음과 같습니다. 4바이트 값을 빅 엔디안 부호 없는 정수로 취급하고, 그 값을 85진법의 각 자릿수(5자리)를 계산한 뒤, 다음 ASCII 문자를 바탕으로 Ascii85 변환 결과를 구합니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>ASCII 문자</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(오리지널은 " "(스페이스)부터 "t"까지의 문자였지만, 끝의 스페이스를 제외하는 메일러(Mailer)가 있었기 때문에, 후에 스페이스를 제외한 "!"부터 "u"의 문자로 대체되었다.)</td></tr>
	</table>
</div>

<p>예를 들어, 'Hello'를 Ascii85로 변환하면 다음과 같습니다.</p>

<p>1. 4바이트마다 구분한다. 4바이트에 미치지 못하는 경우는 끝을 '00'으로 패딩한다.</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. 4바이트마다 빅 엔디안 부호 없는 정수로 취급하여, 그 값을 85진법의 각 자릿수로 변환한다.</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. 85진법의 각 자릿수를 ASCII 문자로 변환한다. 끝을 '00'으로 패딩한 경우는 Adobe/Z85의 경우 패딩분을 제외한다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. 문자를 모두 연결하여 Ascii85 변환 결과로 한다. Adobe는 "&lt;~" &amp; "~&gt;" 로 묶고, 80문자마다 개행한다. btoa는 "xbtoa Begin" &amp; "xbtoa End" (데이터 길이나 체크섬 등도 포함)로 묶고, 78문자마다 개행한다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>변환 결과</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>그 외, 몇 가지 단축형(Abbreviation)이 정의되어 있습니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>단축형</th></tr>
		<tr><th>Z85</th><td>없음</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2 이후)<br /></td></tr>
	</table>
</div>
