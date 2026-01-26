<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre el Cifrado de Escítala</h3>
<p>El Cifrado de Escítala es un tipo de cifrado de transposición que encripta reorganizando los caracteres en un texto. Escítala significa bastón o vara en griego.</p>
<p>Se encripta enrollando una tira larga y estrecha de pergamino alrededor de un bastón y escribiendo caracteres a través del pergamino.</p>
<p>El número de caracteres que se pueden escribir en una vuelta alrededor del bastón es la clave de cifrado. Alternativamente, también se puede especificar el número de caracteres que se pueden escribir en una línea (el número de veces que se enrolla el pergamino).</p>

<p>Por ejemplo, si se cifra "THIS_IS_A_SECRET_MESSAGE" con 4 caracteres por vuelta, es de la siguiente manera:</p>

<p>1. Coloque los caracteres a través del pergamino. Dado que el número de caracteres por vuelta es 4 y el texto tiene 24 caracteres, se colocan hasta 6 caracteres horizontalmente.</p>
<pre>
-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------
</pre>

<p>2. Se encripta desenrollando el pergamino del bastón.</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>
