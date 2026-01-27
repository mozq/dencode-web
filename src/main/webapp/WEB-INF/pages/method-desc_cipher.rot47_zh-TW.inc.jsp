<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 ROT47</h3>
<p>ROT47 是一種透過替換文本中的字元來進行加密的單表代換密碼。</p>
<p>字元的替換是透過將「!」到「~」的字元在「!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~」這 94 個字元中移動 47 個位置來進行的。</p>
<p>例如，「!」被加密為「P」，「A」被加密為「p」，「0」被加密為「_」。</p>

<pre>
加密前 : !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
加密後 : PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO
</pre>

<pre>
加密前的文章 : THIS IS A SECRET MESSAGE 123!
加密後的文章 : %wx$ x$ p $tr#t% |t$$pvt `abP
</pre>

<p>由於具有將密文再次加密即可獲得明文的反轉性，因此可以用與加密相同的流程進行解密。</p>
