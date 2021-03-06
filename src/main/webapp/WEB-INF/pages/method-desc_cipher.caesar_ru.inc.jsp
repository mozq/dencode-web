<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>О шифр цезаря</h3>
<p>Шифр цезаря - это один из кодов единственного типа транслитерации, который шифрует, заменяя символы в тексте другими символами.</p>
<p>Замена символов выполняется путем сдвига символов от «A» до «Z» влево или вправо среди 26 символов «ABCDEFGHIJKLMNOPQRSTUVWXYZ».</p>
<p>Например, при сдвиге на 3 символа влево «A» зашифровывается до «D», а «Z» зашифровывается до «C».</p>

<pre>Исходный алфавит: ABCDEFGHIJKLMNOPQRSTUVWXYZ
Шифрованный     : DEFGHIJKLMNOPQRSTUVWXYZABC</pre>

<pre>Простой текст: THIS IS A SECRET MESSAGE
Криптограмма : WKLV LV D VHFUHW PHVVDJH</pre>

<p>Количество смен - ключ к шифрованию.</p>
<p>Шифруются только буквы, а не числа или символы.</p>
<p>Если количество смен равно 13, результат будет таким же, как и <a href="rot13">ROT13</a>.</p>

<p>Сдвигает символы с сохранением диакритического знака. Так, например, «Á» зашифровано до «D́».</p>


<h4>Поддержка других языков</h4>
<p>Помимо латинских символов поддерживает символы Кирилла.</p>

<p>Если вы хотите сдвинуть иероглифа Кирилла влево на 3 символа, он будет зашифрован следующим образом.</p>

<pre>Исходный алфавит: АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
Шифрованный     : ГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯАБВ</pre>

<p>Сдвигает символы с сохранением диакритического знака. Так, например, русское слово «Ё» зашифровано до «Ӥ». Символы «Й» и «й» рассматриваются как уникальные символы, а не «И» и «и» с диакритическим знаком « ̆» (Breve).</p>
