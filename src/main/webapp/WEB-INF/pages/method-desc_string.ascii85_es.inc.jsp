<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre Ascii85</h3>
<p>Ascii85 es un método de codificación que utiliza caracteres ASCII imprimibles de 7 bits. También se llama Base85.</p>
<p>En Ascii85, los datos se dividen en 4 bytes cada uno y se convierten en 5 caracteres ASCII.</p>
<p>Existen varias variantes de Ascii85. DenCode soporta los siguientes tres tipos de Ascii85. El original es btoa, seguido por Adobe y Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Resumen</th></tr>
		<tr><th>Z85</th><td>Utilizado en ZeroMQ. Evita caracteres que requieren escape como "\" (barra invertida) o "'" (apóstrofe).</td></tr>
		<tr><th>Adobe</th><td>Utilizado para codificar imágenes en archivos PostScript y PDF (Portable Document Format) de Adobe. Encerrado entre "&lt;~" y "~&gt;".</td></tr>
		<tr><th>btoa</th><td>Formato del comando btoa de UNIX. Usado en el pasado para intercambio de datos binarios, pero no es común hoy en día. Encerrado entre líneas "xbtoa Begin" y "xbtoa End".</td></tr>
	</table>
</div>

<p>Los caracteres ASCII utilizados en Ascii85 son los siguientes. Se trata un valor de 4 bytes como un entero sin signo big-endian, se calcula cada dígito (5 dígitos) en base 85, y se obtiene el resultado de conversión Ascii85 basado en los siguientes caracteres ASCII.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Caracteres ASCII</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(Originalmente caracteres desde " " (espacio) hasta "t", pero debido a que algunos clientes de correo eliminaban espacios al final, se reemplazó posteriormente con caracteres desde "!" hasta "u".)</td></tr>
	</table>
</div>

<p>Por ejemplo, convertir "Hello" en Ascii85 da el siguiente resultado:</p>

<p>1. Dividir en grupos de 4 bytes. Si hay menos de 4 bytes, rellenar el final con "00".</p>
<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. Tratar cada 4 bytes como un entero sin signo big-endian y convertir ese valor a dígitos en base 85.</p>
<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. Convertir cada dígito base 85 a caracteres ASCII. Si se rellenó con "00", excluir el relleno para Adobe/Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. Unir todos los caracteres para obtener el resultado de la conversión Ascii85. Adobe se encierra en "&lt;~" y "~&gt;" y hace salto de línea cada 80 caracteres. btoa se encierra en "xbtoa Begin" y "xbtoa End" (incluyendo longitud de datos, suma de control, etc.) y hace salto de línea cada 78 caracteres.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Resultado de conversión</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>Además, se definen algunas formas abreviadas.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Abreviatura</th></tr>
		<tr><th>Z85</th><td>Ninguna</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2 o posterior)<br /></td></tr>
	</table>
</div>
