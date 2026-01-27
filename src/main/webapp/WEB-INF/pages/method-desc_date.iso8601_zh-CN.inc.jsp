<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>关于 ISO 8601 日期</h3>
<p>ISO 8601 是由 ISO 定义的作为国际标准的日期表示格式。</p>
<p>日期和时间用“T”连接表示。时区作为与 UTC 的差值表示为“+09:00”，如果是 UTC 则用“Z”表示。</p>
<p>秒和毫秒之间用逗号 (,) 或点 (.) 分隔。在 DenCode 中，如果毫秒为 000，则省略毫秒。</p>

<p>ISO 8601 有几种格式。</p>
<p>例如，将 2000年1月23日 1时23分45.678秒 (CST; +08:00) 转换为 ISO 8601 的结果如下。</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>格式</th><th>转换结果</th></tr>
		<tr><td>基本格式</td><td>20000123T012345.678+0800</td></tr>
		<tr><td>扩展格式</td><td>2000-01-23T01:23:45.678+08:00</td></tr>
		<tr><td>周 (年-周-星期)</td><td>2000-W03-7T01:23:45.678+08:00</td></tr>
		<tr><td>日 (年-年内日)</td><td>2000-023T01:23:45.678+08:00</td></tr>
	</table>
</div>
