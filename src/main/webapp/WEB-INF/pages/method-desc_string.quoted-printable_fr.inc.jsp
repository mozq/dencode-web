<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos de Quoted-printable</h3>
<p>Quoted-printable est un schéma de codage utilisant des caractères ASCII imprimables sur 7 bits. Il est utilisé dans les e-mails pour transférer des données 8 bits sur un chemin de données 7 bits.</p>
<p>Dans Quoted-printable, les données 8 bits sont représentées sous la forme de 2 chiffres hexadécimaux comme =XX. Par exemple, "あ" devient "=E3=81=82" en UTF-8. Les caractères imprimables sur 7 bits tels que "A" ne sont pas convertis.</p>


<h4>Format d'en-tête de message MIME pour les e-mails (RFC 2047)</h4>
<p>DenCode prend également en charge le décodage des formats d'en-tête de message MIME (RFC 2047) tels que ci-dessous. Ce format est utilisé lorsque l'objet ou le destinataire d'un e-mail contient des caractères non ASCII.</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>Le résultat après décodage est le suivant.</p>

<pre>Subject: サンプル</pre>
