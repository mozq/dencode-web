<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="mf" uri="http://mifmi.org/jsp/taglib/functions"
%><!DOCTYPE html>
<html lang="${mf:h(msg['lang'])}" prefix="og: http://ogp.me/ns#">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
	<meta name="description" content="${mf:h(msg[mf:strcat('site.desc.', method)])}" />
	<meta name="robots" content="index,follow,noarchive" />
	<meta name="application-name" content="${mf:h(msg['site.name'])}" />
	<meta name="apple-mobile-web-app-title" content="${mf:h(msg['site.name'])}" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="msapplication-TileColor" content="#ffffff" />
	<meta name="msapplication-square70x70logo" content="${pageContext.request.contextPath}/static/img/icons/favicon70px.png" />
	<meta name="msapplication-square150x150logo" content="${pageContext.request.contextPath}/static/img/icons/favicon150px.png" />
	<meta name="msapplication-square310x310logo" content="${pageContext.request.contextPath}/static/img/icons/favicon310px.png" />
	<meta property="og:site_name" content="${mf:h(msg['site.name'])}" />
	<meta property="og:url" content="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/${mf:h(currentPath)}" />
	<meta property="og:image" content="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/static/img/icons/favicon310px.png" />
	<meta property="og:locale" content="${mf:h(msg['locale'])}" />
	<meta property="og:locale:alternate" content="en_US" />
	<meta property="og:locale:alternate" content="ja_JP" />
	<meta property="og:locale:alternate" content="ru_RU" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="${mf:h(msg[mf:strcat('site.title.', method)])}${mf:h(msg['site.title.suffix'])}" />
	<meta property="og:description" content="${mf:h(msg[mf:strcat('site.desc.', method)])}" />
	<link rel="alternate" href="${pageContext.request.contextPath}/en/${mf:h(currentPath)}" hreflang="en" />
	<link rel="alternate" href="${pageContext.request.contextPath}/ja/${mf:h(currentPath)}" hreflang="ja" />
	<link rel="alternate" href="${pageContext.request.contextPath}/ru/${mf:h(currentPath)}" hreflang="ru" />
	<link rel="alternate" href="${pageContext.request.contextPath}/${mf:h(currentPath)}" hreflang="x-default" />
	<link rel="icon" type="x-icon" href="${pageContext.request.contextPath}/favicon.ico" />
	<link rel="shortcut icon" type="x-icon" href="${pageContext.request.contextPath}/favicon.ico" />
	<link rel="icon" type="image/png" sizes="192x192"  href="${pageContext.request.contextPath}/static/img/icons/favicon192px.png" />
	<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/static/img/icons/favicon180px.png" />
	<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/all.min.css?v=<%= new java.io.File(application.getRealPath("/static/css/all.min.css")).lastModified() %>" />
	<script>var contextPath = "${pageContext.request.contextPath}";</script>
	<title>${mf:h(msg[mf:strcat('site.title.', method)])}${mf:h(msg['site.title.suffix'])}</title>
