<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 Quoted-printable</h3>
<p>Quoted-printable 是使用 7 位元可列印 ASCII 字元的編碼方式。用於電子郵件中通過 7 位元資料路徑傳輸 8 位元資料。</p>
<p>在 Quoted-printable 中，8 位元資料用類似 =XX 的 2 位十六進位形式表示。例如「あ」在 UTF-8 中表示為「=E3=81=82」。7 位元可列印字元如「A」等不進行轉換。</p>


<h4>電子郵件的 MIME 訊息標頭格式 (RFC 2047)</h4>
<p>DenCode 也支援如下的 MIME 訊息標頭格式 (RFC 2047) 解碼。這種格式用於電子郵件的主旨或收視人等包含非 ASCII 字元的情況。</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>解碼後的結果如下。</p>

<pre>Subject: サンプル</pre>
