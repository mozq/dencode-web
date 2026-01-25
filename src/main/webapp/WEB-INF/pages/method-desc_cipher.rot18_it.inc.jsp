<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni su ROT18</h3>
<p>ROT18 è un tipo di cifrario a sostituzione monoalfabetica che crittografa sostituendo i caratteri del testo con altri caratteri.</p>
<p>La sostituzione dei caratteri avviene spostando i caratteri da "A" a "Z" di 13 posizioni tra le 26 lettere. Inoltre, i numeri da "0" a "9" vengono spostati di 5 posizioni tra le 10 cifre "0123456789".</p>
<p>Ad esempio, "A" viene cifrato in "N", e "0" in "5".</p>

<pre>Prima: ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
Dopo : NOPQRSTUVWXYZABCDEFGHIJKLM5678901234</pre>

<pre>Testo in chiaro: THIS IS A SECRET MESSAGE 123
Testo cifrato  : GUVF VF N FRPERG ZRFFNTR 567</pre>

<p>Poiché ha la proprietà di reversibilità per cui cifrando nuovamente il testo cifrato si ottiene il testo in chiaro, la decrittografia può essere eseguita con lo stesso procedimento della crittografia.</p>