</head>
<body data-dencode-type="${type}" data-dencode-method="${method}">
<header>
	<nav class="navbar navbar-default" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#typeMenu">
					<span class="sr-only">Toggle navigation</span>
					<span class="glyphicon glyphicon-menu-hamburger"></span>
				</button>
				<ul id="localeMenu" class="nav nav-pills navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="glyphicon glyphicon-globe"></span>
							${mf:h(msg['locale.name'])}
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(localeName eq null) ? 'active' : ''}"><a href="${pageContext.request.contextPath}/${mf:h(currentPath)}">${mf:h(msg['locale.name.default'])} (${mf:h(defaultLocaleName)})</a></li>
							<li class="divider"></li>
							<li class="${(localeName eq 'en') ? 'active' : ''}"><a href="${pageContext.request.contextPath}/en/${mf:h(currentPath)}">English</a></li>
							<li class="${(localeName eq 'ja') ? 'active' : ''}"><a href="${pageContext.request.contextPath}/ja/${mf:h(currentPath)}">日本語</a></li>
							<li class="${(localeName eq 'ru') ? 'active' : ''}"><a href="${pageContext.request.contextPath}/ru/${mf:h(currentPath)}">Русский</a></li>
						</ul>
					</li>
				</ul>
				<a id="brand" class="navbar-brand" href="${mf:h(basePath)}/">${mf:h(msg['site.name'])}</a>
				<p class="navbar-text">Enjoy Encoding &amp; Decoding!</p>
			</div>
			<div id="typeMenu" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="${(type eq 'all') ? 'active' : ''}" data-dencode-type="all" data-dencode-method="all">
						<a href="${mf:h(basePath)}/">${mf:h(msg['label.type.all'])}</a>
					</li>
					<li class="dropdown ${(type eq 'string') ? 'active' : ''}" role="presentation" data-dencode-type="string">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.string'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'string.all') ? 'active' : ''}" data-dencode-method="string.all"><a href="${mf:h(basePath)}/string">${mf:h(msg['label.method.string.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.bin') ? 'active' : ''}" data-dencode-method="string.bin"><a href="${mf:h(basePath)}/string/bin">${mf:h(msg['label.method.string.bin'])}</a></li>
							<li class="${(method eq 'string.hex') ? 'active' : ''}" data-dencode-method="string.hex"><a href="${mf:h(basePath)}/string/hex">${mf:h(msg['label.method.string.hex'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.html-escape') ? 'active' : ''}" data-dencode-method="string.html-escape"><a href="${mf:h(basePath)}/string/html-escape">${mf:h(msg['label.method.string.html-escape'])}</a></li>
							<li class="${(method eq 'string.url-encoding') ? 'active' : ''}" data-dencode-method="string.url-encoding"><a href="${mf:h(basePath)}/string/url-encoding">${mf:h(msg['label.method.string.url-encoding'])}</a></li>
							<li class="${(method eq 'string.punycode') ? 'active' : ''}" data-dencode-method="string.punycode"><a href="${mf:h(basePath)}/string/punycode">${mf:h(msg['label.method.string.punycode'])}</a></li>
							<li class="${(method eq 'string.base32') ? 'active' : ''}" data-dencode-method="string.base32"><a href="${mf:h(basePath)}/string/base32">${mf:h(msg['label.method.string.base32'])}</a></li>
							<li class="${(method eq 'string.base64') ? 'active' : ''}" data-dencode-method="string.base64"><a href="${mf:h(basePath)}/string/base64">${mf:h(msg['label.method.string.base64'])}</a></li>
							<li class="${(method eq 'string.quoted-printable') ? 'active' : ''}" data-dencode-method="string.quoted-printable"><a href="${mf:h(basePath)}/string/quoted-printable">${mf:h(msg['label.method.string.quoted-printable'])}</a></li>
							<li class="${(method eq 'string.unicode-escape') ? 'active' : ''}" data-dencode-method="string.unicode-escape"><a href="${mf:h(basePath)}/string/unicode-escape">${mf:h(msg['label.method.string.unicode-escape'])}</a></li>
							<li class="${(method eq 'string.program-string') ? 'active' : ''}" data-dencode-method="string.program-string"><a href="${mf:h(basePath)}/string/program-string">${mf:h(msg['label.method.string.program-string'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.naming-convention') ? 'active' : ''}" data-dencode-method="string.naming-convention"><a href="${mf:h(basePath)}/string/naming-convention">${mf:h(msg['label.method.string.naming-convention'])}</a></li>
							<li class="${(method eq 'string.camel-case') ? 'active' : ''}" data-dencode-method="string.camel-case"><a href="${mf:h(basePath)}/string/camel-case"><span class="glyphicon glyphicon-menu-right"></span> ${mf:h(msg['label.method.string.camel-case'])}</a></li>
							<li class="${(method eq 'string.snake-case') ? 'active' : ''}" data-dencode-method="string.snake-case"><a href="${mf:h(basePath)}/string/snake-case"><span class="glyphicon glyphicon-menu-right"></span> ${mf:h(msg['label.method.string.snake-case'])}</a></li>
							<li class="${(method eq 'string.kebab-case') ? 'active' : ''}" data-dencode-method="string.kebab-case"><a href="${mf:h(basePath)}/string/kebab-case"><span class="glyphicon glyphicon-menu-right"></span> ${mf:h(msg['label.method.string.kebab-case'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.character-width') ? 'active' : ''}" data-dencode-method="string.character-width"><a href="${mf:h(basePath)}/string/character-width">${mf:h(msg['label.method.string.character-width'])}</a></li>
							<li class="${(method eq 'string.letter-case') ? 'active' : ''}" data-dencode-method="string.letter-case"><a href="${mf:h(basePath)}/string/letter-case">${mf:h(msg['label.method.string.letter-case'])}</a></li>
							<li class="${(method eq 'string.text-initials') ? 'active' : ''}" data-dencode-method="string.text-initials"><a href="${mf:h(basePath)}/string/text-initials">${mf:h(msg['label.method.string.text-initials'])}</a></li>
							<li class="${(method eq 'string.text-reverse') ? 'active' : ''}" data-dencode-method="string.text-reverse"><a href="${mf:h(basePath)}/string/text-reverse">${mf:h(msg['label.method.string.text-reverse'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.unicode-normalization') ? 'active' : ''}" data-dencode-method="string.unicode-normalization"><a href="${mf:h(basePath)}/string/unicode-normalization">${mf:h(msg['label.method.string.unicode-normalization'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.line-sort') ? 'active' : ''}" data-dencode-method="string.line-sort"><a href="${mf:h(basePath)}/string/line-sort">${mf:h(msg['label.method.string.line-sort'])}</a></li>
							<li class="${(method eq 'string.line-unique') ? 'active' : ''}" data-dencode-method="string.line-unique"><a href="${mf:h(basePath)}/string/line-unique">${mf:h(msg['label.method.string.line-unique'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'number') ? 'active' : ''}" role="presentation" data-dencode-type="number">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.number'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'number.all') ? 'active' : ''}" data-dencode-method="number.all"><a href="${mf:h(basePath)}/number">${mf:h(msg['label.method.number.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'number.bin') ? 'active' : ''}" data-dencode-method="number.bin"><a href="${mf:h(basePath)}/number/bin">${mf:h(msg['label.method.number.bin'])}</a></li>
							<li class="${(method eq 'number.oct') ? 'active' : ''}" data-dencode-method="number.oct"><a href="${mf:h(basePath)}/number/oct">${mf:h(msg['label.method.number.oct'])}</a></li>
							<li class="${(method eq 'number.hex') ? 'active' : ''}" data-dencode-method="number.hex"><a href="${mf:h(basePath)}/number/hex">${mf:h(msg['label.method.number.hex'])}</a></li>
							<li class="${(method eq 'number.english') ? 'active' : ''}" data-dencode-method="number.english"><a href="${mf:h(basePath)}/number/english">${mf:h(msg['label.method.number.english'])}</a></li>
							<li class="${(method eq 'number.japanese') ? 'active' : ''}" data-dencode-method="number.japanese"><a href="${mf:h(basePath)}/number/japanese">${mf:h(msg['label.method.number.japanese'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'date') ? 'active' : ''}" role="presentation" data-dencode-type="date">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.date'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'date.all') ? 'active' : ''}" data-dencode-method="date.all"><a href="${mf:h(basePath)}/date">${mf:h(msg['label.method.date.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'date.unix-time') ? 'active' : ''}" data-dencode-method="date.unix-time"><a href="${mf:h(basePath)}/date/unix-time">${mf:h(msg['label.method.date.unix-time'])}</a></li>
							<li class="${(method eq 'date.w3cdtf') ? 'active' : ''}" data-dencode-method="date.w3cdtf"><a href="${mf:h(basePath)}/date/w3cdtf">${mf:h(msg['label.method.date.w3cdtf'])}</a></li>
							<li class="${(method eq 'date.iso8601') ? 'active' : ''}" data-dencode-method="date.iso8601"><a href="${mf:h(basePath)}/date/iso8601">${mf:h(msg['label.method.date.iso8601'])}</a></li>
							<li class="${(method eq 'date.rfc2822') ? 'active' : ''}" data-dencode-method="date.rfc2822"><a href="${mf:h(basePath)}/date/rfc2822">${mf:h(msg['label.method.date.rfc2822'])}</a></li>
							<li class="${(method eq 'date.ctime') ? 'active' : ''}" data-dencode-method="date.ctime"><a href="${mf:h(basePath)}/date/ctime">${mf:h(msg['label.method.date.ctime'])}</a></li>
							<li class="${(method eq 'date.japanese-era') ? 'active' : ''}" data-dencode-method="date.japanese-era"><a href="${mf:h(basePath)}/date/japanese-era">${mf:h(msg['label.method.date.japanese-era'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'color') ? 'active' : ''}" role="presentation" data-dencode-type="color">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.color'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'color.all') ? 'active' : ''}" data-dencode-method="color.all"><a href="${mf:h(basePath)}/color">${mf:h(msg['label.method.color.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'color.name') ? 'active' : ''}" data-dencode-method="color.name"><a href="${mf:h(basePath)}/color/name">${mf:h(msg['label.method.color.name'])}</a></li>
							<li class="${(method eq 'color.rgb') ? 'active' : ''}" data-dencode-method="color.rgb"><a href="${mf:h(basePath)}/color/rgb">${mf:h(msg['label.method.color.rgb'])}</a></li>
							<li class="${(method eq 'color.hsl') ? 'active' : ''}" data-dencode-method="color.hsl"><a href="${mf:h(basePath)}/color/hsl">${mf:h(msg['label.method.color.hsl'])}</a></li>
							<li class="${(method eq 'color.hsv') ? 'active' : ''}" data-dencode-method="color.hsv"><a href="${mf:h(basePath)}/color/hsv">${mf:h(msg['label.method.color.hsv'])}</a></li>
							<li class="${(method eq 'color.cmy') ? 'active' : ''}" data-dencode-method="color.cmy"><a href="${mf:h(basePath)}/color/cmy">${mf:h(msg['label.method.color.cmy'])}</a></li>
							<li class="${(method eq 'color.cmyk') ? 'active' : ''}" data-dencode-method="color.cmyk"><a href="${mf:h(basePath)}/color/cmyk">${mf:h(msg['label.method.color.cmyk'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'cipher') ? 'active' : ''}" role="presentation" data-dencode-type="cipher">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.cipher'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'cipher.all') ? 'active' : ''}" data-dencode-method="cipher.all"><a href="${mf:h(basePath)}/cipher">${mf:h(msg['label.method.cipher.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'cipher.caesar') ? 'active' : ''}" data-dencode-method="cipher.caesar"><a href="${mf:h(basePath)}/cipher/caesar">${mf:h(msg['label.method.cipher.caesar'])}</a></li>
							<li class="${(method eq 'cipher.rot13') ? 'active' : ''}" data-dencode-method="cipher.rot13"><a href="${mf:h(basePath)}/cipher/rot13">${mf:h(msg['label.method.cipher.rot13'])}</a></li>
							<li class="${(method eq 'cipher.rot18') ? 'active' : ''}" data-dencode-method="cipher.rot18"><a href="${mf:h(basePath)}/cipher/rot18">${mf:h(msg['label.method.cipher.rot18'])}</a></li>
							<li class="${(method eq 'cipher.rot47') ? 'active' : ''}" data-dencode-method="cipher.rot47"><a href="${mf:h(basePath)}/cipher/rot47">${mf:h(msg['label.method.cipher.rot47'])}</a></li>
							<li class="${(method eq 'cipher.scytale') ? 'active' : ''}" data-dencode-method="cipher.scytale"><a href="${mf:h(basePath)}/cipher/scytale">${mf:h(msg['label.method.cipher.scytale'])}</a></li>
							<li class="${(method eq 'cipher.rail-fence') ? 'active' : ''}" data-dencode-method="cipher.rail-fence"><a href="${mf:h(basePath)}/cipher/rail-fence">${mf:h(msg['label.method.cipher.rail-fence'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'hash') ? 'active' : ''}" role="presentation" data-dencode-type="hash">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.hash'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'hash.all') ? 'active' : ''}" data-dencode-method="hash.all"><a href="${mf:h(basePath)}/hash">${mf:h(msg['label.method.hash.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'hash.md2') ? 'active' : ''}" data-dencode-method="hash.md2"><a href="${mf:h(basePath)}/hash/md2">${mf:h(msg['label.method.hash.md2'])}</a></li>
							<li class="${(method eq 'hash.md5') ? 'active' : ''}" data-dencode-method="hash.md5"><a href="${mf:h(basePath)}/hash/md5">${mf:h(msg['label.method.hash.md5'])}</a></li>
							<li class="${(method eq 'hash.sha1') ? 'active' : ''}" data-dencode-method="hash.sha1"><a href="${mf:h(basePath)}/hash/sha1">${mf:h(msg['label.method.hash.sha1'])}</a></li>
							<li class="${(method eq 'hash.sha256') ? 'active' : ''}" data-dencode-method="hash.sha256"><a href="${mf:h(basePath)}/hash/sha256">${mf:h(msg['label.method.hash.sha256'])}</a></li>
							<li class="${(method eq 'hash.sha384') ? 'active' : ''}" data-dencode-method="hash.sha384"><a href="${mf:h(basePath)}/hash/sha384">${mf:h(msg['label.method.hash.sha384'])}</a></li>
							<li class="${(method eq 'hash.sha512') ? 'active' : ''}" data-dencode-method="hash.sha512"><a href="${mf:h(basePath)}/hash/sha512">${mf:h(msg['label.method.hash.sha512'])}</a></li>
							<li class="${(method eq 'hash.crc32') ? 'active' : ''}" data-dencode-method="hash.crc32"><a href="${mf:h(basePath)}/hash/crc32">${mf:h(msg['label.method.hash.crc32'])}</a></li>
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
				<span id="follow" title="${mf:h(msg['label.follow'])}"><span class="glyphicon glyphicon-pushpin"></span></span>
				<span id="vLen" class="badge popover-toggle" title="${mf:h(msg['label.val.length'])}" data-len-chars="0" data-len-bytes="0">0</span>
			</div>
			<form id="expValue" action="#">
				<div class="input-group">
					<textarea id="v" class="form-control" placeholder="${mf:h(msg[mf:strcat('label.val.tooltip.', method)])}">${mf:h(v)}</textarea>
					<span class="input-group-addon">
						<span class="btn-group-vertical">
							<button type="button" class="btn btn-v-icon-label copy-to-clipboard" title="${mf:h(msg['label.copyToClipboard'])}" data-copy-id="v" data-copy-message="${mf:h(msg['label.copyToClipboard.message'])}" data-copy-error-message="${mf:h(msg['label.copyToClipboard.errorMessage'])}">
								<span class="glyphicon glyphicon-duplicate"></span>
								<span class="btn-label">${mf:h(msg['label.copyToClipboard.buttonLabel'])}</span>
							</button>
							<button type="button" class="btn btn-v-icon-label permanent-link popover-toggle" title="${mf:h(msg['label.permanentLink'])}">
								<span class="glyphicon glyphicon-link"></span>
								<span class="btn-label">${mf:h(msg['label.permanentLink.buttonLabel'])}</span>
							</button>
						</span>
					</span>
				</div>
			</form>
			<div id="oeGroup" class="btn-group btn-group-xs" data-enable="${(useOe) ? 'true' : 'false'}" style="display: none;">
				<button class="btn ${(oe eq 'UTF-8') ? 'active' : ''}" data-oe="UTF-8">UTF-8</button>
				<button class="btn ${(oe eq 'UTF-16BE') ? 'active' : ''}" data-oe="UTF-16BE">UTF-16</button>
				<button class="btn ${(oe eq 'UTF-32BE') ? 'active' : ''}" data-oe="UTF-32BE">UTF-32</button>
				<div class="btn-group btn-group-xs">
					<button id="oex" class="btn ${(oe eq oex) ? 'active' : ''}" data-oe=""></button>
					<button class="btn dropdown-toggle" type="button" data-toggle="dropdown">
						<span class="caret"></span>
					</button>
					<ul id="oexMenu" class="dropdown-menu" role="menu">
						<li class="${(oex eq 'UTF-16LE') ? 'active' : ''}" data-oe="UTF-16LE">UTF-16LE</li>
						<li class="${(oex eq 'UTF-32LE') ? 'active' : ''}" data-oe="UTF-32LE">UTF-32LE</li>
						<li class="divider"></li>
						<li class="${(oex eq 'US-ASCII') ? 'active' : ''}" data-oe="US-ASCII">US-ASCII</li>
						<li class="${(oex eq 'ISO-8859-1') ? 'active' : ''}" data-oe="ISO-8859-1">ISO-8859-1 (Latin-1)</li>
						<li class="${(oex eq 'ISO-8859-15') ? 'active' : ''}" data-oe="ISO-8859-15">ISO-8859-15 (Latin-9)</li>
						<li class="${(oex eq 'windows-1252') ? 'active' : ''}" data-oe="windows-1252">Windows-1252</li>
						<li class="divider"></li>
						<li class="${(oex eq 'ISO-8859-2') ? 'active' : ''}" data-oe="ISO-8859-2">ISO-8859-2 (Latin-2)</li>
						<li class="${(oex eq 'windows-1250') ? 'active' : ''}" data-oe="windows-1250">Windows-1250</li>
						<li class="divider"></li>
						<li class="${(oex eq 'ISO-8859-3') ? 'active' : ''}" data-oe="ISO-8859-3">ISO-8859-3 (Latin-3)</li>
						<li class="divider"></li>
						<li class="${(oex eq 'ISO-8859-4') ? 'active' : ''}" data-oe="ISO-8859-4">ISO-8859-4 (Latin-4)</li>
						<li class="${(oex eq 'ISO-8859-13') ? 'active' : ''}" data-oe="ISO-8859-13">ISO-8859-13 (Latin-7)</li>
						<li class="${(oex eq 'windows-1257') ? 'active' : ''}" data-oe="windows-1257">Windows-1257</li>
						<li class="divider"></li>
						<li class="${(oex eq 'Shift_JIS') ? 'active' : ''}" data-oe="Shift_JIS">Shift_JIS</li>
						<li class="${(oex eq 'EUC-JP') ? 'active' : ''}" data-oe="EUC-JP">EUC-JP</li>
						<li class="${(oex eq 'ISO-2022-JP') ? 'active' : ''}" data-oe="ISO-2022-JP">ISO-2022-JP (JIS)</li>
						<li class="divider"></li>
						<li class="${(oex eq 'GB2312') ? 'active' : ''}" data-oe="GB2312">GB2312 (EUC-CN)</li>
						<li class="${(oex eq 'GB18030') ? 'active' : ''}" data-oe="GB18030">GB18030</li>
						<li class="${(oex eq 'Big5-HKSCS') ? 'active' : ''}" data-oe="Big5-HKSCS">Big5-HKSCS</li>
						<li class="divider"></li>
						<li class="${(oex eq 'EUC-KR') ? 'active' : ''}" data-oe="EUC-KR">EUC-KR (KS X 1001)</li>
						<li class="${(oex eq 'ISO-2022-KR') ? 'active' : ''}" data-oe="ISO-2022-KR">ISO-2022-KR</li>
						<li class="divider"></li>
						<li class="${(oex eq 'ISO-8859-5') ? 'active' : ''}" data-oe="ISO-8859-5">ISO-8859-5</li>
						<li class="${(oex eq 'windows-1251') ? 'active' : ''}" data-oe="windows-1251">Windows-1251</li>
						<li class="${(oex eq 'KOI8-R') ? 'active' : ''}" data-oe="KOI8-R">KOI8-R</li>
						<li class="${(oex eq 'KOI8-U') ? 'active' : ''}" data-oe="KOI8-U">KOI8-U</li>
						<li class="divider"></li>
						<li class="${(oex eq 'ISO-8859-6') ? 'active' : ''}" data-oe="ISO-8859-6">ISO-8859-6</li>
						<li class="${(oex eq 'windows-1256') ? 'active' : ''}" data-oe="windows-1256">Windows-1256</li>
						<li class="divider"></li>
						<li class="${(oex eq 'ISO-8859-7') ? 'active' : ''}" data-oe="ISO-8859-7">ISO-8859-7</li>
						<li class="${(oex eq 'windows-1253') ? 'active' : ''}" data-oe="windows-1253">Windows-1253</li>
						<li class="divider"></li>
						<li class="${(oex eq 'ISO-8859-8') ? 'active' : ''}" data-oe="ISO-8859-8">ISO-8859-8</li>
						<li class="${(oex eq 'windows-1255') ? 'active' : ''}" data-oe="windows-1255">Windows-1255</li>
						<li class="divider"></li>
						<li class="${(oex eq 'ISO-8859-9') ? 'active' : ''}" data-oe="ISO-8859-9">ISO-8859-9 (Latin-5)</li>
						<li class="${(oex eq 'windows-1254') ? 'active' : ''}" data-oe="windows-1254">Windows-1254</li>
						<li class="divider"></li>
						<li class="${(oex eq 'TIS-620') ? 'active' : ''}" data-oe="TIS-620">TIS-620</li>
						<li class="${(oex eq 'windows-874') ? 'active' : ''}" data-oe="windows-874">Windows-874</li>
						<li class="divider"></li>
						<li class="${(oex eq 'windows-1258') ? 'active' : ''}" data-oe="windows-1258">Windows-1258</li>
					</ul>
				</div>
			</div>
			<div id="nlGroup" class="btn-group btn-group-xs" data-enable="${(useNl) ? 'true' : 'false'}" style="display: none;">
				<button class="btn ${(nl eq 'crlf' or nl eq '') ? 'active' : ''}" data-nl="crlf">CRLF (Win)</button>
				<button class="btn ${(nl eq 'lf') ? 'active' : ''}" data-nl="lf">LF (UNIX/Mac)</button>
				<button class="btn ${(nl eq 'cr') ? 'active' : ''}" data-nl="cr">CR (Old Mac)</button>
			</div>
			<select id="tz" class="chzn-select" data-placeholder="${mf:h(msg['label.timeZone'])}" data-msg-chosen-no-results="${mf:h(msg['chosen.no.results'])}" data-enable="${(useTz) ? 'true' : 'false'}" style="display: none;">
				<c:forEach var="tzVal" items="${tzMap}">
					<option value="${mf:h(tzVal.key)}" ${(tz eq tzVal.key) ? 'selected' : ''}>${mf:h(tzVal.value)}</option>
				</c:forEach>
			</select>
		</div>
		
		<div id="decoded" ${(hasDecoded) ? '' : 'style="display: none;"'}>
			<h2 data-toggle-show="#decodedListContainer">
				<span class="toggle-icon glyphicon glyphicon-collapse-down"></span>
				${mf:h(msg['label.decoded'])}
				<img id="decodingIndicator" src="${pageContext.request.contextPath}/static/img/loading-indicator.gif" style="display: none;" />
			</h2>
			<div id="decodedListContainer">
				<table id="decodedList" class="dencoded-list">
					<c:if test="${type eq 'all' or type eq 'string'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.bin'}"><tr data-dencode-method="string.bin"><th>${mf:h(msg['label.decStrBin'])}</th><td><span id="decStrBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.hex'}"><tr data-dencode-method="string.hex"><th>${mf:h(msg['label.decStrHex'])}</th><td><span id="decStrHex" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.html-escape'}"><tr data-dencode-method="string.html-escape"><th>${mf:h(msg['label.decStrHTMLEscape'])}</th><td><span id="decStrHTMLEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.url-encoding'}"><tr data-dencode-method="string.url-encoding"><th>${mf:h(msg['label.decStrURLEncoding'])}</th><td><span id="decStrURLEncoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.punycode'}"><tr data-dencode-method="string.punycode"><th>${mf:h(msg['label.decStrPunycode'])}</th><td><span id="decStrPunycode" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.base32'}"><tr data-dencode-method="string.base32"><th>${mf:h(msg['label.decStrBase32Encoding'])}</th><td><span id="decStrBase32Encoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.base64'}"><tr data-dencode-method="string.base64"><th>${mf:h(msg['label.decStrBase64Encoding'])}</th><td><span id="decStrBase64Encoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.quoted-printable'}"><tr data-dencode-method="string.quoted-printable"><th>${mf:h(msg['label.decStrQuotedPrintable'])}</th><td><span id="decStrQuotedPrintable" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicode-escape'}"><tr data-dencode-method="string.unicode-escape"><th>${mf:h(msg['label.decStrUnicodeEscape'])}</th><td><span id="decStrUnicodeEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.program-string'}"><tr data-dencode-method="string.program-string"><th>${mf:h(msg['label.decStrProgramString'])}</th><td><span id="decStrProgramString" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicode-normalization'}"><tr data-dencode-method="string.unicode-normalization"><th>${mf:h(msg['label.decStrUnicodeNFC'])}</th><td><span id="decStrUnicodeNFC" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicode-normalization'}"><tr data-dencode-method="string.unicode-normalization"><th>${mf:h(msg['label.decStrUnicodeNFKC'])}</th><td><span id="decStrUnicodeNFKC" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'number'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.bin'}"><tr data-dencode-method="number.bin"><th>${mf:h(msg['label.decNumBin'])}</th><td><span id="decNumBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.oct'}"><tr data-dencode-method="number.oct"><th>${mf:h(msg['label.decNumOct'])}</th><td><span id="decNumOct" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.hex'}"><tr data-dencode-method="number.hex"><th>${mf:h(msg['label.decNumHex'])}</th><td><span id="decNumHex" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.english'}"><tr data-dencode-method="number.english"><th>${mf:h(msg['label.decNumEnShortScale'])}</th><td><span id="decNumEnShortScale" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.japanese'}"><tr data-dencode-method="number.japanese"><th>${mf:h(msg['label.decNumJP'])}</th><td><span id="decNumJP" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'cipher'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.caesar'}"><tr data-dencode-method="cipher.caesar"><th>${mf:h(msg['label.decCipherCaesar'])}</th><td><span id="decCipherCaesar" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.decCipherCaesar.option.shift'])}</span>
											<select name="decCipherCaesarShift" class="dencode-option form-control" data-value-link-to="[name=encCipherCaesarShift]">
												<option value="1">${mf:h(msg['label.decCipherCaesar.option.shift.1'])}</option>
												<option value="2">${mf:h(msg['label.decCipherCaesar.option.shift.2'])}</option>
												<option value="3">${mf:h(msg['label.decCipherCaesar.option.shift.3'])}</option>
												<option value="4">${mf:h(msg['label.decCipherCaesar.option.shift.4'])}</option>
												<option value="5">${mf:h(msg['label.decCipherCaesar.option.shift.5'])}</option>
												<option value="6">${mf:h(msg['label.decCipherCaesar.option.shift.6'])}</option>
												<option value="7">${mf:h(msg['label.decCipherCaesar.option.shift.7'])}</option>
												<option value="8">${mf:h(msg['label.decCipherCaesar.option.shift.8'])}</option>
												<option value="9">${mf:h(msg['label.decCipherCaesar.option.shift.9'])}</option>
												<option value="10">${mf:h(msg['label.decCipherCaesar.option.shift.10'])}</option>
												<option value="11">${mf:h(msg['label.decCipherCaesar.option.shift.11'])}</option>
												<option value="12">${mf:h(msg['label.decCipherCaesar.option.shift.12'])}</option>
												<option value="13">${mf:h(msg['label.decCipherCaesar.option.shift.13'])}</option>
												<option value="14">${mf:h(msg['label.decCipherCaesar.option.shift.14'])}</option>
												<option value="15">${mf:h(msg['label.decCipherCaesar.option.shift.15'])}</option>
												<option value="16">${mf:h(msg['label.decCipherCaesar.option.shift.16'])}</option>
												<option value="17">${mf:h(msg['label.decCipherCaesar.option.shift.17'])}</option>
												<option value="18">${mf:h(msg['label.decCipherCaesar.option.shift.18'])}</option>
												<option value="19">${mf:h(msg['label.decCipherCaesar.option.shift.19'])}</option>
												<option value="20">${mf:h(msg['label.decCipherCaesar.option.shift.20'])}</option>
												<option value="21">${mf:h(msg['label.decCipherCaesar.option.shift.21'])}</option>
												<option value="22">${mf:h(msg['label.decCipherCaesar.option.shift.22'])}</option>
												<option value="23">${mf:h(msg['label.decCipherCaesar.option.shift.23'])}</option>
												<option value="24">${mf:h(msg['label.decCipherCaesar.option.shift.24'])}</option>
												<option value="25">${mf:h(msg['label.decCipherCaesar.option.shift.25'])}</option>
												<option value="26">${mf:h(msg['label.decCipherCaesar.option.shift.26'])}</option>
												<option value="27">${mf:h(msg['label.decCipherCaesar.option.shift.27'])}</option>
												<option value="28">${mf:h(msg['label.decCipherCaesar.option.shift.28'])}</option>
												<option value="29">${mf:h(msg['label.decCipherCaesar.option.shift.29'])}</option>
												<option value="30">${mf:h(msg['label.decCipherCaesar.option.shift.30'])}</option>
												<option value="31">${mf:h(msg['label.decCipherCaesar.option.shift.31'])}</option>
											</select>
										</div>
									</div>
								</form>
							</td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.rot13'}"><tr data-dencode-method="cipher.rot13"><th>${mf:h(msg['label.decCipherROT13'])}</th><td><span id="decCipherROT13" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.rot18'}"><tr data-dencode-method="cipher.rot18"><th>${mf:h(msg['label.decCipherROT18'])}</th><td><span id="decCipherROT18" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.rot47'}"><tr data-dencode-method="cipher.rot47"><th>${mf:h(msg['label.decCipherROT47'])}</th><td><span id="decCipherROT47" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.scytale'}"><tr data-dencode-method="cipher.scytale"><th>${mf:h(msg['label.decCipherScytale'])}</th><td><span id="decCipherScytale" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.decCipherScytale.option.key'])}</span>
											<select name="decCipherScytaleKey" class="dencode-option form-control" data-value-link-to="[name=encCipherScytaleKey]">
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
								</form>
							</td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.rail-fence'}"><tr data-dencode-method="cipher.rail-fence"><th>${mf:h(msg['label.decCipherRailFence'])}</th><td><span id="decCipherRailFence" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.decCipherRailFence.option.key'])}</span>
											<select name="decCipherRailFenceKey" class="dencode-option form-control" data-value-link-to="[name=encCipherRailFenceKey]">
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
								</form>
							</td></tr></c:if>
						</tbody>
					</c:if>
				</table>
			</div>
		</div>
		
		<div id="encoded" ${(hasEncoded) ? '' : 'style="display: none;"'}>
			<h2 data-toggle-show="#encodedListContainer">
				<span class="toggle-icon glyphicon glyphicon-collapse-down"></span>
				${mf:h(msg['label.encoded'])}
				<img id="encodingIndicator" src="${pageContext.request.contextPath}/static/img/loading-indicator.gif" style="display: none;" />
			</h2>
			<div id="encodedListContainer">
				<table id="encodedList" class="dencoded-list">
					<c:if test="${type eq 'all' or type eq 'string'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.bin'}"><tr data-dencode-method="string.bin"><th>${mf:h(msg['label.encStrBin'])}</th><td><span id="encStrBin" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.encStrBin.option.separator'])}</span>
											<select name="encStrBinSeparatorEach" class="dencode-option form-control">
												<option value="">${mf:h(msg['label.encStrBin.option.separator.each.none'])}</option>
												<option value="4b">${mf:h(msg['label.encStrBin.option.separator.each.4bits'])}</option>
												<option value="8b">${mf:h(msg['label.encStrBin.option.separator.each.8bits'])}</option>
												<option value="16b">${mf:h(msg['label.encStrBin.option.separator.each.16bits'])}</option>
											</select>
										</div>
									</div>
								</form>
							</td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.hex'}"><tr data-dencode-method="string.hex"><th>${mf:h(msg['label.encStrHex'])}</th><td><span id="encStrHex" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.encStrHex.option.separator'])}</span>
											<select name="encStrHexSeparatorEach" class="dencode-option form-control">
												<option value="">${mf:h(msg['label.encStrHex.option.separator.each.none'])}</option>
												<option value="1B">${mf:h(msg['label.encStrHex.option.separator.each.1byte'])}</option>
												<option value="2B">${mf:h(msg['label.encStrHex.option.separator.each.2bytes'])}</option>
											</select>
										</div>
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.encStrHex.option.case'])}</span>
											<select name="encStrHexCase" class="dencode-option form-control">
												<option value="lower">${mf:h(msg['label.encStrHex.option.case.lower'])}</option>
												<option value="upper">${mf:h(msg['label.encStrHex.option.case.upper'])}</option>
											</select>
										</div>
									</div>
								</form>
							</td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.html-escape'}"><tr data-dencode-method="string.html-escape"><th>${mf:h(msg['label.encStrHTMLEscape'])}</th><td><span id="encStrHTMLEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.html-escape'}"><tr data-dencode-method="string.html-escape"><th>${mf:h(msg['label.encStrHTMLEscapeFully'])}</th><td><span id="encStrHTMLEscapeFully" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.url-encoding'}"><tr data-dencode-method="string.url-encoding"><th>${mf:h(msg['label.encStrURLEncoding'])}</th><td><span id="encStrURLEncoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.punycode'}"><tr data-dencode-method="string.punycode"><th>${mf:h(msg['label.encStrPunycode'])}</th><td><span id="encStrPunycode" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.base32'}"><tr data-dencode-method="string.base32"><th>${mf:h(msg['label.encStrBase32Encoding'])}</th><td><span id="encStrBase32Encoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.base64'}"><tr data-dencode-method="string.base64"><th>${mf:h(msg['label.encStrBase64Encoding'])}</th><td><span id="encStrBase64Encoding" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.encStrBase64.option.lineBreak'])}</span>
											<select name="encStrBase64LineBreakEach" class="dencode-option form-control">
												<option value="">${mf:h(msg['label.encStrBase64.option.lineBreak.each.none'])}</option>
												<option value="64">${mf:h(msg['label.encStrBase64.option.lineBreak.each.64'])}</option>
												<option value="76">${mf:h(msg['label.encStrBase64.option.lineBreak.each.76'])}</option>
											</select>
										</div>
									</div>
								</form>
							</td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.quoted-printable'}"><tr data-dencode-method="string.quoted-printable"><th>${mf:h(msg['label.encStrQuotedPrintable'])}</th><td><span id="encStrQuotedPrintable" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicode-escape'}"><tr data-dencode-method="string.unicode-escape"><th>${mf:h(msg['label.encStrUnicodeEscape'])}</th><td><span id="encStrUnicodeEscape" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.encStrUnicodeEscape.option.surrogatePair'])}</span>
											<select name="encStrUnicodeEscapeSurrogatePairFormat" class="dencode-option form-control">
												<option value="">${mf:h(msg['label.encStrUnicodeEscape.option.surrogatePair.format.uuCodeUnit'])}</option>
												<option value="ubcp">${mf:h(msg['label.encStrUnicodeEscape.option.surrogatePair.format.uBracketCodePoint'])}</option>
												<option value="Ucp">${mf:h(msg['label.encStrUnicodeEscape.option.surrogatePair.format.UCodePoint'])}</option>
											</select>
										</div>
									</div>
								</form>
							</td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.program-string'}"><tr data-dencode-method="string.program-string"><th>${mf:h(msg['label.encStrProgramString'])}</th><td><span id="encStrProgramString" class="for-disp"></span></td></tr></c:if>
						</tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.naming-convention' or method eq 'string.camel-case'}"><tr data-dencode-method="string.camel-case"><th>${mf:h(msg['label.encStrUpperCamelCase'])}</th><td><span id="encStrUpperCamelCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.naming-convention' or method eq 'string.camel-case'}"><tr data-dencode-method="string.camel-case"><th>${mf:h(msg['label.encStrLowerCamelCase'])}</th><td><span id="encStrLowerCamelCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.naming-convention' or method eq 'string.snake-case'}"><tr data-dencode-method="string.snake-case"><th>${mf:h(msg['label.encStrUpperSnakeCase'])}</th><td><span id="encStrUpperSnakeCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.naming-convention' or method eq 'string.snake-case'}"><tr data-dencode-method="string.snake-case"><th>${mf:h(msg['label.encStrLowerSnakeCase'])}</th><td><span id="encStrLowerSnakeCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.naming-convention' or method eq 'string.kebab-case'}"><tr data-dencode-method="string.kebab-case"><th>${mf:h(msg['label.encStrUpperKebabCase'])}</th><td><span id="encStrUpperKebabCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.naming-convention' or method eq 'string.kebab-case'}"><tr data-dencode-method="string.kebab-case"><th>${mf:h(msg['label.encStrLowerKebabCase'])}</th><td><span id="encStrLowerKebabCase" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.character-width'}"><tr data-dencode-method="string.character-width"><th>${mf:h(msg['label.encStrHalfWidth'])}</th><td><span id="encStrHalfWidth" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.character-width'}"><tr data-dencode-method="string.character-width"><th>${mf:h(msg['label.encStrFullWidth'])}</th><td><span id="encStrFullWidth" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.letter-case'}"><tr data-dencode-method="string.letter-case"><th>${mf:h(msg['label.encStrUpperCase'])}</th><td><span id="encStrUpperCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.letter-case'}"><tr data-dencode-method="string.letter-case"><th>${mf:h(msg['label.encStrLowerCase'])}</th><td><span id="encStrLowerCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.letter-case'}"><tr data-dencode-method="string.letter-case"><th>${mf:h(msg['label.encStrSwapCase'])}</th><td><span id="encStrSwapCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.letter-case'}"><tr data-dencode-method="string.letter-case"><th>${mf:h(msg['label.encStrCapitalize'])}</th><td><span id="encStrCapitalize" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.text-initials'}"><tr data-dencode-method="string.text-initials"><th>${mf:h(msg['label.encStrInitials'])}</th><td><span id="encStrInitials" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.text-reverse'}"><tr data-dencode-method="string.text-reverse"><th>${mf:h(msg['label.encStrReverse'])}</th><td><span id="encStrReverse" class="for-disp"></span></td></tr></c:if>
						<tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicode-normalization'}"><tr data-dencode-method="string.unicode-normalization"><th>${mf:h(msg['label.encStrUnicodeNFC'])}</th><td><span id="encStrUnicodeNFC" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicode-normalization'}"><tr data-dencode-method="string.unicode-normalization"><th>${mf:h(msg['label.encStrUnicodeNFKC'])}</th><td><span id="encStrUnicodeNFKC" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.line-sort'}"><tr data-dencode-method="string.line-sort"><th>${mf:h(msg['label.encStrLineSortAsc'])}</th><td><span id="encStrLineSortAsc" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.line-sort'}"><tr data-dencode-method="string.line-sort"><th>${mf:h(msg['label.encStrLineSortDesc'])}</th><td><span id="encStrLineSortDesc" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.line-sort'}"><tr data-dencode-method="string.line-sort"><th>${mf:h(msg['label.encStrLineSortReverse'])}</th><td><span id="encStrLineSortReverse" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.line-unique'}"><tr data-dencode-method="string.line-unique"><th>${mf:h(msg['label.encStrLineUnique'])}</th><td><span id="encStrLineUnique" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'number'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.bin'}"><tr data-dencode-method="number.bin"><th>${mf:h(msg['label.encNumBin'])}</th><td><span id="encNumBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.oct'}"><tr data-dencode-method="number.oct"><th>${mf:h(msg['label.encNumOct'])}</th><td><span id="encNumOct" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.hex'}"><tr data-dencode-method="number.hex"><th>${mf:h(msg['label.encNumHex'])}</th><td><span id="encNumHex" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.english'}"><tr data-dencode-method="number.english"><th>${mf:h(msg['label.encNumEnShortScale'])}</th><td><span id="encNumEnShortScale" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.english'}"><tr data-dencode-method="number.english"><th>${mf:h(msg['label.encNumEnShortScaleFraction'])}</th><td><span id="encNumEnShortScaleFraction" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.japanese'}"><tr data-dencode-method="number.japanese"><th>${mf:h(msg['label.encNumJP'])}</th><td><span id="encNumJP" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.japanese'}"><tr data-dencode-method="number.japanese"><th>${mf:h(msg['label.encNumJPDaiji'])}</th><td><span id="encNumJPDaiji" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'date'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.unix-time'}"><tr data-dencode-method="date.unix-time"><th>${mf:h(msg['label.encDateUnixTime'])}</th><td><span id="encDateUnixTime" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.w3cdtf'}"><tr data-dencode-method="date.w3cdtf"><th>${mf:h(msg['label.encDateW3CDTF'])}</th><td><span id="encDateW3CDTF" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.iso8601'}"><tr data-dencode-method="date.iso8601"><th>${mf:h(msg['label.encDateISO8601'])}</th><td><span id="encDateISO8601" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.iso8601'}"><tr data-dencode-method="date.iso8601"><th>${mf:h(msg['label.encDateISO8601Ext'])}</th><td><span id="encDateISO8601Ext" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.iso8601'}"><tr data-dencode-method="date.iso8601"><th>${mf:h(msg['label.encDateISO8601Week'])}</th><td><span id="encDateISO8601Week" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.iso8601'}"><tr data-dencode-method="date.iso8601"><th>${mf:h(msg['label.encDateISO8601Ordinal'])}</th><td><span id="encDateISO8601Ordinal" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.rfc2822'}"><tr data-dencode-method="date.rfc2822"><th>${mf:h(msg['label.encDateRFC2822'])}</th><td><span id="encDateRFC2822" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.ctime'}"><tr data-dencode-method="date.ctime"><th>${mf:h(msg['label.encDateCTime'])}</th><td><span id="encDateCTime" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.japanese-era'}"><tr data-dencode-method="date.japanese-era"><th>${mf:h(msg['label.encDateJapaneseEra'])}</th><td><span id="encDateJapaneseEra" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'color'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.name'}"><tr data-dencode-method="color.name"><th>${mf:h(msg['label.encColorName'])}</th><td><span id="encColorName" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.rgb'}"><tr data-dencode-method="color.rgb"><th>${mf:h(msg['label.encColorRGBHex3'])}</th><td><span id="encColorRGBHex3" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.rgb'}"><tr data-dencode-method="color.rgb"><th>${mf:h(msg['label.encColorRGBHex6'])}</th><td><span id="encColorRGBHex6" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.rgb'}"><tr data-dencode-method="color.rgb"><th>${mf:h(msg['label.encColorRGBFn8'])}</th><td><span id="encColorRGBFn8" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.rgb'}"><tr data-dencode-method="color.rgb"><th>${mf:h(msg['label.encColorRGBFn'])}</th><td><span id="encColorRGBFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.hsl'}"><tr data-dencode-method="color.hsl"><th>${mf:h(msg['label.encColorHSLFn'])}</th><td><span id="encColorHSLFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.hsv'}"><tr data-dencode-method="color.hsv"><th>${mf:h(msg['label.encColorHSVFn'])}</th><td><span id="encColorHSVFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.cmy'}"><tr data-dencode-method="color.cmy"><th>${mf:h(msg['label.encColorCMYFn'])}</th><td><span id="encColorCMYFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.cmyk'}"><tr data-dencode-method="color.cmyk"><th>${mf:h(msg['label.encColorCMYKFn'])}</th><td><span id="encColorCMYKFn" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'cipher'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.caesar'}"><tr data-dencode-method="cipher.caesar"><th>${mf:h(msg['label.encCipherCaesar'])}</th><td><span id="encCipherCaesar" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.encCipherCaesar.option.shift'])}</span>
											<select name="encCipherCaesarShift" class="dencode-option form-control" data-value-link-to="[name=decCipherCaesarShift]">
												<option value="1">${mf:h(msg['label.encCipherCaesar.option.shift.1'])}</option>
												<option value="2">${mf:h(msg['label.encCipherCaesar.option.shift.2'])}</option>
												<option value="3">${mf:h(msg['label.encCipherCaesar.option.shift.3'])}</option>
												<option value="4">${mf:h(msg['label.encCipherCaesar.option.shift.4'])}</option>
												<option value="5">${mf:h(msg['label.encCipherCaesar.option.shift.5'])}</option>
												<option value="6">${mf:h(msg['label.encCipherCaesar.option.shift.6'])}</option>
												<option value="7">${mf:h(msg['label.encCipherCaesar.option.shift.7'])}</option>
												<option value="8">${mf:h(msg['label.encCipherCaesar.option.shift.8'])}</option>
												<option value="9">${mf:h(msg['label.encCipherCaesar.option.shift.9'])}</option>
												<option value="10">${mf:h(msg['label.encCipherCaesar.option.shift.10'])}</option>
												<option value="11">${mf:h(msg['label.encCipherCaesar.option.shift.11'])}</option>
												<option value="12">${mf:h(msg['label.encCipherCaesar.option.shift.12'])}</option>
												<option value="13">${mf:h(msg['label.encCipherCaesar.option.shift.13'])}</option>
												<option value="14">${mf:h(msg['label.encCipherCaesar.option.shift.14'])}</option>
												<option value="15">${mf:h(msg['label.encCipherCaesar.option.shift.15'])}</option>
												<option value="16">${mf:h(msg['label.encCipherCaesar.option.shift.16'])}</option>
												<option value="17">${mf:h(msg['label.encCipherCaesar.option.shift.17'])}</option>
												<option value="18">${mf:h(msg['label.encCipherCaesar.option.shift.18'])}</option>
												<option value="19">${mf:h(msg['label.encCipherCaesar.option.shift.19'])}</option>
												<option value="20">${mf:h(msg['label.encCipherCaesar.option.shift.20'])}</option>
												<option value="21">${mf:h(msg['label.encCipherCaesar.option.shift.21'])}</option>
												<option value="22">${mf:h(msg['label.encCipherCaesar.option.shift.22'])}</option>
												<option value="23">${mf:h(msg['label.encCipherCaesar.option.shift.23'])}</option>
												<option value="24">${mf:h(msg['label.encCipherCaesar.option.shift.24'])}</option>
												<option value="25">${mf:h(msg['label.encCipherCaesar.option.shift.25'])}</option>
												<option value="26">${mf:h(msg['label.encCipherCaesar.option.shift.26'])}</option>
												<option value="27">${mf:h(msg['label.encCipherCaesar.option.shift.27'])}</option>
												<option value="28">${mf:h(msg['label.encCipherCaesar.option.shift.28'])}</option>
												<option value="29">${mf:h(msg['label.encCipherCaesar.option.shift.29'])}</option>
												<option value="30">${mf:h(msg['label.encCipherCaesar.option.shift.30'])}</option>
												<option value="31">${mf:h(msg['label.encCipherCaesar.option.shift.31'])}</option>
											</select>
										</div>
									</div>
								</form>
							</td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.rot13'}"><tr data-dencode-method="cipher.rot13"><th>${mf:h(msg['label.encCipherROT13'])}</th><td><span id="encCipherROT13" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.rot18'}"><tr data-dencode-method="cipher.rot18"><th>${mf:h(msg['label.encCipherROT18'])}</th><td><span id="encCipherROT18" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.rot47'}"><tr data-dencode-method="cipher.rot47"><th>${mf:h(msg['label.encCipherROT47'])}</th><td><span id="encCipherROT47" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.scytale'}"><tr data-dencode-method="cipher.scytale"><th>${mf:h(msg['label.encCipherScytale'])}</th><td><span id="encCipherScytale" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.encCipherScytale.option.key'])}</span>
											<select name="encCipherScytaleKey" class="dencode-option form-control" data-value-link-to="[name=decCipherScytaleKey]">
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
								</form>
							</td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'cipher.all' or method eq 'cipher.rail-fence'}"><tr data-dencode-method="cipher.rail-fence"><th>${mf:h(msg['label.encCipherRailFence'])}</th><td><span id="encCipherRailFence" class="for-disp"></span>
								<form class="dencode-option-group form-inline">
									<div class="form-group form-group-sm">
										<div class="input-group">
											<span class="input-group-addon">${mf:h(msg['label.encCipherRailFence.option.key'])}</span>
											<select name="encCipherRailFenceKey" class="dencode-option form-control" data-value-link-to="[name=decCipherRailFenceKey]">
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
								</form>
							</td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'hash'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.md2'}"><tr data-dencode-method="hash.md2"><th>${mf:h(msg['label.encHashMD2'])}</th><td><span id="encHashMD2" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.md5'}"><tr data-dencode-method="hash.md5"><th>${mf:h(msg['label.encHashMD5'])}</th><td><span id="encHashMD5" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.sha1'}"><tr data-dencode-method="hash.sha1"><th>${mf:h(msg['label.encHashSHA1'])}</th><td><span id="encHashSHA1" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.sha256'}"><tr data-dencode-method="hash.sha256"><th>${mf:h(msg['label.encHashSHA256'])}</th><td><span id="encHashSHA256" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.sha384'}"><tr data-dencode-method="hash.sha384"><th>${mf:h(msg['label.encHashSHA384'])}</th><td><span id="encHashSHA384" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.sha512'}"><tr data-dencode-method="hash.sha512"><th>${mf:h(msg['label.encHashSHA512'])}</th><td><span id="encHashSHA512" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.crc32'}"><tr data-dencode-method="hash.crc32"><th>${mf:h(msg['label.encHashCRC32'])}</th><td><span id="encHashCRC32" class="for-disp"></span></td></tr></c:if>
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
				<div><a class="other-dencode-link" href="#" data-other-dencode-method="${mf:h((fn:endsWith(method, '.all')) ? 'all' : mf:strcat(type, '.all'))}">${mf:h(msg[mf:strcat('label.otherDencodeLink.', (fn:endsWith(method, '.all')) ? 'all' : mf:strcat(type, '.all'))])}</a></div>
			</c:if>
		</div>
		
		<div id="adBottom" style="margin: 2em 0 1em;">
			<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-6871955725174244" data-ad-slot="5289392761" data-ad-format="rectangle" data-full-width-responsive="true"></ins>
		</div>
		
		<c:set var="methodDescIncPagePath" value="method-desc_${method}_${msg['lang']}.inc.jsp" scope="request" />
		<% if (new java.io.File(application.getRealPath("/WEB-INF/pages/" + request.getAttribute("methodDescIncPagePath"))).exists()) { %>
				<hr />
				<jsp:include page="${methodDescIncPagePath}" />
		<% } %>
	</div>
