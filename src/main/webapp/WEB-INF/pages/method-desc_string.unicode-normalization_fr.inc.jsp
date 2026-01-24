<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>À propos de la normalisation Unicode</h3>
<p>La normalisation Unicode est le processus de décomposition et de composition des caractères. Certains caractères Unicode ont la même apparence mais peuvent être représentés de plusieurs manières. Par exemple, "â" peut être représenté comme un seul point de code "â" (U+00E2) ou comme deux points de code décomposés "a" (U+0061) et " ̂" (U+0302) (caractère de base + caractère combiné). Le premier est appelé caractère précomposé et le second est appelé séquence de caractères combinés (combining character sequence, CCS).</p>
<p>Il existe les types de normalisation Unicode suivants.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Forme de normalisation</th><th scope="col">Description</th><th scope="col">Exemple</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>Décomposition canonique</td><td>"â"(U+00E2) -&gt; "a"(U+0061) + " ̂"(U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>Décomposition de compatibilité</td><td>"ﬁ"(U+FB01) -&gt; "f"(U+0066) + "i"(U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>Décomposition canonique suivie de la composition canonique</td><td>"â"(U+00E2) -&gt; "a"(U+0061) + " ̂"(U+0302) -&gt; "â"(U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>Décomposition de compatibilité suivie de la composition canonique</td><td>"ﬁ"(U+FB01) -&gt; "f"(U+0066) + "i"(U+0069) -&gt; "f"(U+0066) + "i"(U+0069)</td></tr>
	</table>
</div>

<p>L'équivalence canonique normalise tout en préservant les caractères visuellement et fonctionnellement équivalents. Ex. "â" &lt;-&gt; "a" + " ̂"</p>
<p>L'équivalence de compatibilité normalise également les caractères qui prennent des formes sémantiquement différentes, en plus de l'équivalence canonique. Ex. "ﬁ" -&gt; "f" + "i"</p>
