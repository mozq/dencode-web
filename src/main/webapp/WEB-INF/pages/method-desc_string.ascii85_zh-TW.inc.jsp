<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 Ascii85</h3>
<p>Ascii85 是使用 7 位元可列印 ASCII 字元的編碼方式。也被稱為 Base85。</p>
<p>在 Ascii85 中，資料被每 4 個位元組分為一組，並轉換為 5 個 ASCII 字元來表示。</p>
<p>Ascii85 存在多種變體。DenCode 支援以下 3 種 Ascii85。起初是 btoa，後來出現了 Adobe 和 Z85。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>概要</th></tr>
		<tr><th>Z85</th><td>用於 ZeroMQ。避免使用需要跳脫的字元，如 "\"(反斜線) 或 "'"(撇號)。</td></tr>
		<tr><th>Adobe</th><td>用於 Adobe PostScript 和 PDF (Portable Document Format) 檔案中的圖像等編碼。用 "&lt;~" 和 "~&gt;" 包圍。</td></tr>
		<tr><th>btoa</th><td>UNIX 的 btoa 指令格式。過去曾用於二進位資料交換，但現在已不通用。用 "xbtoa Begin" 和 "xbtoa End" 行包圍。</td></tr>
	</table>
</div>

<p>Ascii85 使用的 ASCII 字元如下。將 4 位元組的值視為大端無號整數，計算該值的 85 進位各數位（5 位），然後根據以下 ASCII 字元得出 Ascii85 轉換結果。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>ASCII 字元</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(最初是從 " "(空格) 到 "t" 的字元，但因為有些郵件程式會刪除末尾空格，後來被替換為從 "!" 到 "u" 的字元，去掉了空格。)</td></tr>
	</table>
</div>

<p>例如，將「Hello」用 Ascii85 轉換如下。</p>

<p>1. 每 4 個位元組分隔。不足 4 位元組的在末尾用「00」填充。</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. 將每 4 個位元組視為大端無號整數，轉換為 85 進位的各數位。</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. 將 85 進位的各數位轉換為 ASCII 字元。對於 Adobe/Z85，如果末尾填充了「00」，則去除填充部分。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. 連接所有字元作為 Ascii85 轉換結果。Adobe 用 "&lt;~" &amp; "~&gt;" 包裹，每 80 個字元換行。btoa 用 "xbtoa Begin" &amp; "xbtoa End" (包括資料長度和檢查和等) 包裹，每 78 個字元換行。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>轉換結果</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>此外，還定義了一些縮寫形式。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>縮寫形式</th></tr>
		<tr><th>Z85</th><td>無</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2及以後)<br /></td></tr>
	</table>
</div>
