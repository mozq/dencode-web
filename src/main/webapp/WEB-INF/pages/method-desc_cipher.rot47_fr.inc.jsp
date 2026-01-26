<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos de ROT47</h3>
<p>ROT47 est l'un des chiffres de substitution monoalphabétique qui chiffre en remplaçant les caractères du texte par d'autres caractères.</p>
<p>Le remplacement des caractères est effectué en décalant les caractères de "!" à "~" de 47 caractères parmi les 94 caractères de "!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~".</p>
<p>Par exemple, "!" est chiffré en "P", "A" est chiffré en "p" et "0" est chiffré en "_".</p>

<pre>
Texte clair   : !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
Texte chiffré : PQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNO
</pre>

<pre>
Texte clair   : THIS IS A SECRET MESSAGE 123!
Texte chiffré : %wx$ x$ p $tr#t% |t$$pvt `abP
</pre>

<p>Puisqu'il existe une réciprocité permettant d'obtenir le texte clair en chiffrant à nouveau le texte chiffré, le déchiffrement peut être effectué dans le même flux que le chiffrement.</p>
