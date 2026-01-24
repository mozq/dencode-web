<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre el Cifrado Enigma</h3>
<p>El Cifrado Enigma es un tipo de cifrado de sustitución que encripta reemplazando caracteres con otros caracteres. Soporta el cifrado de las 26 letras de la "A" a la "Z".</p>
<p>La sustitución de caracteres se realiza utilizando una máquina Enigma. DenCode soporta simulaciones de las siguientes máquinas Enigma:</p>

<ul>
	<li>Enigma I</li>
	<li>Enigma M3</li>
	<li>Enigma M4 (U-boat Enigma)</li>
	<li>Norway Enigma "Norenigma"</li>
	<li>Sondermaschine (Special machine)</li>
	<li>Enigma G "Zählwerk Enigma" (A28/G31)</li>
	<li>Enigma G G-312 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-260 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-111 (G31 Hungarian Enigma)</li>
	<li>Enigma D (Commercial Enigma A26)</li>
	<li>Enigma K (Commercial Enigma A27)</li>
	<li>Enigma KD (Enigma K with UKW-D)</li>
	<li>Swiss-K (Swiss Enigma K variant)</li>
	<li>Railway Enigma "Rocket I"</li>
	<li>Enigma T "Tirpitz" (Japanese Enigma)</li>
	<li>Spanish Enigma, wiring D</li>
	<li>Spanish Enigma, wiring F</li>
	<li>Spanish Enigma, Delta (A 16081)</li>
	<li>Spanish Enigma, Sonderschaltung / Delta (A 16101)</li>
</ul>

<p>La máquina Enigma se configura de la siguiente manera. Un carácter introducido desde el teclado (Tastatur) pasa por el clavijero o panel de conexiones (Steckerbrett), el rotor de entrada (ETW, Eintrittswalze), 3 o 4 rotores (Walze), y el reflector (UKW, Umkehrwalze), luego sigue el camino inverso y el resultado cifrado se muestra en el panel de lámparas (Lampenfeld). Se produce una sustitución de caracteres en cada punto, incluidos los rotores.</p>

<pre>
 UKW   Walze  Walze  Walze   ETW  (Stecker)
         3      2      1
 ___    ___    ___    ___    ___    ___
|   |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &lt; Tastatur (Teclado)
| | |  |   |  |   |  |   |  |   |  |   |
| | |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &gt; Lampenfeld (Lámparas)
|   |  |   |  |   |  |   |  |   |  |   |
 ---    ---    ---    ---    ---    ---
</pre>

<p>El rotor de entrada, los rotores y el reflector están cableados internamente para convertir las 26 letras de la "A" a la "Z" en otras letras, y la sustitución se realiza cuando la corriente pasa por ese cableado. Por ejemplo, el rotor "I" de Enigma I tiene el siguiente cableado, donde la letra "A" se sustituye por "E". Además, si la letra que regresa del reflector es "J", sigue el cableado inverso y se sustituye por "Z".</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Todo la configuración de cableado de Enigma I es la siguiente:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Rueda</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
		<tr><td>ETW</td><td>ABCDEFGHIJKLMNOPQRSTUVWXYZ</td></tr>
		<tr><td>I</td><td>EKMFLGDQVZNTOWYHXUSPAIBRCJ</td></tr>
		<tr><td>II</td><td>AJDKSIRUXBLHWTMCQGZNPYFVOE</td></tr>
		<tr><td>III</td><td>BDFHJLCPRTXVZNYEIWGAKMUSQO</td></tr>
		<tr><td>IV</td><td>ESOVPZJAYQUIRHXLNFTGKDCMWB</td></tr>
		<tr><td>V</td><td>VZBRGITYUPSDNHLXAWMJQOFECK</td></tr>
		<tr><td>UKW-A</td><td>EJMZALYXVBWFCRQUONTSPIKHGD</td></tr>
		<tr><td>UKW-B</td><td>YRUHQSLDPXNGOKMIEBFZCWVJAT</td></tr>
		<tr><td>UKW-C</td><td>FVPJIAOYEDRZXWGCTKUQSBNMHL</td></tr>
	</table>
</div>

<p>El clavijero o panel de conexiones permite al usuario realizar sustituciones mediante cableado. Algunas máquinas Enigma tienen el clavijero antes del ETW. El clavijero tiene terminales de entrada/salida para las 26 letras del alfabeto de la "A" a la "Z", y conectando dos letras cualesquiera con un cable, se pueden intercambiar esas dos letras. Por ejemplo, si se conectan "A" y "M" con un cable, "A" se sustituye por "M" y "M" por "A". Las letras de los terminales que no están conectados por cables no se sustituyen.</p>
<p>Cuando se introduce una letra desde el teclado, el rotor gira un paso. La rotación de los rotores comienza desde el rotor derecho, y cuando alcanza la posición de la muesca en ese rotor, el rotor izquierdo también gira un paso. Esta rotación del rotor cambia el cableado para el cifrado con cada carácter, por lo que incluso si se introduce el mismo carácter, se sustituirá por un carácter diferente al anterior.</p>
<p>El rotor tiene un anillo, y las letras de la "A" a la "Z" (o "01" a "26") están grabadas en el exterior del anillo. El anillo permite ajustar el desplazamiento entre las letras externas y el cableado interno del rotor en 26 pasos. Por ejemplo, en el caso del rotor "I" de Enigma I, si la configuración del anillo es "A (01)", "A" se sustituye por "E", pero si la configuración del anillo es "B (02)", el cableado interno se desplaza uno, por lo que en el cableado original Z-J, "A" se sustituye por "K".</p>

