<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos de ROT18</h3>
<p>ROT18 est l'un des chiffres de substitution monoalphabétique qui chiffre en remplaçant les caractères du texte par d'autres caractères.</p>
<p>Le remplacement des caractères est effectué en décalant les caractères de "A" à "Z" de 13 caractères parmi les 26 caractères de "ABCDEFGHIJKLMNOPQRSTUVWXYZ". De plus, les chiffres "0" à "9" sont décalés de 5 caractères parmi les 10 caractères de "0123456789".</p>
<p>Par exemple, "A" est chiffré en "N" et "0" est chiffré en "5".</p>

<pre>
Texte clair   : ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
Texte chiffré : NOPQRSTUVWXYZABCDEFGHIJKLM5678901234
</pre>

<pre>
Texte clair   : THIS IS A SECRET MESSAGE 123
Texte chiffré : GUVF VF N FRPERG ZRFFNTR 567
</pre>

<p>Puisqu'il existe une réciprocité permettant d'obtenir le texte clair en chiffrant à nouveau le texte chiffré, le déchiffrement peut être effectué dans le même flux que le chiffrement.</p>
