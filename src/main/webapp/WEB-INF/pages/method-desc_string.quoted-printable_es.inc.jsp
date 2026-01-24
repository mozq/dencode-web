<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Quoted-printable</h3>
<p>Quoted-printable es un método de codificación que utiliza caracteres ASCII imprimibles de 7 bits. Se utiliza en el correo electrónico para transferir datos de 8 bits a través de rutas de datos de 7 bits.</p>
<p>En Quoted-printable, los datos de 8 bits se representan en formato hexadecimal de 2 dígitos como =XX. Por ejemplo, "あ" se convierte en "=E3=81=82" en UTF-8. Los caracteres imprimibles de 7 bits como "A" no se convierten.</p>


<h4>Formato de encabezado de mensaje MIME para correo electrónico (RFC 2047)</h4>
<p>DenCode también soporta la decodificación del formato de encabezado de mensaje MIME (RFC 2047) como se muestra a continuación. Este formato se utiliza cuando el asunto o el destinatario del correo electrónico contienen caracteres no ASCII.</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>El resultado después de la decodificación es el siguiente:</p>

<pre>Subject: サンプル</pre>
