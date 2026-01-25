<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Quoted-printable에 대해서</h3>
<p>Quoted-printable은 7비트 인쇄 가능한 ASCII 문자를 사용한 부호화 방식입니다. 전자 메일에서 8비트 데이터를 7비트 데이터 경로로 전송하기 위해 사용합니다.</p>
<p>Quoted-printable에서는 8비트 데이터를 =XX와 같은 16진수 2자리 형식으로 나타냅니다. 예를 들어 'あ'는 UTF-8에서 '=E3=81=82'가 됩니다. 7비트 인쇄 가능한 'A' 등의 문자는 변환되지 않습니다.</p>


<h4>이메일의 MIME 메시지 헤더 형식 (RFC 2047)</h4>
<p>DenCode에서는 다음과 같은 MIME 메시지 헤더 형식(RFC 2047)의 디코딩도 지원합니다. 이 형식은 이메일의 제목이나 수신처 등에 ASCII 문자 이외가 포함되는 경우에 사용됩니다.</p>

<pre>Subject: =?UTF-8?Q?=E3=82=B5=E3=83=B3=E3=83=97=E3=83=AB?=</pre>

<p>디코딩 후의 결과는 다음과 같습니다.</p>

<pre>Subject: 샘플(サンプル)</pre>
