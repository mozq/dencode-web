<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 W3C-DTF 日期</h3>
<p>W3C-DTF 是 <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3C 的 NOTE-datetime</a> 中定义的日期表示格式。它是 ISO 8601 部分格式的子集。</p>
<p>日期和时间用“T”连接表示。时区作为与 UTC 的差值表示为“+09:00”，如果是 UTC 则用“Z”表示。</p>
<p>秒和毫秒之间用点 (.) 分隔。</p>

<p>W3C-DTF 用于 HTTP 头部或 RSS 等的日期表示。</p>

<p>例如，将 2000年1月23日 1时23分45.678秒 (CST; +08:00) 转换为 W3C-DTF 的结果如下。</p>

<pre>2000-01-23T01:23:45.678+08:00</pre>
