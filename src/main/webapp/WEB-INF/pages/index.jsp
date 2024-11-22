<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="mf" uri="http://mifmi.org/jsp/taglib/functions"
%><!DOCTYPE html>
<html lang="${mf:h(msg['lang'])}" prefix="og: http://ogp.me/ns#" data-bs-theme="">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="description" content="${mf:h(msg[mf:strcat(method, '.desc')])}" />
	<meta name="robots" content="index,follow,noarchive" />
	<meta name="application-name" content="${mf:h(msg['site.name'])}" />
	<meta name="apple-mobile-web-app-title" content="${mf:h(msg['site.name'])}" />
	<meta name="format-detection" content="address=no,date=no,email=no,telephone=no,url=no" />
	<meta property="og:site_name" content="${mf:h(msg['site.name'])}" />
	<meta property="og:url" content="${baseURL}${pageContext.request.contextPath}/${mf:h(currentPath)}" />
	<meta property="og:image" content="${baseURL}${pageContext.request.contextPath}/static/img/icons/icon-512.png" />
	<meta property="og:locale" content="${mf:h(msg['locale'])}" />
	<meta property="og:type" content="website" />
	<c:choose>
		<c:when test="${method eq 'all.all'}"><meta property="og:title" content="${mf:h(msg['site.name'])} | ${mf:h(msg[mf:strcat(method, '.title')])}" /></c:when>
		<c:otherwise><meta property="og:title" content="${mf:h(msg[mf:strcat(method, '.title')])} - ${mf:h(msg['site.name'])}" /></c:otherwise>
	</c:choose>
	<meta property="og:description" content="${mf:h(msg[mf:strcat(method, '.desc')])}" />
	<c:forEach var="loc" items="${supportedLocaleMap}">
		<link rel="alternate" hreflang="${mf:h(loc.key)}" href="${baseURL}${pageContext.request.contextPath}/${mf:h(loc.key)}/${mf:h(currentPath)}" />
	</c:forEach>
	<link rel="alternate" hreflang="x-default" href="${baseURL}${pageContext.request.contextPath}/${mf:h(currentPath)}" />
	<link rel="icon" type="image/png" sizes="192x192" href="${pageContext.request.contextPath}/static/img/icons/icon-192.png" />
	<link rel="icon" type="image/svg+xml" sizes="any" href="${pageContext.request.contextPath}/static/img/icons/icon.svg" />
	<link rel="apple-touch-icon" type="image/png" sizes="180x180" href="${pageContext.request.contextPath}/static/img/icons/apple-touch-icon.png" />
	<link rel="manifest" href="${pageContext.request.contextPath}/manifest.json" />
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha256-PI8n5gCcz9cQqQXm3PEtDuPG8qx9oFsFctPg0S5zb8g=" crossorigin="anonymous" />
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" integrity="sha256-9kPW/n5nn53j4WMRYAxe9c1rCY96Oogo/MKSVdKzPmI=" crossorigin="anonymous" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css?v=${mf:fileLastModified(pageContext.servletContext.getRealPath('/static/css/main.css'))}" />
	<script defer src="//cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha256-CDOy6cOibCWEdsRiZuaHf8dSGGJRYuBGC+mjoJimHGw=" crossorigin="anonymous"></script>
	<script defer src="${pageContext.request.contextPath}/static/js/all.min.js?v=${mf:fileLastModified(pageContext.servletContext.getRealPath('/static/js/all.min.js'))}"></script>
	<script id="scriptTesseract" data-src="//cdn.jsdelivr.net/npm/tesseract.js@5.1.1/dist/tesseract.min.js" integrity="sha256-qOKZGNCYsrBuEBK9rv+0rsBEXF1WVHCQI+C9H0QqgOg=" crossorigin="anonymous"></script>
	<script id="scriptJsqr" data-src="//cdn.jsdelivr.net/npm/jsqr@1.4.0/dist/jsQR.js" integrity="sha256-vEDIoVGWI2sjFNsIVvcsoLSZgM1UE7jIUqc0n1/uCFk=" crossorigin="anonymous"></script>
	<c:choose>
		<c:when test="${method eq 'all.all'}"><title>${mf:h(msg['site.name'])} | ${mf:h(msg[mf:strcat(method, '.title')])}</title></c:when>
		<c:otherwise><title>${mf:h(msg[mf:strcat(method, '.title')])} - ${mf:h(msg['site.name'])}</title></c:otherwise>
	</c:choose>
	<script>
		document.documentElement.setAttribute("data-bs-theme", (window.matchMedia?.("(prefers-color-scheme:dark)").matches) ? "dark" : "light");
	</script>