<pre>
Anillo: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

Anillo: B (02)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>Los rotores se pueden configurar en orden y posición inicial de rotación. Por ejemplo, si hay 3 tipos de rotores "I", "II", "III", se pueden configurar en la máquina Enigma en el orden "II", "I", "III", y la posición inicial de cada rotor se puede configurar entre "A (01)" y "Z (26)". En cuanto al reflector, algunas máquinas permiten intercambiar entre múltiples tipos con diferente cableado, o configurar la posición inicial. El rotor de entrada es fijo y no se puede cambiar. En el caso de máquinas Enigma con clavijero, también se puede configurar el clavijero. Estas configuraciones se convierten en la clave de cifrado de la máquina Enigma.</p>
<p>A continuación se muestra un ejemplo de cifrado con Enigma I.</p>

<pre>
Ruedas        : UKW-A II I III
Anillos       : X M V  (24 13 22)
Posiciones    : A B L  (01 02 12)
Clavijero     : AM FI NV PS TU WZ

Antes  : SECRET
Después: LCGODU
</pre>

<p>En este caso, la primera letra "S" se sustituye en el siguiente flujo y finalmente se cifra a "L".</p>

<pre>
S -&gt; P  : Clavijero
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : Clavijero
</pre>

<p>Además, si la posición de rotación del rotor y la posición de entrada (+) / salida (-) se representan con letras en el anillo, es como sigue. (Dado que el rotor está girando, el "carácter sustituido" anterior y el "carácter como posición en el anillo" son diferentes).</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Clavijero
           -   +          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           -   +          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           +  -           
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : I
               +-         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          -           +   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>

<p>La máquina Enigma tiene la característica de que si se realiza el cifrado nuevamente con la misma configuración en el texto cifrado, se obtiene el texto plano original. Por lo tanto, si se introduce la "L" cifrada en el ejemplo anterior, se obtiene la "S" original.</p>

<pre>
L -&gt; L  : Clavijero
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : Clavijero
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Clavijero
           +   -          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           +   -          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           -  +           
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : I
               -+         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          +           -   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>


<h3>Configuraciones en DenCode</h3>

<h4>Ruedas (Walzenlage)</h4>
<p>Configura el tipo de reflector y rotores, y el orden de los rotores.</p>
<p>Dado que la entrada es desde el lado derecho de la máquina Enigma, los rotores se cuentan 1, 2, 3 desde la derecha, pero al escribir la configuración del orden de las ruedas, generalmente se escribe de izquierda a derecha. Por ejemplo, en el caso de "UKW-A II I III", representa la configuración de rotor 1 "III", rotor 2 "I", rotor 3 "II" y reflector "UKW-A".</p>
<p>Normalmente hay un total de 4 componentes: 1 reflector y 3 rotores, pero Enigma M4 permite configurar un "reflector delgado" y un "rotor delgado" en la ranura del reflector. En DenCode, el "reflector delgado" se trata igual que un reflector normal, y el "rotor delgado" (Beta, Gamma) se muestra y configura adicionalmente como rotor 4, haciendo un total de 5 configuraciones. Sin embargo, si el reflector es UKW-D, ocupa la ranura del reflector, por lo que no se puede configurar el rotor 4.</p>

<h4>Configuración de Anillos (Ringstellung)</h4>
<p>Configura los anillos de los rotores. Esta configuración cambia la posición del cableado interno del rotor con respecto al anillo. En algunas máquinas Enigma, también se puede configurar el anillo del reflector.</p>

<h4>Posiciones (Grundstellung)</h4>
<p>Configura la posición inicial de los rotores. En algunas máquinas Enigma, también se puede configurar la posición inicial del reflector.</p>
<p>A veces se le llama "Message key" (clave de mensaje) porque se cambiaba para cada mensaje.</p>

<h4>Conexiones del Clavijero (Steckerverbindungen)</h4>
<p>Configura los pares de cableado del clavijero.</p>
<p>DenCode se especifica el cableado enumerando pares de 2 caracteres separados por espacios, como "AB CD EF GH IJ KL". Este ejemplo representa pares de cableado de "A" y "B", "C" y "D", etc.</p>

<h4>Uhr</h4>
<p>Uhr es un accesorio que se conecta al clavijero y permite seleccionar el cableado de 40 formas, de "00" a "39". El clavijero y el Uhr están conectados por 20 cables. Los cables están emparejados de dos en dos, y hay 10 pares. Si la configuración de Uhr es "00", es equivalente a que los pares de cables estén conectados directamente en el clavijero.</p>
<p>Uhr solo se puede configurar en Enigma I. La configuración de Uhr es posible especificando primero 10 pares de cableado en el clavijero.</p>

<h4>Cableado UKW-D</h4>
<p>UKW-D es un reflector cuyo cableado interno se puede cambiar.</p>
<p>La notación del anillo para un reflector normal es "ABCDEFGHIJKLMNOPQRSTUVWXYZ", pero para UKW-D es un orden especial "A-ZXWVUTSRQPON-MLKIHGFEDCB". Los dos guiones "-" en la notación (BO en notación estándar) son fijos y siempre están conectados entre sí y no se pueden cambiar. Se configuran los 12 pares de cableado para los 24 caracteres restantes.</p>

<pre>
Notación UKW-D : A-ZXWVUTSRQPON-MLKIHGFEDCB
Notación Normal: ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-D se puede configurar en Enigma I, Enigma M4 y Enigma KD.</p>
