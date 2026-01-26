<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre a Cifra Rail Fence</h3>
<p>A Cifra Rail Fence é um tipo de cifra de transposição que criptografa reorganizando os caracteres no texto.</p>
<p>Rail fence significa uma cerca feita de trilhos, e a criptografia é feita organizando os caracteres em ziguezague nos trilhos e, finalmente, conectando os caracteres em unidades de trilhos.</p>
<p>O número de trilhos torna-se a chave da cifra.</p>

<p>Por exemplo, se o número de trilhos for 4 e você criptografar "THIS_IS_A_SECRET_MESSAGE", ficará assim:</p>

<p>1. Prepare 4 trilhos (altura 4) e coloque os caracteres em ziguezague a partir do canto superior esquerdo.</p>
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

<p>2. Obtenha os caracteres arranjados para cada trilho.</p>
<pre>
TSCE
HI_ERMSE
I_ASE_SG
S_TA
</pre>

<p>3. Conecte os caracteres dos trilhos.</p>
<pre>TSCEHI_ERMSEI_ASE_SGS_TA</pre>
