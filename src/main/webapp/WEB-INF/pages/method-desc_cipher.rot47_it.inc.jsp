<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni su ROT47</h3>
<p>ROT47 è un tipo di cifrario a sostituzione monoalfabetica che crittografa sostituendo i caratteri del testo con altri caratteri.</p>
<p>La sostituzione dei caratteri avviene spostando i caratteri da "!" a "~" di 47 posizioni tra i 94 caratteri di "!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~".</p>
<p>Ad esempio, "!" viene cifrato in "P", "A" in "p", e "0" in "_".</p>

<pre>Prima: !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
Dopo : PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO</pre>

<pre>Testo in chiaro: THIS IS A SECRET MESSAGE 123!
Testo cifrato  : %wx$ x$ p $tr#t% |t$$pvt `abP</pre>

<p>Poiché ha la proprietà di reversibilità per cui cifrando nuovamente il testo cifrato si ottiene il testo in chiaro, la decrittografia può essere eseguita con lo stesso procedimento della crittografia.</p>
