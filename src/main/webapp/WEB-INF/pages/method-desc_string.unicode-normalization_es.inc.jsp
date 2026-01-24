<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre la normalización Unicode</h3>
<p>La normalización Unicode se refiere a la descomposición y composición de caracteres. Algunos caracteres Unicode tienen múltiples representaciones aunque parezcan iguales. Por ejemplo, "â" se puede representar como un punto de código "â" (U+00E2), o como dos puntos de código descompuestos "a" (U+0061) y " ̂" (U+0302) (carácter base + carácter de combinación). El primero se llama carácter precompuesto y el segundo secuencia de caracteres de combinación (CCS).</p>
<p>Existen los siguientes tipos de normalización Unicode:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th scope="col">Forma de Normalización</th><th scope="col">Descripción</th><th scope="col">Ejemplo</th></tr>
		<tr><td>Normalization Form D (NFD)</td><td>Descomposición canónica</td><td>"â" (U+00E2) -&gt; "a" (U+0061) + " ̂" (U+0302)</td></tr>
		<tr><td>Normalization Form KD (NFKD)</td><td>Descomposición de compatibilidad</td><td>"ﬁ" (U+FB01) -&gt; "f" (U+0066) + "i" (U+0069)</td></tr>
		<tr><td>Normalization Form C (NFC)</td><td>Descomposición canónica seguida de composición canónica</td><td>"â" (U+00E2) -&gt; "a" (U+0061) + " ̂" (U+0302) -&gt; "â" (U+00E2)</td></tr>
		<tr><td>Normalization Form KC (NFKC)</td><td>Descomposición de compatibilidad seguida de composición canónica</td><td>"ﬁ" (U+FB01) -&gt; "f" (U+0066) + "i" (U+0069) -&gt; "f" (U+0066) + "i" (U+0069)</td></tr>
	</table>
</div>

<p>La equivalencia canónica normaliza manteniendo caracteres visual y funcionalmente equivalentes. Ej. "â" &lt;-&gt; "a" + " ̂"</p>
<p>La equivalencia de compatibilidad, además de la equivalencia canónica, también normaliza caracteres que tienen formas semánticamente diferentes. Ej. "ﬁ" -&gt; "f" + "i"</p>
