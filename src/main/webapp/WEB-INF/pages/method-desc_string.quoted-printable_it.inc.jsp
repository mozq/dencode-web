<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni su Quoted-printable</h3>
<p>Quoted-printable è uno schema di codifica che utilizza caratteri ASCII stampabili a 7 bit. È utilizzato nelle e-mail per trasferire dati a 8 bit su percorsi a 7 bit.</p>
<p>In Quoted-printable, i dati a 8 bit sono rappresentati in un formato esadecimale a 2 cifre come =XX. Ad esempio, "あ" in UTF-8 diventa "=E3=81=82". I caratteri stampabili a 7 bit come "A" non vengono convertiti.</p>


<h4>Formato dell'intestazione del messaggio MIME (RFC 2047)</h4>
<p>DenCode supporta anche la decodifica del formato di intestazione dei messaggi MIME (RFC 2047). Questo formato è utilizzato quando l'oggetto o il destinatario dell'e-mail contiene caratteri non ASCII.</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>Il risultato dopo la decodifica è il seguente:</p>

<pre>Subject: サンプル</pre>