</div>

<footer>
	© <a href="https://github.com/mozq/dencode-web" target="_blank">Mozq</a>
	| <a href="#" data-toggle="modal" data-target="#policyDialog">${mf:h(msg['label.policy'])}</a>
</footer>

<div id="policyDialog" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="policyDialogLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<span id="policyDialogLabel" class="modal-title">${mf:h(msg['label.policy'])}</span>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<jsp:include page="policy_${msg['lang']}.inc.jsp" />
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">${mf:h(msg['label.close'])}</button>
			</div>
		</div>
	</div>
</div>

<script id="messagesTmpl" type="text/template">
	<div class="alert {{#type}}alert-{{type}}{{/type}}">
		<button type="button" class="close" data-dismiss="alert">×</button>
		{{#message}}
			<h4>{{message}}</h4>
		{{/message}}
		{{#detail}}
			<p>{{detail}}</p>
		{{/detail}}
	</div>
</script>
<script id="forCopyTmpl" type="text/template">
	<div class="for-copy">
		<form action="#">
			<div class="input-group">
				<textarea id="{{id}}ForCopy" class="form-control select-on-focus" rows="2" readonly>{{value}}</textarea>
				<span class="input-group-addon">
					<span class="btn-group-vertical">
						<button type="button" class="btn btn-v-icon-label copy-to-clipboard" title="${mf:h(msg['label.copyToClipboard'])}" data-copy-id="{{id}}ForCopy" data-copy-message="${mf:h(msg['label.copyToClipboard.message'])}" data-copy-error-message="${mf:h(msg['label.copyToClipboard.errorMessage'])}">
							<span class="glyphicon glyphicon-duplicate"></span>
							<span class="btn-label">${mf:h(msg['label.copyToClipboard.buttonLabel'])}</span>
						</button>
						<button type="button" class="btn btn-v-icon-label permanent-link popover-toggle" title="${mf:h(msg['label.permanentLink'])}">
							<span class="glyphicon glyphicon-link"></span>
							<span class="btn-label">${mf:h(msg['label.permanentLink.buttonLabel'])}</span>
						</button>
					</span>
				</span>
			</div>
		</form>
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
	<form action="#">
		<div id="permanentLink" class="input-group">
			<input id="linkURL" class="form-control select-on-focus" type="text" value="{{permanentLink}}" readonly />
			<span class="input-group-btn">
				<button type="button" class="btn btn-v-icon-label copy-to-clipboard" title="${mf:h(msg['label.copyToClipboard'])}" data-copy-id="linkURL" data-copy-message="${mf:h(msg['label.copyToClipboard.message'])}" data-copy-error-message="${mf:h(msg['label.copyToClipboard.errorMessage'])}">
					<span class="glyphicon glyphicon-duplicate"></span>
					<span class="btn-label">${mf:h(msg['label.copyToClipboard.buttonLabel'])}</span>
				</button>
				<button type="button" class="btn btn-v-icon-label dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
					<span class="glyphicon glyphicon-share-alt"></span>
					<span class="btn-label">${mf:h(msg['label.share.buttonLabel'])}</span>
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu">
					<li><a class="share-link" href="{{permanentLink}}" target="_blank" data-share-method="openNewPage"><span class="glyphicon glyphicon-new-window"></span> ${mf:h(msg['label.openNewPage'])}</a></li>
					<li><a class="share-link" href="mailto:?body=%0D%0A{{permanentLinkUrlEncoded}}" data-share-method="sendByEmail"><span class="glyphicon glyphicon-envelope"></span> ${mf:h(msg['label.sendByEmail'])}</a></li>
					<li><a class="share-link" href="https://twitter.com/share?url={{permanentLinkUrlEncoded}}" target="_blank" data-share-method="shareOnTwitter"><span class="glyphicon glyphicon-share"></span> ${mf:h(msg['label.shareOnTwitter'])}</a></li>
					<li><a class="share-link" href="https://www.facebook.com/sharer/sharer.php?u={{permanentLinkUrlEncoded}}" target="_blank" data-share-method="shareOnFacebook"><span class="glyphicon glyphicon-share"></span> ${mf:h(msg['label.shareOnFacebook'])}</a></li>
				</ul>
			</span>
		</div>
	</form>
</script>
<script id="adMiddleTmpl" type="text/template">
	<tr id="adMiddle">
		<td colspan="2" style="padding: 2em 0">
			<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-6871955725174244" data-ad-slot="8967889103" data-ad-format="horizontal" data-full-width-responsive="true"></ins>
		</td>
	</tr>
</script>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/hogan.js/3.0.2/hogan.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/all.min.js?v=<%= new java.io.File(application.getRealPath("/static/js/all.min.js")).lastModified() %>"></script>
<script>
	"use strict";

	setDefaultErrorMessage(newMessage(
			null,
			"${mf:jsstr(msg['default.error.level'])}",
			"${mf:jsstr(msg['default.error'])}",
			"${mf:jsstr(msg['default.error.detail'])}"
			));
</script>
</body>
</html>
