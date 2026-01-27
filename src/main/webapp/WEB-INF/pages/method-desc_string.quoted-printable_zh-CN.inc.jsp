<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 Quoted-printable</h3>
<p>Quoted-printable 是使用 7 位可打印 ASCII 字符的编码方式。用于电子邮件中通过 7 位数据路径传输 8 位数据。</p>
<p>在 Quoted-printable 中，8 位数据用类似 =XX 的 2 位十六进制形式表示。例如“あ”在 UTF-8 中表示为“=E3=81=82”。7 位可打印字符如“A”等不进行转换。</p>


<h4>电子邮件的 MIME 消息头格式 (RFC 2047)</h4>
<p>DenCode 也支持如下的 MIME 消息头格式 (RFC 2047) 解码。这种格式用于电子邮件的主题或收视人等包含非 ASCII 字符的情况。</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>解码后的结果如下。</p>

<pre>Subject: サンプル</pre>
