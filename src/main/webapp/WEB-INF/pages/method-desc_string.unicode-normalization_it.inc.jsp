<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Informazioni sulla Normalizzazione Unicode</h3>
<p>La normalizzazione Unicode è il processo di scomposizione e composizione dei caratteri. Alcuni caratteri Unicode hanno lo stesso aspetto ma più rappresentazioni. Ad esempio, "â" può essere rappresentato come un singolo punto di codice "â" (U+00E2) o come due punti di codice scomposti "a" (U+0061) e " ̂" (U+0302) (carattere base + carattere combinante). Il primo è chiamato carattere precomposto e il secondo sequenza di caratteri combinanti (CCS).</p>
<p>Esistono i seguenti tipi di normalizzazione Unicode:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Forma di normalizzazione</th><th scope="col">Descrizione</th><th scope="col">Esempio</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>Scomposizione canonica</td><td>"â"(U+00E2) -&gt; "a"(U+0061) + " ̂"(U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>Scomposizione di compatibilità</td><td>"ﬁ"(U+FB01) -&gt; "f"(U+0066) + "i"(U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>Scomposizione canonica seguita da composizione canonica</td><td>"â"(U+00E2) -&gt; "a"(U+0061) + " ̂"(U+0302) -&gt; "â"(U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>Scomposizione di compatibilità seguita da composizione canonica</td><td>"ﬁ"(U+FB01) -&gt; "f"(U+0066) + "i"(U+0069) -&gt; "f"(U+0066) + "i"(U+0069)</td></tr>
	</table>
</div>

<p>L'equivalenza canonica normalizza mantenendo caratteri visivamente e funzionalmente equivalenti. Es. "â" &lt;-&gt; "a" + " ̂"</p>
<p>L'equivalenza di compatibilità include, oltre all'equivalenza canonica, anche caratteri che assumono forme semanticamente diverse come oggetto della normalizzazione. Es. "ﬁ" -&gt; "f" + "i"</p>
