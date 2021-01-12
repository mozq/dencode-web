<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>W3C-DTF日時について</h3>
<p>W3C-DTFは、<a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3CのNOTE-datetime</a>で定義された日時表記の形式です。ISO 8601の一部の形式のみに限定したサブセットです。</p>
<p>日付と時刻を「T」で繋げて表記します。タイムゾーンはUTCからの差分時刻として「+09:00」のように表記し、UTCの場合は「Z」で表します。</p>
<p>秒とミリ秒の間はドット(.)で区切ります。</p>

<p>W3C-DTFは、HTTPヘッダーやRSSなどの日時表記として使用されています。</p>

<p>例えば、2000年1月23日 1時23分45.678秒(JST; +09:00) をW3C-DTFに変換し場合は以下の結果になります。</p>

<pre>2000-01-23T01:23:45.678+09:00</pre>
