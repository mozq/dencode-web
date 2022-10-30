<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>みかか変換について</h3>
<p>みかか変換は、文章の文字を他の文字に置換することで暗号化する単一換字式暗号のひとつです。基本的には日本のインターネット上において、隠語や難読化のために利用されています。</p>
<p>文字の置換は、日本語のJISキーボード(JIS X4064 / OADG109A)に印字された英字と日本語の文字を相互に変換することで行います。</p>

<p>
<a title="StuartBrady (the first version) and others., GFDL &lt;http://www.gnu.org/copyleft/fdl.html&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:KB_Japanese.svg"><img width="512" alt="KB Japanese" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/KB_Japanese.svg/512px-KB_Japanese.svg.png"></a>
</p>

<p>例えば、「n」は「み」、「t」は「か」に暗号化されます。</p>

<pre>暗号化前の文章: this is a secret message
暗号化後の文章: かくにと にと ち といそすいか もいととちきい</pre>

<p>元は日本の通信事業者のひとつである「NTT」をJISキーボードでかな入力した結果の「みかか」と呼んでいたネットスラングに由来します。</p>

<p>日本語の「を」はJISキーボード上で英字の対応がないため、変換されません。</p>

<p>「\」(英字フォントではバックスラッシュ、日本語フォントでは円記号)は、JISキーボード上では「ー」と「ろ」の2か所に存在しています。これらのマッピングは「ろ」&lt;-&gt;「\」、「ー」&lt;-&gt;「|」としており、「ー」には例外的に「|」がマッピングされていることに注意してください。MacのJISキーボードでは「ろ」のキーの英字は「_」のみであるため、本来であれば「ろ」&lt;-&gt;「_」、「ー」&lt;-&gt;「\」とするのが良いのですが、既存の変換ツールの仕様に準じています。</p>

<p>DenCodeでは、英字と日本語の変換を同時に行うため、暗号化と復号化は同じ意味となります。そのため、「nttはみかか」を変換すると「みかかfntt」になり、逆に「みかかfntt」を変換すると「nttはみかか」になります。</p>

<p>オプションとして、厳格モードと寛容モードの2種類の変換モードを提供しています。厳格モードでは、ZとEを除く英字の大文字や日本語のカタカナは変換しませんが、寛容モードではそれらの文字も変換します。これらは、再変換する際に「N -> み -> n」や「ミ -> n -> み」のように元の文字に戻らないことを許容するかどうかで使い分けてください。</p>
