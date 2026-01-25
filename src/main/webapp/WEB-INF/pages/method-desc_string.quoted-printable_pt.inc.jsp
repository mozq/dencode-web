<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Quoted-printable</h3>
<p>Quoted-printable é um método de codificação que utiliza caracteres ASCII imprimíveis de 7 bits. É usado em e-mail para transferir dados de 8 bits através de um caminho de dados de 7 bits.</p>
<p>No Quoted-printable, os dados de 8 bits são representados no formato de 2 dígitos hexadecimais como =XX. Por exemplo, "あ" torna-se "=E3=81=82" em UTF-8. Caracteres imprimíveis de 7 bits como "A" não são convertidos.</p>


<h4>Formato de cabeçalho de mensagem MIME de e-mail (RFC 2047)</h4>
<p>O DenCode também suporta a decodificação do seguinte formato de cabeçalho de mensagem MIME (RFC 2047). Este formato é usado quando o assunto ou destinatário do e-mail contém caracteres não ASCII.</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>O resultado após a decodificação é o seguinte:</p>

<pre>Subject: サンプル</pre>
