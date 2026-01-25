<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>W3C-DTF 일시에 대해서</h3>
<p>W3C-DTF는 <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3C의 NOTE-datetime</a>에서 정의된 일시 표기 형식입니다. ISO 8601의 일부 형식만으로 한정한 서브셋(Subset)입니다.</p>
<p>날짜와 시각을 'T'로 연결하여 표기합니다. 타임존은 UTC와의 차분 시각으로 '+09:00'과 같이 표기하고, UTC의 경우는 'Z'로 나타냅니다.</p>
<p>초와 밀리초 사이는 점(.)으로 구분합니다.</p>

<p>W3C-DTF는 HTTP 헤더나 RSS 등의 일시 표기로 사용되고 있습니다.</p>

<p>예를 들어, 2000년 1월 23일 1시 23분 45.678초(JST; +09:00)를 W3C-DTF로 변환한 경우 다음과 같은 결과가 됩니다.</p>

<pre>2000-01-23T01:23:45.678+09:00</pre>
