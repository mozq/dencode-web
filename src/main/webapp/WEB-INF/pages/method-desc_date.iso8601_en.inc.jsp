<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About ISO 8601 date and time</h3>
<p>ISO 8601 is a date and time notation format defined by ISO as an international standard.</p>
<p>The date and time are connected by "T" and written. The time zone is expressed as "+09:00" as the difference time from UTC, and in the case of UTC, it is expressed as "Z".</p>
<p>Separate seconds and milliseconds with a comma (,) or dot (.). DenCode omits milliseconds when milliseconds are 000.</p>

<p>ISO 8601 comes in several formats.</p>
<p>For example, converting January 23, 2000 1:23:45.678 (JST; +09:00) to ISO 8601 results in the following:</p>

<div class="table-responsive">
	<table class="table">
		<tr><th>Format</th><th>Conversion result</th></tr>
		<tr><td>Basic format</td><td>20000123T012345.678+0900</td></tr>
		<tr><td>Extended format</td><td>2000-01-23T01:23:45.678+09:00</td></tr>
		<tr><td>Week dates (year - week - day of the week)</td><td>2000-W03-7T01:23:45.678+09:00</td></tr>
		<tr><td>Ordinal dates (year - day of the year)</td><td>2000-023T01:23:45.678+09:00</td></tr>
	</table>
</div>
