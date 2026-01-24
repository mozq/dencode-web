<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Ascii85</h3>
<p>Ascii85 is an encoding scheme that uses 7-bit printable ASCII characters, also known as Base85. </p>
<p>Ascii85 divides the data into 4 bytes each and converts them into 5 ASCII characters to represent them.</p>
<p>There are many variants of Ascii85, and DenCode supports the following three types of Ascii85. The original being btoa, followed by Adobe and Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Summary</th></tr>
		<tr><th>Z85</th><td>Used by ZeroMQ." \" (backslash) and "'" (apostrophe) characters that require escaping are not used.</td></tr>
		<tr><th>Adobe</th><td>It is used to encode images and other data in Adobe's PostScript and PDF (Portable Document Format) files. It is enclosed in "&lt;~" and "~&gt;".</td></tr>
		<tr><th>btoa</th><td>A form of the UNIX btoa command. It was used in the past for exchanging binary data, but is no longer common. Enclosed in "xbtoa Begin" and "xbtoa End" lines.</td></tr>
	</table>
</div>

<p>The ASCII characters used in Ascii85 are as follows: treat the 4-byte value as a big-endian unsigned integer, calculate each digit (5 digits) of the 85 decimal system from it, and then find the Ascii85 conversion result based on the following ASCII characters</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>ASCII characters</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(The original was from " " (space) to "t", but because some mailers excluded trailing spaces, it was later replaced by the "!" to "u" characters without spaces.)</td></tr>
	</table>
</div>

<p>For example, if we convert "Hello" with Ascii85, it will look like this.</p>

<p>1. Separate every 4 bytes; if less than 4 bytes, end with "00" for padding.</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. Every 4 bytes are treated as a big-endian unsigned integer, and the value is converted to each digit of the 85 decimal system.</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. Convert each digit of the 85 decimal system to an ASCII character. If the end is padded with "00", the padding is excluded in the case of Adobe/Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. The characters are all joined together to form the Ascii85 conversion result. adobe is enclosed in "&lt;~" &amp; "~&gt;", with a new line every 80 characters. btoa is enclosed in "xbtoa Begin" &amp; "xbtoa End" (including data length, checksum, etc.), with a new line every 78 characters.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Conversion result</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>Several other contractions have been defined.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Contractions</th></tr>
		<tr><th>Z85</th><td>None</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2 or later)<br /></td></tr>
	</table>
</div>
