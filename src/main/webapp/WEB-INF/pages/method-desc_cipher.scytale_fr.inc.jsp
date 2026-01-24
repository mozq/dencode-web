<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du chiffre de la Scytale</h3>
<p>Le chiffre de la Scytale est l'un des chiffres de transposition chiffre en réarrangeant les caractères du texte. Scytale signifie bâton en grec.</p>
<p>Une bande de parchemin est enroulée autour de la scytale et chiffrée en écrivant des caractères en travers du parchemin.</p>
<p>La clé de chiffrement est le nombre de caractères pouvant être écrits sur un tour de la scytale. Alternativement, vous pouvez également spécifier le nombre de caractères pouvant être écrits sur une ligne (le nombre de fois que le parchemin est enroulé).</p>

<p>Par exemple, lorsque "THIS_IS_A_SECRET_MESSAGE" est chiffré avec 4 caractères par tour de scytale, cela donne ce qui suit.</p>

<p>1. Placez les caractères en travers de la bande de parchemin.</p>
<pre>-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------</pre>

<p>2. Il est chiffré en déroulant le parchemin de la scytale.</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>
