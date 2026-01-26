<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sul Cifrario Rail Fence</h3>
<p>Il Cifrario Rail Fence è un tipo di cifrario a trasposizione che crittografa riorganizzando i caratteri del testo.</p>
<p>Rail Fence significa recinto a rotaia (o staccionata), e la crittografia avviene disponendo i caratteri a zigzag sulle rotaie e infine unendo i caratteri per unità di rotaia.</p>
<p>Il numero di rotaie è la chiave di crittografia.</p>

<p>Ad esempio, se criptiamo "THIS_IS_A_SECRET_MESSAGE" con 4 rotaie:</p>

<p>1. Prepara 4 rotaie (altezza 4) e disponi i caratteri a zigzag partendo da in alto a sinistra.</p>
<pre>
-----------------------------------------------
T           S           C           E          
-----------------------------------------------
  H       I   _       E   R       M   S       E
-----------------------------------------------
    I   _       A   S       E   _       S   G  
-----------------------------------------------
      S           _           T           A    
-----------------------------------------------
</pre>

<p>2. Prendi i caratteri disposti per ogni rotaia.</p>
<pre>
TSCE
HI_ERMSE
I_ASE_SG
S_TA
</pre>

<p>3. Unisci i caratteri delle rotaie.</p>
<pre>TSCEHI_ERMSEI_ASE_SGS_TA</pre>
