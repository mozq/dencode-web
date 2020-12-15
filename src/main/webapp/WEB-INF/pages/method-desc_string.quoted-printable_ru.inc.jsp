<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О QP-кодировка</h3>
<p>QP-кодировка - это метод кодирования, использующий 7-битные печатаемые символы ASCII. Используется для передачи 8-битных данных по 7-битному пути данных в электронной почте.</p>
<p>QP-кодировка представляет 8-битные данные в 2-значном шестнадцатеричном формате, например =XX. Например, «あ» в UTF-8 становится «=E3=81=82». 7-битные печатные символы, такие как «A», не преобразуются.</p>


<h4>Формат заголовка сообщения электронной почты MIME (RFC 2047)</h4>
<p>DenCode также поддерживает декодирование формата заголовка сообщения MIME (RFC 2047), как показано ниже. Этот формат используется, когда тема, получатель и т. Д. Электронного письма содержат символы, отличные от ASCII.</p>

<pre>Subject: =?UTF-8?Q?=D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80?=</pre>

<p>Результат после расшифровки следующий.</p>

<pre>Subject: пример</pre>