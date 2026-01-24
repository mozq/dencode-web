<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>Sobre los números japoneses (Kansuji)</h3>
<p>Representa valores numéricos con números japoneses (Kansuji). Hay dos tipos de Kansuji: los que se usan comúnmente en el Japón moderno y los que usan caracteres antiguos llamados "Daiji".</p>

<p>Ejemplos de Kansuji modernos y Daiji son los siguientes:</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Arábigo</th><th>Kansuji</th><th>Kansuji (Daiji)</th></tr>
		</thead>
		<tbody>
			<tr><td class="text-right">1234</td><td>千二百三十四</td><td>壱阡弐陌参拾肆</td></tr>
			<tr><td class="text-right">12345.67890</td><td>一万二千三百四十五・六七八九〇</td><td>壱萬弐阡参陌肆拾伍・陸漆捌玖零</td></tr>
			<tr><td class="text-right">1234567890</td><td>十二億三千四百五十六万七千八百九十</td><td>壱拾弐億参阡肆陌伍拾陸萬漆阡捌陌玖拾</td></tr>
			<tr><td class="text-right">500000000000000000 (5 * 10<sup>17</sup>)</td><td>五十京</td><td>伍拾京</td></tr>
		</tbody>
	</table>
</div>

<p>En Kansuji, los números del 0 al 9 se representan con los siguientes caracteres:</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Arábigo</th><th>Kansuji</th><th>Kansuji (Daiji)</th></tr>
		</thead>
		<tbody>
			<tr><td class="text-right">0</td><td>〇</td><td>零</td></tr>
			<tr><td class="text-right">1</td><td>一</td><td>壱</td></tr>
			<tr><td class="text-right">2</td><td>二</td><td>弐</td></tr>
			<tr><td class="text-right">3</td><td>三</td><td>参</td></tr>
			<tr><td class="text-right">4</td><td>四</td><td>肆</td></tr>
			<tr><td class="text-right">5</td><td>五</td><td>伍</td></tr>
			<tr><td class="text-right">6</td><td>六</td><td>陸</td></tr>
			<tr><td class="text-right">7</td><td>七</td><td>漆</td></tr>
			<tr><td class="text-right">8</td><td>八</td><td>捌</td></tr>
			<tr><td class="text-right">9</td><td>九</td><td>玖</td></tr>
		</tbody>
	</table>
</div>

<p>Para números de 10 o más, cada dígito se representa con los siguientes caracteres. En Kansuji, el nombre del dígito cambia cada 4 dígitos (sistema de miríadas).</p>

<div class="table-responsive">
	<table class="table">
		<thead>
			<tr><th>Dígito</th><th>Kansuji</th><th>Kansuji (Daiji)</th></tr>
		</thead>
		<tbody>
			<tr><td>10<sup>1</sup></td><td>十</td><td>拾</td></tr>
			<tr><td>10<sup>2</sup></td><td>百</td><td>陌</td></tr>
			<tr><td>10<sup>3</sup></td><td>千</td><td>阡</td></tr>
			<tr><td>10<sup>4</sup></td><td>万</td><td>萬</td></tr>
			<tr><td>10<sup>8</sup></td><td colspan="2">億</td></tr>
			<tr><td>10<sup>12</sup></td><td colspan="2">兆</td></tr>
			<tr><td>10<sup>16</sup></td><td colspan="2">京</td></tr>
			<tr><td>10<sup>20</sup></td><td colspan="2">垓</td></tr>
			<tr><td>10<sup>24</sup></td><td colspan="2">秭</td></tr>
			<tr><td>10<sup>28</sup></td><td colspan="2">穣</td></tr>
			<tr><td>10<sup>32</sup></td><td colspan="2">溝</td></tr>
			<tr><td>10<sup>36</sup></td><td colspan="2">澗</td></tr>
			<tr><td>10<sup>40</sup></td><td colspan="2">正</td></tr>
			<tr><td>10<sup>44</sup></td><td colspan="2">載</td></tr>
			<tr><td>10<sup>48</sup></td><td colspan="2">極</td></tr>
			<tr><td>10<sup>52</sup></td><td colspan="2">恒河沙</td></tr>
			<tr><td>10<sup>56</sup></td><td colspan="2">阿僧祇</td></tr>
			<tr><td>10<sup>60</sup></td><td colspan="2">那由他</td></tr>
			<tr><td>10<sup>64</sup></td><td colspan="2">不可思議</td></tr>
			<tr><td>10<sup>68</sup></td><td colspan="2">無量大数</td></tr>
		</tbody>
	</table>
</div>

<p>Para 10, 100 y 1000, es común omitir el "uno" y escribir "十", "百", "千" en lugar de "一十", "一百", "一千". Sin embargo, en el caso de Daiji, a veces se escribe explícitamente "壱".</p>

<p>Los decimales se representan después de "・" utilizando notación posicional.</p>

<p>Entre los Daiji anteriores, las leyes japonesas solo definen "壱", "弐", "参", y "拾".</p>

<p>En Daiji, los dígitos mayores a "億" no están definidos, pero en DenCode se representan con los mismos nombres de dígitos que en Kansuji normal.</p>
