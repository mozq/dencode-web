<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><h3>About W3C-DTF date and time</h3>
<p>W3C-DTF is a date and time notation format defined by <a href="https://www.w3.org/TR/NOTE-datetime" target="_blank">W3C NOTE-datetime</a>. A subset limited to only some formats of ISO 8601.</p>
<p>The date and time are connected by "T" and written. The time zone is expressed as "+09:00" as the difference time from UTC, and in the case of UTC, it is expressed as "Z".</p>
<p>Separate seconds and milliseconds with a dot (.).</p>

<p>W3C-DTF is used as a date and time notation for HTTP headers and RSS.</p>

<p>For example, converting January 23, 2000 1:23:45.678 (JST; +09:00) to W3C-DTF results in the following:</p>

<pre>2000-01-23T01:23:45.678+09:00</pre>