</head>
<body data-context-path="${pageContext.request.contextPath}" data-dencode-type="${type}" data-dencode-method="${method}">
<header>
	<nav class="navbar navbar-expand-sm">
		<div class="container-fluid">
			<a id="brand" class="navbar-brand" href="${mf:h(basePath)}/">${mf:h(msg['site.name'])}</a>
			<span class="navbar-text">Enjoy encoding &amp; decoding!</span>
			
			<div id="localeMenu" class="dropdown">
				<span class="dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-expanded="false">
					<i class="bi bi-globe2"></i>
					${mf:h(msg['locale.name'])}
					<span class="caret"></span>
				</span>
				<ul class="dropdown-menu dropdown-menu-end" role="menu">
					<li><a class="dropdown-item ${(localeId eq null) ? 'active' : ''}" href="${pageContext.request.contextPath}/${mf:h(currentPath)}">${mf:h(msg['locale.name.default'])} (${mf:h(defaultLocaleName)})</a></li>
					<li class="dropdown-divider"></li>
					<c:forEach var="loc" items="${supportedLocaleMap}">
						<li><a class="dropdown-item ${(localeId eq loc.key) ? 'active' : ''}" href="${pageContext.request.contextPath}/${mf:h(loc.key)}/${mf:h(currentPath)}">${mf:h(loc.value)}</a></li>
					</c:forEach>
				</ul>
			</div>
			
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#typeMenuCollapse" aria-controls="typeMenuCollapse" aria-label="${mf:h(msg['label.menu'])}" aria-expanded="false">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</nav>
	<nav class="navbar navbar-expand-sm">
		<div class="container-fluid">
			<div id="typeMenuCollapse" class="collapse navbar-collapse">
				<ul id="typeMenu" class="navbar-nav">
					<li class="nav-item ${(type eq 'all') ? 'active' : ''}" data-dencode-type="all">
						<a class="nav-link" href="${mf:h(basePath)}/" data-dencode-method="all.all">${mf:h(msg['all.type'])}</a>
					</li>
					<li class="nav-item dropdown ${(type eq 'string') ? 'active' : ''}" role="presentation" data-dencode-type="string">
						<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['string.type'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string" data-dencode-method="string.all">${mf:h(msg['string.all.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/bin" data-dencode-method="string.bin">${mf:h(msg['string.bin.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/hex" data-dencode-method="string.hex">${mf:h(msg['string.hex.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/html-escape" data-dencode-method="string.html-escape">${mf:h(msg['string.html-escape.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/url-encoding" data-dencode-method="string.url-encoding">${mf:h(msg['string.url-encoding.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/punycode" data-dencode-method="string.punycode">${mf:h(msg['string.punycode.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/base32" data-dencode-method="string.base32">${mf:h(msg['string.base32.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/base45" data-dencode-method="string.base45">${mf:h(msg['string.base45.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/base64" data-dencode-method="string.base64">${mf:h(msg['string.base64.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/ascii85" data-dencode-method="string.ascii85">${mf:h(msg['string.ascii85.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/quoted-printable" data-dencode-method="string.quoted-printable">${mf:h(msg['string.quoted-printable.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/unicode-escape" data-dencode-method="string.unicode-escape">${mf:h(msg['string.unicode-escape.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/program-string" data-dencode-method="string.program-string">${mf:h(msg['string.program-string.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/morse-code" data-dencode-method="string.morse-code">${mf:h(msg['string.morse-code.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/naming-convention" data-dencode-method="string.naming-convention">${mf:h(msg['string.naming-convention.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/camel-case" data-dencode-method="string.camel-case"><i class="bi bi-chevron-right"></i> ${mf:h(msg['string.camel-case.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/snake-case" data-dencode-method="string.snake-case"><i class="bi bi-chevron-right"></i> ${mf:h(msg['string.snake-case.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/kebab-case" data-dencode-method="string.kebab-case"><i class="bi bi-chevron-right"></i> ${mf:h(msg['string.kebab-case.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/character-width" data-dencode-method="string.character-width">${mf:h(msg['string.character-width.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/letter-case" data-dencode-method="string.letter-case">${mf:h(msg['string.letter-case.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/text-initials" data-dencode-method="string.text-initials">${mf:h(msg['string.text-initials.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/text-reverse" data-dencode-method="string.text-reverse">${mf:h(msg['string.text-reverse.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/font-style" data-dencode-method="string.font-style">${mf:h(msg['string.font-style.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/unicode-normalization" data-dencode-method="string.unicode-normalization">${mf:h(msg['string.unicode-normalization.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/line-sort" data-dencode-method="string.line-sort">${mf:h(msg['string.line-sort.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/string/line-unique" data-dencode-method="string.line-unique">${mf:h(msg['string.line-unique.method'])}</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown ${(type eq 'number') ? 'active' : ''}" role="presentation" data-dencode-type="number">
						<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['number.type'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a class="dropdown-item" href="${mf:h(basePath)}/number" data-dencode-method="number.all">${mf:h(msg['number.all.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/number/dec" data-dencode-method="number.dec">${mf:h(msg['number.dec.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/number/bin" data-dencode-method="number.bin">${mf:h(msg['number.bin.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/number/oct" data-dencode-method="number.oct">${mf:h(msg['number.oct.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/number/hex" data-dencode-method="number.hex">${mf:h(msg['number.hex.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/number/english" data-dencode-method="number.english">${mf:h(msg['number.english.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/number/japanese" data-dencode-method="number.japanese">${mf:h(msg['number.japanese.method'])}</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown ${(type eq 'date') ? 'active' : ''}" role="presentation" data-dencode-type="date">
						<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['date.type'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a class="dropdown-item" href="${mf:h(basePath)}/date" data-dencode-method="date.all">${mf:h(msg['date.all.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/date/unix-time" data-dencode-method="date.unix-time">${mf:h(msg['date.unix-time.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/date/w3cdtf" data-dencode-method="date.w3cdtf">${mf:h(msg['date.w3cdtf.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/date/iso8601" data-dencode-method="date.iso8601">${mf:h(msg['date.iso8601.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/date/rfc2822" data-dencode-method="date.rfc2822">${mf:h(msg['date.rfc2822.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/date/ctime" data-dencode-method="date.ctime">${mf:h(msg['date.ctime.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/date/japanese-era" data-dencode-method="date.japanese-era">${mf:h(msg['date.japanese-era.method'])}</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown ${(type eq 'color') ? 'active' : ''}" role="presentation" data-dencode-type="color">
						<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['color.type'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a class="dropdown-item" href="${mf:h(basePath)}/color" data-dencode-method="color.all">${mf:h(msg['color.all.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/color/name" data-dencode-method="color.name">${mf:h(msg['color.name.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/color/rgb" data-dencode-method="color.rgb">${mf:h(msg['color.rgb.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/color/hsl" data-dencode-method="color.hsl">${mf:h(msg['color.hsl.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/color/hsv" data-dencode-method="color.hsv">${mf:h(msg['color.hsv.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/color/cmyk" data-dencode-method="color.cmyk">${mf:h(msg['color.cmyk.method'])}</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown ${(type eq 'cipher') ? 'active' : ''}" role="presentation" data-dencode-type="cipher">
						<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['cipher.type'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher" data-dencode-method="cipher.all">${mf:h(msg['cipher.all.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/caesar" data-dencode-method="cipher.caesar">${mf:h(msg['cipher.caesar.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/rot13" data-dencode-method="cipher.rot13">${mf:h(msg['cipher.rot13.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/rot18" data-dencode-method="cipher.rot18">${mf:h(msg['cipher.rot18.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/rot47" data-dencode-method="cipher.rot47">${mf:h(msg['cipher.rot47.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/atbash" data-dencode-method="cipher.atbash">${mf:h(msg['cipher.atbash.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/affine" data-dencode-method="cipher.affine">${mf:h(msg['cipher.affine.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/vigenere" data-dencode-method="cipher.vigenere">${mf:h(msg['cipher.vigenere.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/enigma" data-dencode-method="cipher.enigma">${mf:h(msg['cipher.enigma.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/jis-keyboard" data-dencode-method="cipher.jis-keyboard">${mf:h(msg['cipher.jis-keyboard.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/scytale" data-dencode-method="cipher.scytale">${mf:h(msg['cipher.scytale.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/cipher/rail-fence" data-dencode-method="cipher.rail-fence">${mf:h(msg['cipher.rail-fence.method'])}</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown ${(type eq 'hash') ? 'active' : ''}" role="presentation" data-dencode-type="hash">
						<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['hash.type'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a class="dropdown-item" href="${mf:h(basePath)}/hash" data-dencode-method="hash.all">${mf:h(msg['hash.all.method'])}</a></li>
							<li class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/hash/md2" data-dencode-method="hash.md2">${mf:h(msg['hash.md2.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/hash/md5" data-dencode-method="hash.md5">${mf:h(msg['hash.md5.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/hash/sha1" data-dencode-method="hash.sha1">${mf:h(msg['hash.sha1.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/hash/sha256" data-dencode-method="hash.sha256">${mf:h(msg['hash.sha256.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/hash/sha384" data-dencode-method="hash.sha384">${mf:h(msg['hash.sha384.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/hash/sha512" data-dencode-method="hash.sha512">${mf:h(msg['hash.sha512.method'])}</a></li>
							<li><a class="dropdown-item" href="${mf:h(basePath)}/hash/crc32" data-dencode-method="hash.crc32">${mf:h(msg['hash.crc32.method'])}</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</header>

<div class="container">
	<div id="messages" class="messages">
	</div>
	
	<div class="content">
		<div id="top"></div>
		
		<div id="exp">
			<div id="expHeader">
				<span id="follow" title="${mf:h(msg['label.follow'])}"><i class="bi bi-pin-angle-fill"></i></span>
				<span id="vLen" class="badge bg-secondary popover-toggle" title="${mf:h(msg['label.val.length'])}" data-bs-toggle="popover" data-bs-placement="left" data-len-chars="0" data-len-bytes="0">0</span>
			</div>
			<div id="expValue">
				<div class="input-group">
					<textarea id="v" class="form-control" placeholder="${mf:h(msg[mf:strcat(method, '.tooltip')])}">${mf:h(v)}</textarea>
					<div class="btn-group-vertical">
						<button id="load" type="button" class="btn btn-v-icon-label dropdown-toggle" title="${mf:h(msg['label.load'])}" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="bi bi-file-earmark-arrow-up"></i>
							<span class="btn-label">${mf:h(msg['label.load.buttonLabel'])}</span>
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu dropdown-menu-right" role="menu">
							<%-- <li id="loadFile" class="dropdown-item" data-load-message="${mf:h(msg['label.load.message'])}" data-load-error-message="${mf:h(msg['label.load.errorMessage'])}" data-load-unsupported-message="${mf:h(msg['label.load.unsupportedMessage'])}" tabindex="0"><i class="bi bi-file-earmark-arrow-up"></i> ${mf:h(msg['label.load.file'])}</li> --%>
							<li id="loadImage" class="dropdown-item" data-load-message="${mf:h(msg['label.load.message'])}" data-load-error-message="${mf:h(msg['label.load.errorMessage'])}" data-load-unsupported-message="${mf:h(msg['label.load.unsupportedMessage'])}" tabindex="0"><i class="bi bi-camera"></i> ${mf:h(msg['label.load.image'])}</li>
							<li id="loadQrcode" class="dropdown-item" data-load-message="${mf:h(msg['label.load.message'])}" data-load-error-message="${mf:h(msg['label.load.errorMessage'])}" data-load-unsupported-message="${mf:h(msg['label.load.unsupportedMessage'])}" tabindex="0"><i class="bi bi-qr-code-scan"></i> ${mf:h(msg['label.load.qrcode'])}</li>
						</ul>
						<button type="button" class="btn btn-v-icon-label permanent-link popover-toggle" title="${mf:h(msg['label.permanentLink'])}" data-bs-toggle="popover" data-bs-placement="left">
							<i class="bi bi-link-45deg"></i>
							<span class="btn-label">${mf:h(msg['label.permanentLink.buttonLabel'])}</span>
						</button>
					</div>
				</div>
			</div>
			<div id="expOptions">
				<div id="oeGroup" class="btn-group btn-group-sm" data-default-value="${mf:h(oe)}" style="display: none;">
					<button class="btn" data-oe="UTF-8">UTF-8</button>
					<button class="btn" data-oe="UTF-16BE">UTF-16</button>
					<button class="btn" data-oe="UTF-32BE">UTF-32</button>
					<button id="oex" class="btn" data-oe=""></button>
					<button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-label="${mf:h(msg['label.etc'])}" aria-expanded="false">
						<span class="caret"></span>
					</button>
					<ul id="oexMenu" class="dropdown-menu" role="menu" data-default-value="${mf:h(oex)}">
						<li class="dropdown-item" data-oe="UTF-16LE" tabindex="0">UTF-16LE</li>
						<li class="dropdown-item" data-oe="UTF-32LE" tabindex="0">UTF-32LE</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="US-ASCII" tabindex="0">US-ASCII</li>
						<li class="dropdown-item" data-oe="ISO-8859-1" tabindex="0">ISO-8859-1 (Latin-1)</li>
						<li class="dropdown-item" data-oe="ISO-8859-15" tabindex="0">ISO-8859-15 (Latin-9)</li>
						<li class="dropdown-item" data-oe="windows-1252" tabindex="0">Windows-1252</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="ISO-8859-2" tabindex="0">ISO-8859-2 (Latin-2)</li>
						<li class="dropdown-item" data-oe="windows-1250" tabindex="0">Windows-1250</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="ISO-8859-3" tabindex="0">ISO-8859-3 (Latin-3)</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="ISO-8859-4" tabindex="0">ISO-8859-4 (Latin-4)</li>
						<li class="dropdown-item" data-oe="ISO-8859-13" tabindex="0">ISO-8859-13 (Latin-7)</li>
						<li class="dropdown-item" data-oe="windows-1257" tabindex="0">Windows-1257</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="Shift_JIS" tabindex="0">Shift_JIS</li>
						<li class="dropdown-item" data-oe="EUC-JP" tabindex="0">EUC-JP</li>
						<li class="dropdown-item" data-oe="ISO-2022-JP" tabindex="0">ISO-2022-JP (JIS)</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="GB2312" tabindex="0">GB2312 (EUC-CN)</li>
						<li class="dropdown-item" data-oe="GB18030" tabindex="0">GB18030</li>
						<li class="dropdown-item" data-oe="Big5-HKSCS" tabindex="0">Big5-HKSCS</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="EUC-KR" tabindex="0">EUC-KR (KS X 1001)</li>
						<li class="dropdown-item" data-oe="ISO-2022-KR" tabindex="0">ISO-2022-KR</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="ISO-8859-5" tabindex="0">ISO-8859-5</li>
						<li class="dropdown-item" data-oe="windows-1251" tabindex="0">Windows-1251</li>
						<li class="dropdown-item" data-oe="KOI8-R" tabindex="0">KOI8-R</li>
						<li class="dropdown-item" data-oe="KOI8-U" tabindex="0">KOI8-U</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="ISO-8859-6" tabindex="0">ISO-8859-6</li>
						<li class="dropdown-item" data-oe="windows-1256" tabindex="0">Windows-1256</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="ISO-8859-7" tabindex="0">ISO-8859-7</li>
						<li class="dropdown-item" data-oe="windows-1253" tabindex="0">Windows-1253</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="ISO-8859-8" tabindex="0">ISO-8859-8</li>
						<li class="dropdown-item" data-oe="windows-1255" tabindex="0">Windows-1255</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="ISO-8859-9" tabindex="0">ISO-8859-9 (Latin-5)</li>
						<li class="dropdown-item" data-oe="windows-1254" tabindex="0">Windows-1254</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="TIS-620" tabindex="0">TIS-620</li>
						<li class="dropdown-item" data-oe="windows-874" tabindex="0">Windows-874</li>
						<li class="dropdown-divider"></li>
						<li class="dropdown-item" data-oe="windows-1258" tabindex="0">Windows-1258</li>
					</ul>
				</div>
				<div id="nlGroup" class="btn-group btn-group-sm" data-default-value="${mf:h(nl)}" style="display: none;">
					<button class="btn" data-nl="crlf">CRLF (Win)</button>
					<button class="btn" data-nl="lf">LF (UNIX/Mac)</button>
					<button class="btn" data-nl="cr">CR (Old Mac)</button>
				</div>
				<div id="tzGroup" class="btn-group btn-group-sm" data-default-value="${mf:h(tz)}" style="display: none;">
					<button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-label="${mf:h(msg['label.timeZone'])}" aria-expanded="false">
						<span id="tz" data-tz=""></span>
						<span class="caret"></span>
					</button>
					<div id="tzMenu" class="dropdown-menu" role="menu">
						<input id="tzMenuFilter" class="form-control" value="" />
						<div id="tzMenuItems">
							<c:forEach var="tzVal" items="${tzMap}">
								<span class="dropdown-item" data-tz="${mf:h(tzVal.key)}" tabindex="0">${mf:h(tzVal.value)}</span>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div id="decoded" ${(hasDecoder) ? '' : 'style="display: none;"'}>
			<h2 data-bs-toggle="collapse" data-bs-target="#decodedListContainer" aria-expanded="true">
				<i class="toggle-icon bi bi-caret-down-square"></i>
				${mf:h(msg['label.decoded'])}
				<svg id="decodingIndicator" style="display: none;"><use href="#loading-indicator" /></svg>
			</h2>
			<div id="decodedListContainer" class="collapse show">
				<table id="decodedList" class="dencoded-list">
					<c:if test="${types.contains('string')}">
						<tbody>
							<c:if test="${methods.contains('string.bin')}"><tr data-dencode-method="string.bin"><th>${mf:h(msg['string.bin.func.decStrBin'])}</th><td><span id="decStrBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.hex')}"><tr data-dencode-method="string.hex"><th>${mf:h(msg['string.hex.func.decStrHex'])}</th><td><span id="decStrHex" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.html-escape')}"><tr data-dencode-method="string.html-escape"><th>${mf:h(msg['string.html-escape.func.decStrHTMLEscape'])}</th><td><span id="decStrHTMLEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.url-encoding')}"><tr data-dencode-method="string.url-encoding"><th>${mf:h(msg['string.url-encoding.func.decStrURLEncoding'])}</th><td><span id="decStrURLEncoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.punycode')}"><tr data-dencode-method="string.punycode"><th>${mf:h(msg['string.punycode.func.decStrPunycode'])}</th><td><span id="decStrPunycode" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base32')}"><tr data-dencode-method="string.base32"><th>${mf:h(msg['string.base32.func.decStrBase32'])}</th><td><span id="decStrBase32" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base45')}"><tr data-dencode-method="string.base45"><th>${mf:h(msg['string.base45.func.decStrBase45'])}</th><td><span id="decStrBase45" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base45')}"><tr data-dencode-method="string.base45"><th>${mf:h(msg['string.base45.func.decStrBase45ZlibCoseCbor'])}</th><td><span id="decStrBase45ZlibCoseCbor" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base64')}"><tr data-dencode-method="string.base64"><th>${mf:h(msg['string.base64.func.decStrBase64'])}</th><td><span id="decStrBase64" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.ascii85')}"><tr data-dencode-method="string.ascii85"><th>${mf:h(msg['string.ascii85.func.decStrAscii85'])}</th><td><span id="decStrAscii85" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.quoted-printable')}"><tr data-dencode-method="string.quoted-printable"><th>${mf:h(msg['string.quoted-printable.func.decStrQuotedPrintable'])}</th><td><span id="decStrQuotedPrintable" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.unicode-escape')}"><tr data-dencode-method="string.unicode-escape"><th>${mf:h(msg['string.unicode-escape.func.decStrUnicodeEscape'])}</th><td><span id="decStrUnicodeEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.program-string')}"><tr data-dencode-method="string.program-string"><th>${mf:h(msg['string.program-string.func.decStrProgramString'])}</th><td><span id="decStrProgramString" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.morse-code')}"><tr data-dencode-method="string.morse-code"><th>${mf:h(msg['string.morse-code.func.decStrMorseCode'])}</th><td><span id="decStrMorseCode" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.morse-code.variant'])}</span>
										<select name="_string.morse-code.variant" class="dencode-option form-select" data-sync-with="string.morse-code.variant">
											<option value="international">${mf:h(msg['string.morse-code.variant.international'])}</option>
											<option value="japanese">${mf:h(msg['string.morse-code.variant.japanese'])}</option>
											<option value="russian">${mf:h(msg['string.morse-code.variant.russian'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.unicode-normalization')}"><tr data-dencode-method="string.unicode-normalization"><th>${mf:h(msg['string.unicode-normalization.func.decStrUnicodeNFC'])}</th><td><span id="decStrUnicodeNFC" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.unicode-normalization')}"><tr data-dencode-method="string.unicode-normalization"><th>${mf:h(msg['string.unicode-normalization.func.decStrUnicodeNFKC'])}</th><td><span id="decStrUnicodeNFKC" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('number')}">
						<tbody>
							<c:if test="${methods.contains('number.dec')}"><tr data-dencode-method="number.dec"><th>${mf:h(msg['number.dec.func.decNumDec'])}</th><td><span id="decNumDec" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.bin')}"><tr data-dencode-method="number.bin"><th>${mf:h(msg['number.bin.func.decNumBin'])}</th><td><span id="decNumBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.oct')}"><tr data-dencode-method="number.oct"><th>${mf:h(msg['number.oct.func.decNumOct'])}</th><td><span id="decNumOct" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.hex')}"><tr data-dencode-method="number.hex"><th>${mf:h(msg['number.hex.func.decNumHex'])}</th><td><span id="decNumHex" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.english')}"><tr data-dencode-method="number.english"><th>${mf:h(msg['number.english.func.decNumEnShortScale'])}</th><td><span id="decNumEnShortScale" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.japanese')}"><tr data-dencode-method="number.japanese"><th>${mf:h(msg['number.japanese.func.decNumJP'])}</th><td><span id="decNumJP" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('cipher')}">
						<tbody>
							<c:if test="${methods.contains('cipher.caesar')}"><tr data-dencode-method="cipher.caesar"><th>${mf:h(msg['cipher.caesar.func.decCipherCaesar'])}</th><td><span id="decCipherCaesar" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['_cipher.caesar.shift'])}</span>
										<select name="_cipher.caesar.shift" class="dencode-option form-select" data-sync-with="cipher.caesar.shift">
											<option value="-42">${mf:h(msg['_cipher.caesar.shift.b42'])}</option>
											<option value="-41">${mf:h(msg['_cipher.caesar.shift.b41'])}</option>
											<option value="-40">${mf:h(msg['_cipher.caesar.shift.b40'])}</option>
											<option value="-39">${mf:h(msg['_cipher.caesar.shift.b39'])}</option>
											<option value="-38">${mf:h(msg['_cipher.caesar.shift.b38'])}</option>
											<option value="-37">${mf:h(msg['_cipher.caesar.shift.b37'])}</option>
											<option value="-36">${mf:h(msg['_cipher.caesar.shift.b36'])}</option>
											<option value="-35">${mf:h(msg['_cipher.caesar.shift.b35'])}</option>
											<option value="-34">${mf:h(msg['_cipher.caesar.shift.b34'])}</option>
											<option value="-33">${mf:h(msg['_cipher.caesar.shift.b33'])}</option>
											<option value="-32">${mf:h(msg['_cipher.caesar.shift.b32'])}</option>
											<option value="-31">${mf:h(msg['_cipher.caesar.shift.b31'])}</option>
											<option value="-30">${mf:h(msg['_cipher.caesar.shift.b30'])}</option>
											<option value="-29">${mf:h(msg['_cipher.caesar.shift.b29'])}</option>
											<option value="-28">${mf:h(msg['_cipher.caesar.shift.b28'])}</option>
											<option value="-27">${mf:h(msg['_cipher.caesar.shift.b27'])}</option>
											<option value="-26">${mf:h(msg['_cipher.caesar.shift.b26'])}</option>
											<option value="-25">${mf:h(msg['_cipher.caesar.shift.b25'])}</option>
											<option value="-24">${mf:h(msg['_cipher.caesar.shift.b24'])}</option>
											<option value="-23">${mf:h(msg['_cipher.caesar.shift.b23'])}</option>
											<option value="-22">${mf:h(msg['_cipher.caesar.shift.b22'])}</option>
											<option value="-21">${mf:h(msg['_cipher.caesar.shift.b21'])}</option>
											<option value="-20">${mf:h(msg['_cipher.caesar.shift.b20'])}</option>
											<option value="-19">${mf:h(msg['_cipher.caesar.shift.b19'])}</option>
											<option value="-18">${mf:h(msg['_cipher.caesar.shift.b18'])}</option>
											<option value="-17">${mf:h(msg['_cipher.caesar.shift.b17'])}</option>
											<option value="-16">${mf:h(msg['_cipher.caesar.shift.b16'])}</option>
											<option value="-15">${mf:h(msg['_cipher.caesar.shift.b15'])}</option>
											<option value="-14">${mf:h(msg['_cipher.caesar.shift.b14'])}</option>
											<option value="-13">${mf:h(msg['_cipher.caesar.shift.b13'])}</option>
											<option value="-12">${mf:h(msg['_cipher.caesar.shift.b12'])}</option>
											<option value="-11">${mf:h(msg['_cipher.caesar.shift.b11'])}</option>
											<option value="-10">${mf:h(msg['_cipher.caesar.shift.b10'])}</option>
											<option value="-9">${mf:h(msg['_cipher.caesar.shift.b9'])}</option>
											<option value="-8">${mf:h(msg['_cipher.caesar.shift.b8'])}</option>
											<option value="-7">${mf:h(msg['_cipher.caesar.shift.b7'])}</option>
											<option value="-6">${mf:h(msg['_cipher.caesar.shift.b6'])}</option>
											<option value="-5">${mf:h(msg['_cipher.caesar.shift.b5'])}</option>
											<option value="-4">${mf:h(msg['_cipher.caesar.shift.b4'])}</option>
											<option value="-3">${mf:h(msg['_cipher.caesar.shift.b3'])}</option>
											<option value="-2">${mf:h(msg['_cipher.caesar.shift.b2'])}</option>
											<option value="-1">${mf:h(msg['_cipher.caesar.shift.b1'])}</option>
											<option value="1">${mf:h(msg['_cipher.caesar.shift.1'])}</option>
											<option value="2">${mf:h(msg['_cipher.caesar.shift.2'])}</option>
											<option value="3">${mf:h(msg['_cipher.caesar.shift.3'])}</option>
											<option value="4">${mf:h(msg['_cipher.caesar.shift.4'])}</option>
											<option value="5">${mf:h(msg['_cipher.caesar.shift.5'])}</option>
											<option value="6">${mf:h(msg['_cipher.caesar.shift.6'])}</option>
											<option value="7">${mf:h(msg['_cipher.caesar.shift.7'])}</option>
											<option value="8">${mf:h(msg['_cipher.caesar.shift.8'])}</option>
											<option value="9">${mf:h(msg['_cipher.caesar.shift.9'])}</option>
											<option value="10">${mf:h(msg['_cipher.caesar.shift.10'])}</option>
											<option value="11">${mf:h(msg['_cipher.caesar.shift.11'])}</option>
											<option value="12">${mf:h(msg['_cipher.caesar.shift.12'])}</option>
											<option value="13">${mf:h(msg['_cipher.caesar.shift.13'])}</option>
											<option value="14">${mf:h(msg['_cipher.caesar.shift.14'])}</option>
											<option value="15">${mf:h(msg['_cipher.caesar.shift.15'])}</option>
											<option value="16">${mf:h(msg['_cipher.caesar.shift.16'])}</option>
											<option value="17">${mf:h(msg['_cipher.caesar.shift.17'])}</option>
											<option value="18">${mf:h(msg['_cipher.caesar.shift.18'])}</option>
											<option value="19">${mf:h(msg['_cipher.caesar.shift.19'])}</option>
											<option value="20">${mf:h(msg['_cipher.caesar.shift.20'])}</option>
											<option value="21">${mf:h(msg['_cipher.caesar.shift.21'])}</option>
											<option value="22">${mf:h(msg['_cipher.caesar.shift.22'])}</option>
											<option value="23">${mf:h(msg['_cipher.caesar.shift.23'])}</option>
											<option value="24">${mf:h(msg['_cipher.caesar.shift.24'])}</option>
											<option value="25">${mf:h(msg['_cipher.caesar.shift.25'])}</option>
											<option value="26">${mf:h(msg['_cipher.caesar.shift.26'])}</option>
											<option value="27">${mf:h(msg['_cipher.caesar.shift.27'])}</option>
											<option value="28">${mf:h(msg['_cipher.caesar.shift.28'])}</option>
											<option value="29">${mf:h(msg['_cipher.caesar.shift.29'])}</option>
											<option value="30">${mf:h(msg['_cipher.caesar.shift.30'])}</option>
											<option value="31">${mf:h(msg['_cipher.caesar.shift.31'])}</option>
											<option value="32">${mf:h(msg['_cipher.caesar.shift.32'])}</option>
											<option value="33">${mf:h(msg['_cipher.caesar.shift.33'])}</option>
											<option value="34">${mf:h(msg['_cipher.caesar.shift.34'])}</option>
											<option value="35">${mf:h(msg['_cipher.caesar.shift.35'])}</option>
											<option value="36">${mf:h(msg['_cipher.caesar.shift.36'])}</option>
											<option value="37">${mf:h(msg['_cipher.caesar.shift.37'])}</option>
											<option value="38">${mf:h(msg['_cipher.caesar.shift.38'])}</option>
											<option value="39">${mf:h(msg['_cipher.caesar.shift.39'])}</option>
											<option value="40">${mf:h(msg['_cipher.caesar.shift.40'])}</option>
											<option value="41">${mf:h(msg['_cipher.caesar.shift.41'])}</option>
											<option value="42">${mf:h(msg['_cipher.caesar.shift.42'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot13')}"><tr data-dencode-method="cipher.rot13"><th>${mf:h(msg['cipher.rot13.func.decCipherROT13'])}</th><td><span id="decCipherROT13" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot18')}"><tr data-dencode-method="cipher.rot18"><th>${mf:h(msg['cipher.rot18.func.decCipherROT18'])}</th><td><span id="decCipherROT18" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot47')}"><tr data-dencode-method="cipher.rot47"><th>${mf:h(msg['cipher.rot47.func.decCipherROT47'])}</th><td><span id="decCipherROT47" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.affine')}"><tr data-dencode-method="cipher.affine"><th>${mf:h(msg['cipher.affine.func.decCipherAffine'])}</th><td><span id="decCipherAffine" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.affine.a'])}</span>
										<select name="_cipher.affine.a" class="dencode-option form-select" data-sync-with="cipher.affine.a">
											<option value="-25">-25</option>
											<option value="-23">-23</option>
											<option value="-21">-21</option>
											<option value="-19">-19</option>
											<option value="-17">-17</option>
											<option value="-15">-15</option>
											<option value="-13">-13</option>
											<option value="-11">-11</option>
											<option value="-9">-9</option>
											<option value="-7">-7</option>
											<option value="-5">-5</option>
											<option value="-3">-3</option>
											<option value="-1">-1</option>
											<option value="1">1</option>
											<option value="3">3</option>
											<option value="5">5</option>
											<option value="7">7</option>
											<option value="9">9</option>
											<option value="11">11</option>
											<option value="13">13</option>
											<option value="15">15</option>
											<option value="17">17</option>
											<option value="19">19</option>
											<option value="21">21</option>
											<option value="23">23</option>
											<option value="25">25</option>
										</select>
									</div>
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.affine.b'])}</span>
										<select name="_cipher.affine.b" class="dencode-option form-select" data-sync-with="cipher.affine.b">
											<option value="-25">-25</option>
											<option value="-24">-24</option>
											<option value="-23">-23</option>
											<option value="-22">-22</option>
											<option value="-21">-21</option>
											<option value="-20">-20</option>
											<option value="-19">-19</option>
											<option value="-18">-18</option>
											<option value="-17">-17</option>
											<option value="-16">-16</option>
											<option value="-15">-15</option>
											<option value="-14">-14</option>
											<option value="-13">-13</option>
											<option value="-12">-12</option>
											<option value="-11">-11</option>
											<option value="-10">-10</option>
											<option value="-9">-9</option>
											<option value="-8">-8</option>
											<option value="-7">-7</option>
											<option value="-6">-6</option>
											<option value="-5">-5</option>
											<option value="-4">-4</option>
											<option value="-3">-3</option>
											<option value="-2">-2</option>
											<option value="-1">-1</option>
											<option value="0">0</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
											<option value="21">21</option>
											<option value="22">22</option>
											<option value="23">23</option>
											<option value="24">24</option>
											<option value="25">25</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('cipher.vigenere')}"><tr data-dencode-method="cipher.vigenere"><th>${mf:h(msg['cipher.vigenere.func.decCipherVigenere'])}</th><td><span id="decCipherVigenere" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.vigenere.key'])}</span>
										<input name="_cipher.vigenere.key" class="dencode-option form-control" value="" placeholder="${mf:h(msg['cipher.vigenere.key.tooltip'])}" data-sync-with="cipher.vigenere.key" />
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.enigma')}"><tr data-dencode-method="cipher.enigma"><th>${mf:h(msg['cipher.enigma.func.decCipherEnigma'])}</th><td><span id="decCipherEnigma" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="dencode-option-grid cipher-enigma">
										<div class="dencode-option-grid-label cipher-enigma-option-machine">
											${mf:h(msg['cipher.enigma.machine'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-machine">
											<select name="_cipher.enigma.machine" class="dencode-option form-select" data-sync-with="cipher.enigma.machine">
												<option value="I" data-reflectors="UKW-A,UKW-B,UKW-C,UKW-D" data-rotors="I,II,III,IV,V" data-has="plugboard,uhr,ukwd">Enigma I</option>
												<option value="M3" data-reflectors="UKW-B,UKW-C" data-rotors="I,II,III,IV,V,VI,VII,VIII" data-has="plugboard">Enigma M3</option>
												<option value="M4" data-reflectors="UKW-B,UKW-C,UKW-D" data-rotors="I,II,III,IV,V,VI,VII,VIII" data-has="4wheels,plugboard,ukwd">Enigma M4 (U-boat Enigma)</option>
												<option value="Norway" data-reflectors="UKW" data-rotors="I,II,III,IV,V" data-has="plugboard">Norway Enigma "Norenigma"</option>
												<option value="Sonder" data-reflectors="UKW" data-rotors="I,II,III" data-has="plugboard">Sondermaschine (Special machine)</option>
												<option value="G" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma G "Zählwerk Enigma" (A28/G31)</option>
												<option value="G-312" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma G G-312 (G31 Abwehr Enigma)</option>
												<option value="G-260" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma G G-260 (G31 Abwehr Enigma)</option>
												<option value="G-111" data-reflectors="UKW" data-rotors="I,II,V" data-has="settable-reflector">Enigma G G-111 (G31 Hungarian Enigma)</option>
												<option value="D" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma D (Commercial Enigma A26)</option>
												<option value="K" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma K (Commercial Enigma A27)</option>
												<option value="KD" data-reflectors="UKW,UKW-D" data-rotors="I,II,III" data-has="ukwd">Enigma KD (Enigma K with UKW-D)</option>
												<option value="Swiss-K" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Swiss-K (Swiss Enigma K variant)</option>
												<option value="Railway" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Railway Enigma "Rocket I"</option>
												<option value="T" data-reflectors="UKW" data-rotors="I,II,III,IV,V,VI,VII,VIII" data-has="settable-reflector">Enigma T "Tirpitz" (Japanese Enigma)</option>
												<option value="Spanish-D" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Spanish Enigma, wiring D</option>
												<option value="Spanish-F" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Spanish Enigma, wiring F</option>
												<option value="Spanish-Delta" data-reflectors="UKW" data-rotors="I,II,III,IV,V" data-has="settable-reflector">Spanish Enigma, Delta (A 16081)</option>
												<option value="Spanish-S" data-reflectors="UKW" data-rotors="I,II,III,IV,V" data-has="plugboard,settable-reflector">Spanish Enigma, Sonderschaltung / Delta (A 16101)</option>
											</select>
										</div>
										<div class="dencode-option-grid-label">
											${mf:h(msg['cipher.enigma.wheels'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-reflector">
											<select name="_cipher.enigma.reflector" class="dencode-option form-select" data-sync-with="cipher.enigma.reflector">
												<option value="UKW">UKW</option>
												<option value="UKW-A">UKW-A</option>
												<option value="UKW-B">UKW-B</option>
												<option value="UKW-C">UKW-C</option>
												<option value="UKW-D">UKW-D</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor4">
											<select name="_cipher.enigma.rotor4" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor4">
												<option value="Beta">Beta</option>
												<option value="Gamma">Gamma</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor3">
											<select name="_cipher.enigma.rotor3" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor3">
												<option value="I">I</option>
												<option value="II">II</option>
												<option value="III">III</option>
												<option value="IV">IV</option>
												<option value="V">V</option>
												<option value="VI">VI</option>
												<option value="VII">VII</option>
												<option value="VIII">VIII</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor2">
											<select name="_cipher.enigma.rotor2" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor2">
												<option value="I">I</option>
												<option value="II">II</option>
												<option value="III">III</option>
												<option value="IV">IV</option>
												<option value="V">V</option>
												<option value="VI">VI</option>
												<option value="VII">VII</option>
												<option value="VIII">VIII</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor1">
											<select name="_cipher.enigma.rotor1" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor1">
												<option value="I">I</option>
												<option value="II">II</option>
												<option value="III">III</option>
												<option value="IV">IV</option>
												<option value="V">V</option>
												<option value="VI">VI</option>
												<option value="VII">VII</option>
												<option value="VIII">VIII</option>
											</select>
										</div>
										
										<div class="dencode-option-grid-label">
											${mf:h(msg['cipher.enigma.rings'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-reflector cipher-enigma-option-reflector-ring">
											<select name="_cipher.enigma.reflector-ring" class="dencode-option form-select" data-sync-with="cipher.enigma.reflector-ring">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor4">
											<select name="_cipher.enigma.rotor4-ring" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor4-ring">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor3">
											<select name="_cipher.enigma.rotor3-ring" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor3-ring">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor2">
											<select name="_cipher.enigma.rotor2-ring" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor2-ring">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor1">
											<select name="_cipher.enigma.rotor1-ring" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor1-ring">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										
										<div class="dencode-option-grid-label">
											${mf:h(msg['cipher.enigma.positions'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-reflector cipher-enigma-option-reflector-position">
											<select name="_cipher.enigma.reflector-position" class="dencode-option form-select" data-sync-with="cipher.enigma.reflector-position">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor4">
											<select name="_cipher.enigma.rotor4-position" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor4-position">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor3">
											<select name="_cipher.enigma.rotor3-position" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor3-position">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor2">
											<select name="_cipher.enigma.rotor2-position" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor2-position">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor1">
											<select name="_cipher.enigma.rotor1-position" class="dencode-option form-select" data-sync-with="cipher.enigma.rotor1-position">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										
										<div class="dencode-option-grid-label cipher-enigma-option-plugboard">
											${mf:h(msg['cipher.enigma.plugboard'])}
										</div>
										<div class="dencode-option-grid-label cipher-enigma-option-uhr">
											${mf:h(msg['cipher.enigma.uhr'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-plugboard">
											<input type="text" name="_cipher.enigma.plugboard" class="dencode-option form-control" value="" placeholder="${mf:h(msg['cipher.enigma.plugboard.tooltip'])}" data-sync-with="cipher.enigma.plugboard" />
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-uhr">
											<select name="_cipher.enigma.uhr" class="dencode-option form-select" data-sync-with="cipher.enigma.uhr">
												<option value="0">00</option>
												<option value="1">01</option>
												<option value="2">02</option>
												<option value="3">03</option>
												<option value="4">04</option>
												<option value="5">05</option>
												<option value="6">06</option>
												<option value="7">07</option>
												<option value="8">08</option>
												<option value="9">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
												<option value="24">24</option>
												<option value="25">25</option>
												<option value="26">26</option>
												<option value="27">27</option>
												<option value="28">28</option>
												<option value="29">29</option>
												<option value="30">30</option>
												<option value="31">31</option>
												<option value="32">32</option>
												<option value="33">33</option>
												<option value="34">34</option>
												<option value="35">35</option>
												<option value="36">36</option>
												<option value="37">37</option>
												<option value="38">38</option>
												<option value="39">39</option>
											</select>
										</div>
										
										<div class="dencode-option-grid-label cipher-enigma-option-ukwd">
											${mf:h(msg['cipher.enigma.ukwd'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-ukwd">
											<input type="text" name="_cipher.enigma.ukwd" class="dencode-option form-control" value="" placeholder="${mf:h(msg['cipher.enigma.ukwd.tooltip'])}" data-sync-with="cipher.enigma.ukwd" />
										</div>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('cipher.scytale')}"><tr data-dencode-method="cipher.scytale"><th>${mf:h(msg['cipher.scytale.func.decCipherScytale'])}</th><td><span id="decCipherScytale" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.scytale.key'])}</span>
										<select name="_cipher.scytale.key" class="dencode-option form-select" data-sync-with="cipher.scytale.key">
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
										</select>
										
										<span class="input-group-text">${mf:h(msg['cipher.scytale.key-per'])}</span>
										<select name="_cipher.scytale.key-per" class="dencode-option form-select" data-sync-with="cipher.scytale.key-per">
											<option value="y">${mf:h(msg['cipher.scytale.key-per.y'])}</option>
											<option value="x">${mf:h(msg['cipher.scytale.key-per.x'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.rail-fence')}"><tr data-dencode-method="cipher.rail-fence"><th>${mf:h(msg['cipher.rail-fence.func.decCipherRailFence'])}</th><td><span id="decCipherRailFence" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.rail-fence.key'])}</span>
										<select name="_cipher.rail-fence.key" class="dencode-option form-select" data-sync-with="cipher.rail-fence.key">
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
					</c:if>
				</table>
			</div>
		</div>
		
		<div id="encoded" ${(hasEncoder) ? '' : 'style="display: none;"'}>
			<h2 data-bs-toggle="collapse" data-bs-target="#encodedListContainer" aria-expanded="true">
				<i class="toggle-icon bi bi-caret-down-square"></i>
				${mf:h(msg['label.encoded'])}
				<svg id="encodingIndicator" style="display: none;"><use href="#loading-indicator" /></svg>
			</h2>
			<div id="encodedListContainer" class="collapse show">
				<table id="encodedList" class="dencoded-list">
					<c:if test="${types.contains('string')}">
						<tbody>
							<c:if test="${methods.contains('string.bin')}"><tr data-dencode-method="string.bin"><th>${mf:h(msg['string.bin.func.encStrBin'])}</th><td><span id="encStrBin" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.bin.separator-each'])}</span>
										<select name="string.bin.separator-each" class="dencode-option form-select">
											<option value="">${mf:h(msg['string.bin.separator-each.none'])}</option>
											<option value="4b">${mf:h(msg['string.bin.separator-each.4bits'])}</option>
											<option value="8b">${mf:h(msg['string.bin.separator-each.8bits'])}</option>
											<option value="16b">${mf:h(msg['string.bin.separator-each.16bits'])}</option>
											<option value="24b">${mf:h(msg['string.bin.separator-each.24bits'])}</option>
											<option value="32b">${mf:h(msg['string.bin.separator-each.32bits'])}</option>
											<option value="64b">${mf:h(msg['string.bin.separator-each.64bits'])}</option>
											<option value="128b">${mf:h(msg['string.bin.separator-each.128bits'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.hex')}"><tr data-dencode-method="string.hex"><th>${mf:h(msg['string.hex.func.encStrHex'])}</th><td><span id="encStrHex" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.hex.separator-each'])}</span>
										<select name="string.hex.separator-each" class="dencode-option form-select">
											<option value="">${mf:h(msg['string.hex.separator-each.none'])}</option>
											<option value="1B">${mf:h(msg['string.hex.separator-each.1byte'])}</option>
											<option value="2B">${mf:h(msg['string.hex.separator-each.2bytes'])}</option>
											<option value="3B">${mf:h(msg['string.hex.separator-each.3bytes'])}</option>
											<option value="4B">${mf:h(msg['string.hex.separator-each.4bytes'])}</option>
											<option value="8B">${mf:h(msg['string.hex.separator-each.8bytes'])}</option>
											<option value="16B">${mf:h(msg['string.hex.separator-each.16bytes'])}</option>
										</select>
									</div>
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.hex.case'])}</span>
										<select name="string.hex.case" class="dencode-option form-select">
											<option value="lower">${mf:h(msg['string.hex.case.lower'])}</option>
											<option value="upper">${mf:h(msg['string.hex.case.upper'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.html-escape')}"><tr data-dencode-method="string.html-escape"><th>${mf:h(msg['string.html-escape.func.encStrHTMLEscape'])}</th><td><span id="encStrHTMLEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.html-escape')}"><tr data-dencode-method="string.html-escape"><th>${mf:h(msg['string.html-escape.func.encStrHTMLEscapeFully'])}</th><td><span id="encStrHTMLEscapeFully" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.url-encoding')}"><tr data-dencode-method="string.url-encoding"><th>${mf:h(msg['string.url-encoding.func.encStrURLEncoding'])}</th><td><span id="encStrURLEncoding" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.url-encoding.space'])}</span>
										<select name="string.url-encoding.space" class="dencode-option form-select">
											<option value="">${mf:h(msg['string.url-encoding.space.default'])}</option>
											<option value="form">${mf:h(msg['string.url-encoding.space.form'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.punycode')}"><tr data-dencode-method="string.punycode"><th>${mf:h(msg['string.punycode.func.encStrPunycode'])}</th><td><span id="encStrPunycode" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base32')}"><tr data-dencode-method="string.base32"><th>${mf:h(msg['string.base32.func.encStrBase32'])}</th><td><span id="encStrBase32" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base45')}"><tr data-dencode-method="string.base45"><th>${mf:h(msg['string.base45.func.encStrBase45'])}</th><td><span id="encStrBase45" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base64')}"><tr data-dencode-method="string.base64"><th>${mf:h(msg['string.base64.func.encStrBase64'])}</th><td><span id="encStrBase64" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.base64.line-break-each'])}</span>
										<select name="string.base64.line-break-each" class="dencode-option form-select">
											<option value="">${mf:h(msg['string.base64.line-break-each.none'])}</option>
											<option value="64">${mf:h(msg['string.base64.line-break-each.64'])}</option>
											<option value="76">${mf:h(msg['string.base64.line-break-each.76'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.ascii85')}"><tr data-dencode-method="string.ascii85"><th>${mf:h(msg['string.ascii85.func.encStrAscii85'])}</th><td><span id="encStrAscii85" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.ascii85.variant'])}</span>
										<select name="string.ascii85.variant" class="dencode-option form-select">
											<option value="z85">${mf:h(msg['string.ascii85.variant.z85'])}</option>
											<option value="adobe">${mf:h(msg['string.ascii85.variant.adobe'])}</option>
											<option value="btoa">${mf:h(msg['string.ascii85.variant.btoa'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.quoted-printable')}"><tr data-dencode-method="string.quoted-printable"><th>${mf:h(msg['string.quoted-printable.func.encStrQuotedPrintable'])}</th><td><span id="encStrQuotedPrintable" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.unicode-escape')}"><tr data-dencode-method="string.unicode-escape"><th>${mf:h(msg['string.unicode-escape.func.encStrUnicodeEscape'])}</th><td><span id="encStrUnicodeEscape" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.unicode-escape.notation'])}</span>
										<select name="string.unicode-escape.notation" class="dencode-option form-select">
											<option value="cubu">${mf:h(msg['string.unicode-escape.notation.cubu'])}</option>
											<option value="cpbu_bub">${mf:h(msg['string.unicode-escape.notation.cpbu_bub'])}</option>
											<option value="cpbu_bU">${mf:h(msg['string.unicode-escape.notation.cpbu_bU'])}</option>
											<option value="cpbub">${mf:h(msg['string.unicode-escape.notation.cpbub'])}</option>
											<option value="cpbxb">${mf:h(msg['string.unicode-escape.notation.cpbxb'])}</option>
											<option value="cpb">${mf:h(msg['string.unicode-escape.notation.cpb'])}</option>
											<option value="cpahx">${mf:h(msg['string.unicode-escape.notation.cpahx'])}</option>
											<option value="cupu">${mf:h(msg['string.unicode-escape.notation.cupu'])}</option>
											<option value="cp">${mf:h(msg['string.unicode-escape.notation.cp'])}</option>
											<option value="cp0x">${mf:h(msg['string.unicode-escape.notation.cp0x'])}</option>
											<option value="cnbNb">${mf:h(msg['string.unicode-escape.notation.cnbNb'])}</option>
										</select>
									</div>
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.unicode-escape.case'])}</span>
										<select name="string.unicode-escape.case" class="dencode-option form-select">
											<option value="upper">${mf:h(msg['string.unicode-escape.case.upper'])}</option>
											<option value="lower">${mf:h(msg['string.unicode-escape.case.lower'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.program-string')}"><tr data-dencode-method="string.program-string"><th>${mf:h(msg['string.program-string.func.encStrProgramString'])}</th><td><span id="encStrProgramString" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.program-string.quotes'])}</span>
										<select name="string.program-string.quotes" class="dencode-option form-select">
											<option value="double">${mf:h(msg['string.program-string.quotes.double'])}</option>
											<option value="single">${mf:h(msg['string.program-string.quotes.single'])}</option>
											<option value="none">${mf:h(msg['string.program-string.quotes.none'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.morse-code')}"><tr data-dencode-method="string.morse-code"><th>${mf:h(msg['string.morse-code.func.encStrMorseCode'])}</th><td><span id="encStrMorseCode" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.morse-code.variant'])}</span>
										<select name="string.morse-code.variant" class="dencode-option form-select">
											<option value="international">${mf:h(msg['string.morse-code.variant.international'])}</option>
											<option value="japanese">${mf:h(msg['string.morse-code.variant.japanese'])}</option>
											<option value="russian">${mf:h(msg['string.morse-code.variant.russian'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.camel-case')}"><tr data-dencode-method="string.camel-case"><th>${mf:h(msg['string.camel-case.func.encStrUpperCamelCase'])}</th><td><span id="encStrUpperCamelCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.camel-case')}"><tr data-dencode-method="string.camel-case"><th>${mf:h(msg['string.camel-case.func.encStrLowerCamelCase'])}</th><td><span id="encStrLowerCamelCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.snake-case')}"><tr data-dencode-method="string.snake-case"><th>${mf:h(msg['string.snake-case.func.encStrUpperSnakeCase'])}</th><td><span id="encStrUpperSnakeCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.snake-case')}"><tr data-dencode-method="string.snake-case"><th>${mf:h(msg['string.snake-case.func.encStrLowerSnakeCase'])}</th><td><span id="encStrLowerSnakeCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.kebab-case')}"><tr data-dencode-method="string.kebab-case"><th>${mf:h(msg['string.kebab-case.func.encStrUpperKebabCase'])}</th><td><span id="encStrUpperKebabCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.kebab-case')}"><tr data-dencode-method="string.kebab-case"><th>${mf:h(msg['string.kebab-case.func.encStrLowerKebabCase'])}</th><td><span id="encStrLowerKebabCase" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.character-width')}"><tr data-dencode-method="string.character-width"><th>${mf:h(msg['string.character-width.func.encStrHalfWidth'])}</th><td><span id="encStrHalfWidth" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.character-width')}"><tr data-dencode-method="string.character-width"><th>${mf:h(msg['string.character-width.func.encStrFullWidth'])}</th><td><span id="encStrFullWidth" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${mf:h(msg['string.letter-case.func.encStrUpperCase'])}</th><td><span id="encStrUpperCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${mf:h(msg['string.letter-case.func.encStrLowerCase'])}</th><td><span id="encStrLowerCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${mf:h(msg['string.letter-case.func.encStrSwapCase'])}</th><td><span id="encStrSwapCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${mf:h(msg['string.letter-case.func.encStrCapitalize'])}</th><td><span id="encStrCapitalize" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.text-initials')}"><tr data-dencode-method="string.text-initials"><th>${mf:h(msg['string.text-initials.func.encStrInitials'])}</th><td><span id="encStrInitials" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.text-reverse')}"><tr data-dencode-method="string.text-reverse"><th>${mf:h(msg['string.text-reverse.func.encStrReverse'])}</th><td><span id="encStrReverse" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.font-style')}"><tr data-dencode-method="string.font-style"><th>${mf:h(msg['string.font-style.func.encStrFontStyle'])}</th><td><span id="encStrFontStyle" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.font-style.style'])}</span>
										<select name="string.font-style.style" class="dencode-option form-select">
											<option value="">${mf:h(msg['string.font-style.style.none'])}</option>
											<option value="sansserif">𝖲𝖺𝗇𝗌-𝗌𝖾𝗋𝗂𝖿</option>
											<option value="sansserif-bold">𝗦𝗮𝗻𝘀-𝘀𝗲𝗿𝗶𝗳 (${mf:h(msg['string.font-style.style.bold'])})</option>
											<option value="sansserif-italic">𝘚𝘢𝘯𝘴-𝘴𝘦𝘳𝘪𝘧 (${mf:h(msg['string.font-style.style.italic'])})</option>
											<option value="sansserif-bold-italic">𝙎𝙖𝙣𝙨-𝙨𝙚𝙧𝙞𝙛 (${mf:h(msg['string.font-style.style.bold-italic'])})</option>
											<option value="serif-bold">𝐒𝐞𝐫𝐢𝐟 (${mf:h(msg['string.font-style.style.bold'])})</option>
											<option value="serif-italic">𝑆𝑒𝑟𝑖𝑓 (${mf:h(msg['string.font-style.style.italic'])})</option>
											<option value="serif-bold-italic">𝑺𝒆𝒓𝒊𝒇 (${mf:h(msg['string.font-style.style.bold-italic'])})</option>
											<option value="script">𝒮𝒸𝓇𝒾𝓅𝓉</option>
											<option value="script-bold">𝓢𝓬𝓻𝓲𝓹𝓽 (${mf:h(msg['string.font-style.style.bold'])})</option>
											<option value="fraktur">𝔉𝔯𝔞𝔨𝔱𝔲𝔯</option>
											<option value="fraktur-bold">𝕱𝖗𝖆𝖐𝖙𝖚𝖗 (${mf:h(msg['string.font-style.style.bold'])})</option>
											<option value="doublestruck">𝔻𝕠𝕦𝕓𝕝𝕖 𝕊𝕥𝕣𝕦𝕔𝕜</option>
											<option value="monospace">𝙼𝚘𝚗𝚘𝚜𝚙𝚊𝚌𝚎</option>
											<option value="smallcapital">Sᴍᴀʟʟ Cᴀᴘɪᴛᴀʟ</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.unicode-normalization')}"><tr data-dencode-method="string.unicode-normalization"><th>${mf:h(msg['string.unicode-normalization.func.encStrUnicodeNFC'])}</th><td><span id="encStrUnicodeNFC" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.unicode-normalization')}"><tr data-dencode-method="string.unicode-normalization"><th>${mf:h(msg['string.unicode-normalization.func.encStrUnicodeNFKC'])}</th><td><span id="encStrUnicodeNFKC" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.line-sort')}"><tr data-dencode-method="string.line-sort"><th>${mf:h(msg['string.line-sort.func.encStrLineSort'])}</th><td><span id="encStrLineSort" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['string.line-sort.order'])}</span>
										<select name="string.line-sort.order" class="dencode-option form-select">
											<option value="asc">${mf:h(msg['string.line-sort.order.asc'])}</option>
											<option value="desc">${mf:h(msg['string.line-sort.order.desc'])}</option>
											<option value="reverse">${mf:h(msg['string.line-sort.order.reverse'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.line-unique')}"><tr data-dencode-method="string.line-unique"><th>${mf:h(msg['string.line-unique.func.encStrLineUnique'])}</th><td><span id="encStrLineUnique" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('number')}">
						<tbody>
							<c:if test="${methods.contains('number.dec')}"><tr data-dencode-method="number.dec"><th>${mf:h(msg['number.dec.func.encNumDec'])}</th><td><span id="encNumDec" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.bin')}"><tr data-dencode-method="number.bin"><th>${mf:h(msg['number.bin.func.encNumBin'])}</th><td><span id="encNumBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.oct')}"><tr data-dencode-method="number.oct"><th>${mf:h(msg['number.oct.func.encNumOct'])}</th><td><span id="encNumOct" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.hex')}"><tr data-dencode-method="number.hex"><th>${mf:h(msg['number.hex.func.encNumHex'])}</th><td><span id="encNumHex" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.english')}"><tr data-dencode-method="number.english"><th>${mf:h(msg['number.english.func.encNumEnShortScale'])}</th><td><span id="encNumEnShortScale" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['number.english.decimal-notation'])}</span>
										<select name="number.english.decimal-notation" class="dencode-option form-select">
											<option value="">${mf:h(msg['number.english.decimal-notation.default'])}</option>
											<option value="fraction">${mf:h(msg['number.english.decimal-notation.fraction'])}</option>
										</select>
									</div>
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['number.english.system'])}</span>
										<select name="number.english.system" class="dencode-option form-select">
											<option value="">${mf:h(msg['number.english.system.default'])}</option>
											<option value="cw">${mf:h(msg['number.english.system.cw'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('number.japanese')}"><tr data-dencode-method="number.japanese"><th>${mf:h(msg['number.japanese.func.encNumJP'])}</th><td><span id="encNumJP" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.japanese')}"><tr data-dencode-method="number.japanese"><th>${mf:h(msg['number.japanese.func.encNumJPDaiji'])}</th><td><span id="encNumJPDaiji" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('date')}">
						<tbody>
							<c:if test="${methods.contains('date.unix-time')}"><tr data-dencode-method="date.unix-time"><th>${mf:h(msg['date.unix-time.func.encDateUnixTime'])}</th><td><span id="encDateUnixTime" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('date.w3cdtf')}"><tr data-dencode-method="date.w3cdtf"><th>${mf:h(msg['date.w3cdtf.func.encDateW3CDTF'])}</th><td><span id="encDateW3CDTF" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('date.iso8601')}"><tr data-dencode-method="date.iso8601"><th>${mf:h(msg['date.iso8601.func.encDateISO8601'])}</th><td><span id="encDateISO8601" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['date.iso8601.decimal-separator'])}</span>
										<select name="date.iso8601.decimal-separator" class="dencode-option form-select">
											<option value=".">${mf:h(msg['date.iso8601.decimal-separator.dot'])}</option>
											<option value=",">${mf:h(msg['date.iso8601.decimal-separator.comma'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('date.iso8601')}"><tr data-dencode-method="date.iso8601"><th>${mf:h(msg['date.iso8601.func.encDateISO8601Ext'])}</th><td><span id="encDateISO8601Ext" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['date.iso8601.decimal-separator'])}</span>
										<select name="_date.iso8601.decimal-separator_ext" class="dencode-option form-select" data-sync-with="date.iso8601.decimal-separator">
											<option value=".">${mf:h(msg['date.iso8601.decimal-separator.dot'])}</option>
											<option value=",">${mf:h(msg['date.iso8601.decimal-separator.comma'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('date.iso8601')}"><tr data-dencode-method="date.iso8601"><th>${mf:h(msg['date.iso8601.func.encDateISO8601Week'])}</th><td><span id="encDateISO8601Week" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['date.iso8601.decimal-separator'])}</span>
										<select name="_date.iso8601.decimal-separator_week" class="dencode-option form-select" data-sync-with="date.iso8601.decimal-separator">
											<option value=".">${mf:h(msg['date.iso8601.decimal-separator.dot'])}</option>
											<option value=",">${mf:h(msg['date.iso8601.decimal-separator.comma'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('date.iso8601')}"><tr data-dencode-method="date.iso8601"><th>${mf:h(msg['date.iso8601.func.encDateISO8601Ordinal'])}</th><td><span id="encDateISO8601Ordinal" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['date.iso8601.decimal-separator'])}</span>
										<select name="_date.iso8601.decimal-separator_ordinal" class="dencode-option form-select" data-sync-with="date.iso8601.decimal-separator">
											<option value=".">${mf:h(msg['date.iso8601.decimal-separator.dot'])}</option>
											<option value=",">${mf:h(msg['date.iso8601.decimal-separator.comma'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('date.rfc2822')}"><tr data-dencode-method="date.rfc2822"><th>${mf:h(msg['date.rfc2822.func.encDateRFC2822'])}</th><td><span id="encDateRFC2822" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('date.ctime')}"><tr data-dencode-method="date.ctime"><th>${mf:h(msg['date.ctime.func.encDateCTime'])}</th><td><span id="encDateCTime" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('date.japanese-era')}"><tr data-dencode-method="date.japanese-era"><th>${mf:h(msg['date.japanese-era.func.encDateJapaneseEra'])}</th><td><span id="encDateJapaneseEra" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('color')}">
						<tbody>
							<c:if test="${methods.contains('color.name')}"><tr data-dencode-method="color.name"><th>${mf:h(msg['color.name.func.encColorName'])}</th><td><span id="encColorName" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('color.rgb')}"><tr data-dencode-method="color.rgb"><th>${mf:h(msg['color.rgb.func.encColorRGBHex'])}</th><td><span id="encColorRGBHex" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('color.rgb')}"><tr data-dencode-method="color.rgb"><th>${mf:h(msg['color.rgb.func.encColorRGBFn'])}</th><td><span id="encColorRGBFn" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['color.rgb.notation'])}</span>
										<select name="color.rgb.notation" class="dencode-option form-select">
											<option value="percentage">${mf:h(msg['color.rgb.notation.percentage'])}</option>
											<option value="number">${mf:h(msg['color.rgb.notation.number'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('color.hsl')}"><tr data-dencode-method="color.hsl"><th>${mf:h(msg['color.hsl.func.encColorHSLFn'])}</th><td><span id="encColorHSLFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('color.hsv')}"><tr data-dencode-method="color.hsv"><th>${mf:h(msg['color.hsv.func.encColorHSVFn'])}</th><td><span id="encColorHSVFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('color.cmyk')}"><tr data-dencode-method="color.cmyk"><th>${mf:h(msg['color.cmyk.func.encColorCMYKFn'])}</th><td><span id="encColorCMYKFn" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('cipher')}">
						<tbody>
							<c:if test="${methods.contains('cipher.caesar')}"><tr data-dencode-method="cipher.caesar"><th>${mf:h(msg['cipher.caesar.func.encCipherCaesar'])}</th><td><span id="encCipherCaesar" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.caesar.shift'])}</span>
										<select name="cipher.caesar.shift" class="dencode-option form-select" data-default-value="-3">
											<option value="-42">${mf:h(msg['cipher.caesar.shift.b42'])}</option>
											<option value="-41">${mf:h(msg['cipher.caesar.shift.b41'])}</option>
											<option value="-40">${mf:h(msg['cipher.caesar.shift.b40'])}</option>
											<option value="-39">${mf:h(msg['cipher.caesar.shift.b39'])}</option>
											<option value="-38">${mf:h(msg['cipher.caesar.shift.b38'])}</option>
											<option value="-37">${mf:h(msg['cipher.caesar.shift.b37'])}</option>
											<option value="-36">${mf:h(msg['cipher.caesar.shift.b36'])}</option>
											<option value="-35">${mf:h(msg['cipher.caesar.shift.b35'])}</option>
											<option value="-34">${mf:h(msg['cipher.caesar.shift.b34'])}</option>
											<option value="-33">${mf:h(msg['cipher.caesar.shift.b33'])}</option>
											<option value="-32">${mf:h(msg['cipher.caesar.shift.b32'])}</option>
											<option value="-31">${mf:h(msg['cipher.caesar.shift.b31'])}</option>
											<option value="-30">${mf:h(msg['cipher.caesar.shift.b30'])}</option>
											<option value="-29">${mf:h(msg['cipher.caesar.shift.b29'])}</option>
											<option value="-28">${mf:h(msg['cipher.caesar.shift.b28'])}</option>
											<option value="-27">${mf:h(msg['cipher.caesar.shift.b27'])}</option>
											<option value="-26">${mf:h(msg['cipher.caesar.shift.b26'])}</option>
											<option value="-25">${mf:h(msg['cipher.caesar.shift.b25'])}</option>
											<option value="-24">${mf:h(msg['cipher.caesar.shift.b24'])}</option>
											<option value="-23">${mf:h(msg['cipher.caesar.shift.b23'])}</option>
											<option value="-22">${mf:h(msg['cipher.caesar.shift.b22'])}</option>
											<option value="-21">${mf:h(msg['cipher.caesar.shift.b21'])}</option>
											<option value="-20">${mf:h(msg['cipher.caesar.shift.b20'])}</option>
											<option value="-19">${mf:h(msg['cipher.caesar.shift.b19'])}</option>
											<option value="-18">${mf:h(msg['cipher.caesar.shift.b18'])}</option>
											<option value="-17">${mf:h(msg['cipher.caesar.shift.b17'])}</option>
											<option value="-16">${mf:h(msg['cipher.caesar.shift.b16'])}</option>
											<option value="-15">${mf:h(msg['cipher.caesar.shift.b15'])}</option>
											<option value="-14">${mf:h(msg['cipher.caesar.shift.b14'])}</option>
											<option value="-13">${mf:h(msg['cipher.caesar.shift.b13'])}</option>
											<option value="-12">${mf:h(msg['cipher.caesar.shift.b12'])}</option>
											<option value="-11">${mf:h(msg['cipher.caesar.shift.b11'])}</option>
											<option value="-10">${mf:h(msg['cipher.caesar.shift.b10'])}</option>
											<option value="-9">${mf:h(msg['cipher.caesar.shift.b9'])}</option>
											<option value="-8">${mf:h(msg['cipher.caesar.shift.b8'])}</option>
											<option value="-7">${mf:h(msg['cipher.caesar.shift.b7'])}</option>
											<option value="-6">${mf:h(msg['cipher.caesar.shift.b6'])}</option>
											<option value="-5">${mf:h(msg['cipher.caesar.shift.b5'])}</option>
											<option value="-4">${mf:h(msg['cipher.caesar.shift.b4'])}</option>
											<option value="-3">${mf:h(msg['cipher.caesar.shift.b3'])}</option>
											<option value="-2">${mf:h(msg['cipher.caesar.shift.b2'])}</option>
											<option value="-1">${mf:h(msg['cipher.caesar.shift.b1'])}</option>
											<option value="1">${mf:h(msg['cipher.caesar.shift.1'])}</option>
											<option value="2">${mf:h(msg['cipher.caesar.shift.2'])}</option>
											<option value="3">${mf:h(msg['cipher.caesar.shift.3'])}</option>
											<option value="4">${mf:h(msg['cipher.caesar.shift.4'])}</option>
											<option value="5">${mf:h(msg['cipher.caesar.shift.5'])}</option>
											<option value="6">${mf:h(msg['cipher.caesar.shift.6'])}</option>
											<option value="7">${mf:h(msg['cipher.caesar.shift.7'])}</option>
											<option value="8">${mf:h(msg['cipher.caesar.shift.8'])}</option>
											<option value="9">${mf:h(msg['cipher.caesar.shift.9'])}</option>
											<option value="10">${mf:h(msg['cipher.caesar.shift.10'])}</option>
											<option value="11">${mf:h(msg['cipher.caesar.shift.11'])}</option>
											<option value="12">${mf:h(msg['cipher.caesar.shift.12'])}</option>
											<option value="13">${mf:h(msg['cipher.caesar.shift.13'])}</option>
											<option value="14">${mf:h(msg['cipher.caesar.shift.14'])}</option>
											<option value="15">${mf:h(msg['cipher.caesar.shift.15'])}</option>
											<option value="16">${mf:h(msg['cipher.caesar.shift.16'])}</option>
											<option value="17">${mf:h(msg['cipher.caesar.shift.17'])}</option>
											<option value="18">${mf:h(msg['cipher.caesar.shift.18'])}</option>
											<option value="19">${mf:h(msg['cipher.caesar.shift.19'])}</option>
											<option value="20">${mf:h(msg['cipher.caesar.shift.20'])}</option>
											<option value="21">${mf:h(msg['cipher.caesar.shift.21'])}</option>
											<option value="22">${mf:h(msg['cipher.caesar.shift.22'])}</option>
											<option value="23">${mf:h(msg['cipher.caesar.shift.23'])}</option>
											<option value="24">${mf:h(msg['cipher.caesar.shift.24'])}</option>
											<option value="25">${mf:h(msg['cipher.caesar.shift.25'])}</option>
											<option value="26">${mf:h(msg['cipher.caesar.shift.26'])}</option>
											<option value="27">${mf:h(msg['cipher.caesar.shift.27'])}</option>
											<option value="28">${mf:h(msg['cipher.caesar.shift.28'])}</option>
											<option value="29">${mf:h(msg['cipher.caesar.shift.29'])}</option>
											<option value="30">${mf:h(msg['cipher.caesar.shift.30'])}</option>
											<option value="31">${mf:h(msg['cipher.caesar.shift.31'])}</option>
											<option value="32">${mf:h(msg['cipher.caesar.shift.32'])}</option>
											<option value="33">${mf:h(msg['cipher.caesar.shift.33'])}</option>
											<option value="34">${mf:h(msg['cipher.caesar.shift.34'])}</option>
											<option value="35">${mf:h(msg['cipher.caesar.shift.35'])}</option>
											<option value="36">${mf:h(msg['cipher.caesar.shift.36'])}</option>
											<option value="37">${mf:h(msg['cipher.caesar.shift.37'])}</option>
											<option value="38">${mf:h(msg['cipher.caesar.shift.38'])}</option>
											<option value="39">${mf:h(msg['cipher.caesar.shift.39'])}</option>
											<option value="40">${mf:h(msg['cipher.caesar.shift.40'])}</option>
											<option value="41">${mf:h(msg['cipher.caesar.shift.41'])}</option>
											<option value="42">${mf:h(msg['cipher.caesar.shift.42'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot13')}"><tr data-dencode-method="cipher.rot13"><th>${mf:h(msg['cipher.rot13.func.encCipherROT13'])}</th><td><span id="encCipherROT13" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot18')}"><tr data-dencode-method="cipher.rot18"><th>${mf:h(msg['cipher.rot18.func.encCipherROT18'])}</th><td><span id="encCipherROT18" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot47')}"><tr data-dencode-method="cipher.rot47"><th>${mf:h(msg['cipher.rot47.func.encCipherROT47'])}</th><td><span id="encCipherROT47" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.atbash')}"><tr data-dencode-method="cipher.atbash"><th>${mf:h(msg['cipher.atbash.func.encCipherAtbash'])}</th><td><span id="encCipherAtbash" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.affine')}"><tr data-dencode-method="cipher.affine"><th>${mf:h(msg['cipher.affine.func.encCipherAffine'])}</th><td><span id="encCipherAffine" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.affine.a'])}</span>
										<select name="cipher.affine.a" class="dencode-option form-select" data-default-value="1">
											<option value="-25">-25</option>
											<option value="-23">-23</option>
											<option value="-21">-21</option>
											<option value="-19">-19</option>
											<option value="-17">-17</option>
											<option value="-15">-15</option>
											<option value="-13">-13</option>
											<option value="-11">-11</option>
											<option value="-9">-9</option>
											<option value="-7">-7</option>
											<option value="-5">-5</option>
											<option value="-3">-3</option>
											<option value="-1">-1</option>
											<option value="1">1</option>
											<option value="3">3</option>
											<option value="5">5</option>
											<option value="7">7</option>
											<option value="9">9</option>
											<option value="11">11</option>
											<option value="13">13</option>
											<option value="15">15</option>
											<option value="17">17</option>
											<option value="19">19</option>
											<option value="21">21</option>
											<option value="23">23</option>
											<option value="25">25</option>
										</select>
									</div>
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.affine.b'])}</span>
										<select name="cipher.affine.b" class="dencode-option form-select" data-default-value="0">
											<option value="-25">-25</option>
											<option value="-24">-24</option>
											<option value="-23">-23</option>
											<option value="-22">-22</option>
											<option value="-21">-21</option>
											<option value="-20">-20</option>
											<option value="-19">-19</option>
											<option value="-18">-18</option>
											<option value="-17">-17</option>
											<option value="-16">-16</option>
											<option value="-15">-15</option>
											<option value="-14">-14</option>
											<option value="-13">-13</option>
											<option value="-12">-12</option>
											<option value="-11">-11</option>
											<option value="-10">-10</option>
											<option value="-9">-9</option>
											<option value="-8">-8</option>
											<option value="-7">-7</option>
											<option value="-6">-6</option>
											<option value="-5">-5</option>
											<option value="-4">-4</option>
											<option value="-3">-3</option>
											<option value="-2">-2</option>
											<option value="-1">-1</option>
											<option value="0">0</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
											<option value="21">21</option>
											<option value="22">22</option>
											<option value="23">23</option>
											<option value="24">24</option>
											<option value="25">25</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('cipher.vigenere')}"><tr data-dencode-method="cipher.vigenere"><th>${mf:h(msg['cipher.vigenere.func.encCipherVigenere'])}</th><td><span id="encCipherVigenere" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.vigenere.key'])}</span>
										<input name="cipher.vigenere.key" class="dencode-option form-control" value="" placeholder="${mf:h(msg['cipher.vigenere.key.tooltip'])}" />
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.enigma')}"><tr data-dencode-method="cipher.enigma"><th>${mf:h(msg['cipher.enigma.func.encCipherEnigma'])}</th><td><span id="encCipherEnigma" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="dencode-option-grid cipher-enigma">
										<div class="dencode-option-grid-label cipher-enigma-option-machine">
											${mf:h(msg['cipher.enigma.machine'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-machine">
											<select name="cipher.enigma.machine" class="dencode-option form-select">
												<option value="I" data-reflectors="UKW-A,UKW-B,UKW-C,UKW-D" data-rotors="I,II,III,IV,V" data-has="plugboard,uhr,ukwd">Enigma I</option>
												<option value="M3" data-reflectors="UKW-B,UKW-C" data-rotors="I,II,III,IV,V,VI,VII,VIII" data-has="plugboard">Enigma M3</option>
												<option value="M4" data-reflectors="UKW-B,UKW-C,UKW-D" data-rotors="I,II,III,IV,V,VI,VII,VIII" data-has="4wheels,plugboard,ukwd">Enigma M4 (U-boat Enigma)</option>
												<option value="Norway" data-reflectors="UKW" data-rotors="I,II,III,IV,V" data-has="plugboard">Norway Enigma "Norenigma"</option>
												<option value="Sonder" data-reflectors="UKW" data-rotors="I,II,III" data-has="plugboard">Sondermaschine (Special machine)</option>
												<option value="G" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma G "Zählwerk Enigma" (A28/G31)</option>
												<option value="G-312" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma G G-312 (G31 Abwehr Enigma)</option>
												<option value="G-260" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma G G-260 (G31 Abwehr Enigma)</option>
												<option value="G-111" data-reflectors="UKW" data-rotors="I,II,V" data-has="settable-reflector">Enigma G G-111 (G31 Hungarian Enigma)</option>
												<option value="D" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma D (Commercial Enigma A26)</option>
												<option value="K" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Enigma K (Commercial Enigma A27)</option>
												<option value="KD" data-reflectors="UKW,UKW-D" data-rotors="I,II,III" data-has="ukwd">Enigma KD (Enigma K with UKW-D)</option>
												<option value="Swiss-K" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Swiss-K (Swiss Enigma K variant)</option>
												<option value="Railway" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Railway Enigma "Rocket I"</option>
												<option value="T" data-reflectors="UKW" data-rotors="I,II,III,IV,V,VI,VII,VIII" data-has="settable-reflector">Enigma T "Tirpitz" (Japanese Enigma)</option>
												<option value="Spanish-D" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Spanish Enigma, wiring D</option>
												<option value="Spanish-F" data-reflectors="UKW" data-rotors="I,II,III" data-has="settable-reflector">Spanish Enigma, wiring F</option>
												<option value="Spanish-Delta" data-reflectors="UKW" data-rotors="I,II,III,IV,V" data-has="settable-reflector">Spanish Enigma, Delta (A 16081)</option>
												<option value="Spanish-S" data-reflectors="UKW" data-rotors="I,II,III,IV,V" data-has="plugboard,settable-reflector">Spanish Enigma, Sonderschaltung / Delta (A 16101)</option>
											</select>
										</div>
										<div class="dencode-option-grid-label">
											${mf:h(msg['cipher.enigma.wheels'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-reflector">
											<select name="cipher.enigma.reflector" class="dencode-option form-select">
												<option value="UKW">UKW</option>
												<option value="UKW-A">UKW-A</option>
												<option value="UKW-B">UKW-B</option>
												<option value="UKW-C">UKW-C</option>
												<option value="UKW-D">UKW-D</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor4">
											<select name="cipher.enigma.rotor4" class="dencode-option form-select">
												<option value="Beta">Beta</option>
												<option value="Gamma">Gamma</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor3">
											<select name="cipher.enigma.rotor3" class="dencode-option form-select" data-default-value="III">
												<option value="I">I</option>
												<option value="II">II</option>
												<option value="III">III</option>
												<option value="IV">IV</option>
												<option value="V">V</option>
												<option value="VI">VI</option>
												<option value="VII">VII</option>
												<option value="VIII">VIII</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor2">
											<select name="cipher.enigma.rotor2" class="dencode-option form-select" data-default-value="II">
												<option value="I">I</option>
												<option value="II">II</option>
												<option value="III">III</option>
												<option value="IV">IV</option>
												<option value="V">V</option>
												<option value="VI">VI</option>
												<option value="VII">VII</option>
												<option value="VIII">VIII</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor1">
											<select name="cipher.enigma.rotor1" class="dencode-option form-select" data-default-value="I">
												<option value="I">I</option>
												<option value="II">II</option>
												<option value="III">III</option>
												<option value="IV">IV</option>
												<option value="V">V</option>
												<option value="VI">VI</option>
												<option value="VII">VII</option>
												<option value="VIII">VIII</option>
											</select>
										</div>
										
										<div class="dencode-option-grid-label">
											${mf:h(msg['cipher.enigma.rings'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-reflector cipher-enigma-option-reflector-ring">
											<select name="cipher.enigma.reflector-ring" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor4">
											<select name="cipher.enigma.rotor4-ring" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor3">
											<select name="cipher.enigma.rotor3-ring" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor2">
											<select name="cipher.enigma.rotor2-ring" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor1">
											<select name="cipher.enigma.rotor1-ring" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										
										<div class="dencode-option-grid-label">
											${mf:h(msg['cipher.enigma.positions'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-reflector cipher-enigma-option-reflector-position">
											<select name="cipher.enigma.reflector-position" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor4">
											<select name="cipher.enigma.rotor4-position" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor3">
											<select name="cipher.enigma.rotor3-position" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor2">
											<select name="cipher.enigma.rotor2-position" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-rotor1">
											<select name="cipher.enigma.rotor1-position" class="dencode-option form-select">
												<option value="1">A (01)</option>
												<option value="2">B (02)</option>
												<option value="3">C (03)</option>
												<option value="4">D (04)</option>
												<option value="5">E (05)</option>
												<option value="6">F (06)</option>
												<option value="7">G (07)</option>
												<option value="8">H (08)</option>
												<option value="9">I (09)</option>
												<option value="10">J (10)</option>
												<option value="11">K (11)</option>
												<option value="12">L (12)</option>
												<option value="13">M (13)</option>
												<option value="14">N (14)</option>
												<option value="15">O (15)</option>
												<option value="16">P (16)</option>
												<option value="17">Q (17)</option>
												<option value="18">R (18)</option>
												<option value="19">S (19)</option>
												<option value="20">T (20)</option>
												<option value="21">U (21)</option>
												<option value="22">V (22)</option>
												<option value="23">W (23)</option>
												<option value="24">X (24)</option>
												<option value="25">Y (25)</option>
												<option value="26">Z (26)</option>
											</select>
										</div>
										
										<div class="dencode-option-grid-label cipher-enigma-option-plugboard">
											${mf:h(msg['cipher.enigma.plugboard'])}
										</div>
										<div class="dencode-option-grid-label cipher-enigma-option-uhr">
											${mf:h(msg['cipher.enigma.uhr'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-plugboard">
											<input type="text" name="cipher.enigma.plugboard" class="dencode-option form-control" value="" placeholder="${mf:h(msg['cipher.enigma.plugboard.tooltip'])}" />
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-uhr">
											<select name="cipher.enigma.uhr" class="dencode-option form-select">
												<option value="0">00</option>
												<option value="1">01</option>
												<option value="2">02</option>
												<option value="3">03</option>
												<option value="4">04</option>
												<option value="5">05</option>
												<option value="6">06</option>
												<option value="7">07</option>
												<option value="8">08</option>
												<option value="9">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
												<option value="24">24</option>
												<option value="25">25</option>
												<option value="26">26</option>
												<option value="27">27</option>
												<option value="28">28</option>
												<option value="29">29</option>
												<option value="30">30</option>
												<option value="31">31</option>
												<option value="32">32</option>
												<option value="33">33</option>
												<option value="34">34</option>
												<option value="35">35</option>
												<option value="36">36</option>
												<option value="37">37</option>
												<option value="38">38</option>
												<option value="39">39</option>
											</select>
										</div>
										
										<div class="dencode-option-grid-label cipher-enigma-option-ukwd">
											${mf:h(msg['cipher.enigma.ukwd'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-ukwd">
											<input type="text" name="cipher.enigma.ukwd" class="dencode-option form-control" value="" placeholder="${mf:h(msg['cipher.enigma.ukwd.tooltip'])}" />
										</div>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('cipher.jis-keyboard')}"><tr data-dencode-method="cipher.jis-keyboard"><th>${mf:h(msg['cipher.jis-keyboard.func.encCipherJisKeyboard'])}</th><td><span id="encCipherJisKeyboard" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.jis-keyboard.mode'])}</span>
										<select name="cipher.jis-keyboard.mode" class="dencode-option form-select">
											<option value="lenient">${mf:h(msg['cipher.jis-keyboard.mode.lenient'])}</option>
											<option value="strict">${mf:h(msg['cipher.jis-keyboard.mode.strict'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('cipher.scytale')}"><tr data-dencode-method="cipher.scytale"><th>${mf:h(msg['cipher.scytale.func.encCipherScytale'])}</th><td><span id="encCipherScytale" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.scytale.key'])}</span>
										<select name="cipher.scytale.key" class="dencode-option form-select">
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
										</select>
										
										<span class="input-group-text">${mf:h(msg['cipher.scytale.key-per'])}</span>
										<select name="cipher.scytale.key-per" class="dencode-option form-select">
											<option value="y">${mf:h(msg['cipher.scytale.key-per.y'])}</option>
											<option value="x">${mf:h(msg['cipher.scytale.key-per.x'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.rail-fence')}"><tr data-dencode-method="cipher.rail-fence"><th>${mf:h(msg['cipher.rail-fence.func.encCipherRailFence'])}</th><td><span id="encCipherRailFence" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${mf:h(msg['cipher.rail-fence.key'])}</span>
										<select name="cipher.rail-fence.key" class="dencode-option form-select">
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('hash')}">
						<tbody>
							<c:if test="${methods.contains('hash.md2')}"><tr data-dencode-method="hash.md2"><th>${mf:h(msg['hash.md2.func.encHashMD2'])}</th><td><span id="encHashMD2" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.md5')}"><tr data-dencode-method="hash.md5"><th>${mf:h(msg['hash.md5.func.encHashMD5'])}</th><td><span id="encHashMD5" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.sha1')}"><tr data-dencode-method="hash.sha1"><th>${mf:h(msg['hash.sha1.func.encHashSHA1'])}</th><td><span id="encHashSHA1" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.sha256')}"><tr data-dencode-method="hash.sha256"><th>${mf:h(msg['hash.sha256.func.encHashSHA256'])}</th><td><span id="encHashSHA256" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.sha384')}"><tr data-dencode-method="hash.sha384"><th>${mf:h(msg['hash.sha384.func.encHashSHA384'])}</th><td><span id="encHashSHA384" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.sha512')}"><tr data-dencode-method="hash.sha512"><th>${mf:h(msg['hash.sha512.func.encHashSHA512'])}</th><td><span id="encHashSHA512" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.crc32')}"><tr data-dencode-method="hash.crc32"><th>${mf:h(msg['hash.crc32.func.encHashCRC32'])}</th><td><span id="encHashCRC32" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
				</table>
			</div>
		</div>
		
		<div id="otherDencodeNav">
			<c:if test="${method eq 'string.bin'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="string.hex">${mf:h(msg['label.otherDencodeLink.string.hex'])}</a></div>
			</c:if>
			<c:if test="${method eq 'string.hex'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="string.bin">${mf:h(msg['label.otherDencodeLink.string.bin'])}</a></div>
			</c:if>
			
			<c:if test="${method eq 'string.camel-case' or method eq 'string.snake-case' or method eq 'string.kebab-case'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="string.naming-convention">${mf:h(msg['label.otherDencodeLink.string.naming-convention'])}</a></div>
			</c:if>
			
			<c:if test="${method eq 'number.bin'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="number.bin">${mf:h(msg['label.otherDencodeLink.number.bin'])}</a></div>
			</c:if>
			<c:if test="${method eq 'number.hex'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="number.hex">${mf:h(msg['label.otherDencodeLink.number.hex'])}</a></div>
			</c:if>
			
			<c:if test="${type ne 'all'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="${mf:h((fn:endsWith(method, '.all')) ? 'all.all' : mf:strcat(type, '.all'))}">${mf:h(msg[mf:strcat('label.otherDencodeLink.', (fn:endsWith(method, '.all')) ? 'all.all' : mf:strcat(type, '.all'))])}</a></div>
			</c:if>
		</div>
		
		<div id="adBottom" style="margin: 2em 0 1em;">
			<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-6871955725174244" data-ad-slot="5289392761" data-ad-format="rectangle" data-full-width-responsive="true"></ins>
		</div>
		
		<c:set var="methodDescIncPagePath" value="method-desc_${method}_${msg['lang']}.inc.jsp" scope="request" />
		<c:if test="${mf:fileExists(pageContext.servletContext.getRealPath(mf:strcat('/WEB-INF/pages/', methodDescIncPagePath)))}">
			<hr />
			<jsp:include page="${methodDescIncPagePath}" />
		</c:if>
	</div>
</div>

<footer>
	© <a href="https://github.com/mozq/dencode-web" target="_blank">Mozq</a>
	| <a href="#" data-bs-toggle="modal" data-bs-target="#policyDialog">${mf:h(msg['label.policy'])}</a>
</footer>

<div id="messageDialog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div id="messageDialogBody" class="modal-body">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn" data-bs-dismiss="modal">${mf:h(msg['label.ok'])}</button>
			</div>
		</div>
	</div>
</div>

<div id="policyDialog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<span id="policyDialogLabel" class="modal-title">${mf:h(msg['label.policy'])}</span>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="${mf:h(msg['label.close'])}"></button>
			</div>
			<div class="modal-body">
				<c:choose>
					<c:when test="${mf:fileExists(pageContext.servletContext.getRealPath(mf:strcat3('/WEB-INF/pages/policy_', msg['lang'], '.inc.jsp')))}">
						<jsp:include page="policy_${msg['lang']}.inc.jsp" />
					</c:when>
					<c:otherwise>
						<jsp:include page="policy_en.inc.jsp" />
					</c:otherwise>
				</c:choose>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn" data-bs-dismiss="modal">${mf:h(msg['label.close'])}</button>
			</div>
		</div>
	</div>
</div>

<div style="display: none;">
	<input id="loadFileInput" type="file" accept="text/*" />
	<input id="loadImageInput" type="file" accept="image/*" />
	<input id="loadQrcodeInput" type="file" accept="image/*" />
</div>

<script id="messageTmpl" type="text/template">
	<div class="alert {{#type}}alert-{{type}}{{/type}} alert-dismissible" data-message-id="{{messageId}}" data-message-level="{{level}}" role="alert">
		<strong>{{message}}</strong>
		{{#detail}}<p>{{detail}}</p>{{/detail}}
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="${mf:h(msg['label.close'])}"></button>
	</div>
</script>
<script id="forCopyTmpl" type="text/template">
	<div class="for-copy">
		<div class="input-group">
			<textarea id="{{id}}ForCopy" class="form-control select-on-focus" rows="2" readonly>{{value}}</textarea>
			<span class="btn-group-vertical">
				<button type="button" class="btn btn-v-icon-label copy-to-clipboard" title="${mf:h(msg['label.copyToClipboard'])}" data-copy-id="{{id}}ForCopy" data-copy-message="${mf:h(msg['label.copyToClipboard.message'])}" data-copy-error-message="${mf:h(msg['label.copyToClipboard.errorMessage'])}">
					<i class="bi bi-clipboard"></i>
					<span class="btn-label">${mf:h(msg['label.copyToClipboard.buttonLabel'])}</span>
				</button>
				<button type="button" class="btn btn-v-icon-label permanent-link popover-toggle" title="${mf:h(msg['label.permanentLink'])}" data-bs-toggle="popover" data-bs-placement="left">
					<i class="bi bi-link-45deg"></i>
					<span class="btn-label">${mf:h(msg['label.permanentLink.buttonLabel'])}</span>
				</button>
			</span>
		</div>
	</div>
</script>
<script id="lengthTmpl" type="text/template">
	{{chars}}
	{{#oneChar}}${mf:h(msg['label.val.length.char'])}{{/oneChar}}
	{{^oneChar}}${mf:h(msg['label.val.length.chars'])}{{/oneChar}}
	/
	{{bytes}}
	{{#oneByte}}${mf:h(msg['label.val.length.byte'])}{{/oneByte}}
	{{^oneByte}}${mf:h(msg['label.val.length.bytes'])}{{/oneByte}}
</script>
<script id="permanentLinkTmpl" type="text/template">
	<div id="permanentLink" class="input-group">
		<input id="linkURL" class="form-control select-on-focus" type="text" value="{{permanentLink}}" readonly />
		<button type="button" class="btn btn-v-icon-label copy-to-clipboard" title="${mf:h(msg['label.copyToClipboard'])}" data-copy-id="linkURL" data-copy-message="${mf:h(msg['label.copyToClipboard.message'])}" data-copy-error-message="${mf:h(msg['label.copyToClipboard.errorMessage'])}">
			<i class="bi bi-clipboard"></i>
			<span class="btn-label">${mf:h(msg['label.copyToClipboard.buttonLabel'])}</span>
		</button>
		<button type="button" class="btn btn-v-icon-label dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
			<i class="bi bi-share-fill"></i>
			<span class="btn-label">${mf:h(msg['label.share.buttonLabel'])}</span>
			<span class="caret"></span>
		</button>
		<ul class="dropdown-menu" role="menu">
			<li><a class="dropdown-item share-link" href="{{permanentLink}}" target="_blank" data-share-method="openNewPage"><i class="bi bi-box-arrow-up-right"></i> ${mf:h(msg['label.openNewPage'])}</a></li>
			<li><a class="dropdown-item share-link" href="mailto:?body=%0D%0A{{permanentLinkUrlEncoded}}" data-share-method="sendByEmail"><i class="bi bi-envelope"></i> ${mf:h(msg['label.sendByEmail'])}</a></li>
			<li><a class="dropdown-item share-link" href="https://twitter.com/share?url={{permanentLinkUrlEncoded}}" target="_blank" data-share-method="shareOnTwitter"><i class="bi bi-twitter"></i> ${mf:h(msg['label.shareOnTwitter'])}</a></li>
			<li><a class="dropdown-item share-link" href="https://www.facebook.com/sharer/sharer.php?u={{permanentLinkUrlEncoded}}" target="_blank" data-share-method="shareOnFacebook"><i class="bi bi-facebook"></i> ${mf:h(msg['label.shareOnFacebook'])}</a></li>
		</ul>
	</div>
</script>
<script id="adMiddleTmpl" type="text/template">
	<tr id="adMiddle">
		<td colspan="2" style="padding: 2em 0">
			<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-6871955725174244" data-ad-slot="8967889103" data-ad-format="rectangle, horizontal" data-full-width-responsive="true"></ins>
		</td>
	</tr>
</script>

<script id="dencoderDefs" type="application/json">${dencoderDefsJson}</script>

<script type="text/message" data-id="default.error" data-level="${mf:h(msg['default.error.level'])}" data-message="${mf:h(msg['default.error'])}" data-detail="${mf:h(msg['default.error.detail'])}"></script>
<script type="text/message" data-id="network.error" data-level="${mf:h(msg['network.error.level'])}" data-message="${mf:h(msg['network.error'])}" data-detail="${mf:h(msg['network.error.detail'])}"></script>

<svg style="display: none;" aria-hidden="true">
	<defs>
		<symbol id="loading-indicator" fill="none" stroke="currentColor" viewBox="0 0 100 100">
			<circle cx="50" cy="50" r="40" stroke-width="15" stroke-dasharray="200">
				<animateTransform attributeName="transform" type="rotate" dur="1s" keyTimes="0;1" values="0 50 50;360 50 50" repeatCount="indefinite" />
			</circle>
		</symbol>
	</defs>
</svg>

</body>
</html>
