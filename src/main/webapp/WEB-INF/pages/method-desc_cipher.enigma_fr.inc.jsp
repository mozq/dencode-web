<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos du chiffre Enigma</h3>
<p>Le chiffre Enigma est un type de chiffre de substitution qui chiffre les lettres en les remplaçant par d'autres lettres. Il supporte le chiffrement de 26 caractères de "A" à "Z".</p>
<p>Le remplacement des caractères est effectué à l'aide de la machine à chiffrer Enigma, et DenCode supporte les simulations de machines Enigma suivantes :</p>

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

<p>La machine Enigma se compose des éléments suivants. Les caractères entrés au clavier (Tastatur) passent par un tableau de connexions (Steckerbrett), une roue d'entrée (ETW, Eintrittswalze), trois ou quatre rotors (Walze), un réflecteur (UKW, Umkehrwalze), puis le chemin inverse. Le résultat chiffré est affiché sur le panneau lumineux (Lampenfeld). La substitution de lettres est effectuée à tous les emplacements, y compris les rotors.</p>

<pre>
 UKW   Walze  Walze  Walze   ETW  (Stecker)
         3      2      1
 ___    ___    ___    ___    ___    ___
|   |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &lt; Tastatur
| | |  |   |  |   |  |   |  |   |  |   |
| | |  |   |  |   |  |   |  |   |  |   |
|  -|--|---|--|---|--|---|--|---|--|---|-- &gt; Lampenfeld
|   |  |   |  |   |  |   |  |   |  |   |
 ---    ---    ---    ---    ---    ---
</pre>

<p>La roue d'entrée, les rotors et le réflecteur sont câblés en interne pour convertir les 26 lettres de "A" à "Z" en d'autres lettres, et la conversion se fait lorsque les fils sont sous tension. Par exemple, le rotor "I" de l'Enigma I est câblé comme suit, et la lettre "A" est convertie en "E". De plus, la lettre "J" revenant du réflecteur est convertie en "Z" en suivant le câblage inverse.</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Tout le câblage pour l'Enigma I est le suivant.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Roue</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
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

<p>Le tableau de connexions (plugboard) est un mécanisme qui permet à l'utilisateur de configurer les substitutions par câblage. Sur certaines machines Enigma, il y a un tableau de connexions avant l'ETW. Le tableau de connexions possède des bornes d'entrée et de sortie pour les 26 lettres de "A" à "Z". En connectant deux lettres avec un câble, ces deux caractères sont permutés. Par exemple, si vous connectez "A" et "M" avec un câble, "A" sera converti en "M" et "M" en "A". Les caractères des bornes d'entrée et de sortie qui ne sont pas câblés ne seront pas convertis.</p>
<p>Lorsque vous entrez un caractère au clavier, le rotor tourne d'un cran. La rotation des rotors commence par celui de droite, et lorsqu'il atteint l'encoche (notch) sur le rotor, le rotor de gauche tourne également d'un cran. Cette rotation du rotor modifie le câblage de chiffrement pour chaque caractère, donc même si vous entrez le même caractère, il sera converti en un caractère différent du précédent.</p>
<p>Le rotor possède un anneau (Ring), avec les lettres "A" à "Z" (ou "01" à "26") gravées sur sa circonférence extérieure. L'anneau permet de régler le décalage entre la lettre sur sa périphérie et le câblage interne du rotor sur 26 positions. Par exemple, dans le cas du rotor "I" de l'Enigma I, si le réglage de l'anneau est "A (01)", le "A" sera converti en "E", mais si le réglage de l'anneau est "B (02)", le câblage interne est décalé de un, donc "A" sera converti en "K" (selon le câblage original Z-J).</p>

<pre>
Anneau : A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

Anneau : B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>Les rotors peuvent être configurés dans un certain ordre et avec une position initiale de rotation. Par exemple, s'il existe trois types de rotors, "I", "II" et "III", ils peuvent être placés dans la machine Enigma dans l'ordre "II", "I" et "III", et la position initiale de chaque rotor peut être réglée entre "A (01)" et "Z (26)". Les réflecteurs sont également interchangeables parmi plusieurs types avec différents câblages, et certaines machines Enigma permettent de régler une position initiale pour le réflecteur. La roue d'entrée est fixe et ne peut pas être modifiée. Pour les machines Enigma équipées de tableaux de connexions, celui-ci peut également être configuré. Ces réglages constituent la clé de chiffrement de la machine Enigma.</p>
<p>Un exemple de chiffrement avec Enigma I est présenté ci-dessous.</p>

<pre>
Ordre des roues       : UKW-A II I III
Réglage de l'anneau   : X M V  (24 13 22)
Position initiale     : A B L  (01 02 12)
Tableau de connexions : AM FI NV PS TU WZ

Texte avant chiffrement : SECRET
Texte après chiffrement : LCGODU
</pre>

