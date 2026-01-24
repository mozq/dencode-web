<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Über die Enigma-Chiffre</h3>
<p>Die Enigma-Chiffre ist eine polyalphabetische Substitutionschiffre, die Buchstaben in andere Buchstaben umwandelt. Sie unterstützt die Verschlüsselung der 26 Buchstaben von "A" bis "Z".</p>
<p>Die Substitution erfolgt mithilfe einer Enigma-Maschine. DenCode unterstützt die Simulation der folgenden Enigma-Modelle:</p>

<ul>
	<li>Enigma I</li>
	<li>Enigma M3</li>
	<li>Enigma M4 (U-Boot-Enigma)</li>
	<li>Norway Enigma "Norenigma"</li>
	<li>Sondermaschine</li>
	<li>Enigma G "Zählwerk Enigma" (A28/G31)</li>
	<li>Enigma G G-312 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-260 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-111 (G31 Ungarische Enigma)</li>
	<li>Enigma D (Kommerzielle Enigma A26)</li>
	<li>Enigma K (Kommerzielle Enigma A27)</li>
	<li>Enigma KD (Enigma K mit UKW-D)</li>
	<li>Swiss-K (Schweizer Enigma K Variante)</li>
	<li>Railway Enigma "Rocket I"</li>
	<li>Enigma T "Tirpitz" (Japanische Enigma)</li>
	<li>Spanische Enigma, Verdrahtung D</li>
	<li>Spanische Enigma, Verdrahtung F</li>
	<li>Spanische Enigma, Delta (A 16081)</li>
	<li>Spanische Enigma, Sonderschaltung / Delta (A 16101)</li>
</ul>

<p>Die Struktur einer Enigma-Maschine ist wie folgt: Ein über die Tastatur (Tastatur) eingegebener Buchstabe durchläuft das Steckerbrett (Steckerbrett), die Eintrittswalze (ETW), 3 oder 4 Walzen (Rotoren) und die Umkehrwalze (UKW). Danach läuft das Signal den Weg zurück und das Ergebnis leuchtet auf dem Lampenfeld (Lampenfeld) auf. An jeder Station findet eine Substitution des Buchstabens statt.</p>

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

<p>Die Eintrittswalze, die Rotoren und die Umkehrwalze haben interne Verdrahtungen, die die 26 Buchstaben "A" bis "Z" permutieren. Zum Beispiel hat Rotor "I" der Enigma I folgende Verdrahtung, bei der "A" zu "E" wird. Wenn das Signal von der Umkehrwalze zurückkommt, wird bei "J" der umgekehrte Weg genommen und es wird zu "Z".</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Alle Verdrahtungen der Enigma I sind wie folgt:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Walze</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
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

<p>Das Steckerbrett ermöglicht es dem Benutzer, zusätzliche Vertauschungen durch Kabelverbindungen vorzunehmen. Es befindet sich vor der Eintrittswalze. Das Steckerbrett hat Buchsen für die 26 Buchstaben. Durch Verbinden zweier Buchstaben mit einem Kabel werden diese vertauscht. Wenn z.B. "A" und "M" verbunden sind, wird "A" zu "M" und "M" zu "A". Buchstaben ohne Kabelverbindung bleiben unverändert.</p>
<p>Wenn eine Taste gedrückt wird, dreht sich der erste Rotor (rechts) um einen Schritt weiter. Wenn ein Rotor eine bestimmte Position (Notch) erreicht, dreht sich auch der nächste Rotor (links) weiter. Durch diese Rotation ändert sich die interne Verdrahtung für jeden Buchstaben, sodass der gleiche Buchstabe jedes Mal anders verschlüsselt wird.</p>
<p>Jeder Rotor hat einen Ring, auf dem die Buchstaben "A" bis "Z" (oder "01" bis "26") stehen. Die Ringstellung bestimmt den Versatz zwischen der internen Verdrahtung und den Buchstaben auf dem Ring. Bei Enigma I Rotor "I" und Ringstellung "A (01)" wird "A" zu "E". Bei Ringstellung "B (02)" verschiebt sich die Verdrahtung, sodass "A" zu "K" wird.</p>

<pre>
Ring: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

