<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Tentang Quoted-printable</h3>
<p>Quoted-printable adalah skema pengkodean yang menggunakan karakter ASCII 7-bit yang dapat dicetak. Ini digunakan dalam email untuk mentransfer data 8-bit melalui jalur data 7-bit.</p>
<p>Dalam Quoted-printable, data 8-bit direpresentasikan dalam format heksadesimal 2 digit seperti =XX. Misalnya, "あ" menjadi "=E3=81=82" dalam UTF-8. Karakter 7-bit yang dapat dicetak seperti "A" tidak dikonversi.</p>


<h4>Format Header Pesan MIME Email (RFC 2047)</h4>
<p>DenCode juga mendukung dekode format header pesan MIME (RFC 2047) seperti di bawah ini. Format ini digunakan ketika subjek atau tujuan email berisi karakter non-ASCII.</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>Hasil setelah dekode adalah sebagai berikut.</p>

<pre>Subject: サンプル</pre>