<p>Dans ce cas, la première lettre "S" sera convertie selon le flux suivant, et finalement chiffrée en "L".</p>

<pre>
S -&gt; P  : Tableau de connexions
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : Tableau de connexions
</pre>

<p>La position de rotation du rotor et les positions d'entrée (+) / sortie (-) sont représentées par les lettres sur l'anneau comme indiqué ci-dessous. (Puisque le rotor tourne, les "caractères transcrits" et les "caractères en tant que positions sur l'anneau" ci-dessus sont différents.)</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Tableau de connexions
           -   +          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           -   +          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           +  -           
BCDEFGHIJKLMNOPQRSTUVWXYZA  : I
               +-         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          -           +   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>

<p>La machine Enigma a la particularité que si vous chiffrez à nouveau un texte chiffré avec les mêmes réglages, vous obtiendrez le texte clair d'origine. Par conséquent, entrer le "L" chiffré dans l'exemple ci-dessus donnera le "S" original.</p>

<pre>
L -&gt; L  : Tableau de connexions
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : Tableau de connexions
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Tableau de connexions
           +   -          
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : ETW
           +   -          
MNOPQRSTUVWXYZABCDEFGHIJKL  : III
           -  +           
BCDEFGHIJKLMNOPQRSTUVWXYZA  : I
               -+         
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : II
          +           -   
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : UKW-A
</pre>


<h3>Éléments de réglage dans DenCode</h3>

<h4>Ordre des roues (Walzenlage)</h4>
<p>Définit le type de réflecteur et de rotors, ainsi que l'ordre des rotors.</p>
<p>L'entrée se faisant par le côté droit de la machine Enigma, les rotors sont comptés de la droite vers la gauche (1, 2, 3...), mais lors de la description de l'ordre des roues, ils sont généralement écrits de gauche à droite. Par exemple, un ordre de roues "UKW-A II I III" indique les réglages du rotor 1 "III", du rotor 2 "I", du rotor 3 "II" et du réflecteur "UKW-A".</p>
<p>Normalement, il y a un réflecteur et trois rotors pour un total de quatre, mais l'Enigma M4 peut être configurée avec un "réflecteur mince" et un "rotor mince" dans l'emplacement du réflecteur. Dans DenCode, le "réflecteur mince" est traité comme un réflecteur normal, et le "rotor mince" (Beta, Gamma) est affiché en supplément comme rotor 4, pour un total de 5 réglages. Cependant, si le réflecteur est UKW-D, le rotor 4 ne peut pas être défini car il occupe l'emplacement du réflecteur.</p>

<h4>Réglage de l'anneau (Ringstellung)</h4>
<p>Définit l'anneau du rotor. Ce réglage modifie la position du câblage interne du rotor par rapport à l'anneau. Sur certaines machines Enigma, le réflecteur peut également avoir un réglage d'anneau.</p>

<h4>Position initiale (Grundstellung)</h4>
<p>Définit la position initiale du rotor. Sur certaines machines Enigma, le réflecteur peut également être réglé sur une position initiale.</p>
<p>On l'appelle parfois "Clé de message" (Message key) car elle était définie différemment pour chaque message.</p>

<h4>Câblage du tableau de connexions (Steckerverbindungen)</h4>
<p>Définit les paires de câblage pour le tableau de connexions.</p>
<p>Dans DenCode, le câblage est spécifié en énumérant des paires de deux caractères à convertir, comme "AB CD EF GH IJ KL", séparées par un espace. Dans cet exemple, les paires sont "A" et "B", "C" et "D", et ainsi de suite.</p>

<h4>Uhr</h4>
<p>L'Uhr est un accessoire qui se connecte au tableau de connexions et permet de choisir un câblage parmi 40 possibilités, de "00" à "39". Le tableau de connexions et l'Uhr sont reliés par 20 câbles. Lorsque l'Uhr est réglé sur "00", cette paire de câbles est équivalente à une connexion directe sur le tableau de connexions.</p>
<p>L'Uhr ne peut être défini que pour l'Enigma I. L'Uhr peut être activé en spécifiant d'abord 10 paires de câblage sur le tableau de connexions.</p>

<h4>Câblage UKW-D</h4>
<p>L'UKW-D est un réflecteur avec un câblage interne modifiable.</p>
<p>La notation normale pour les anneaux de réflecteur est "ABCDEFGHIJKLMNOPQRSTUVWXYZ", mais la notation de l'UKW-D suit un ordre spécial : "A-ZXWVUTSRQPON-MLKIHGFEDCB". Les deux "-" (BO dans la notation normale) sont fixes et toujours connectés l'un à l'autre sans pouvoir être modifiés. Les 24 autres caractères et 12 paires de fils sont configurables.</p>

<pre>
Notation UKW-D   : A-ZXWVUTSRQPON-MLKIHGFEDCB
Notation normale : ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>L'UKW-D peut être configuré pour Enigma I, Enigma M4 et Enigma KD.</p>
