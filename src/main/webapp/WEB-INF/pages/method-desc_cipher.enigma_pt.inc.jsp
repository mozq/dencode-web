<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre a Cifra Enigma</h3>
<p>A Cifra Enigma é um tipo de cifra de substituição que criptografa substituindo caracteres por outros caracteres. Suporta a criptografia de 26 letras de "A" a "Z".</p>
<p>A substituição de caracteres é realizada usando a Máquina Enigma. O DenCode suporta simulações das seguintes máquinas Enigma:</p>

<ul>
	<li>Enigma I</li>
	<li>Enigma M3</li>
	<li>Enigma M4 (U-boat Enigma)</li>
	<li>Norway Enigma "Norenigma"</li>
	<li>Sondermaschine (Máquina Especial)</li>
	<li>Enigma G "Zählwerk Enigma" (A28/G31)</li>
	<li>Enigma G G-312 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-260 (G31 Abwehr Enigma)</li>
	<li>Enigma G G-111 (G31 Hungarian Enigma)</li>
	<li>Enigma D (Commercial Enigma A26)</li>
	<li>Enigma K (Commercial Enigma A27)</li>
	<li>Enigma KD (Enigma K com UKW-D)</li>
	<li>Swiss-K (Swiss Enigma K variante)</li>
	<li>Railway Enigma "Rocket I"</li>
	<li>Enigma T "Tirpitz" (Japanese Enigma)</li>
	<li>Spanish Enigma, fiação D</li>
	<li>Spanish Enigma, fiação F</li>
	<li>Spanish Enigma, Delta (A 16081)</li>
	<li>Spanish Enigma, Sonderschaltung / Delta (A 16101)</li>
</ul>

<p>A máquina Enigma é configurada da seguinte forma: Um caractere inserido no teclado (Tastatur) passa pelo painel de conexões (Steckerbrett), pela roda de entrada (ETW, Eintrittswalze), por 3 ou 4 rotores (Walze), pelo refletor (UKW, Umkehrwalze), e então segue o caminho inverso, e o resultado criptografado é exibido no painel de lâmpadas (Lampenfeld). A substituição de caracteres ocorre em todos os lugares, incluindo os rotores.</p>

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

<p>A roda de entrada, os rotores e o refletor são conectados internamente para converter 26 caracteres de "A" a "Z" em outros caracteres, e a substituição é realizada energizando a fiação. Por exemplo, o rotor "I" da Enigma I tem a seguinte fiação, e o caractere "A" é substituído por "E". Além disso, se o caractere retornado do refletor for "J", ele segue a fiação inversa e é substituído por "Z".</p>

<pre>
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ
</pre>

<p>Toda a fiação da Enigma I é a seguinte:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Roda</th><th>ABCDEFGHIJKLMNOPQRSTUVWXYZ</th></tr>
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

<p>O painel de conexões é um mecanismo que permite ao usuário realizar a substituição através de fiação. Algumas máquinas Enigma têm um painel de conexões antes da ETW. O painel de conexões tem terminais de entrada/saída para 26 letras de "A" a "Z", e conectando quaisquer duas letras com um cabo, esses dois caracteres podem ser trocados. Por exemplo, se "A" e "M" estiverem conectados com um cabo, "A" é substituído por "M", e "M" é substituído por "A". Caracteres nos terminais de entrada/saída que não estão conectados com cabos não são substituídos.</p>
<p>Digitar um caractere no teclado gira o rotor um passo. A rotação do rotor começa pelo rotor do lado direito, e quando ele gira para a posição do entalhe no rotor, o rotor esquerdo também gira um passo. Essa rotação do rotor altera a fiação para criptografia caractere por caractere, de modo que, mesmo que o mesmo caractere seja inserido, ele será substituído por um caractere diferente da vez anterior.</p>
<p>Os rotores têm um anel, e caracteres de "A" a "Z" (ou "01" a "26") estão gravados na circunferência externa do anel. O anel permite definir o deslocamento entre os caracteres na circunferência externa e a fiação interna do rotor em 26 passos. Por exemplo, no caso do rotor "I" da "Enigma I", se a configuração do anel for "A (01)", "A" é substituído por "E", mas se a configuração do anel for "B (02)", a fiação interna muda em 1, então, como a fiação original Z-J, "A" é substituído por "K".</p>

<pre>
Anel: A (01)
ABCDEFGHIJKLMNOPQRSTUVWXYZ
||||||||||||||||||||||||||
EKMFLGDQVZNTOWYHXUSPAIBRCJ

Anel: B (02)
BCDEFGHIJKLMNOPQRSTUVWXYZA
||||||||||||||||||||||||||
FLNGMHERWAOUPXZIYVTQBJCSDK
</pre>

<p>Os rotores podem ter sua ordem e posição inicial de rotação configuradas. Por exemplo, se houver 3 tipos de rotores "I", "II" e "III", eles podem ser configurados na máquina Enigma em uma ordem como "II", "I", "III", e a posição inicial de cada rotor pode ser definida entre "A (01)" e "Z (26)". Quanto ao refletor, algumas máquinas Enigma permitem trocar refletores de múltiplos tipos com fiações diferentes, ou configurar a posição inicial. A roda de entrada é fixa e não pode ser alterada. Máquinas Enigma com painel de conexões também permitem configurar o painel de conexões. Essas configurações tornam-se a chave para a criptografia pela máquina Enigma.</p>
<p>Um exemplo de criptografia com Enigma I é mostrado abaixo.</p>

