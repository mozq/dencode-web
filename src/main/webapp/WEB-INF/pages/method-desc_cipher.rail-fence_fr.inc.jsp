<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du chiffre Rail Fence</h3>
<p>Le chiffre Rail Fence est l'un des chiffres de transposition qui chiffre en réarrangeant les caractères du texte.</p>
<p>Rail Fence signifie une clôture faite de rails (traverses). Les caractères sont disposés en zigzag sur les rails, et enfin, les caractères sont concaténés par rail pour le chiffrement.</p>
<p>Le nombre de rails constitue la clé de chiffrement.</p>

<p>Par exemple, lorsque "THIS_IS_A_SECRET_MESSAGE" est chiffré avec 4 rails, cela donne ce qui suit.</p>

<p>1. Préparez 4 rails (hauteur 4) et disposez les caractères en zigzag à partir du haut à gauche.</p>
<pre>-----------------------------------------------
T           S           C           E          
-----------------------------------------------
  H       I   _       E   R       M   S       E
-----------------------------------------------
    I   _       A   S       E   _       S   G  
-----------------------------------------------
      S           _           T           A    
-----------------------------------------------</pre>

<p>2. Récupérez les caractères placés dans chaque rail.</p>
<pre>TSCE
HI_ERMSE
I_ASE_SG
S_TA</pre>

<p>3. Concaténez les caractères des rails.</p>
<pre>TSCEHI_ERMSEI_ASE_SGS_TA</pre>
