<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>關於 ISO 8601 日期</h3>
<p>ISO 8601 是由 ISO 定義的作為國際標準的日期表示格式。</p>
<p>日期和時間用「T」連接表示。時區作為與 UTC 的差值表示為「+08:00」，如果是 UTC 則用「Z」表示。</p>
<p>秒和毫秒之間用逗號 (,) 或點 (.) 分隔。在 DenCode 中，如果毫秒為 000，則省略毫秒。</p>

<p>ISO 8601 有幾種格式。</p>
<p>例如，將 2000年1月23日 1時23分45.678秒 (CST; +08:00) 轉換為 ISO 8601 的結果如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>格式</th><th>轉換結果</th></tr>
		<tr><td>基本格式</td><td>20000123T012345.678+0800</td></tr>
		<tr><td>擴充格式</td><td>2000-01-23T01:23:45.678+08:00</td></tr>
		<tr><td>週 (年-週-星期)</td><td>2000-W03-7T01:23:45.678+08:00</td></tr>
		<tr><td>日 (年-年內日)</td><td>2000-023T01:23:45.678+08:00</td></tr>
	</table>
</div>
