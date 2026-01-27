<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 ROT47</h3>
<p>ROT47 是一种通过替换文本中的字符来进行加密的单表代换密码。</p>
<p>字符的替换是通过将“!”到“~”的字符在“!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~”这 94 个字符中移动 47 个位置来进行的。</p>
<p>例如，“!”被加密为“P”，“A”被加密为“p”，“0”被加密为“_”。</p>

<pre>
加密前 : !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
加密后 : PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO
</pre>

<pre>
加密前的文章 : THIS IS A SECRET MESSAGE 123!
加密后的文章 : %wx$ x$ p $tr#t% |t$$pvt `abP
</pre>

<p>由于具有将密文再次加密即可获得明文的反转性，因此可以用与加密相同的流程进行解密。</p>
