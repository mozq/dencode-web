<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre a Cifra de Cítala</h3>
<p>A Cifra de Cítala é um tipo de cifra de transposição que criptografa reordenando os caracteres no texto. Scytale significa bastão em grego.</p>
<p>A criptografia é feita enrolando uma tira longa de pergaminho ao redor de um bastão e escrevendo caracteres ao longo do pergaminho.</p>
<p>O número de caracteres que podem ser escritos ao redor do bastão torna-se a chave da cifra. Alternativamente, o número de caracteres que podem ser escritos em uma linha (o número de vezes que o pergaminho é enrolado) também pode ser especificado.</p>

<p>Por exemplo, se o número de caracteres que podem ser escritos ao redor do bastão for 4 e você criptografar "THIS_IS_A_SECRET_MESSAGE", ficará assim:</p>

<p>1. Organize os caracteres ao longo do pergaminho. Como o número de caracteres ao redor do bastão é 4 e o texto a ser criptografado tem 24 caracteres, organizamos até 6 caracteres horizontalmente.</p>
<pre
>-----------------------------------
     | T | H | I | S | _ | I |___|
     | S | _ | A | _ | S | E |
  ___| C | R | E | T | _ | M |
 |   | E | S | S | A | G | E |
-----------------------------------
</pre>

<p>2. O desenrolar do pergaminho do bastão resulta na criptografia.</p>
<pre>TSCEH_RSIAESS_TA_S_GIEME</pre>
