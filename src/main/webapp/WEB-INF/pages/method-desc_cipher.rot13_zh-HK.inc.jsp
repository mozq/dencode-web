<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 ROT13</h3>
<p>ROT13 是一種透過替換文本中的字符來進行加密的單表代換密碼。</p>
<p>字符的替換是透過將「A」到「Z」的字符在「ABCDEFGHIJKLMNOPQRSTUVWXYZ」這 26 個字符中移動 13 個位置來進行的。</p>
<p>例如，「A」被加密為「N」，「Z」被加密為「M」。</p>

<pre>
加密前 : ABCDEFGHIJKLMNOPQRSTUVWXYZ
加密後 : NOPQRSTUVWXYZABCDEFGHIJKLM
</pre>

<pre>
加密前的文章 (明文) : THIS IS A SECRET MESSAGE
加密後的文章 (密文) : GUVF VF N FRPERG ZRFFNTR
</pre>

<p>由於具有將密文再次加密即可獲得明文的反轉性，因此可以用與加密相同的流程進行解密。</p>
