<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sul Cifrario Enigma</h3>
<p>Il cifrario Enigma è un tipo di cifrario a sostituzione polialfabetica che crittografa sostituendo i caratteri con altri caratteri. Supporta la crittografia di 26 lettere dalla "A" alla "Z".</p>
<p>La sostituzione dei caratteri viene eseguita utilizzando la macchina Enigma. DenCode supporta la simulazione delle seguenti macchine Enigma:</p>

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

<p>La macchina Enigma ha la seguente configurazione. I caratteri immessi dalla tastiera (Tastatur) passano attraverso il pannello a prese (Steckerbrett), la ruota di ingresso (ETW, Eintrittswalze), tre o quattro rotori (Walze), il riflettore (UKW, Umkehrwalze), e poi seguono il percorso inverso per visualizzare il risultato cifrato sul pannello lampade (Lampenfeld). La sostituzione dei caratteri avviene in tutti i punti, come nei rotori.</p>

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

<p>La ruota di ingresso, i rotori e il riflettore sono cablati internamente per convertire le 26 lettere da "A" a "Z" in altre lettere, e la conversione avviene quando i cavi vengono alimentati. Ad esempio, il rotore "I" di Enigma I è cablato come segue, e il carattere "A" viene convertito in "E". Inoltre, se il carattere che ritorna dal riflettore è "J", seguendo il cablaggio inverso viene convertito in "Z".</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Tutti i cablaggi di Enigma I sono i seguenti:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Ruota</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
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

<p>Il pannello a prese (plugboard) è un meccanismo che consente all'utente di eseguire sostituzioni tramite cavi. In alcune macchine Enigma, il pannello a prese si trova prima dell'ETW. Il pannello a prese ha terminali di ingresso/uscita per le 26 lettere dell'alfabeto da "A" a "Z" e, collegando due lettere arbitrarie con un cavo, è possibile scambiare quelle due lettere. Ad esempio, se si collegano "A" e "M" con un cavo, "A" viene scambiato con "M" e "M" con "A". I caratteri dei terminali non collegati con cavi non vengono sostituiti.</p>
<p>Quando si immette un carattere dalla tastiera, il rotore ruota di un passo. La rotazione dei rotori inizia dal rotore a destra e, quando raggiunge la posizione della tacca (notch) sul rotore, anche il rotore a sinistra ruota di un passo. Questa rotazione del rotore cambia il cablaggio per la crittografia per ogni carattere, quindi anche se si inserisce lo stesso carattere, verrà convertito in un carattere diverso rispetto alla volta precedente.</p>
<p>Il rotore ha un anello, e sulla circonferenza esterna dell'anello sono incise le lettere da "A" a "Z" (o da "01" a "26"). L'anello può impostare l'offset tra i caratteri sulla circonferenza esterna e il cablaggio interno del rotore in 26 passaggi. Ad esempio, nel caso del rotore "I" di Enigma I, se l'impostazione dell'anello è "A (01)", "A" viene convertito in "E", ma se l'impostazione dell'anello è "B (02)", il cablaggio interno viene spostato di 1, quindi come cablaggio originale Z-J, "A" viene convertito in "K".</p>

<pre>
Anello: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

Anello: B (02)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>È possibile impostare l'ordine e la posizione iniziale di rotazione dei rotori. Ad esempio, se ci sono tre tipi di rotori "I", "II" e "III", possono essere impostati nella macchina Enigma nell'ordine "II", "I", "III", e la posizione iniziale di ciascun rotore può essere impostata tra "A (01)" e "Z (26)". Anche per i riflettori, esistono macchine Enigma in cui è possibile scambiare tra diversi tipi di riflettori con cablaggi diversi o impostare la posizione iniziale. La ruota di ingresso è fissa e non può essere modificata. Nel caso di macchine Enigma con pannello a prese, è possibile impostare anche il pannello a prese. Queste impostazioni costituiscono la chiave di crittografia della macchina Enigma.</p>
<p>Di seguito è mostrato un esempio di crittografia con Enigma I.</p>

<pre>
Ordine Ruote         : UKW-A II I III
Impostazione Anelli  : X M V  (24 13 22)
Impostazione Posizione: A B L (01 02 12)
Pannello a prese     : AM FI NV PS TU WZ

Testo prima della crittografia: SECRET
Testo dopo la crittografia    : LCGODU
</pre>

<p>In questo caso, il primo carattere "S" viene convertito nel seguente flusso e infine cifrato in "L".</p>

