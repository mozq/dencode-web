<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 W3C-DTF 日期</h3>
<p>W3C-DTF 是 <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3C 的 NOTE-datetime</a> 中定義的日期表示格式。它是 ISO 8601 部分格式的子集。</p>
<p>日期和時間用「T」連接表示。時區作為與 UTC 的差值表示為「+08:00」，如果是 UTC 則用「Z」表示。</p>
<p>秒和毫秒之間用點 (.) 分隔。</p>

<p>W3C-DTF 用於 HTTP 標頭或 RSS 等的日期表示。</p>

<p>例如，將 2000年1月23日 1時23分45.678秒 (CST; +08:00) 轉換為 W3C-DTF 的結果如下。</p>

<pre>2000-01-23T01:23:45.678+08:00</pre>
