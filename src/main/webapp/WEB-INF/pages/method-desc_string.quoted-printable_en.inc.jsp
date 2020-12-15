<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About Quoted-printable</h3>
<p>Quoted-printable is an encoding method that uses 7-bit printable ASCII characters. Used to transfer 8-bit data in a 7-bit data path in email.</p>
<p>Quoted-printable represents 8-bit data in 2-digit hexadecimal format, such as =XX. For example, "あ" in UTF-8 becomes "=E3=81=82". 7-bit printable characters such as "A" are not converted.</p>


<h4>Email MIME message header type (RFC 2047)</h4>
<p>DenCode also supports decoding of MIME message header format (RFC 2047), such as below. This format is used when the subject, recipient, etc. of the email contains non-ASCII characters.</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>The result after decoding is as follows.</p>

<pre>Subject: サンプル</pre>
