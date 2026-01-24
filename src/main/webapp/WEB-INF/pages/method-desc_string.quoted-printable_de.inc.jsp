<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über Quoted-printable</h3>
<p>Quoted-printable ist eine Kodierung, die 7-Bit druckbare ASCII-Zeichen verwendet. Sie wird häufig in E-Mails eingesetzt, um 8-Bit-Daten über 7-Bit-Datenwege zu übertragen.</p>
<p>Dabei werden 8-Bit-Daten im Format =XX als zweistellige Hexadezimalzahl dargestellt. Zum Beispiel wird „あ“ in UTF-8 zu „=E3=81=82“. Druckbare 7-Bit-Zeichen wie „A“ bleiben unverändert.</p>

<h4>MIME-Nachrichtenheader (RFC 2047)</h4>
<p>DenCode unterstützt auch die Dekodierung von MIME-Headern (RFC 2047). Dies wird verwendet, wenn E-Mail-Betreffzeilen oder Empfänger Nicht-ASCII-Zeichen enthalten.</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>Das dekodierte Ergebnis:</p>

<pre>Subject: サンプル</pre>