Ring: B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>Die Rotoren können in beliebiger Reihenfolge eingesetzt und auf eine beliebige Anfangsposition eingestellt werden. Zum Beispiel können die Rotoren "I", "II" und "III" in der Reihenfolge "II", "I", "III" eingesetzt werden. Die Anfangsposition jedes Rotors kann zwischen "A (01)" und "Z (26)" gewählt werden. Auch die Umkehrwalze kann bei manchen Modellen gewählt oder eingestellt werden.</p>
<p>Hier ist ein Beispiel für die Verschlüsselung mit der Enigma I:</p>

<pre>
Walzenlage    : UKW-A II I III
Ringstellung  : X M V  (24 13 22)
Grundstellung : A B L  (01 02 12)
Steckerbrett  : AM FI NV PS TU WZ

Klartext      : SECRET
Geheimtext    : LCGODU
</pre>

<p>Der erste Buchstabe "S" durchläuft folgenden Pfad und wird zu "L":</p>

<pre>
S -&gt; P  : Steckerbrett
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : Steckerbrett
</pre>

<p>Die Positionen von Eingang (+) und Ausgang (-) auf dem Ring dargestellt (da die Rotoren sich drehen, unterscheiden sich diese von den oben genannten Buchstaben):</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Plugboard
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

<p>Die Enigma ist reziprok: Wenn der Geheimtext mit denselben Einstellungen erneut eingegeben wird, erhält man den Klartext. "L" ergibt also wieder "S".</p>

<pre>
L -&gt; L  : Steckerbrett
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : Steckerbrett
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Plugboard
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

<h3>Einstellungen in DenCode</h3>

<h4>Walzenlage</h4>
<p>Wählt den Typ der Umkehrwalze und der Rotoren sowie deren Reihenfolge.</p>
<p>Da das Signal von rechts kommt, werden die Rotoren von rechts nach links gezählt (1, 2, 3). Die Einstellung schreibt man jedoch meist von links nach rechts (Reflektor, Rotor links, ..., Rotor rechts). "UKW-A II I III" bedeutet also: Reflektor UKW-A, Rotor links (3) II, Rotor mitte (2) I, Rotor rechts (1) III.</p>
<p>Normalerweise gibt es 3 Rotoren. Die Enigma M4 hat einen zusätzlichen "dünnen" Reflektor und einen "dünnen" Rotor im Reflektor-Slot. DenCode behandelt den "dünnen" Reflektor normal und den "dünnen" Rotor (Beta, Gamma) als Rotor 4. Bei UKW-D entfällt Rotor 4.</p>

<h4>Ringstellung</h4>
<p>Stellt den Ringversatz für jeden Rotor ein. Bei manchen Modellen auch für die Umkehrwalze.</p>

<h4>Grundstellung</h4>
<p>Stellt die Anfangsposition der Rotoren ein. Bei manchen Modellen auch für die Umkehrwalze.</p>
<p>Da dies pro Nachricht geändert wurde, nennt man es auch "Spruchschlüssel".</p>

<h4>Steckerverbindungen</h4>
<p>Konfiguriert die Kabelverbindungen des Steckerbretts.</p>
<p>Geben Sie Paare von Buchstaben ein, die vertauscht werden sollen, z.B. "AB CD EF GH IJ KL".</p>

<h4>Uhr</h4>
<p>Die Uhr ist ein Zubehör, das an das Steckerbrett angeschlossen wird und 40 verschiedene Verdrahtungen ("00" bis "39") bietet. Sie wird mit 10 Kabelpaaren verbunden.</p>
<p>Nur für Enigma I verfügbar. Erfordert 10 Steckerpaare.</p>

<h4>UKW-D Verdrahtung</h4>
<p>Die UKW-D ist eine umverdrahtbare Umkehrwalze.</p>
<p>Im Gegensatz zur normalen Beschriftung "A...Z" nutzt UKW-D die Reihenfolge "A-ZXWVUTSRQPON-MLKIHGFEDCB". Die zwei "-" (entspricht B und O) sind fest verbunden. Die anderen 24 Buchstaben können in 12 Paaren frei verbunden werden.</p>

<pre>
UKW-D Beschriftung: A-ZXWVUTSRQPON-MLKIHGFEDCB
Normale Notation:   ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>Verfügbar für Enigma I, Enigma M4, Enigma KD.</p>
