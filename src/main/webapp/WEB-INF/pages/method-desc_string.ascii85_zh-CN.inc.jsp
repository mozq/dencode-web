<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 Ascii85</h3>
<p>Ascii85 是使用 7 位可打印 ASCII 字符的编码方式。也被称为 Base85。</p>
<p>在 Ascii85 中，数据被每 4 个字节分为一组，并转换为 5 个 ASCII 字符来表示。</p>
<p>Ascii85 存在多种变体。DenCode 支持以下 3 种 Ascii85。起初是 btoa，后来出现了 Adobe 和 Z85。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>概要</th></tr>
		<tr><th>Z85</th><td>用于 ZeroMQ。避免使用需要转义的字符，如 "\"(反斜杠) 或 "'"(撇号)。</td></tr>
		<tr><th>Adobe</th><td>用于 Adobe PostScript 和 PDF (Portable Document Format) 文件中的图像等编码。用 "&lt;~" 和 "~&gt;" 包围。</td></tr>
		<tr><th>btoa</th><td>UNIX 的 btoa 命令格式。过去曾用于二进制数据交换，但现在已不通用。用 "xbtoa Begin" 和 "xbtoa End" 行包围。</td></tr>
	</table>
</div>

<p>Ascii85 使用的 ASCII 字符如下。将 4 字节的值视为大端无符号整数，计算该值的 85 进制各数位（5 位），然后根据以下 ASCII 字符得出 Ascii85 转换结果。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>ASCII 字符</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(最初是从 " "(空格) 到 "t" 的字符，但因为有些邮件程序会删除末尾空格，后来被替换为从 "!" 到 "u" 的字符，去掉了空格。)</td></tr>
	</table>
</div>

<p>例如，将“Hello”用 Ascii85 转换如下。</p>

<p>1. 每 4 个字节分隔。不足 4 字节的在末尾用“00”填充。</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. 将每 4 个字节视为大端无符号整数，转换为 85 进制的各数位。</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. 将 85 进制的各数位转换为 ASCII 字符。对于 Adobe/Z85，如果末尾填充了“00”，则去除填充部分。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. 连接所有字符作为 Ascii85 转换结果。Adobe 用 "&lt;~" &amp; "~&gt;" 包裹，每 80 个字符换行。btoa 用 "xbtoa Begin" &amp; "xbtoa End" (包括数据长度和校验和等) 包裹，每 78 个字符换行。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>转换结果</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>此外，还定义了一些缩写形式。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>缩写形式</th></tr>
		<tr><th>Z85</th><td>无</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2及以后)<br /></td></tr>
	</table>
</div>
