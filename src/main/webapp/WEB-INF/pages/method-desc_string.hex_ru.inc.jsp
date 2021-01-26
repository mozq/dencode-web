<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О строках шестнадцатеричных символов</h3>
<p>Шестнадцатеричная строка - это двоичное значение строки в шестнадцатеричной системе счисления.</p>
<p>Поскольку двоичное значение различается в зависимости от кодировки символов, результат преобразования в строку шестнадцатеричных символов также отличается.</p>

<p>Например, результат преобразования «выборки» в шестнадцатеричную строку выглядит следующим образом.</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th>Кодировка символов</th><th>Шестиугольная струна</th></tr>
		<tr><td>UTF-8</td><td>D0 B2 D1 8B D0 B1 D0 BE D1 80 D0 BA D0 B8</td></tr>
		<tr><td>UTF-16</td><td>04 32 04 4B 04 31 04 3E 04 40 04 3A 04 38</td></tr>
		<tr><td>KOI8-R</td><td>D7 D9 C2 CF D2 CB C9</td></tr>
	</table>
</div>