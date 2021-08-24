<%@ page contentType="application/xml; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="mf" uri="http://mifmi.org/jsp/taglib/functions"
%><?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:xhtml="http://www.w3.org/1999/xhtml">
	<c:forEach var="path" items="${supportedMethodPaths}">
		<url>
			<loc>${baseURL}${pageContext.request.contextPath}/${mf:h(path)}</loc>
			<c:forEach var="loc" items="${supportedLocaleMap}">
				<xhtml:link rel="alternate" hreflang="${mf:h(loc.key)}" href="${baseURL}${pageContext.request.contextPath}/${mf:h(loc.key)}/${mf:h(path)}" />
			</c:forEach>
		</url>
	</c:forEach>
</urlset>
