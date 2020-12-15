<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>シーザー暗号について</h3>
<p>シーザー暗号は、文章の文字を他の文字に置換することで暗号化する単一換字式暗号のひとつです。</p>
<p>文字の置換は、「A」から「Z」までの文字を「ABCDEFGHIJKLMNOPQRSTUVWXYZ」の26文字の中で左または右にシフトさせることで行います。</p>
<p>例えば、左に3文字シフトする場合は「A」は「D」、「Z」は「C」に暗号化されます。</p>

<pre>暗号化前: ABCDEFGHIJKLMNOPQRSTUVWXYZ
暗号化後: DEFGHIJKLMNOPQRSTUVWXYZABC</pre>

<pre>暗号化前の文章: THIS IS A SECRET MESSAGE
暗号化後の文章: WKLV LV D VHFUHW PHVVDJH</pre>

<p>シフトする数が暗号のキーになります。</p>
<p>英字のみが暗号化され、数字や記号などは暗号化されません。</p>
<p>シフトする数が13の場合、<a href="rot13">ROT13</a>と同じ結果になります。</p>

<p>ダイアクリティカルマークを保持した状態で文字をシフトします。そのため、例えば「Á」は「D́」に暗号化されます。</p>


<h4>その他の言語サポート</h4>
<p>ラテン文字の他に、キリル文字をサポートしています。</p>

<p>キリル文字を左に3文字シフトする場合は以下のように暗号化されます。</p>

<pre>暗号化前: АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
暗号化後: ГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯАБВ</pre>

<p>ダイアクリティカルマークを保持した状態で文字をシフトします。そのため、例えばロシア語の「Ё」は「Ӥ」に暗号化されます。「Й」および「й」の文字は、「И」「и」にダイアクリティカルマークである「 ̆」(Breve)が付いた文字ではなく、固有の1文字として扱われます。</p>