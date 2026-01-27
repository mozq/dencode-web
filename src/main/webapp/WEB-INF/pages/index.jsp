<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="jakarta.tags.core"
%><%@ taglib prefix="dc" uri="http://dencode.com/jsp/taglib"
%><!DOCTYPE html>
<html lang="${dc:h(msg['lang'])}" prefix="og: http://ogp.me/ns#" data-lang3="${dc:h(msg['lang3'])}" data-ui-theme="">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="description" content="${dc:h(msg[method += '.desc'])}" />
	<meta name="robots" content="index,follow,noarchive" />
	<meta name="application-name" content="${dc:h(msg['site.name'])}" />
	<meta name="apple-mobile-web-app-title" content="${dc:h(msg['site.name'])}" />
	<meta name="format-detection" content="address=no,date=no,email=no,telephone=no,url=no" />
	<meta property="og:site_name" content="${dc:h(msg['site.name'])}" />
	<meta property="og:url" content="${baseURL}${pageContext.request.contextPath}/${dc:h(currentPath)}" />
	<meta property="og:image" content="${baseURL}${pageContext.request.contextPath}/static/img/icons/icon-512.png" />
	<meta property="og:locale" content="${dc:h(msg['locale'])}" />
	<meta property="og:type" content="website" />
	<c:choose>
		<c:when test="${method eq 'all.all'}"><meta property="og:title" content="${dc:h(msg['site.name'])} | ${dc:h(msg[method += '.title'])}" /></c:when>
		<c:otherwise><meta property="og:title" content="${dc:h(msg[method += '.title'])} - ${dc:h(msg['site.name'])}" /></c:otherwise>
	</c:choose>
	<meta property="og:description" content="${dc:h(msg[method += '.desc'])}" />
	<c:forEach var="loc" items="${supportedLocaleMap}">
		<link rel="alternate" hreflang="${dc:h(loc.key.toLowerCase())}" href="${baseURL}${pageContext.request.contextPath}/${dc:h(loc.key.toLowerCase())}/${dc:h(currentPath)}" />
	</c:forEach>
	<link rel="alternate" hreflang="x-default" href="${baseURL}${pageContext.request.contextPath}/${dc:h(currentPath)}" />
	<link rel="apple-touch-icon" type="image/png" href="${pageContext.request.contextPath}/apple-touch-icon.png" />
	<link rel="apple-touch-icon" type="image/svg+xml" href="${pageContext.request.contextPath}/static/img/icons/icon.svg" />
	<link rel="icon" type="image/png" sizes="192x192" href="${pageContext.request.contextPath}/static/img/icons/icon-192.png" />
	<link rel="icon" type="image/svg+xml" sizes="any" href="${pageContext.request.contextPath}/static/img/icons/icon.svg" />
	<link rel="manifest" href="${pageContext.request.contextPath}/manifest.json" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css?v=${dc:fileLastModified(pageContext, '/static/css/main.css')}" />
	<script defer src="${pageContext.request.contextPath}/static/js/all.min.js?v=${dc:fileLastModified(pageContext, '/static/js/all.min.js')}"></script>
	<script id="scriptTesseract" data-src="https://cdn.jsdelivr.net/npm/tesseract.js@6.0.1/dist/tesseract.min.js" integrity="sha256-EP/3hIQGd1nEMCigKnLXbQuQ6xcwK7I7WKnsVBC8kos=" crossorigin="anonymous"></script>
	<script id="scriptZXing" data-src="https://cdn.jsdelivr.net/npm/@zxing/library@0.21.3/umd/index.min.js" integrity="sha256-18yPad1wvc86wAya5XK/KsufQTK6N5xy34QuTbkYZS0=" crossorigin="anonymous"></script>
	<style><%-- Bootstrap Icons --%>
		.bi-globe2 { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/globe2.svg'); }
		.bi-pin-angle-fill { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/pin-angle-fill.svg'); }
		.bi-file-earmark-arrow-up { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/file-earmark-arrow-up.svg'); }
		.bi-link-45deg { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/link-45deg.svg'); }
		.bi-file-text { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/file-text.svg'); }
		.bi-camera { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/camera.svg'); }
		.bi-qr-code-scan { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/qr-code-scan.svg'); }
		.bi-clipboard { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/clipboard.svg'); }
		.bi-link-45deg { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/link-45deg.svg'); }
		.bi-share-fill { --bi-icon: url('https://cdn.jsdelivr.net/npm/bootstrap-icons@1/icons/share-fill.svg'); }
		.bi { display: inline-block; width: 1em; height: 1em; vertical-align: -0.125em; background-color: currentColor; -webkit-mask-image: var(--bi-icon); mask-image: var(--bi-icon); -webkit-mask-size: cover; mask-size: cover; }
	</style>
	<script>
		document.documentElement.setAttribute("data-ui-theme", (window.matchMedia?.("(prefers-color-scheme:dark)")?.matches) ? "dark" : "light");
	</script>
	<c:choose>
		<c:when test="${method eq 'all.all'}"><title>${dc:h(msg['site.name'])} | ${dc:h(msg[method += '.title'])}</title></c:when>
		<c:otherwise><title>${dc:h(msg[method += '.title'])} - ${dc:h(msg['site.name'])}</title></c:otherwise>
	</c:choose>
</head>
<body data-context-path="${pageContext.request.contextPath}" data-dencode-type="${type}" data-dencode-method="${method}">
<header role="banner">
	<nav class="navbar" role="navigation">
		<a id="brand" class="navbar-brand" href="${dc:h(basePath)}/">${dc:h(msg['site.name'])}</a>
		<span class="navbar-text">Enjoy encoding &amp; decoding!</span>
		
		<div id="localeMenu" class="dropdown">
			<div class="dropdown-toggle" role="button" aria-expanded="false">
				<i class="bi bi-globe2"></i>
				${dc:h(msg['locale.name'])}
				
				<ul class="dropdown-menu dropdown-menu-end" role="menu">
					<li class="${(localeId eq null) ? 'active' : ''}"><a href="${pageContext.request.contextPath}/${dc:h(currentPath)}">${dc:h(msg['locale.name.default'])} (${dc:h(defaultLocaleName)})</a></li>
					<li><hr /></li>
					<c:forEach var="loc" items="${supportedLocaleMap}">
						<li class="${(localeId eq loc.key) ? 'active' : ''}"><a hreflang="${dc:h(loc.key.toLowerCase())}" href="${pageContext.request.contextPath}/${dc:h(loc.key.toLowerCase())}/${dc:h(currentPath)}">${dc:h(loc.value)}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		
		<button type="button" class="navbar-toggler" aria-label="${dc:h(msg['label.menu'])}" aria-controls="navMenu" aria-expanded="false">
			<svg class="navbar-toggler-icon"><use href="#menu" /></svg>
		</button>
	</nav>
	<nav id="navMenu" class="navbar navbar-collapsible" role="navigation">
		<ul id="typeMenu" class="navbar-nav">
			<li class="nav-item ${(type eq 'all') ? 'active' : ''}" data-dencode-type="all">
				<a href="${dc:h(basePath)}/" data-dencode-method="all.all">${dc:h(msg['all.type'])}</a>
			</li>
			<li class="nav-item dropdown-toggle ${(type eq 'string') ? 'active' : ''}" role="button" aria-expanded="false" data-dencode-type="string">
				<a href="${dc:h(basePath)}/string" data-dencode-method="string.all">${dc:h(msg['string.type'])}</a>
				
				<ul class="dropdown-menu" role="menu">
					<li><a href="${dc:h(basePath)}/string" data-dencode-method="string.all">${dc:h(msg['string.all.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/string/bin" data-dencode-method="string.bin">${dc:h(msg['string.bin.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/hex" data-dencode-method="string.hex">${dc:h(msg['string.hex.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/string/html-escape" data-dencode-method="string.html-escape">${dc:h(msg['string.html-escape.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/url-encoding" data-dencode-method="string.url-encoding">${dc:h(msg['string.url-encoding.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/punycode" data-dencode-method="string.punycode">${dc:h(msg['string.punycode.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/base32" data-dencode-method="string.base32">${dc:h(msg['string.base32.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/base45" data-dencode-method="string.base45">${dc:h(msg['string.base45.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/base64" data-dencode-method="string.base64">${dc:h(msg['string.base64.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/ascii85" data-dencode-method="string.ascii85">${dc:h(msg['string.ascii85.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/quoted-printable" data-dencode-method="string.quoted-printable">${dc:h(msg['string.quoted-printable.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/unicode-escape" data-dencode-method="string.unicode-escape">${dc:h(msg['string.unicode-escape.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/program-string" data-dencode-method="string.program-string">${dc:h(msg['string.program-string.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/string/morse-code" data-dencode-method="string.morse-code">${dc:h(msg['string.morse-code.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/braille" data-dencode-method="string.braille">${dc:h(msg['string.braille.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/string/naming-convention" data-dencode-method="string.naming-convention">${dc:h(msg['string.naming-convention.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/camel-case" data-dencode-method="string.camel-case">❯ ${dc:h(msg['string.camel-case.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/snake-case" data-dencode-method="string.snake-case">❯ ${dc:h(msg['string.snake-case.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/kebab-case" data-dencode-method="string.kebab-case">❯ ${dc:h(msg['string.kebab-case.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/string/character-width" data-dencode-method="string.character-width">${dc:h(msg['string.character-width.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/letter-case" data-dencode-method="string.letter-case">${dc:h(msg['string.letter-case.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/text-initials" data-dencode-method="string.text-initials">${dc:h(msg['string.text-initials.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/text-reverse" data-dencode-method="string.text-reverse">${dc:h(msg['string.text-reverse.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/string/font-style" data-dencode-method="string.font-style">${dc:h(msg['string.font-style.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/string/unicode-normalization" data-dencode-method="string.unicode-normalization">${dc:h(msg['string.unicode-normalization.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/string/line-sort" data-dencode-method="string.line-sort">${dc:h(msg['string.line-sort.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/string/line-unique" data-dencode-method="string.line-unique">${dc:h(msg['string.line-unique.method'])}</a></li>
				</ul>
			</li>
			<li class="nav-item dropdown-toggle ${(type eq 'number') ? 'active' : ''}" role="button" aria-expanded="false" data-dencode-type="number">
				<a href="${dc:h(basePath)}/number" data-dencode-method="number.all">${dc:h(msg['number.type'])}</a>
				
				<ul class="dropdown-menu" role="menu">
					<li><a href="${dc:h(basePath)}/number" data-dencode-method="number.all">${dc:h(msg['number.all.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/number/dec" data-dencode-method="number.dec">${dc:h(msg['number.dec.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/number/bin" data-dencode-method="number.bin">${dc:h(msg['number.bin.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/number/oct" data-dencode-method="number.oct">${dc:h(msg['number.oct.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/number/hex" data-dencode-method="number.hex">${dc:h(msg['number.hex.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/number/n-ary" data-dencode-method="number.n-ary">${dc:h(msg['number.n-ary.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/number/fraction" data-dencode-method="number.fraction">${dc:h(msg['number.fraction.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/number/english" data-dencode-method="number.english">${dc:h(msg['number.english.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/number/japanese" data-dencode-method="number.japanese">${dc:h(msg['number.japanese.method'])}</a></li>
				</ul>
			</li>
			<li class="nav-item dropdown-toggle ${(type eq 'date') ? 'active' : ''}" role="button" aria-expanded="false" data-dencode-type="date">
				<a href="${dc:h(basePath)}/date" data-dencode-method="date.all">${dc:h(msg['date.type'])}</a>
				
				<ul class="dropdown-menu" role="menu">
					<li><a href="${dc:h(basePath)}/date" data-dencode-method="date.all">${dc:h(msg['date.all.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/date/unix-time" data-dencode-method="date.unix-time">${dc:h(msg['date.unix-time.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/date/w3cdtf" data-dencode-method="date.w3cdtf">${dc:h(msg['date.w3cdtf.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/date/iso8601" data-dencode-method="date.iso8601">${dc:h(msg['date.iso8601.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/date/rfc2822" data-dencode-method="date.rfc2822">${dc:h(msg['date.rfc2822.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/date/ctime" data-dencode-method="date.ctime">${dc:h(msg['date.ctime.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/date/japanese-era" data-dencode-method="date.japanese-era">${dc:h(msg['date.japanese-era.method'])}</a></li>
				</ul>
			</li>
			<li class="nav-item dropdown-toggle ${(type eq 'color') ? 'active' : ''}" role="button" aria-expanded="false" data-dencode-type="color">
				<a href="${dc:h(basePath)}/color" data-dencode-method="color.all">${dc:h(msg['color.type'])}</a>
				
				<ul class="dropdown-menu" role="menu">
					<li><a href="${dc:h(basePath)}/color" data-dencode-method="color.all">${dc:h(msg['color.all.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/color/name" data-dencode-method="color.name">${dc:h(msg['color.name.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/color/rgb" data-dencode-method="color.rgb">${dc:h(msg['color.rgb.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/color/hsl" data-dencode-method="color.hsl">${dc:h(msg['color.hsl.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/color/hsv" data-dencode-method="color.hsv">${dc:h(msg['color.hsv.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/color/cmyk" data-dencode-method="color.cmyk">${dc:h(msg['color.cmyk.method'])}</a></li>
				</ul>
			</li>
			<li class="nav-item dropdown-toggle ${(type eq 'cipher') ? 'active' : ''}" role="button" aria-expanded="false" data-dencode-type="cipher">
				<a href="${dc:h(basePath)}/cipher" data-dencode-method="cipher.all">${dc:h(msg['cipher.type'])}</a>
				
				<ul class="dropdown-menu" role="menu">
					<li><a href="${dc:h(basePath)}/cipher" data-dencode-method="cipher.all">${dc:h(msg['cipher.all.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/cipher/caesar" data-dencode-method="cipher.caesar">${dc:h(msg['cipher.caesar.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/cipher/rot13" data-dencode-method="cipher.rot13">${dc:h(msg['cipher.rot13.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/cipher/rot18" data-dencode-method="cipher.rot18">${dc:h(msg['cipher.rot18.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/cipher/rot47" data-dencode-method="cipher.rot47">${dc:h(msg['cipher.rot47.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/cipher/atbash" data-dencode-method="cipher.atbash">${dc:h(msg['cipher.atbash.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/cipher/affine" data-dencode-method="cipher.affine">${dc:h(msg['cipher.affine.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/cipher/vigenere" data-dencode-method="cipher.vigenere">${dc:h(msg['cipher.vigenere.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/cipher/enigma" data-dencode-method="cipher.enigma">${dc:h(msg['cipher.enigma.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/cipher/jis-keyboard" data-dencode-method="cipher.jis-keyboard">${dc:h(msg['cipher.jis-keyboard.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/cipher/scytale" data-dencode-method="cipher.scytale">${dc:h(msg['cipher.scytale.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/cipher/rail-fence" data-dencode-method="cipher.rail-fence">${dc:h(msg['cipher.rail-fence.method'])}</a></li>
				</ul>
			</li>
			<li class="nav-item dropdown-toggle ${(type eq 'hash') ? 'active' : ''}" role="button" aria-expanded="false" data-dencode-type="hash">
				<a href="${dc:h(basePath)}/hash" data-dencode-method="hash.all">${dc:h(msg['hash.type'])}</a>
				
				<ul class="dropdown-menu" role="menu">
					<li><a href="${dc:h(basePath)}/hash" data-dencode-method="hash.all">${dc:h(msg['hash.all.method'])}</a></li>
					<li><hr /></li>
					<li><a href="${dc:h(basePath)}/hash/md2" data-dencode-method="hash.md2">${dc:h(msg['hash.md2.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/hash/md5" data-dencode-method="hash.md5">${dc:h(msg['hash.md5.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/hash/sha1" data-dencode-method="hash.sha1">${dc:h(msg['hash.sha1.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/hash/sha256" data-dencode-method="hash.sha256">${dc:h(msg['hash.sha256.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/hash/sha384" data-dencode-method="hash.sha384">${dc:h(msg['hash.sha384.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/hash/sha512" data-dencode-method="hash.sha512">${dc:h(msg['hash.sha512.method'])}</a></li>
					<li><a href="${dc:h(basePath)}/hash/crc32" data-dencode-method="hash.crc32">${dc:h(msg['hash.crc32.method'])}</a></li>
				</ul>
			</li>
		</ul>
	</nav>
</header>

<div class="container">
	<div id="messages" class="messages">
	</div>
	
	<main role="main">
		<div id="exp">
			<div id="expHeader">
				<span id="follow" title="${dc:h(msg['label.follow'])}"><i class="bi bi-pin-angle-fill"></i></span>
				<span id="vLen" class="popover-toggle" title="${dc:h(msg['label.val.length'])}" data-len-chars="0" data-len-bytes="0">0</span>
			</div>
			<div id="expValue">
				<div class="input-group">
					<textarea id="v" class="form-control" placeholder="${dc:h(msg[method += '.tooltip'])}">${dc:h(v)}</textarea>
					<div class="btn-group-vertical">
						<button type="button" id="load" class="btn btn-v-icon-label dropdown-toggle" title="${dc:h(msg['label.load'])}" aria-expanded="false">
							<i class="bi bi-file-earmark-arrow-up"></i>
							<span class="btn-label">${dc:h(msg['label.load.buttonLabel'])}</span>
							
							<ul class="dropdown-menu dropdown-menu-end" role="menu">
								<li id="loadFile" data-load-message="${dc:h(msg['label.load.message'])}" data-load-error-message="${dc:h(msg['label.load.errorMessage'])}" tabindex="0"><i class="bi bi-file-text"></i> ${dc:h(msg['label.load.file'])}</li>
								<li id="loadImage" data-load-message="${dc:h(msg['label.load.message'])}" data-load-error-message="${dc:h(msg['label.load.errorMessage'])}" tabindex="0"><i class="bi bi-camera"></i> ${dc:h(msg['label.load.image'])}</li>
								<li id="loadCode" data-load-message="${dc:h(msg['label.load.message'])}" data-load-error-message="${dc:h(msg['label.load.errorMessage'])}" tabindex="0"><i class="bi bi-qr-code-scan"></i> ${dc:h(msg['label.load.code'])}</li>
							</ul>
						</button>
						<button type="button" class="btn btn-v-icon-label permanent-link popover-toggle" title="${dc:h(msg['label.permanentLink'])}">
							<i class="bi bi-link-45deg"></i>
							<span class="btn-label">${dc:h(msg['label.permanentLink.buttonLabel'])}</span>
						</button>
					</div>
				</div>
			</div>
			<div id="expOptions">
				<div id="oeGroup" class="btn-group btn-group-sm dropdown" data-default-value="${dc:h(oe)}" style="display: none;">
					<button type="button" class="btn" data-oe="UTF-8">UTF-8</button>
					<button type="button" class="btn" data-oe="UTF-16BE">UTF-16</button>
					<button type="button" class="btn" data-oe="UTF-32BE">UTF-32</button>
					<button type="button" id="oex" class="btn" data-oe=""></button>
					<button type="button" class="btn dropdown-toggle" aria-label="${dc:h(msg['label.etc'])}" aria-expanded="false"></button>
					<ul id="oexMenu" class="dropdown-menu dropdown-menu-end" role="menu" data-default-value="${dc:h(oex)}">
						<li data-oe="UTF-16LE" tabindex="0">UTF-16LE</li>
						<li data-oe="UTF-32LE" tabindex="0">UTF-32LE</li>
						<li><hr /></li>
						<li data-oe="US-ASCII" tabindex="0">US-ASCII</li>
						<li data-oe="ISO-8859-1" tabindex="0">ISO-8859-1 (Latin-1)</li>
						<li data-oe="ISO-8859-15" tabindex="0">ISO-8859-15 (Latin-9)</li>
						<li data-oe="windows-1252" tabindex="0">Windows-1252</li>
						<li><hr /></li>
						<li data-oe="ISO-8859-2" tabindex="0">ISO-8859-2 (Latin-2)</li>
						<li data-oe="windows-1250" tabindex="0">Windows-1250</li>
						<li><hr /></li>
						<li data-oe="ISO-8859-3" tabindex="0">ISO-8859-3 (Latin-3)</li>
						<li><hr /></li>
						<li data-oe="ISO-8859-4" tabindex="0">ISO-8859-4 (Latin-4)</li>
						<li data-oe="ISO-8859-13" tabindex="0">ISO-8859-13 (Latin-7)</li>
						<li data-oe="windows-1257" tabindex="0">Windows-1257</li>
						<li><hr /></li>
						<li data-oe="Shift_JIS" tabindex="0">Shift_JIS</li>
						<li data-oe="EUC-JP" tabindex="0">EUC-JP</li>
						<li data-oe="ISO-2022-JP" tabindex="0">ISO-2022-JP (JIS)</li>
						<li><hr /></li>
						<li data-oe="GB2312" tabindex="0">GB2312 (EUC-CN)</li>
						<li data-oe="GB18030" tabindex="0">GB18030</li>
						<li data-oe="Big5-HKSCS" tabindex="0">Big5-HKSCS</li>
						<li><hr /></li>
						<li data-oe="EUC-KR" tabindex="0">EUC-KR (KS X 1001)</li>
						<li data-oe="ISO-2022-KR" tabindex="0">ISO-2022-KR</li>
						<li><hr /></li>
						<li data-oe="ISO-8859-5" tabindex="0">ISO-8859-5</li>
						<li data-oe="windows-1251" tabindex="0">Windows-1251</li>
						<li data-oe="KOI8-R" tabindex="0">KOI8-R</li>
						<li data-oe="KOI8-U" tabindex="0">KOI8-U</li>
						<li><hr /></li>
						<li data-oe="ISO-8859-6" tabindex="0">ISO-8859-6</li>
						<li data-oe="windows-1256" tabindex="0">Windows-1256</li>
						<li><hr /></li>
						<li data-oe="ISO-8859-7" tabindex="0">ISO-8859-7</li>
						<li data-oe="windows-1253" tabindex="0">Windows-1253</li>
						<li><hr /></li>
						<li data-oe="ISO-8859-8" tabindex="0">ISO-8859-8</li>
						<li data-oe="windows-1255" tabindex="0">Windows-1255</li>
						<li><hr /></li>
						<li data-oe="ISO-8859-9" tabindex="0">ISO-8859-9 (Latin-5)</li>
						<li data-oe="windows-1254" tabindex="0">Windows-1254</li>
						<li><hr /></li>
						<li data-oe="TIS-620" tabindex="0">TIS-620</li>
						<li data-oe="windows-874" tabindex="0">Windows-874</li>
						<li><hr /></li>
						<li data-oe="windows-1258" tabindex="0">Windows-1258</li>
					</ul>
				</div>
				<div id="nlGroup" class="btn-group btn-group-sm dropdown" data-default-value="${dc:h(nl)}" style="display: none;">
					<button type="button" class="btn dropdown-toggle" aria-label="${dc:h(msg['label.newline'])}" aria-expanded="false">
						<span id="nl" data-nl=""></span>
					</button>
					<ul id="nlMenu" class="dropdown-menu" role="menu">
						<li data-nl="lf" tabindex="0">LF (\n)</li>
						<li data-nl="crlf" tabindex="0">CRLF (\r\n)</li>
						<li data-nl="cr" tabindex="0">CR (\r)</li>
					</ul>
				</div>
				<div id="tzGroup" class="btn-group btn-group-sm dropdown" data-default-value="${dc:h(tz)}" style="display: none;">
					<button type="button" class="btn dropdown-toggle" aria-label="${dc:h(msg['label.timeZone'])}" aria-expanded="false">
						<span id="tz" data-tz=""></span>
					</button>
					<div id="tzMenu" class="dropdown-menu" role="menu">
						<input type="search" id="tzMenuFilter" class="form-control" value="" />
						<ul id="tzMenuItems">
							<c:forEach var="tzVal" items="${tzMap}">
								<li data-tz="${dc:h(tzVal.key)}" tabindex="0">${dc:h(tzVal.value)}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div id="decoded" ${(hasDecoder) ? '' : 'style="display: none;"'}>
			<h2 aria-controls="decodedListContainer" aria-expanded="true">
				<svg class="toggle-icon"><use href="#caret-down-square" /></svg>
				${dc:h(msg['label.decoded'])}
				<svg id="decodingIndicator" style="display: none;"><use href="#loading-indicator" /></svg>
			</h2>
			<div id="decodedListContainer" class="collapsible expanded">
				<table id="decodedList" class="dencoded-list">
					<c:if test="${types.contains('string')}">
						<tbody>
							<c:if test="${methods.contains('string.bin')}"><tr data-dencode-method="string.bin"><th>${dc:h(msg['string.bin.func.decStrBin'])}</th><td><span id="decStrBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.hex')}"><tr data-dencode-method="string.hex"><th>${dc:h(msg['string.hex.func.decStrHex'])}</th><td><span id="decStrHex" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.html-escape')}"><tr data-dencode-method="string.html-escape"><th>${dc:h(msg['string.html-escape.func.decStrHTMLEscape'])}</th><td><span id="decStrHTMLEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.url-encoding')}"><tr data-dencode-method="string.url-encoding"><th>${dc:h(msg['string.url-encoding.func.decStrURLEncoding'])}</th><td><span id="decStrURLEncoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.punycode')}"><tr data-dencode-method="string.punycode"><th>${dc:h(msg['string.punycode.func.decStrPunycode'])}</th><td><span id="decStrPunycode" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base32')}"><tr data-dencode-method="string.base32"><th>${dc:h(msg['string.base32.func.decStrBase32'])}</th><td><span id="decStrBase32" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base45')}"><tr data-dencode-method="string.base45"><th>${dc:h(msg['string.base45.func.decStrBase45'])}</th><td><span id="decStrBase45" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base45')}"><tr data-dencode-method="string.base45"><th>${dc:h(msg['string.base45.func.decStrBase45ZlibCoseCbor'])}</th><td><span id="decStrBase45ZlibCoseCbor" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base64')}"><tr data-dencode-method="string.base64"><th>${dc:h(msg['string.base64.func.decStrBase64'])}</th><td><span id="decStrBase64" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.ascii85')}"><tr data-dencode-method="string.ascii85"><th>${dc:h(msg['string.ascii85.func.decStrAscii85'])}</th><td><span id="decStrAscii85" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.quoted-printable')}"><tr data-dencode-method="string.quoted-printable"><th>${dc:h(msg['string.quoted-printable.func.decStrQuotedPrintable'])}</th><td><span id="decStrQuotedPrintable" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.unicode-escape')}"><tr data-dencode-method="string.unicode-escape"><th>${dc:h(msg['string.unicode-escape.func.decStrUnicodeEscape'])}</th><td><span id="decStrUnicodeEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.program-string')}"><tr data-dencode-method="string.program-string"><th>${dc:h(msg['string.program-string.func.decStrProgramString'])}</th><td><span id="decStrProgramString" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.morse-code')}"><tr data-dencode-method="string.morse-code"><th>${dc:h(msg['string.morse-code.func.decStrMorseCode'])}</th><td><span id="decStrMorseCode" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.morse-code.variant'])}</span>
										<select name="_string.morse-code.variant" class="dencode-option form-select" data-sync-with="string.morse-code.variant">
											<option value="international">${dc:h(msg['string.morse-code.variant.international'])}</option>
											<option value="japanese">${dc:h(msg['string.morse-code.variant.japanese'])}</option>
											<option value="russian">${dc:h(msg['string.morse-code.variant.russian'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.braille')}"><tr data-dencode-method="string.braille"><th>${dc:h(msg['string.braille.func.decStrBraille'])}</th><td><span id="decStrBraille" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.braille.variant'])}</span>
										<select name="_string.braille.variant" class="dencode-option form-select" data-sync-with="string.braille.variant">
											<option value="ueb1">${dc:h(msg['string.braille.variant.ueb1'])}</option>
											<option value="japanese">${dc:h(msg['string.braille.variant.japanese'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.unicode-normalization')}"><tr data-dencode-method="string.unicode-normalization"><th>${dc:h(msg['string.unicode-normalization.func.decStrUnicodeNFC'])}</th><td><span id="decStrUnicodeNFC" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.unicode-normalization')}"><tr data-dencode-method="string.unicode-normalization"><th>${dc:h(msg['string.unicode-normalization.func.decStrUnicodeNFKC'])}</th><td><span id="decStrUnicodeNFKC" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('number')}">
						<tbody>
							<c:if test="${methods.contains('number.dec')}"><tr data-dencode-method="number.dec"><th>${dc:h(msg['number.dec.func.decNumDec'])}</th><td><span id="decNumDec" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.bin')}"><tr data-dencode-method="number.bin"><th>${dc:h(msg['number.bin.func.decNumBin'])}</th><td><span id="decNumBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.oct')}"><tr data-dencode-method="number.oct"><th>${dc:h(msg['number.oct.func.decNumOct'])}</th><td><span id="decNumOct" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.hex')}"><tr data-dencode-method="number.hex"><th>${dc:h(msg['number.hex.func.decNumHex'])}</th><td><span id="decNumHex" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.n-ary')}"><tr data-dencode-method="number.n-ary"><th>${dc:h(msg['number.n-ary.func.decNumNAry'])}</th><td><span id="decNumNAry" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['number.n-ary.radix'])}</span>
										<select name="_number.n-ary.radix" class="dencode-option form-select" data-sync-with="number.n-ary.radix">
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
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.english')}"><tr data-dencode-method="number.english"><th>${dc:h(msg['number.english.func.decNumEnShortScale'])}</th><td><span id="decNumEnShortScale" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.japanese')}"><tr data-dencode-method="number.japanese"><th>${dc:h(msg['number.japanese.func.decNumJP'])}</th><td><span id="decNumJP" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('cipher')}">
						<tbody>
							<c:if test="${methods.contains('cipher.caesar')}"><tr data-dencode-method="cipher.caesar"><th>${dc:h(msg['cipher.caesar.func.decCipherCaesar'])}</th><td><span id="decCipherCaesar" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['_cipher.caesar.shift'])}</span>
										<select name="_cipher.caesar.shift" class="dencode-option form-select" data-sync-with="cipher.caesar.shift">
											<option value="-42">${dc:h(msg['_cipher.caesar.shift.b42'])}</option>
											<option value="-41">${dc:h(msg['_cipher.caesar.shift.b41'])}</option>
											<option value="-40">${dc:h(msg['_cipher.caesar.shift.b40'])}</option>
											<option value="-39">${dc:h(msg['_cipher.caesar.shift.b39'])}</option>
											<option value="-38">${dc:h(msg['_cipher.caesar.shift.b38'])}</option>
											<option value="-37">${dc:h(msg['_cipher.caesar.shift.b37'])}</option>
											<option value="-36">${dc:h(msg['_cipher.caesar.shift.b36'])}</option>
											<option value="-35">${dc:h(msg['_cipher.caesar.shift.b35'])}</option>
											<option value="-34">${dc:h(msg['_cipher.caesar.shift.b34'])}</option>
											<option value="-33">${dc:h(msg['_cipher.caesar.shift.b33'])}</option>
											<option value="-32">${dc:h(msg['_cipher.caesar.shift.b32'])}</option>
											<option value="-31">${dc:h(msg['_cipher.caesar.shift.b31'])}</option>
											<option value="-30">${dc:h(msg['_cipher.caesar.shift.b30'])}</option>
											<option value="-29">${dc:h(msg['_cipher.caesar.shift.b29'])}</option>
											<option value="-28">${dc:h(msg['_cipher.caesar.shift.b28'])}</option>
											<option value="-27">${dc:h(msg['_cipher.caesar.shift.b27'])}</option>
											<option value="-26">${dc:h(msg['_cipher.caesar.shift.b26'])}</option>
											<option value="-25">${dc:h(msg['_cipher.caesar.shift.b25'])}</option>
											<option value="-24">${dc:h(msg['_cipher.caesar.shift.b24'])}</option>
											<option value="-23">${dc:h(msg['_cipher.caesar.shift.b23'])}</option>
											<option value="-22">${dc:h(msg['_cipher.caesar.shift.b22'])}</option>
											<option value="-21">${dc:h(msg['_cipher.caesar.shift.b21'])}</option>
											<option value="-20">${dc:h(msg['_cipher.caesar.shift.b20'])}</option>
											<option value="-19">${dc:h(msg['_cipher.caesar.shift.b19'])}</option>
											<option value="-18">${dc:h(msg['_cipher.caesar.shift.b18'])}</option>
											<option value="-17">${dc:h(msg['_cipher.caesar.shift.b17'])}</option>
											<option value="-16">${dc:h(msg['_cipher.caesar.shift.b16'])}</option>
											<option value="-15">${dc:h(msg['_cipher.caesar.shift.b15'])}</option>
											<option value="-14">${dc:h(msg['_cipher.caesar.shift.b14'])}</option>
											<option value="-13">${dc:h(msg['_cipher.caesar.shift.b13'])}</option>
											<option value="-12">${dc:h(msg['_cipher.caesar.shift.b12'])}</option>
											<option value="-11">${dc:h(msg['_cipher.caesar.shift.b11'])}</option>
											<option value="-10">${dc:h(msg['_cipher.caesar.shift.b10'])}</option>
											<option value="-9">${dc:h(msg['_cipher.caesar.shift.b9'])}</option>
											<option value="-8">${dc:h(msg['_cipher.caesar.shift.b8'])}</option>
											<option value="-7">${dc:h(msg['_cipher.caesar.shift.b7'])}</option>
											<option value="-6">${dc:h(msg['_cipher.caesar.shift.b6'])}</option>
											<option value="-5">${dc:h(msg['_cipher.caesar.shift.b5'])}</option>
											<option value="-4">${dc:h(msg['_cipher.caesar.shift.b4'])}</option>
											<option value="-3">${dc:h(msg['_cipher.caesar.shift.b3'])}</option>
											<option value="-2">${dc:h(msg['_cipher.caesar.shift.b2'])}</option>
											<option value="-1">${dc:h(msg['_cipher.caesar.shift.b1'])}</option>
											<option value="1">${dc:h(msg['_cipher.caesar.shift.1'])}</option>
											<option value="2">${dc:h(msg['_cipher.caesar.shift.2'])}</option>
											<option value="3">${dc:h(msg['_cipher.caesar.shift.3'])}</option>
											<option value="4">${dc:h(msg['_cipher.caesar.shift.4'])}</option>
											<option value="5">${dc:h(msg['_cipher.caesar.shift.5'])}</option>
											<option value="6">${dc:h(msg['_cipher.caesar.shift.6'])}</option>
											<option value="7">${dc:h(msg['_cipher.caesar.shift.7'])}</option>
											<option value="8">${dc:h(msg['_cipher.caesar.shift.8'])}</option>
											<option value="9">${dc:h(msg['_cipher.caesar.shift.9'])}</option>
											<option value="10">${dc:h(msg['_cipher.caesar.shift.10'])}</option>
											<option value="11">${dc:h(msg['_cipher.caesar.shift.11'])}</option>
											<option value="12">${dc:h(msg['_cipher.caesar.shift.12'])}</option>
											<option value="13">${dc:h(msg['_cipher.caesar.shift.13'])}</option>
											<option value="14">${dc:h(msg['_cipher.caesar.shift.14'])}</option>
											<option value="15">${dc:h(msg['_cipher.caesar.shift.15'])}</option>
											<option value="16">${dc:h(msg['_cipher.caesar.shift.16'])}</option>
											<option value="17">${dc:h(msg['_cipher.caesar.shift.17'])}</option>
											<option value="18">${dc:h(msg['_cipher.caesar.shift.18'])}</option>
											<option value="19">${dc:h(msg['_cipher.caesar.shift.19'])}</option>
											<option value="20">${dc:h(msg['_cipher.caesar.shift.20'])}</option>
											<option value="21">${dc:h(msg['_cipher.caesar.shift.21'])}</option>
											<option value="22">${dc:h(msg['_cipher.caesar.shift.22'])}</option>
											<option value="23">${dc:h(msg['_cipher.caesar.shift.23'])}</option>
											<option value="24">${dc:h(msg['_cipher.caesar.shift.24'])}</option>
											<option value="25">${dc:h(msg['_cipher.caesar.shift.25'])}</option>
											<option value="26">${dc:h(msg['_cipher.caesar.shift.26'])}</option>
											<option value="27">${dc:h(msg['_cipher.caesar.shift.27'])}</option>
											<option value="28">${dc:h(msg['_cipher.caesar.shift.28'])}</option>
											<option value="29">${dc:h(msg['_cipher.caesar.shift.29'])}</option>
											<option value="30">${dc:h(msg['_cipher.caesar.shift.30'])}</option>
											<option value="31">${dc:h(msg['_cipher.caesar.shift.31'])}</option>
											<option value="32">${dc:h(msg['_cipher.caesar.shift.32'])}</option>
											<option value="33">${dc:h(msg['_cipher.caesar.shift.33'])}</option>
											<option value="34">${dc:h(msg['_cipher.caesar.shift.34'])}</option>
											<option value="35">${dc:h(msg['_cipher.caesar.shift.35'])}</option>
											<option value="36">${dc:h(msg['_cipher.caesar.shift.36'])}</option>
											<option value="37">${dc:h(msg['_cipher.caesar.shift.37'])}</option>
											<option value="38">${dc:h(msg['_cipher.caesar.shift.38'])}</option>
											<option value="39">${dc:h(msg['_cipher.caesar.shift.39'])}</option>
											<option value="40">${dc:h(msg['_cipher.caesar.shift.40'])}</option>
											<option value="41">${dc:h(msg['_cipher.caesar.shift.41'])}</option>
											<option value="42">${dc:h(msg['_cipher.caesar.shift.42'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot13')}"><tr data-dencode-method="cipher.rot13"><th>${dc:h(msg['cipher.rot13.func.decCipherROT13'])}</th><td><span id="decCipherROT13" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot18')}"><tr data-dencode-method="cipher.rot18"><th>${dc:h(msg['cipher.rot18.func.decCipherROT18'])}</th><td><span id="decCipherROT18" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot47')}"><tr data-dencode-method="cipher.rot47"><th>${dc:h(msg['cipher.rot47.func.decCipherROT47'])}</th><td><span id="decCipherROT47" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.affine')}"><tr data-dencode-method="cipher.affine"><th>${dc:h(msg['cipher.affine.func.decCipherAffine'])}</th><td><span id="decCipherAffine" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.affine.a'])}</span>
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
										<span class="input-group-text">${dc:h(msg['cipher.affine.b'])}</span>
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
							<c:if test="${methods.contains('cipher.vigenere')}"><tr data-dencode-method="cipher.vigenere"><th>${dc:h(msg['cipher.vigenere.func.decCipherVigenere'])}</th><td><span id="decCipherVigenere" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.vigenere.key'])}</span>
										<input type="text" name="_cipher.vigenere.key" class="dencode-option form-control" value="" placeholder="${dc:h(msg['cipher.vigenere.key.tooltip'])}" data-sync-with="cipher.vigenere.key" />
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.enigma')}"><tr data-dencode-method="cipher.enigma"><th>${dc:h(msg['cipher.enigma.func.decCipherEnigma'])}</th><td><span id="decCipherEnigma" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="dencode-option-grid cipher-enigma">
										<div class="dencode-option-grid-label cipher-enigma-option-machine">
											${dc:h(msg['cipher.enigma.machine'])}
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
											${dc:h(msg['cipher.enigma.wheels'])}
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
											${dc:h(msg['cipher.enigma.rings'])}
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
											${dc:h(msg['cipher.enigma.positions'])}
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
											${dc:h(msg['cipher.enigma.plugboard'])}
										</div>
										<div class="dencode-option-grid-label cipher-enigma-option-uhr">
											${dc:h(msg['cipher.enigma.uhr'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-plugboard">
											<input type="text" name="_cipher.enigma.plugboard" class="dencode-option form-control" value="" placeholder="${dc:h(msg['cipher.enigma.plugboard.tooltip'])}" data-sync-with="cipher.enigma.plugboard" />
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
											${dc:h(msg['cipher.enigma.ukwd'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-ukwd">
											<input type="text" name="_cipher.enigma.ukwd" class="dencode-option form-control" value="" placeholder="${dc:h(msg['cipher.enigma.ukwd.tooltip'])}" data-sync-with="cipher.enigma.ukwd" />
										</div>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('cipher.scytale')}"><tr data-dencode-method="cipher.scytale"><th>${dc:h(msg['cipher.scytale.func.decCipherScytale'])}</th><td><span id="decCipherScytale" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.scytale.key'])}</span>
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
										
										<span class="input-group-text">${dc:h(msg['cipher.scytale.key-per'])}</span>
										<select name="_cipher.scytale.key-per" class="dencode-option form-select" data-sync-with="cipher.scytale.key-per">
											<option value="y">${dc:h(msg['cipher.scytale.key-per.y'])}</option>
											<option value="x">${dc:h(msg['cipher.scytale.key-per.x'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.rail-fence')}"><tr data-dencode-method="cipher.rail-fence"><th>${dc:h(msg['cipher.rail-fence.func.decCipherRailFence'])}</th><td><span id="decCipherRailFence" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.rail-fence.key'])}</span>
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
			<h2 aria-controls="encodedListContainer" aria-expanded="true">
				<svg class="toggle-icon"><use href="#caret-down-square" /></svg>
				${dc:h(msg['label.encoded'])}
				<svg id="encodingIndicator" style="display: none;"><use href="#loading-indicator" /></svg>
			</h2>
			<div id="encodedListContainer" class="collapsible expanded">
				<table id="encodedList" class="dencoded-list">
					<c:if test="${types.contains('string')}">
						<tbody>
							<c:if test="${methods.contains('string.bin')}"><tr data-dencode-method="string.bin"><th>${dc:h(msg['string.bin.func.encStrBin'])}</th><td><span id="encStrBin" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.bin.separator-each'])}</span>
										<select name="string.bin.separator-each" class="dencode-option form-select">
											<option value="">${dc:h(msg['string.bin.separator-each.none'])}</option>
											<option value="4b">${dc:h(msg['string.bin.separator-each.4bits'])}</option>
											<option value="8b">${dc:h(msg['string.bin.separator-each.8bits'])}</option>
											<option value="16b">${dc:h(msg['string.bin.separator-each.16bits'])}</option>
											<option value="24b">${dc:h(msg['string.bin.separator-each.24bits'])}</option>
											<option value="32b">${dc:h(msg['string.bin.separator-each.32bits'])}</option>
											<option value="64b">${dc:h(msg['string.bin.separator-each.64bits'])}</option>
											<option value="128b">${dc:h(msg['string.bin.separator-each.128bits'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.hex')}"><tr data-dencode-method="string.hex"><th>${dc:h(msg['string.hex.func.encStrHex'])}</th><td><span id="encStrHex" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.hex.separator-each'])}</span>
										<select name="string.hex.separator-each" class="dencode-option form-select">
											<option value="">${dc:h(msg['string.hex.separator-each.none'])}</option>
											<option value="1B">${dc:h(msg['string.hex.separator-each.1byte'])}</option>
											<option value="2B">${dc:h(msg['string.hex.separator-each.2bytes'])}</option>
											<option value="3B">${dc:h(msg['string.hex.separator-each.3bytes'])}</option>
											<option value="4B">${dc:h(msg['string.hex.separator-each.4bytes'])}</option>
											<option value="8B">${dc:h(msg['string.hex.separator-each.8bytes'])}</option>
											<option value="16B">${dc:h(msg['string.hex.separator-each.16bytes'])}</option>
										</select>
									</div>
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.hex.case'])}</span>
										<select name="string.hex.case" class="dencode-option form-select">
											<option value="lower">${dc:h(msg['string.hex.case.lower'])}</option>
											<option value="upper">${dc:h(msg['string.hex.case.upper'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.html-escape')}"><tr data-dencode-method="string.html-escape"><th>${dc:h(msg['string.html-escape.func.encStrHTMLEscape'])}</th><td><span id="encStrHTMLEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.html-escape')}"><tr data-dencode-method="string.html-escape"><th>${dc:h(msg['string.html-escape.func.encStrHTMLEscapeFully'])}</th><td><span id="encStrHTMLEscapeFully" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.url-encoding')}"><tr data-dencode-method="string.url-encoding"><th>${dc:h(msg['string.url-encoding.func.encStrURLEncoding'])}</th><td><span id="encStrURLEncoding" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.url-encoding.space'])}</span>
										<select name="string.url-encoding.space" class="dencode-option form-select">
											<option value="">${dc:h(msg['string.url-encoding.space.default'])}</option>
											<option value="form">${dc:h(msg['string.url-encoding.space.form'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.punycode')}"><tr data-dencode-method="string.punycode"><th>${dc:h(msg['string.punycode.func.encStrPunycode'])}</th><td><span id="encStrPunycode" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base32')}"><tr data-dencode-method="string.base32"><th>${dc:h(msg['string.base32.func.encStrBase32'])}</th><td><span id="encStrBase32" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base45')}"><tr data-dencode-method="string.base45"><th>${dc:h(msg['string.base45.func.encStrBase45'])}</th><td><span id="encStrBase45" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.base64')}"><tr data-dencode-method="string.base64"><th>${dc:h(msg['string.base64.func.encStrBase64'])}</th><td><span id="encStrBase64" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.base64.line-break-each'])}</span>
										<select name="string.base64.line-break-each" class="dencode-option form-select">
											<option value="">${dc:h(msg['string.base64.line-break-each.none'])}</option>
											<option value="64">${dc:h(msg['string.base64.line-break-each.64'])}</option>
											<option value="76">${dc:h(msg['string.base64.line-break-each.76'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.ascii85')}"><tr data-dencode-method="string.ascii85"><th>${dc:h(msg['string.ascii85.func.encStrAscii85'])}</th><td><span id="encStrAscii85" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.ascii85.variant'])}</span>
										<select name="string.ascii85.variant" class="dencode-option form-select">
											<option value="z85">${dc:h(msg['string.ascii85.variant.z85'])}</option>
											<option value="adobe">${dc:h(msg['string.ascii85.variant.adobe'])}</option>
											<option value="btoa">${dc:h(msg['string.ascii85.variant.btoa'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.quoted-printable')}"><tr data-dencode-method="string.quoted-printable"><th>${dc:h(msg['string.quoted-printable.func.encStrQuotedPrintable'])}</th><td><span id="encStrQuotedPrintable" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.unicode-escape')}"><tr data-dencode-method="string.unicode-escape"><th>${dc:h(msg['string.unicode-escape.func.encStrUnicodeEscape'])}</th><td><span id="encStrUnicodeEscape" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.unicode-escape.notation'])}</span>
										<select name="string.unicode-escape.notation" class="dencode-option form-select">
											<option value="cubu">${dc:h(msg['string.unicode-escape.notation.cubu'])}</option>
											<option value="cpbu_bub">${dc:h(msg['string.unicode-escape.notation.cpbu_bub'])}</option>
											<option value="cpbu_bU">${dc:h(msg['string.unicode-escape.notation.cpbu_bU'])}</option>
											<option value="cpbub">${dc:h(msg['string.unicode-escape.notation.cpbub'])}</option>
											<option value="cpbxb">${dc:h(msg['string.unicode-escape.notation.cpbxb'])}</option>
											<option value="cpb">${dc:h(msg['string.unicode-escape.notation.cpb'])}</option>
											<option value="cpahx">${dc:h(msg['string.unicode-escape.notation.cpahx'])}</option>
											<option value="cupu">${dc:h(msg['string.unicode-escape.notation.cupu'])}</option>
											<option value="cp">${dc:h(msg['string.unicode-escape.notation.cp'])}</option>
											<option value="cp0x">${dc:h(msg['string.unicode-escape.notation.cp0x'])}</option>
											<option value="cnbNb">${dc:h(msg['string.unicode-escape.notation.cnbNb'])}</option>
										</select>
									</div>
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.unicode-escape.case'])}</span>
										<select name="string.unicode-escape.case" class="dencode-option form-select">
											<option value="upper">${dc:h(msg['string.unicode-escape.case.upper'])}</option>
											<option value="lower">${dc:h(msg['string.unicode-escape.case.lower'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.program-string')}"><tr data-dencode-method="string.program-string"><th>${dc:h(msg['string.program-string.func.encStrProgramString'])}</th><td><span id="encStrProgramString" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.program-string.quotes'])}</span>
										<select name="string.program-string.quotes" class="dencode-option form-select">
											<option value="double">${dc:h(msg['string.program-string.quotes.double'])}</option>
											<option value="single">${dc:h(msg['string.program-string.quotes.single'])}</option>
											<option value="none">${dc:h(msg['string.program-string.quotes.none'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.morse-code')}"><tr data-dencode-method="string.morse-code"><th>${dc:h(msg['string.morse-code.func.encStrMorseCode'])}</th><td><span id="encStrMorseCode" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.morse-code.variant'])}</span>
										<select name="string.morse-code.variant" class="dencode-option form-select">
											<option value="international">${dc:h(msg['string.morse-code.variant.international'])}</option>
											<option value="japanese">${dc:h(msg['string.morse-code.variant.japanese'])}</option>
											<option value="russian">${dc:h(msg['string.morse-code.variant.russian'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.braille')}"><tr data-dencode-method="string.braille"><th>${dc:h(msg['string.braille.func.encStrBraille'])}</th><td><span id="encStrBraille" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.braille.variant'])}</span>
										<select name="string.braille.variant" class="dencode-option form-select">
											<option value="ueb1">${dc:h(msg['string.braille.variant.ueb1'])}</option>
											<option value="japanese">${dc:h(msg['string.braille.variant.japanese'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.camel-case')}"><tr data-dencode-method="string.camel-case"><th>${dc:h(msg['string.camel-case.func.encStrUpperCamelCase'])}</th><td><span id="encStrUpperCamelCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.camel-case')}"><tr data-dencode-method="string.camel-case"><th>${dc:h(msg['string.camel-case.func.encStrLowerCamelCase'])}</th><td><span id="encStrLowerCamelCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.snake-case')}"><tr data-dencode-method="string.snake-case"><th>${dc:h(msg['string.snake-case.func.encStrUpperSnakeCase'])}</th><td><span id="encStrUpperSnakeCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.snake-case')}"><tr data-dencode-method="string.snake-case"><th>${dc:h(msg['string.snake-case.func.encStrLowerSnakeCase'])}</th><td><span id="encStrLowerSnakeCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.kebab-case')}"><tr data-dencode-method="string.kebab-case"><th>${dc:h(msg['string.kebab-case.func.encStrUpperKebabCase'])}</th><td><span id="encStrUpperKebabCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.naming-convention') or methods.contains('string.kebab-case')}"><tr data-dencode-method="string.kebab-case"><th>${dc:h(msg['string.kebab-case.func.encStrLowerKebabCase'])}</th><td><span id="encStrLowerKebabCase" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.character-width')}"><tr data-dencode-method="string.character-width"><th>${dc:h(msg['string.character-width.func.encStrHalfWidth'])}</th><td><span id="encStrHalfWidth" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.character-width')}"><tr data-dencode-method="string.character-width"><th>${dc:h(msg['string.character-width.func.encStrFullWidth'])}</th><td><span id="encStrFullWidth" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${dc:h(msg['string.letter-case.func.encStrUpperCase'])}</th><td><span id="encStrUpperCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${dc:h(msg['string.letter-case.func.encStrLowerCase'])}</th><td><span id="encStrLowerCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${dc:h(msg['string.letter-case.func.encStrSwapCase'])}</th><td><span id="encStrSwapCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${dc:h(msg['string.letter-case.func.encStrCapitalize'])}</th><td><span id="encStrCapitalize" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.letter-case')}"><tr data-dencode-method="string.letter-case"><th>${dc:h(msg['string.letter-case.func.encStrAlternatingCaps'])}</th><td><span id="encStrAlternatingCaps" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.letter-case.alt-variant'])}</span>
										<select name="string.letter-case.alt-variant" class="dencode-option form-select">
											<option value="lower-upper">${dc:h(msg['string.letter-case.alt-variant.lower-upper'])}</option>
											<option value="upper-lower">${dc:h(msg['string.letter-case.alt-variant.upper-lower'])}</option>
											<option value="vowels-lower">${dc:h(msg['string.letter-case.alt-variant.vowels-lower'])}</option>
											<option value="vowels-upper">${dc:h(msg['string.letter-case.alt-variant.vowels-upper'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.text-initials')}"><tr data-dencode-method="string.text-initials"><th>${dc:h(msg['string.text-initials.func.encStrInitials'])}</th><td><span id="encStrInitials" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.text-reverse')}"><tr data-dencode-method="string.text-reverse"><th>${dc:h(msg['string.text-reverse.func.encStrReverse'])}</th><td><span id="encStrReverse" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.font-style')}"><tr data-dencode-method="string.font-style"><th>${dc:h(msg['string.font-style.func.encStrFontStyle'])}</th><td><span id="encStrFontStyle" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.font-style.style'])}</span>
										<select name="string.font-style.style" class="dencode-option form-select">
											<option value="">${dc:h(msg['string.font-style.style.none'])}</option>
											<option value="sansserif">𝖲𝖺𝗇𝗌-𝗌𝖾𝗋𝗂𝖿</option>
											<option value="sansserif-bold">𝗦𝗮𝗻𝘀-𝘀𝗲𝗿𝗶𝗳 (${dc:h(msg['string.font-style.style.bold'])})</option>
											<option value="sansserif-italic">𝘚𝘢𝘯𝘴-𝘴𝘦𝘳𝘪𝘧 (${dc:h(msg['string.font-style.style.italic'])})</option>
											<option value="sansserif-bold-italic">𝙎𝙖𝙣𝙨-𝙨𝙚𝙧𝙞𝙛 (${dc:h(msg['string.font-style.style.bold-italic'])})</option>
											<option value="serif-bold">𝐒𝐞𝐫𝐢𝐟 (${dc:h(msg['string.font-style.style.bold'])})</option>
											<option value="serif-italic">𝑆𝑒𝑟𝑖𝑓 (${dc:h(msg['string.font-style.style.italic'])})</option>
											<option value="serif-bold-italic">𝑺𝒆𝒓𝒊𝒇 (${dc:h(msg['string.font-style.style.bold-italic'])})</option>
											<option value="script">𝒮𝒸𝓇𝒾𝓅𝓉</option>
											<option value="script-bold">𝓢𝓬𝓻𝓲𝓹𝓽 (${dc:h(msg['string.font-style.style.bold'])})</option>
											<option value="fraktur">𝔉𝔯𝔞𝔨𝔱𝔲𝔯</option>
											<option value="fraktur-bold">𝕱𝖗𝖆𝖐𝖙𝖚𝖗 (${dc:h(msg['string.font-style.style.bold'])})</option>
											<option value="doublestruck">𝔻𝕠𝕦𝕓𝕝𝕖 𝕊𝕥𝕣𝕦𝕔𝕜</option>
											<option value="monospace">𝙼𝚘𝚗𝚘𝚜𝚙𝚊𝚌𝚎</option>
											<option value="smallcapital">Sᴍᴀʟʟ Cᴀᴘɪᴛᴀʟ</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.unicode-normalization')}"><tr data-dencode-method="string.unicode-normalization"><th>${dc:h(msg['string.unicode-normalization.func.encStrUnicodeNFC'])}</th><td><span id="encStrUnicodeNFC" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('string.unicode-normalization')}"><tr data-dencode-method="string.unicode-normalization"><th>${dc:h(msg['string.unicode-normalization.func.encStrUnicodeNFKC'])}</th><td><span id="encStrUnicodeNFKC" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('string.line-sort')}"><tr data-dencode-method="string.line-sort"><th>${dc:h(msg['string.line-sort.func.encStrLineSort'])}</th><td><span id="encStrLineSort" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['string.line-sort.order'])}</span>
										<select name="string.line-sort.order" class="dencode-option form-select">
											<option value="asc">${dc:h(msg['string.line-sort.order.asc'])}</option>
											<option value="desc">${dc:h(msg['string.line-sort.order.desc'])}</option>
											<option value="reverse">${dc:h(msg['string.line-sort.order.reverse'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('string.line-unique')}"><tr data-dencode-method="string.line-unique"><th>${dc:h(msg['string.line-unique.func.encStrLineUnique'])}</th><td><span id="encStrLineUnique" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('number')}">
						<tbody>
							<c:if test="${methods.contains('number.dec')}"><tr data-dencode-method="number.dec"><th>${dc:h(msg['number.dec.func.encNumDec'])}</th><td><span id="encNumDec" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.bin')}"><tr data-dencode-method="number.bin"><th>${dc:h(msg['number.bin.func.encNumBin'])}</th><td><span id="encNumBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.oct')}"><tr data-dencode-method="number.oct"><th>${dc:h(msg['number.oct.func.encNumOct'])}</th><td><span id="encNumOct" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.hex')}"><tr data-dencode-method="number.hex"><th>${dc:h(msg['number.hex.func.encNumHex'])}</th><td><span id="encNumHex" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.n-ary')}"><tr data-dencode-method="number.n-ary"><th>${dc:h(msg['number.n-ary.func.encNumNAry'])}</th><td><span id="encNumNAry" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['number.n-ary.radix'])}</span>
										<select name="number.n-ary.radix" class="dencode-option form-select" data-default-value="32">
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
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.fraction')}"><tr data-dencode-method="number.fraction"><th>${dc:h(msg['number.fraction.func.encNumFraction'])}</th><td><span id="encNumFraction" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('number.english')}"><tr data-dencode-method="number.english"><th>${dc:h(msg['number.english.func.encNumEnShortScale'])}</th><td><span id="encNumEnShortScale" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['number.english.decimal-notation'])}</span>
										<select name="number.english.decimal-notation" class="dencode-option form-select">
											<option value="">${dc:h(msg['number.english.decimal-notation.default'])}</option>
											<option value="fraction">${dc:h(msg['number.english.decimal-notation.fraction'])}</option>
										</select>
									</div>
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['number.english.system'])}</span>
										<select name="number.english.system" class="dencode-option form-select">
											<option value="">${dc:h(msg['number.english.system.default'])}</option>
											<option value="cw">${dc:h(msg['number.english.system.cw'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('number.japanese')}"><tr data-dencode-method="number.japanese"><th>${dc:h(msg['number.japanese.func.encNumJP'])}</th><td><span id="encNumJP" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('number.japanese')}"><tr data-dencode-method="number.japanese"><th>${dc:h(msg['number.japanese.func.encNumJPDaiji'])}</th><td><span id="encNumJPDaiji" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('date')}">
						<tbody>
							<c:if test="${methods.contains('date.unix-time')}"><tr data-dencode-method="date.unix-time"><th>${dc:h(msg['date.unix-time.func.encDateUnixTime'])}</th><td><span id="encDateUnixTime" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('date.w3cdtf')}"><tr data-dencode-method="date.w3cdtf"><th>${dc:h(msg['date.w3cdtf.func.encDateW3CDTF'])}</th><td><span id="encDateW3CDTF" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('date.iso8601')}"><tr data-dencode-method="date.iso8601"><th>${dc:h(msg['date.iso8601.func.encDateISO8601'])}</th><td><span id="encDateISO8601" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['date.iso8601.decimal-separator'])}</span>
										<select name="date.iso8601.decimal-separator" class="dencode-option form-select">
											<option value=".">${dc:h(msg['date.iso8601.decimal-separator.dot'])}</option>
											<option value=",">${dc:h(msg['date.iso8601.decimal-separator.comma'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('date.iso8601')}"><tr data-dencode-method="date.iso8601"><th>${dc:h(msg['date.iso8601.func.encDateISO8601Ext'])}</th><td><span id="encDateISO8601Ext" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['date.iso8601.decimal-separator'])}</span>
										<select name="_date.iso8601.decimal-separator_ext" class="dencode-option form-select" data-sync-with="date.iso8601.decimal-separator">
											<option value=".">${dc:h(msg['date.iso8601.decimal-separator.dot'])}</option>
											<option value=",">${dc:h(msg['date.iso8601.decimal-separator.comma'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('date.iso8601')}"><tr data-dencode-method="date.iso8601"><th>${dc:h(msg['date.iso8601.func.encDateISO8601Week'])}</th><td><span id="encDateISO8601Week" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['date.iso8601.decimal-separator'])}</span>
										<select name="_date.iso8601.decimal-separator_week" class="dencode-option form-select" data-sync-with="date.iso8601.decimal-separator">
											<option value=".">${dc:h(msg['date.iso8601.decimal-separator.dot'])}</option>
											<option value=",">${dc:h(msg['date.iso8601.decimal-separator.comma'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('date.iso8601')}"><tr data-dencode-method="date.iso8601"><th>${dc:h(msg['date.iso8601.func.encDateISO8601Ordinal'])}</th><td><span id="encDateISO8601Ordinal" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['date.iso8601.decimal-separator'])}</span>
										<select name="_date.iso8601.decimal-separator_ordinal" class="dencode-option form-select" data-sync-with="date.iso8601.decimal-separator">
											<option value=".">${dc:h(msg['date.iso8601.decimal-separator.dot'])}</option>
											<option value=",">${dc:h(msg['date.iso8601.decimal-separator.comma'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('date.rfc2822')}"><tr data-dencode-method="date.rfc2822"><th>${dc:h(msg['date.rfc2822.func.encDateRFC2822'])}</th><td><span id="encDateRFC2822" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('date.ctime')}"><tr data-dencode-method="date.ctime"><th>${dc:h(msg['date.ctime.func.encDateCTime'])}</th><td><span id="encDateCTime" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('date.japanese-era')}"><tr data-dencode-method="date.japanese-era"><th>${dc:h(msg['date.japanese-era.func.encDateJapaneseEra'])}</th><td><span id="encDateJapaneseEra" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('color')}">
						<tbody>
							<c:if test="${methods.contains('color.name')}"><tr data-dencode-method="color.name"><th>${dc:h(msg['color.name.func.encColorName'])}</th><td><span id="encColorName" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('color.rgb')}"><tr data-dencode-method="color.rgb"><th>${dc:h(msg['color.rgb.func.encColorRGBHex'])}</th><td><span id="encColorRGBHex" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('color.rgb')}"><tr data-dencode-method="color.rgb"><th>${dc:h(msg['color.rgb.func.encColorRGBFn'])}</th><td><span id="encColorRGBFn" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['color.rgb.notation'])}</span>
										<select name="color.rgb.notation" class="dencode-option form-select">
											<option value="percentage">${dc:h(msg['color.rgb.notation.percentage'])}</option>
											<option value="number">${dc:h(msg['color.rgb.notation.number'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('color.hsl')}"><tr data-dencode-method="color.hsl"><th>${dc:h(msg['color.hsl.func.encColorHSLFn'])}</th><td><span id="encColorHSLFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('color.hsv')}"><tr data-dencode-method="color.hsv"><th>${dc:h(msg['color.hsv.func.encColorHSVFn'])}</th><td><span id="encColorHSVFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('color.cmyk')}"><tr data-dencode-method="color.cmyk"><th>${dc:h(msg['color.cmyk.func.encColorCMYKFn'])}</th><td><span id="encColorCMYKFn" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${types.contains('cipher')}">
						<tbody>
							<c:if test="${methods.contains('cipher.caesar')}"><tr data-dencode-method="cipher.caesar"><th>${dc:h(msg['cipher.caesar.func.encCipherCaesar'])}</th><td><span id="encCipherCaesar" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.caesar.shift'])}</span>
										<select name="cipher.caesar.shift" class="dencode-option form-select" data-default-value="-3">
											<option value="-42">${dc:h(msg['cipher.caesar.shift.b42'])}</option>
											<option value="-41">${dc:h(msg['cipher.caesar.shift.b41'])}</option>
											<option value="-40">${dc:h(msg['cipher.caesar.shift.b40'])}</option>
											<option value="-39">${dc:h(msg['cipher.caesar.shift.b39'])}</option>
											<option value="-38">${dc:h(msg['cipher.caesar.shift.b38'])}</option>
											<option value="-37">${dc:h(msg['cipher.caesar.shift.b37'])}</option>
											<option value="-36">${dc:h(msg['cipher.caesar.shift.b36'])}</option>
											<option value="-35">${dc:h(msg['cipher.caesar.shift.b35'])}</option>
											<option value="-34">${dc:h(msg['cipher.caesar.shift.b34'])}</option>
											<option value="-33">${dc:h(msg['cipher.caesar.shift.b33'])}</option>
											<option value="-32">${dc:h(msg['cipher.caesar.shift.b32'])}</option>
											<option value="-31">${dc:h(msg['cipher.caesar.shift.b31'])}</option>
											<option value="-30">${dc:h(msg['cipher.caesar.shift.b30'])}</option>
											<option value="-29">${dc:h(msg['cipher.caesar.shift.b29'])}</option>
											<option value="-28">${dc:h(msg['cipher.caesar.shift.b28'])}</option>
											<option value="-27">${dc:h(msg['cipher.caesar.shift.b27'])}</option>
											<option value="-26">${dc:h(msg['cipher.caesar.shift.b26'])}</option>
											<option value="-25">${dc:h(msg['cipher.caesar.shift.b25'])}</option>
											<option value="-24">${dc:h(msg['cipher.caesar.shift.b24'])}</option>
											<option value="-23">${dc:h(msg['cipher.caesar.shift.b23'])}</option>
											<option value="-22">${dc:h(msg['cipher.caesar.shift.b22'])}</option>
											<option value="-21">${dc:h(msg['cipher.caesar.shift.b21'])}</option>
											<option value="-20">${dc:h(msg['cipher.caesar.shift.b20'])}</option>
											<option value="-19">${dc:h(msg['cipher.caesar.shift.b19'])}</option>
											<option value="-18">${dc:h(msg['cipher.caesar.shift.b18'])}</option>
											<option value="-17">${dc:h(msg['cipher.caesar.shift.b17'])}</option>
											<option value="-16">${dc:h(msg['cipher.caesar.shift.b16'])}</option>
											<option value="-15">${dc:h(msg['cipher.caesar.shift.b15'])}</option>
											<option value="-14">${dc:h(msg['cipher.caesar.shift.b14'])}</option>
											<option value="-13">${dc:h(msg['cipher.caesar.shift.b13'])}</option>
											<option value="-12">${dc:h(msg['cipher.caesar.shift.b12'])}</option>
											<option value="-11">${dc:h(msg['cipher.caesar.shift.b11'])}</option>
											<option value="-10">${dc:h(msg['cipher.caesar.shift.b10'])}</option>
											<option value="-9">${dc:h(msg['cipher.caesar.shift.b9'])}</option>
											<option value="-8">${dc:h(msg['cipher.caesar.shift.b8'])}</option>
											<option value="-7">${dc:h(msg['cipher.caesar.shift.b7'])}</option>
											<option value="-6">${dc:h(msg['cipher.caesar.shift.b6'])}</option>
											<option value="-5">${dc:h(msg['cipher.caesar.shift.b5'])}</option>
											<option value="-4">${dc:h(msg['cipher.caesar.shift.b4'])}</option>
											<option value="-3">${dc:h(msg['cipher.caesar.shift.b3'])}</option>
											<option value="-2">${dc:h(msg['cipher.caesar.shift.b2'])}</option>
											<option value="-1">${dc:h(msg['cipher.caesar.shift.b1'])}</option>
											<option value="1">${dc:h(msg['cipher.caesar.shift.1'])}</option>
											<option value="2">${dc:h(msg['cipher.caesar.shift.2'])}</option>
											<option value="3">${dc:h(msg['cipher.caesar.shift.3'])}</option>
											<option value="4">${dc:h(msg['cipher.caesar.shift.4'])}</option>
											<option value="5">${dc:h(msg['cipher.caesar.shift.5'])}</option>
											<option value="6">${dc:h(msg['cipher.caesar.shift.6'])}</option>
											<option value="7">${dc:h(msg['cipher.caesar.shift.7'])}</option>
											<option value="8">${dc:h(msg['cipher.caesar.shift.8'])}</option>
											<option value="9">${dc:h(msg['cipher.caesar.shift.9'])}</option>
											<option value="10">${dc:h(msg['cipher.caesar.shift.10'])}</option>
											<option value="11">${dc:h(msg['cipher.caesar.shift.11'])}</option>
											<option value="12">${dc:h(msg['cipher.caesar.shift.12'])}</option>
											<option value="13">${dc:h(msg['cipher.caesar.shift.13'])}</option>
											<option value="14">${dc:h(msg['cipher.caesar.shift.14'])}</option>
											<option value="15">${dc:h(msg['cipher.caesar.shift.15'])}</option>
											<option value="16">${dc:h(msg['cipher.caesar.shift.16'])}</option>
											<option value="17">${dc:h(msg['cipher.caesar.shift.17'])}</option>
											<option value="18">${dc:h(msg['cipher.caesar.shift.18'])}</option>
											<option value="19">${dc:h(msg['cipher.caesar.shift.19'])}</option>
											<option value="20">${dc:h(msg['cipher.caesar.shift.20'])}</option>
											<option value="21">${dc:h(msg['cipher.caesar.shift.21'])}</option>
											<option value="22">${dc:h(msg['cipher.caesar.shift.22'])}</option>
											<option value="23">${dc:h(msg['cipher.caesar.shift.23'])}</option>
											<option value="24">${dc:h(msg['cipher.caesar.shift.24'])}</option>
											<option value="25">${dc:h(msg['cipher.caesar.shift.25'])}</option>
											<option value="26">${dc:h(msg['cipher.caesar.shift.26'])}</option>
											<option value="27">${dc:h(msg['cipher.caesar.shift.27'])}</option>
											<option value="28">${dc:h(msg['cipher.caesar.shift.28'])}</option>
											<option value="29">${dc:h(msg['cipher.caesar.shift.29'])}</option>
											<option value="30">${dc:h(msg['cipher.caesar.shift.30'])}</option>
											<option value="31">${dc:h(msg['cipher.caesar.shift.31'])}</option>
											<option value="32">${dc:h(msg['cipher.caesar.shift.32'])}</option>
											<option value="33">${dc:h(msg['cipher.caesar.shift.33'])}</option>
											<option value="34">${dc:h(msg['cipher.caesar.shift.34'])}</option>
											<option value="35">${dc:h(msg['cipher.caesar.shift.35'])}</option>
											<option value="36">${dc:h(msg['cipher.caesar.shift.36'])}</option>
											<option value="37">${dc:h(msg['cipher.caesar.shift.37'])}</option>
											<option value="38">${dc:h(msg['cipher.caesar.shift.38'])}</option>
											<option value="39">${dc:h(msg['cipher.caesar.shift.39'])}</option>
											<option value="40">${dc:h(msg['cipher.caesar.shift.40'])}</option>
											<option value="41">${dc:h(msg['cipher.caesar.shift.41'])}</option>
											<option value="42">${dc:h(msg['cipher.caesar.shift.42'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot13')}"><tr data-dencode-method="cipher.rot13"><th>${dc:h(msg['cipher.rot13.func.encCipherROT13'])}</th><td><span id="encCipherROT13" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot18')}"><tr data-dencode-method="cipher.rot18"><th>${dc:h(msg['cipher.rot18.func.encCipherROT18'])}</th><td><span id="encCipherROT18" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.rot47')}"><tr data-dencode-method="cipher.rot47"><th>${dc:h(msg['cipher.rot47.func.encCipherROT47'])}</th><td><span id="encCipherROT47" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.atbash')}"><tr data-dencode-method="cipher.atbash"><th>${dc:h(msg['cipher.atbash.func.encCipherAtbash'])}</th><td><span id="encCipherAtbash" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('cipher.affine')}"><tr data-dencode-method="cipher.affine"><th>${dc:h(msg['cipher.affine.func.encCipherAffine'])}</th><td><span id="encCipherAffine" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.affine.a'])}</span>
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
										<span class="input-group-text">${dc:h(msg['cipher.affine.b'])}</span>
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
							<c:if test="${methods.contains('cipher.vigenere')}"><tr data-dencode-method="cipher.vigenere"><th>${dc:h(msg['cipher.vigenere.func.encCipherVigenere'])}</th><td><span id="encCipherVigenere" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.vigenere.key'])}</span>
										<input type="text" name="cipher.vigenere.key" class="dencode-option form-control" value="" placeholder="${dc:h(msg['cipher.vigenere.key.tooltip'])}" />
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.enigma')}"><tr data-dencode-method="cipher.enigma"><th>${dc:h(msg['cipher.enigma.func.encCipherEnigma'])}</th><td><span id="encCipherEnigma" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="dencode-option-grid cipher-enigma">
										<div class="dencode-option-grid-label cipher-enigma-option-machine">
											${dc:h(msg['cipher.enigma.machine'])}
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
											${dc:h(msg['cipher.enigma.wheels'])}
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
											${dc:h(msg['cipher.enigma.rings'])}
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
											${dc:h(msg['cipher.enigma.positions'])}
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
											${dc:h(msg['cipher.enigma.plugboard'])}
										</div>
										<div class="dencode-option-grid-label cipher-enigma-option-uhr">
											${dc:h(msg['cipher.enigma.uhr'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-plugboard">
											<input type="text" name="cipher.enigma.plugboard" class="dencode-option form-control" value="" placeholder="${dc:h(msg['cipher.enigma.plugboard.tooltip'])}" />
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
											${dc:h(msg['cipher.enigma.ukwd'])}
										</div>
										<div class="dencode-option-grid-value cipher-enigma-option-ukwd">
											<input type="text" name="cipher.enigma.ukwd" class="dencode-option form-control" value="" placeholder="${dc:h(msg['cipher.enigma.ukwd.tooltip'])}" />
										</div>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('cipher.jis-keyboard')}"><tr data-dencode-method="cipher.jis-keyboard"><th>${dc:h(msg['cipher.jis-keyboard.func.encCipherJisKeyboard'])}</th><td><span id="encCipherJisKeyboard" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.jis-keyboard.mode'])}</span>
										<select name="cipher.jis-keyboard.mode" class="dencode-option form-select">
											<option value="lenient">${dc:h(msg['cipher.jis-keyboard.mode.lenient'])}</option>
											<option value="strict">${dc:h(msg['cipher.jis-keyboard.mode.strict'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${methods.contains('cipher.scytale')}"><tr data-dencode-method="cipher.scytale"><th>${dc:h(msg['cipher.scytale.func.encCipherScytale'])}</th><td><span id="encCipherScytale" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.scytale.key'])}</span>
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
										
										<span class="input-group-text">${dc:h(msg['cipher.scytale.key-per'])}</span>
										<select name="cipher.scytale.key-per" class="dencode-option form-select">
											<option value="y">${dc:h(msg['cipher.scytale.key-per.y'])}</option>
											<option value="x">${dc:h(msg['cipher.scytale.key-per.x'])}</option>
										</select>
									</div>
								</div>
							</td></tr></c:if>
							<c:if test="${methods.contains('cipher.rail-fence')}"><tr data-dencode-method="cipher.rail-fence"><th>${dc:h(msg['cipher.rail-fence.func.encCipherRailFence'])}</th><td><span id="encCipherRailFence" class="for-disp"></span>
								<div class="dencode-option-group">
									<div class="input-group">
										<span class="input-group-text">${dc:h(msg['cipher.rail-fence.key'])}</span>
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
							<c:if test="${methods.contains('hash.md2')}"><tr data-dencode-method="hash.md2"><th>${dc:h(msg['hash.md2.func.encHashMD2'])}</th><td><span id="encHashMD2" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.md5')}"><tr data-dencode-method="hash.md5"><th>${dc:h(msg['hash.md5.func.encHashMD5'])}</th><td><span id="encHashMD5" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.sha1')}"><tr data-dencode-method="hash.sha1"><th>${dc:h(msg['hash.sha1.func.encHashSHA1'])}</th><td><span id="encHashSHA1" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.sha256')}"><tr data-dencode-method="hash.sha256"><th>${dc:h(msg['hash.sha256.func.encHashSHA256'])}</th><td><span id="encHashSHA256" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.sha384')}"><tr data-dencode-method="hash.sha384"><th>${dc:h(msg['hash.sha384.func.encHashSHA384'])}</th><td><span id="encHashSHA384" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.sha512')}"><tr data-dencode-method="hash.sha512"><th>${dc:h(msg['hash.sha512.func.encHashSHA512'])}</th><td><span id="encHashSHA512" class="for-disp"></span></td></tr></c:if>
							<c:if test="${methods.contains('hash.crc32')}"><tr data-dencode-method="hash.crc32"><th>${dc:h(msg['hash.crc32.func.encHashCRC32'])}</th><td><span id="encHashCRC32" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
				</table>
			</div>
		</div>
		
		<div id="otherDencodeNav">
			<c:if test="${method eq 'string.bin'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="string.hex">${dc:h(msg['label.otherDencodeLink.string.hex'])}</a></div>
			</c:if>
			<c:if test="${method eq 'string.hex'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="string.bin">${dc:h(msg['label.otherDencodeLink.string.bin'])}</a></div>
			</c:if>
			
			<c:if test="${method eq 'string.camel-case' or method eq 'string.snake-case' or method eq 'string.kebab-case'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="string.naming-convention">${dc:h(msg['label.otherDencodeLink.string.naming-convention'])}</a></div>
			</c:if>
			
			<c:if test="${method eq 'number.bin'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="number.bin">${dc:h(msg['label.otherDencodeLink.number.bin'])}</a></div>
			</c:if>
			<c:if test="${method eq 'number.hex'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="number.hex">${dc:h(msg['label.otherDencodeLink.number.hex'])}</a></div>
			</c:if>
			
			<c:if test="${type ne 'all'}">
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="${dc:h(method.endsWith('.all') ? 'all.all' : type += '.all')}">${dc:h(msg['label.otherDencodeLink.' += (method.endsWith('.all') ? 'all.all' : type += '.all')])}</a></div>
			</c:if>
		</div>
		
		<div id="adBottom" style="margin: 2em 0 1em;">
			<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-6871955725174244" data-ad-slot="5289392761" data-ad-format="rectangle" data-full-width-responsive="true"></ins>
		</div>
		
		<c:set var="methodDescIncPagePath" value="method-desc_${method}_${msg['lang']}.inc.jsp" scope="request" />
		<c:if test="${dc:fileExists(pageContext, '/WEB-INF/pages/' += methodDescIncPagePath)}">
			<hr />
			<jsp:include page="${methodDescIncPagePath}" />
		</c:if>
	</main>
</div>

<footer role="contentinfo">
	© <a href="https://github.com/mozq/dencode-web" target="_blank">Mozq</a>
	| <a href="#policy">${dc:h(msg['label.policy'])}</a>
</footer>


<dialog id="messageDialog" class="modal">
	<div id="messageDialogBody" class="modal-body">
	</div>
	<div class="modal-footer">
		<button type="button" class="btn" data-close="modal">${dc:h(msg['label.ok'])}</button>
	</div>
</dialog>

<dialog id="policyDialog" class="modal">
	<div class="modal-header">
		<span id="policyDialogLabel" class="modal-title">${dc:h(msg['label.policy'])}</span>
		<button type="button" class="btn-close" data-close="modal" aria-label="${dc:h(msg['label.close'])}">
			<svg class="inline-icon"><use href="#close" /></svg>
		</button>
	</div>
	<div class="modal-body">
		<c:choose>
			<c:when test="${dc:fileExists(pageContext, '/WEB-INF/pages/policy_' += msg['lang'] += '.inc.jsp')}">
				<jsp:include page="policy_${msg['lang']}.inc.jsp" />
			</c:when>
			<c:otherwise>
				<jsp:include page="policy_en.inc.jsp" />
			</c:otherwise>
		</c:choose>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn" data-close="modal">${dc:h(msg['label.close'])}</button>
	</div>
</dialog>

<div style="display:none" aria-hidden="true">
	<div>
		<input type="file" id="loadFileInput" accept="text/*" />
		<input type="file" id="loadImageInput" accept="image/*;capture=camera" />
		<input type="file" id="loadCodeInput" accept="image/*;capture=camera" />
	</div>
	
	<svg>
		<defs>
			<symbol id="loading-indicator" fill="none" stroke="currentColor" viewBox="0 0 100 100">
				<circle cx="50" cy="50" r="40" stroke-width="15" stroke-dasharray="200">
					<animateTransform attributeName="transform" type="rotate" dur="1s" keyTimes="0;1" values="0 50 50;360 50 50" repeatCount="indefinite" />
				</circle>
			</symbol>
			<symbol id="menu" viewBox="0 0 16 16" fill="currentColor">
				<rect x="2" y="3" width="12" height="1.5" rx="0.7" />
				<rect x="2" y="7" width="12" height="1.5" rx="0.7" />
				<rect x="2" y="11" width="12" height="1.5" rx="0.7" />
			</symbol>
			<symbol id="caret-down-square" viewBox="0 0 16 16">
				<rect x="1" y="1" rx="2" ry="2" width="14" height="14" fill="none" stroke="currentColor" stroke-width="0.9" />
				<polygon points="3.5,6 12.5,6 8,11.2" fill="currentColor" />
			</symbol>
			<symbol id="close" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round">
				<line x1="3" y1="3" x2="13" y2="13" />
				<line x1="13" y1="3" x2="3" y2="13" />
			</symbol>
		</defs>
	</svg>
	
	<template id="popoverTmpl">
		<div class="popover">
			<div class="popover-header">{{title}}</div>
			<div class="popover-body">{{body}}</div>
		</div>
	</template>
	
	<template id="messageTmpl">
		<div class="message message-{{level}}" data-message-id="{{messageId}}" role="alert">
			<strong>{{message}}</strong>
			<p>{{detail}}</p>
			<button type="button" class="btn-close" data-close="message" aria-label="${dc:h(msg['label.close'])}">
				<svg class="inline-icon"><use href="#close" /></svg>
			</button>
		</div>
	</template>
	
	<template id="forCopyTmpl">
		<div class="for-copy">
			<div class="input-group">
				<textarea id="{{id}}ForCopy" class="form-control select-on-focus" rows="2" readonly>{{value}}</textarea>
				<span class="btn-group-vertical">
					<button type="button" class="btn btn-v-icon-label copy-to-clipboard" title="${dc:h(msg['label.copyToClipboard'])}" data-copy-id="{{id}}ForCopy" data-copy-message="${dc:h(msg['label.copyToClipboard.message'])}" data-copy-error-message="${dc:h(msg['label.copyToClipboard.errorMessage'])}">
						<i class="bi bi-clipboard"></i>
						<span class="btn-label">${dc:h(msg['label.copyToClipboard.buttonLabel'])}</span>
					</button>
					<button type="button" class="btn btn-v-icon-label permanent-link popover-toggle" title="${dc:h(msg['label.permanentLink'])}">
						<i class="bi bi-link-45deg"></i>
						<span class="btn-label">${dc:h(msg['label.permanentLink.buttonLabel'])}</span>
					</button>
				</span>
			</div>
		</div>
	</template>
	
	<template id="lengthTmpl">
		{{chars}}
		{{#oneChar}}${dc:h(msg['label.val.length.char'])}{{/oneChar}}
		{{^oneChar}}${dc:h(msg['label.val.length.chars'])}{{/oneChar}}
		/
		{{bytes}}
		{{#oneByte}}${dc:h(msg['label.val.length.byte'])}{{/oneByte}}
		{{^oneByte}}${dc:h(msg['label.val.length.bytes'])}{{/oneByte}}
	</template>
	
	<template id="permanentLinkTmpl">
		<div id="permanentLink" class="input-group">
			<input type="text" id="linkURL" class="form-control select-on-focus" value="{{permanentLink}}" readonly />
			<button type="button" class="btn btn-v-icon-label copy-to-clipboard" title="${dc:h(msg['label.copyToClipboard'])}" data-copy-id="linkURL" data-copy-message="${dc:h(msg['label.copyToClipboard.message'])}" data-copy-error-message="${dc:h(msg['label.copyToClipboard.errorMessage'])}">
				<i class="bi bi-clipboard"></i>
				<span class="btn-label">${dc:h(msg['label.copyToClipboard.buttonLabel'])}</span>
			</button>
			<button type="button" class="btn btn-v-icon-label dropdown-toggle toggle-manual share" aria-expanded="false">
				<i class="bi bi-share-fill"></i>
				<span class="btn-label">${dc:h(msg['label.share.buttonLabel'])}</span>
	
				<ul class="dropdown-menu" role="menu">
					<li><a class="share-link" href="{{permanentLink}}" target="_blank" data-share-method="openNewPage">${dc:h(msg['label.openNewPage'])}</a></li>
					<li><a class="share-link" href="mailto:?body=%0D%0A{{permanentLinkUrlEncoded}}" data-share-method="sendByEmail">${dc:h(msg['label.sendByEmail'])}</a></li>
					<li><a class="share-link" href="https://twitter.com/share?url={{permanentLinkUrlEncoded}}" target="_blank" data-share-method="shareOnTwitter">${dc:h(msg['label.shareOnTwitter'])}</a></li>
					<li><a class="share-link" href="https://www.facebook.com/sharer/sharer.php?u={{permanentLinkUrlEncoded}}" target="_blank" data-share-method="shareOnFacebook">${dc:h(msg['label.shareOnFacebook'])}</a></li>
				</ul>
			</button>
		</div>
	</template>
	
	<template id="adMiddleTmpl">
		<tr id="adMiddle">
			<td colspan="2" style="padding: 2em 0">
				<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-6871955725174244" data-ad-slot="8967889103" data-ad-format="rectangle, horizontal" data-full-width-responsive="true"></ins>
			</td>
		</tr>
	</template>
	
	<script id="dencoderDefs" type="application/json">${dencoderDefsJson}</script>
	
	<script type="text/message" data-id="default.error" data-level="${dc:h(msg['default.error.level'])}" data-message="${dc:h(msg['default.error'])}" data-detail=""></script>
	<script type="text/message" data-id="network.error" data-level="${dc:h(msg['network.error.level'])}" data-message="${dc:h(msg['network.error'])}" data-detail=""></script>
</div>
</body>
</html>
