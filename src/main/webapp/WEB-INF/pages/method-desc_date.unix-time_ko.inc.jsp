<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>UNIX Time에 대해서</h3>
<p>UNIX Time(POSIX Time, Epoch 초)은 UNIX Epoch인 1970년 1월 1일 0시 0분 0초(UTC)부터의 윤초를 포함하지 않은 경과 초수입니다.</p>
<p>UNIX Epoch 이전의 시각은 마이너스 값으로 나타냅니다.</p>
<p>DenCode에서는 UNIX 시각을 초 단위로 다룹니다. 밀리초나 마이크로초는 소수점 이하의 수치로 나타냅니다.</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>일시</th><th>UNIX Time</th></tr>
		<tr><td>1900-01-01 00:00:00 UTC</td><td>-2208988800</td></tr>
		<tr><td>1970-01-01 00:00:00 UTC (UNIX Epoch)</td><td>0</td></tr>
		<tr><td>2000-01-23 01:23:45.678 UTC</td><td>948590625.678</td></tr>
	</table>
</div>
