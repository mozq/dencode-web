<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre el Cifrado Rail Fence</h3>
<p>El Cifrado Rail Fence es un tipo de cifrado de transposición que encripta reorganizando los caracteres en un texto.</p>
<p>Rail Fence significa cerca de rieles. Se encripta colocando caracteres en zigzag en los rieles y, finalmente, conectando los caracteres en unidades de rieles.</p>
<p>El número de rieles es la clave de cifrado.</p>

<p>Por ejemplo, si se cifra "THIS_IS_A_SECRET_MESSAGE" con 4 rieles, es de la siguiente manera:</p>

<p>1. Prepare 4 rieles (altura 4) y coloque caracteres en zigzag desde la parte superior izquierda.</p>
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

<p>2. Obtenga los caracteres colocados por unidad de riel.</p>
<pre>
TSCE
HI_ERMSE
I_ASE_SG
S_TA
</pre>

<p>3. Conecte los caracteres de los rieles.</p>
<pre>TSCEHI_ERMSEI_ASE_SGS_TA</pre>
