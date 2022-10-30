<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About JIS keyboard conversion (Mikaka conversion)</h3>
<p>JIS keyboard conversion (Mikaka conversion) is one of the single substitution ciphers that encrypts by replacing characters in text with other characters. Basically, it is used for jargon and obfuscation on the Japanese Internet.</p>
<p>Character replacement is performed by converting between English characters and Japanese characters printed on the Japanese JIS keyboard (JIS X4064 / OADG109A).</p>

<p>
<a title="StuartBrady (the first version) and others., GFDL &lt;http://www.gnu.org/copyleft/fdl.html&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:KB_Japanese.svg"><img width="512" alt="KB Japanese" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/KB_Japanese.svg/512px-KB_Japanese.svg.png"></a>
</p>

<p>For example, "n" is encrypted to "み" and "t" to "か".</p>

<pre>Text before encryption: this is a secret message
Text after encryption : かくにと にと ち といそすいか もいととちきい</pre>

<p>Originally, it is derived from Internet slang called "みかか" (Mikaka), which is the result of typing "NTT", one of the Japanese telecommunications carriers, with a JIS keyboard.</p>

<p>The Japanese "を" is not converted because it has no alphabetic counterpart on the JIS keyboard.</p>

<p>"\" (backslash in English fonts, yen symbol in Japanese fonts) exists in two places on the JIS keyboard: "ー" and "ろ". Please note that these mappings are "ろ" &lt;-&gt; "\", "ー" &lt;-&gt; "|". On Mac JIS keyboard, the only English character for Japanese "ろ" key is "_", so it should be "ろ" &lt;-&gt; "_", "ー" &lt;-&gt; "\" is better, but it conforms to the specifications of existing conversion tools.</p>

<p>DenCode converts English and Japanese characters at the same time, so encryption and decryption have the same meaning. Therefore, converting "nttはみかか" becomes "みかかfntt", and vice versa, converting "みかかfntt" becomes "nttはみかか".</p>

<p>Two optional conversion modes are provided: strict and lenient. Strict-mode does not convert upper-case alphabetic characters except Z and E and Japanese katakana characters, but lenient-mode converts those characters as well. Use these depending on whether or not to allow not to return to the original character such as "N -> み -> n" or "ミ -> n -> み" when reconverting.</p>
