<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О Нормализации Unicode</h3>
<p>Нормализация Unicode - это декомпозиция и композиция символов. Некоторые символы Unicode имеют одинаковый внешний вид, но имеют несколько представлений. Например, «â» может быть представлен как одна кодовая точка для «â» (U+00E2) и две разложенные кодовые точки для «a» (U+0061) и « ̂» (U+0302). Его также можно выразить как (базовый символ + объединяющий символ). Первый называется предварительно составленным символом, а второй - последовательностью комбинируемых символов (combining character sequence, CCS).</p>
<p>Существуют следующие типы нормализации Unicode:</p>

<div class="table-responsive">
	<table class="table table-sm table-fit">
		<tr><th scope="col">Форма нормализации</th><th scope="col">Описание</th><th scope="col">пример</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>Персонажи разлагаются по канонической эквивалентности</td><td>«â» (U+00E2) -&gt; «a» (U+0061) + « ̂» (U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>Персонажи разложены по совместимости</td><td>«ﬁ» (U+FB01) -&gt; «f» (U+0066) + «i» (U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>Персонажи раскладываются, а затем перекомпоновываются в соответствии с канонической эквивалентностью</td><td>«â» (U+00E2) -&gt; «a» (U+0061) + « ̂» (U+0302) -&gt; «â» (U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>Символы разлагаются по совместимости, а затем перекомпоновываются в соответствии с канонической эквивалентностью</td><td>«ﬁ» (U+FB01) -&gt; «f» (U+0066) + «i» (U+0069) -&gt; «f» (U+0066) + «i» (U+0069)</td></tr>
	</table>
</div>

<p>Каноническая эквивалентность нормализуется при сохранении визуально и функционально эквивалентных символов. например «â» &lt;-&gt; «a» + « ̂»</p>
<p>Помимо канонической эквивалентности, эквивалентность совместимости также нормализует символы, имеющие разные семантические формы. например «ﬁ» -&gt; «f» + «i»</p>