<pre>
S -&gt; P  : Pannello a prese
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : Pannello a prese
</pre>

<p>Inoltre, le posizioni di rotazione dei rotori e le posizioni di ingresso (+) / uscita (-) rappresentate dai caratteri sull'anello sono le seguenti. (Poiché il rotore sta ruotando, il "carattere convertito" sopra e il "carattere come posizione sull'anello" sono diversi.)</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Pannello a prese
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

<p>La macchina Enigma ha la caratteristica che se si crittografa nuovamente il testo cifrato con le stesse impostazioni, si ottiene il testo in chiaro originale. Pertanto, inserendo la "L" cifrata nell'esempio sopra, si ottiene la "S" originale.</p>

<pre>
L -&gt; L  : Pannello a prese
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : Pannello a prese
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Pannello a prese
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


<h3>Elementi di impostazione in DenCode</h3>

<h4>Ordine Ruote (Walzenlage)</h4>
<p>Imposta il tipo di riflettore e rotori, e l'ordine dei rotori.</p>
<p>L'input avviene dal lato destro della macchina Enigma, quindi i rotori vengono contati da 1, 2, 3 a partire da destra, ma quando si indica l'impostazione dell'ordine delle ruote, generalmente si scrive da sinistra. Ad esempio, nel caso dell'ordine "UKW-A II I III", rappresenta le impostazioni: Rotore 1 "III", Rotore 2 "I", Rotore 3 "II", Riflettore "UKW-A".</p>
<p>Normalmente ci sono un riflettore e tre rotori per un totale di quattro, ma Enigma M4 può impostare un "riflettore sottile" e un "rotore sottile" nello slot del riflettore. In DenCode, il "riflettore sottile" viene trattato come un normale riflettore e il "rotore sottile" (Beta, Gamma) viene visualizzato aggiuntivamente come Rotore 4, per un totale di 5 impostazioni. Tuttavia, se il riflettore è UKW-D, occupa lo slot del riflettore, quindi il Rotore 4 non può essere impostato.</p>

<h4>Impostazione Anelli (Ringstellung)</h4>
<p>Imposta gli anelli dei rotori. Questa impostazione modifica la posizione del cablaggio interno del rotore rispetto all'anello. In alcune macchine Enigma, è possibile impostare l'anello anche per il riflettore.</p>

<h4>Impostazione Posizione (Grundstellung)</h4>
<p>Imposta la posizione iniziale dei rotori. In alcune macchine Enigma, è possibile impostare la posizione iniziale anche per il riflettore.</p>
<p>A volte viene chiamata "Message key" perché veniva cambiata per ogni messaggio.</p>

<h4>Cablaggio Pannello a prese (Steckerverbindungen)</h4>
<p>Imposta le coppie di cablaggio del pannello a prese.</p>
<p>In DenCode, il cablaggio viene specificato elencando le coppie di 2 caratteri da scambiare separate da spazi, come "AB CD EF GH IJ KL". In questo esempio, rappresenta le coppie di cablaggio "A" e "B", "C" e "D", ecc.</p>

<h4>Uhr</h4>
<p>Uhr è un accessorio che si collega al pannello a prese e seleziona il cablaggio tra 40 modi da "00" a "39". Il pannello a prese e l'Uhr sono collegati da 20 cavi. I cavi sono in coppie e ci sono 10 coppie. Se l'impostazione dell'Uhr è "00", equivale al caso in cui quelle coppie di cavi siano cablate direttamente sul pannello a prese.</p>
<p>L'Uhr può essere impostato solo su Enigma I. L'impostazione dell'Uhr diventa possibile specificando prima 10 set di coppie di cablaggio sul pannello a prese.</p>

<h4>Cablaggio UKW-D</h4>
<p>UKW-D è un riflettore con cablaggio interno modificabile.</p>
<p>La notazione normale dell'anello del riflettore è "ABCDEFGHIJKLMNOPQRSTUVWXYZ", ma la notazione di UKW-D è in un ordine speciale "A-ZXWVUTSRQPON-MLKIHGFEDCB". I due "-" nella notazione (BO nella notazione normale) sono fissi e sono sempre cablati l'uno all'altro e non possono essere modificati. Si impostano le altre 24 lettere in 12 coppie.</p>

<pre>
Notazione UKW-D  : A-ZXWVUTSRQPON-MLKIHGFEDCB
Notazione Normale: ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-D può essere impostato per Enigma I, Enigma M4 ed Enigma KD.</p>
