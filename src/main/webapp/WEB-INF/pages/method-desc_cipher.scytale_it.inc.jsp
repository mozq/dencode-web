<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sul Cifrario a Scytale</h3>
<p>Il Cifrario a Scytale è un tipo di cifrario a trasposizione che crittografa riorganizzando i caratteri del testo. Scytale significa bastone (o manganello) in greco.</p>
<p>La crittografia viene eseguita avvolgendo una striscia di pergamena attorno a un bastone e scrivendo i caratteri attraverso la pergamena.</p>
<p>Il numero di caratteri che possono essere scritti in un giro del bastone è la chiave di crittografia. Oppure, è possibile specificare il numero di caratteri che possono essere scritti in una riga (il numero di volte che la pergamena è avvolta).</p>

<p>Ad esempio, se il numero di caratteri per giro è 4 e si cripta "THIS_IS_A_SECRET_MESSAGE":</p>

<p>1. Disponi i caratteri attraverso la pergamena. Poiché il numero di caratteri per giro è 4 e il testo da criptare ha 24 caratteri, disponi fino a 6 caratteri orizzontalmente.</p>
<pre>
-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------
</pre>

<p>2. Srotolando la pergamena dal bastone, il testo risulta cifrato.</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>
