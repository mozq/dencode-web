<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos d'Ascii85</h3>
<p>Ascii85 est un schéma de codage utilisant des caractères ASCII imprimables sur 7 bits. Il est également appelé Base85.</p>
<p>Dans Ascii85, les données sont divisées en groupes de 4 octets et converties en 5 caractères ASCII.</p>
<p>Il existe diverses variantes d'Ascii85. DenCode prend en charge les trois types d'Ascii85 suivants. L'original est btoa, suivi plus tard par Adobe et Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Aperçu</th></tr>
		<tr><th>Z85</th><td>Utilisé dans ZeroMQ. Conçu pour éviter d'utiliser des caractères nécessitant un échappement tels que "\" (barre oblique inverse) et "'" (apostrophe).</td></tr>
		<tr><th>Adobe</th><td>Utilisé pour encoder des images, etc. dans les fichiers PostScript et PDF (Portable Document Format) d'Adobe. Entouré de "&lt;~" et "~&gt;".</td></tr>
		<tr><th>btoa</th><td>Format de la commande btoa sous UNIX. Utilisé dans le passé pour l'échange de données binaires, mais n'est plus courant aujourd'hui. Entouré des lignes "xbtoa Begin" et "xbtoa End".</td></tr>
	</table>
</div>

<p>Les caractères ASCII utilisés dans Ascii85 sont les suivants. Une valeur de 4 octets est traitée comme un entier non signé big-endian, calculée pour chaque chiffre en base 85 (5 chiffres), et le résultat de la conversion Ascii85 est déterminé sur la base des caractères ASCII suivants.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Caractères ASCII</th></tr>
		<tr><th>Z85</th><td>0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-:+=^!/*?&amp;&lt;&gt;()[]{}@%$#</td></tr>
		<tr><th>Adobe</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu</td></tr>
		<tr><th>btoa</th><td>!"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu<br />(À l'origine, c'était les caractères de " " (espace) à "t", mais comme certains clients de messagerie supprimaient les espaces de fin, ils ont été remplacés plus tard par les caractères de "!" à "u" excluant l'espace.)</td></tr>
	</table>
</div>

<p>Par exemple, la conversion de "Hello" en Ascii85 donne ce qui suit.</p>

<p>1. Diviser par 4 octets. S'il y a moins de 4 octets, remplir la fin avec "00".</p>

<pre>48656C6C<sub>(16)</sub> 6F000000<sub>(16)</sub>  (Hell o)</pre>

<p>2. Traiter chaque bloc de 4 octets comme un entier non signé big-endian et convertir cette valeur en chaque chiffre de la base 85.</p>

<pre>48656C6C<sub>(16)</sub>
= 1214606444<sub>(10)</sub>
= <b>23</b> * 85<sup>4</sup> + <b>22</b> * 85<sup>3</sup> + <b>66</b> * 85<sup>2</sup> + <b>52</b> * 85 + <b>49</b></pre>

<pre>6F000000<sub>(16)</sub>
= 1862270976<sub>(10)</sub>
= <b>35</b> * 85<sup>4</sup> + <b>57</b> * 85<sup>3</sup> + <b>33</b> * 85<sup>2</sup> + <b>65</b> * 85 + <b>26</b></pre>

<p>3. Convertir chaque chiffre de la base 85 en caractère ASCII. Si la fin a été remplie avec "00", exclure le remplissage pour Adobe/Z85.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><td>23</td><td>22</td><td>66</td><td>52</td><td>49</td><td></td><td>35</td><td>57</td><td>33</td><td>65</td><td>26</td></tr>
		<tr><th>Z85</th><td>n</td><td>m</td><td>=</td><td>Q</td><td>N</td><td></td><td>z</td><td>V</td><td></td><td></td><td></td></tr>
		<tr><th>Adobe</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td></td><td></td><td></td></tr>
		<tr><th>btoa</th><td>8</td><td>7</td><td>c</td><td>U</td><td>R</td><td></td><td>D</td><td>Z</td><td>B</td><td>b</td><td>;</td></tr>
	</table>
</div>

<p>4. Concaténer tous les caractères pour obtenir le résultat de la conversion Ascii85. Adobe entoure avec "&lt;~" &amp; "~&gt;" et ajoute un saut de ligne tous les 80 caractères. btoa entoure avec "xbtoa Begin" &amp; "xbtoa End" (incluant la longueur des données et la somme de contrôle) et ajoute un saut de ligne tous les 78 caractères.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Résultat de la conversion</th></tr>
		<tr><th>Z85</th><td>nm=QNzV</td></tr>
		<tr><th>Adobe</th><td>&lt;~87cURDZ~&gt;</td></tr>
		<tr><th>btoa</th><td>xbtoa Begin<br />87cURDZBb;<br />xbtoa End N 5 5 E 42 S 1f9 R a9f</td></tr>
	</table>
</div>

<p>De plus, plusieurs formes raccourcies sont définies.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th></th><th>Forme raccourcie</th></tr>
		<tr><th>Z85</th><td>Aucune</td></tr>
		<tr><th>Adobe</th><td>00000000<sub>(16)</sub> -&gt; z</td></tr>
		<tr><th>btoa</th><td>00000000<sub>(16)</sub> -&gt; z<br />20202020<sub>(16)</sub> -&gt; y (btoa v4.2 ou ultérieur)<br /></td></tr>
	</table>
</div>
