<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 ROT13</h3>
<p>ROT13 是一种通过替换文本中的字符来进行加密的单表代换密码。</p>
<p>字符的替换是通过将“A”到“Z”的字符在“ABCDEFGHIJKLMNOPQRSTUVWXYZ”这 26 个字符中移动 13 个位置来进行的。</p>
<p>例如，“A”被加密为“N”，“Z”被加密为“M”。</p>

<pre>
加密前 : ABCDEFGHIJKLMNOPQRSTUVWXYZ
加密后 : NOPQRSTUVWXYZABCDEFGHIJKLM
</pre>

<pre>
加密前的文章 (明文) : THIS IS A SECRET MESSAGE
加密后的文章 (密文) : GUVF VF N FRPERG ZRFFNTR
</pre>

<p>由于具有将密文再次加密即可获得明文的反转性，因此可以用与加密相同的流程进行解密。</p>