<pre>
Rodas              : UKW-A II I III
Config. Anéis      : X M V  (24 13 22)
Config. Posição    : A B L  (01 02 12)
Painel de Conexões : AM FI NV PS TU WZ

Antes da Criptografia  : SECRET
Depois da Criptografia : LCGODU
</pre>

<p>Neste caso, a primeira letra "S" é substituída na seguinte sequência, e finalmente criptografada para "L".</p>

<pre>
S -&gt; P  : Painel de Conexões
P -&gt; P  : ETW
P -&gt; L  : III
L -&gt; P  : I
P -&gt; W  : II
W -&gt; K  : UKW-A
K -&gt; Q  : II
Q -&gt; O  : I
O -&gt; L  : III
L -&gt; L  : ETW
L -&gt; L  : Painel de Conexões
</pre>

<p>Além disso, se a posição de rotação do rotor e a posição de Entrada (+) / Saída (-) forem representadas por caracteres no anel, elas são as seguintes: (Como o rotor está girando, o "caractere substituído" acima e o "caractere como posição no anel" são diferentes.)</p>

<pre>
           -      +       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Painel de Conexões
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

<p>A máquina Enigma tem a característica de que, se a criptografia for realizada novamente no texto cifrado com as mesmas configurações, o texto simples original é obtido. Portanto, inserir "L", que foi criptografado no exemplo acima, produz o "S" original.</p>

<pre>
L -&gt; L  : Painel de Conexões
L -&gt; L  : ETW
L -&gt; O  : III
O -&gt; Q  : I
Q -&gt; K  : II
K -&gt; W  : UKW-A
W -&gt; P  : II
P -&gt; L  : I
L -&gt; P  : III
P -&gt; P  : ETW
P -&gt; S  : Painel de Conexões
</pre>

<pre>
           +      -       
ABCDEFGHIJKLMNOPQRSTUVWXYZ  : Painel de Conexões
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


<h3>Itens de configuração no DenCode</h3>

<h4>Rodas (Walzenlage)</h4>
<p>Define o tipo de refletor e rotores, e a ordem dos rotores.</p>
<p>Como a entrada é do lado direito da máquina Enigma, os rotores são contados 1, 2, 3 da direita, mas ao anotar a configuração da ordem das rodas, geralmente é escrito da esquerda para a direita. Por exemplo, uma ordem de roda "UKW-A II I III" representa a configuração do rotor 1 "III", rotor 2 "I", rotor 3 "II" e refletor "UKW-A".</p>
<p>Normalmente, há 1 refletor e 3 rotores, totalizando 4, mas a Enigma M4 permite configurar um "refletor fino" e um "rotor fino" no slot do refletor. No DenCode, o "refletor fino" é tratado da mesma forma que um refletor normal, e o "rotor fino" (Beta, Gamma) é exibido adicionalmente como rotor 4, totalizando 5 configurações. No entanto, se o refletor for UKW-D, o rotor 4 não pode ser configurado porque ocupa o slot do refletor.</p>

<h4>Configuração dos anéis (Ringstellung)</h4>
<p>Define os anéis dos rotores. Esta configuração altera a posição da fiação interna do rotor em relação ao anel. Em algumas máquinas Enigma, o anel do refletor também pode ser configurado.</p>

<h4>Configuração da posição (Grundstellung)</h4>
<p>Define a posição inicial dos rotores. Em algumas máquinas Enigma, a posição inicial do refletor também pode ser configurada.</p>
<p>Como a configuração era alterada para cada mensagem, às vezes é chamada de "Chave da mensagem" (Message key).</p>

<h4>Painel de conexões (Steckerverbindungen)</h4>
<p>Define os pares de fiação do painel de conexões.</p>
<p>No DenCode, a fiação é especificada listando pares de 2 caracteres a serem trocados, separados por espaços, como "AB CD EF GH IJ KL". Este exemplo representa os pares de fiação "A" e "B", "C" e "D", etc.</p>

<h4>Uhr</h4>
<p>Uhr é um acessório que se conecta ao painel de conexões e permite selecionar a fiação de 40 maneiras, de "00" a "39". O painel de conexões e o Uhr são conectados por 20 cabos. Os cabos são emparelhados dois a dois, e há 10 pares. Se a configuração do Uhr for "00", é equivalente aos pares de cabos serem conectados diretamente no painel de conexões.</p>
<p>Uhr só pode ser configurado na Enigma I. A configuração do Uhr torna-se possível especificando primeiro 10 conjuntos de pares de fiação do painel de conexões.</p>

<h4>Fiação UKW-D</h4>
<p>UKW-D é um refletor com fiação interna alterável.</p>
<p>A notação do anel de um refletor normal é "ABCDEFGHIJKLMNOPQRSTUVWXYZ", mas a notação do UKW-D é uma ordem especial "A-ZXWVUTSRQPON-MLKIHGFEDCB". Os dois "-" na notação (BO na notação normal) são fixos e estão sempre conectados um ao outro e não podem ser alterados. Os outros 24 caracteres são configurados como 12 pares de fiação.</p>

<pre>
Notação UKW-D  : A-ZXWVUTSRQPON-MLKIHGFEDCB
Notação normal : ABCDEFGHIJKLMNOPQRSTUVWXYZ
</pre>

<p>UKW-D pode ser configurado para Enigma I, Enigma M4 e Enigma KD.</p>
