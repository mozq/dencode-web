<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Quoted-printableについて</h3>
<p>Quoted-printableは、7ビットの印字可能なASCII文字を使用した符号化方式です。電子メールにおいて、8ビットデータを7ビットデータパスで転送するために使用します。</p>
<p>Quoted-printableでは、8ビットのデータを =XX のような16進数2桁の形式で表します。例えば「あ」はUTF-8で「=E3=81=82」となります。7ビットの印字可能な「A」などの文字は変換されません。</p>


<h4>EメールのMIMEメッセージヘッダー型式 (RFC 2047)</h4>
<p>DenCodeでは、以下のようなMIMEメッセージヘッダー型式（RFC 2047）のデコードもサポートします。この型式は、Eメールの件名や宛先などにASCII文字以外が含まれる場合に使用されます。</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>デコードの後の結果は以下のとおりです。</p>

<pre>Subject: サンプル</pre>
