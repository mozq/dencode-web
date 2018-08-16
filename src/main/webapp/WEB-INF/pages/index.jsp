<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="mf" uri="http://mifmi.org/jsp/taglib/functions"
%><!DOCTYPE html>
<html lang="${mf:h(msg['lang'])}" prefix="og: http://ogp.me/ns#">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
	<meta name="description" content="${mf:h(msg[mf:strcat('site.desc.', type)])}" />
	<meta name="robots" content="index,follow,noarchive" />
	<meta name="application-name" content="${mf:h(msg['site.name'])}" />
	<meta name="apple-mobile-web-app-title" content="${mf:h(msg['site.name'])}" />
	<meta property="og:site_name" content="${mf:h(msg['site.name'])}" />
	<meta property="og:url" content="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/${mf:h(currentPath)}" />
	<meta property="og:image" content="${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}/res/img/icons/favicon200px.png" />
	<meta property="og:locale" content="${mf:h(msg['locale'])}" />
	<meta property="og:locale:alternate" content="en_US" />
	<meta property="og:locale:alternate" content="ja_JP" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="${mf:h(msg[mf:strcat('site.title.', method)])}${mf:h(msg['site.title.suffix'])}" />
	<meta property="og:description" content="${mf:h(msg[mf:strcat('site.desc.', method)])}" />
	<link rel="alternate" href="${pageContext.request.contextPath}/en/${mf:h(currentPath)}" hreflang="en" />
	<link rel="alternate" href="${pageContext.request.contextPath}/ja/${mf:h(currentPath)}" hreflang="ja" />
	<link rel="alternate" href="${pageContext.request.contextPath}/hi/${mf:h(currentPath)}" hreflang="hi" />
	<link rel="alternate" href="${pageContext.request.contextPath}/${mf:h(currentPath)}" hreflang="x-default" />
	<link rel="icon" type="x-icon" href="${pageContext.request.contextPath}/favicon.ico" />
	<link rel="shortcut icon" type="x-icon" href="${pageContext.request.contextPath}/favicon.ico" />
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/res/img/icons/favicon144px.png" />
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/res/img/icons/favicon114px.png" />
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/res/img/icons/favicon72px.png" />
	<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/res/img/icons/favicon57px.png" />
	<link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />
	<link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/chosen/1.8.2/chosen.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/css/main.css" />
	<script type="text/javascript">
	var contextPath = "${pageContext.request.contextPath}";
	</script>
	<!--[if lt IE 9]>  
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<title>${mf:h(msg[mf:strcat('site.title.', method)])}${mf:h(msg['site.title.suffix'])}</title>
</head>
<body>
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
							<li class="${(localeName eq 'hi') ? 'active' : ''}"><a href="${pageContext.request.contextPath}/hi/${mf:h(currentPath)}">हिन्दी</a></li>
						</ul>
					</li>
				</ul>
				<a id="brand" class="navbar-brand" href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/">${mf:h(msg['site.name'])}</a>
				<p class="navbar-text">Enjoy Encoding &amp; Decoding!</p>
			</div>
			<div id="typeMenu" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="${(type eq 'all') ? 'active' : ''}" data-dencode-type="all" data-dencode-method="all">
						<a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/">${mf:h(msg['label.type.all'])}</a>
					</li>
					<li class="dropdown ${(type eq 'string') ? 'active' : ''}" role="presentation" data-dencode-type="string">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.string'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'string.all') ? 'active' : ''}" data-dencode-method="string.all"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string">${mf:h(msg['label.method.string.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.bin') ? 'active' : ''}" data-dencode-method="string.bin"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/bin">${mf:h(msg['label.method.string.bin'])}</a></li>
							<li class="${(method eq 'string.hex') ? 'active' : ''}" data-dencode-method="string.hex"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/hex">${mf:h(msg['label.method.string.hex'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.htmlEscape') ? 'active' : ''}" data-dencode-method="string.htmlEscape"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/html-escape">${mf:h(msg['label.method.string.htmlEscape'])}</a></li>
							<li class="${(method eq 'string.urlEncoding') ? 'active' : ''}" data-dencode-method="string.urlEncoding"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/url-encoding">${mf:h(msg['label.method.string.urlEncoding'])}</a></li>
							<li class="${(method eq 'string.base64') ? 'active' : ''}" data-dencode-method="string.base64"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/base64">${mf:h(msg['label.method.string.base64'])}</a></li>
							<li class="${(method eq 'string.quotedPrintable') ? 'active' : ''}" data-dencode-method="string.quotedPrintable"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/quoted-printable">${mf:h(msg['label.method.string.quotedPrintable'])}</a></li>
							<li class="${(method eq 'string.unicodeEscape') ? 'active' : ''}" data-dencode-method="string.unicodeEscape"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/unicode-escape">${mf:h(msg['label.method.string.unicodeEscape'])}</a></li>
							<li class="${(method eq 'string.programString') ? 'active' : ''}" data-dencode-method="string.programString"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/program-string">${mf:h(msg['label.method.string.programString'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.camelCase') ? 'active' : ''}" data-dencode-method="string.camelCase"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/camel-case">${mf:h(msg['label.method.string.camelCase'])}</a></li>
							<li class="${(method eq 'string.snakeCase') ? 'active' : ''}" data-dencode-method="string.snakeCase"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/snake-case">${mf:h(msg['label.method.string.snakeCase'])}</a></li>
							<li class="${(method eq 'string.chainCase') ? 'active' : ''}" data-dencode-method="string.chainCase"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/chain-case">${mf:h(msg['label.method.string.chainCase'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.characterWidth') ? 'active' : ''}" data-dencode-method="string.characterWidth"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/character-width">${mf:h(msg['label.method.string.characterWidth'])}</a></li>
							<li class="${(method eq 'string.letterCase') ? 'active' : ''}" data-dencode-method="string.letterCase"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/letter-case">${mf:h(msg['label.method.string.letterCase'])}</a></li>
							<li class="${(method eq 'string.textInitials') ? 'active' : ''}" data-dencode-method="string.textInitials"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/text-initials">${mf:h(msg['label.method.string.textInitials'])}</a></li>
							<li class="${(method eq 'string.textReverse') ? 'active' : ''}" data-dencode-method="string.textReverse"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/text-reverse">${mf:h(msg['label.method.string.textReverse'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'string.unicodeNormalization') ? 'active' : ''}" data-dencode-method="string.unicodeNormalization"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/string/unicode-normalization">${mf:h(msg['label.method.string.unicodeNormalization'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'number') ? 'active' : ''}" role="presentation" data-dencode-type="number">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.number'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'number.all') ? 'active' : ''}" data-dencode-method="number.all"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/number">${mf:h(msg['label.method.number.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'number.bin') ? 'active' : ''}" data-dencode-method="number.bin"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/number/bin">${mf:h(msg['label.method.number.bin'])}</a></li>
							<li class="${(method eq 'number.oct') ? 'active' : ''}" data-dencode-method="number.oct"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/number/oct">${mf:h(msg['label.method.number.oct'])}</a></li>
							<li class="${(method eq 'number.hex') ? 'active' : ''}" data-dencode-method="number.hex"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/number/hex">${mf:h(msg['label.method.number.hex'])}</a></li>
							<li class="${(method eq 'number.japanese') ? 'active' : ''}" data-dencode-method="number.japanese"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/number/japanese">${mf:h(msg['label.method.number.japanese'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'date') ? 'active' : ''}" role="presentation" data-dencode-type="date">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.date'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'date.all') ? 'active' : ''}" data-dencode-method="date.all"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/date">${mf:h(msg['label.method.date.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'date.unixTime') ? 'active' : ''}" data-dencode-method="date.unixTime"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/date/unix-time">${mf:h(msg['label.method.date.unixTime'])}</a></li>
							<li class="${(method eq 'date.iso8601') ? 'active' : ''}" data-dencode-method="date.iso8601"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/date/iso8601">${mf:h(msg['label.method.date.iso8601'])}</a></li>
							<li class="${(method eq 'date.rfc2822') ? 'active' : ''}" data-dencode-method="date.rfc2822"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/date/rfc2822">${mf:h(msg['label.method.date.rfc2822'])}</a></li>
							<li class="${(method eq 'date.ctime') ? 'active' : ''}" data-dencode-method="date.ctime"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/date/ctime">${mf:h(msg['label.method.date.ctime'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'color') ? 'active' : ''}" role="presentation" data-dencode-type="color">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.color'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'color.all') ? 'active' : ''}" data-dencode-method="color.all"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/color">${mf:h(msg['label.method.color.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'color.name') ? 'active' : ''}" data-dencode-method="color.name"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/color/name">${mf:h(msg['label.method.color.name'])}</a></li>
							<li class="${(method eq 'color.rgb') ? 'active' : ''}" data-dencode-method="color.rgb"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/color/rgb">${mf:h(msg['label.method.color.rgb'])}</a></li>
							<li class="${(method eq 'color.hsl') ? 'active' : ''}" data-dencode-method="color.hsl"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/color/hsl">${mf:h(msg['label.method.color.hsl'])}</a></li>
							<li class="${(method eq 'color.hsv') ? 'active' : ''}" data-dencode-method="color.hsv"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/color/hsv">${mf:h(msg['label.method.color.hsv'])}</a></li>
							<li class="${(method eq 'color.cmy') ? 'active' : ''}" data-dencode-method="color.cmy"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/color/cmy">${mf:h(msg['label.method.color.cmy'])}</a></li>
							<li class="${(method eq 'color.cmyk') ? 'active' : ''}" data-dencode-method="color.cmyk"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/color/cmyk">${mf:h(msg['label.method.color.cmyk'])}</a></li>
						</ul>
					</li>
					<li class="dropdown ${(type eq 'hash') ? 'active' : ''}" role="presentation" data-dencode-type="hash">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
							<span class="dropdown-menu-label">${mf:h(msg['label.type.hash'])}</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li class="${(method eq 'hash.all') ? 'active' : ''}" data-dencode-method="hash.all"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/hash">${mf:h(msg['label.method.hash.all'])}</a></li>
							<li class="divider"></li>
							<li class="${(method eq 'hash.md2') ? 'active' : ''}" data-dencode-method="hash.md2"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/hash/md2">${mf:h(msg['label.method.hash.md2'])}</a></li>
							<li class="${(method eq 'hash.md5') ? 'active' : ''}" data-dencode-method="hash.md5"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/hash/md5">${mf:h(msg['label.method.hash.md5'])}</a></li>
							<li class="${(method eq 'hash.sha1') ? 'active' : ''}" data-dencode-method="hash.sha1"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/hash/sha1">${mf:h(msg['label.method.hash.sha1'])}</a></li>
							<li class="${(method eq 'hash.sha256') ? 'active' : ''}" data-dencode-method="hash.sha256"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/hash/sha256">${mf:h(msg['label.method.hash.sha256'])}</a></li>
							<li class="${(method eq 'hash.sha384') ? 'active' : ''}" data-dencode-method="hash.sha384"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/hash/sha384">${mf:h(msg['label.method.hash.sha384'])}</a></li>
							<li class="${(method eq 'hash.sha512') ? 'active' : ''}" data-dencode-method="hash.sha512"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/hash/sha512">${mf:h(msg['label.method.hash.sha512'])}</a></li>
							<li class="${(method eq 'hash.crc32') ? 'active' : ''}" data-dencode-method="hash.crc32"><a href="${pageContext.request.contextPath}${mf:h(mf:strcatNotBlank('/', localeName))}/hash/crc32">${mf:h(msg['label.method.hash.crc32'])}</a></li>
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
				<span id="link" title="${mf:h(msg['label.permanentLink'])}" data-toggle="popover"><span class="glyphicon glyphicon-link"></span></span>
				<span id="vLen" class="badge" title="${mf:h(msg['label.val.length'])}" data-toggle="popover" data-len-chars="0" data-len-bytes="0">0</span>
			</div>
			<textarea id="v" placeholder="${mf:h(msg[mf:strcat('label.val.tooltip.', method)])}">${mf:h(v)}</textarea><br />
			<div id="oeGroup" class="btn-group btn-group-xs" data-enable="${(useOe) ? 'true' : 'false'}" style="display: none;">
				<button class="btn ${(oe eq 'utf8' or oe eq '') ? 'active' : ''}" data-oe="utf8" data-oe-iana="UTF-8">UTF-8</button>
				<button class="btn ${(oe eq 'utf16') ? 'active' : ''}" data-oe="utf16" data-oe-iana="UTF-16">UTF-16</button>
				<button class="btn ${(oe eq 'utf32') ? 'active' : ''}" data-oe="utf32" data-oe-iana="UTF-32">UTF-32</button>
				<div class="btn-group btn-group-xs">
					<button id="oex" class="btn ${(oe eq oex) ? 'active' : ''}" data-oe="" data-oe-iana="" style="display: none;"></button>
					<button class="btn dropdown-toggle" type="button" data-toggle="dropdown">
						<span class="caret"></span>
					</button>
					<ul id="oexMenu" class="dropdown-menu" role="menu">
						<li class="${(oex eq 'iso88591') ? 'active' : ''}" data-oe="iso88591" data-oe-iana="ISO-8859-1">ISO-8859-1 (Latin-1)</li>
						<li class="${(oex eq 'iso885915') ? 'active' : ''}" data-oe="iso885915" data-oe-iana="ISO-8859-15">ISO-8859-15 (Latin-9)</li>
						<li class="${(oex eq 'cp1252') ? 'active' : ''}" data-oe="cp1252" data-oe-iana="windows-1252">Windows-1252</li>
						<li class="divider"></li>
						<li class="${(oex eq 'iso88592') ? 'active' : ''}" data-oe="iso88592" data-oe-iana="ISO-8859-2">ISO-8859-2 (Latin-2)</li>
						<li class="${(oex eq 'cp1250') ? 'active' : ''}" data-oe="cp1250" data-oe-iana="windows-1250">Windows-1250</li>
						<li class="divider"></li>
						<li class="${(oex eq 'iso88594') ? 'active' : ''}" data-oe="iso88594" data-oe-iana="ISO-8859-4">ISO-8859-4 (Latin-4)</li>
						<li class="${(oex eq 'iso885913') ? 'active' : ''}" data-oe="iso885913" data-oe-iana="ISO-8859-13">ISO-8859-13 (Latin-7)</li>
						<li class="${(oex eq 'cp1257') ? 'active' : ''}" data-oe="cp1257" data-oe-iana="windows-1257">Windows-1257</li>
						<li class="divider"></li>
						<li class="${(oex eq 'sjis') ? 'active' : ''}" data-oe="sjis" data-oe-iana="Shift_JIS">Shift_JIS</li>
						<li class="${(oex eq 'eucjp') ? 'active' : ''}" data-oe="eucjp" data-oe-iana="EUC-JP">EUC-JP</li>
						<li class="${(oex eq 'iso2022jp') ? 'active' : ''}" data-oe="iso2022jp" data-oe-iana="ISO-2022-JP">ISO-2022-JP (JIS)</li>
						<li class="divider"></li>
						<li class="${(oex eq 'gb18030') ? 'active' : ''}" data-oe="gb18030" data-oe-iana="GB18030">GB18030</li>
						<li class="${(oex eq 'euccn') ? 'active' : ''}" data-oe="euccn" data-oe-iana="GB2312">EUC-CN (GB2312)</li>
						<li class="${(oex eq 'big5hkscs') ? 'active' : ''}" data-oe="big5hkscs" data-oe-iana="Big5-HKSCS">Big5-HKSCS</li>
						<li class="divider"></li>
						<li class="${(oex eq 'euckr') ? 'active' : ''}" data-oe="euckr" data-oe-iana="EUC-KR">EUC-KR</li>
						<li class="divider"></li>
						<li class="${(oex eq 'iso88595') ? 'active' : ''}" data-oe="iso88595" data-oe-iana="ISO-8859-5">ISO-8859-5</li>
						<li class="${(oex eq 'cp1251') ? 'active' : ''}" data-oe="cp1251" data-oe-iana="windows-1251">Windows-1251</li>
						<li class="${(oex eq 'koi8r') ? 'active' : ''}" data-oe="koi8r" data-oe-iana="KOI8-R">KOI8-R</li>
						<li class="${(oex eq 'koi8u') ? 'active' : ''}" data-oe="koi8u" data-oe-iana="KOI8-U">KOI8-U</li>
						<li class="divider"></li>
						<li class="${(oex eq 'iso88596') ? 'active' : ''}" data-oe="iso88596" data-oe-iana="ISO-8859-6">ISO-8859-6</li>
						<li class="${(oex eq 'cp1256') ? 'active' : ''}" data-oe="cp1256" data-oe-iana="windows-1256">Windows-1256</li>
						<li class="divider"></li>
						<li class="${(oex eq 'iso88597') ? 'active' : ''}" data-oe="iso88597" data-oe-iana="ISO-8859-7">ISO-8859-7</li>
						<li class="${(oex eq 'cp1253') ? 'active' : ''}" data-oe="cp1253" data-oe-iana="windows-1253">Windows-1253</li>
						<li class="divider"></li>
						<li class="${(oex eq 'iso88598') ? 'active' : ''}" data-oe="iso88598" data-oe-iana="ISO-8859-8">ISO-8859-8</li>
						<li class="${(oex eq 'cp1255') ? 'active' : ''}" data-oe="cp1255" data-oe-iana="windows-1255">Windows-1255</li>
						<li class="divider"></li>
						<li class="${(oex eq 'iso88599') ? 'active' : ''}" data-oe="iso88599" data-oe-iana="ISO-8859-9">ISO-8859-9</li>
						<li class="${(oex eq 'cp1254') ? 'active' : ''}" data-oe="cp1254" data-oe-iana="windows-1254">Windows-1254</li>
						<li class="divider"></li>
						<li class="${(oex eq 'tis620') ? 'active' : ''}" data-oe="tis620" data-oe-iana="TIS-620">TIS-620</li>
						<li class="${(oex eq 'cp874') ? 'active' : ''}" data-oe="cp874" data-oe-iana="windows-874">Windows-874</li>
						<li class="divider"></li>
						<li class="${(oex eq 'cp1258') ? 'active' : ''}" data-oe="cp1258" data-oe-iana="windows-1258">Windows-1258</li>
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
				<img id="decodingIndicator" src="${pageContext.request.contextPath}/res/img/loading-indicator.gif" style="display: none;" />
			</h2>
			<div id="decodedListContainer">
				<table id="decodedList" class="dencoded-list">
					<c:if test="${type eq 'all' or type eq 'string'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.bin'}"><tr><th>${mf:h(msg['label.decBin'])}</th><td><span id="decBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.hex'}"><tr><th>${mf:h(msg['label.decHex'])}</th><td><span id="decHex" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.htmlEscape'}"><tr><th>${mf:h(msg['label.decHTMLEscape'])}</th><td><span id="decHTMLEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.urlEncoding'}"><tr><th>${mf:h(msg['label.decURLEncoding'])}</th><td><span id="decURLEncoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.base64'}"><tr><th>${mf:h(msg['label.decBase64Encoding'])}</th><td><span id="decBase64Encoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.quotedPrintable'}"><tr><th>${mf:h(msg['label.decQuotedPrintable'])}</th><td><span id="decQuotedPrintable" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicodeEscape'}"><tr><th>${mf:h(msg['label.decUnicodeEscape'])}</th><td><span id="decUnicodeEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.programString'}"><tr><th>${mf:h(msg['label.decProgramString'])}</th><td><span id="decProgramString" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicodeNormalization'}"><tr><th>${mf:h(msg['label.decUnicodeNFC'])}</th><td><span id="decUnicodeNFC" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicodeNormalization'}"><tr><th>${mf:h(msg['label.decUnicodeNFKC'])}</th><td><span id="decUnicodeNFKC" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'number'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.bin'}"><tr><th>${mf:h(msg['label.decNumBin'])}</th><td><span id="decNumBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.oct'}"><tr><th>${mf:h(msg['label.decNumOct'])}</th><td><span id="decNumOct" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.hex'}"><tr><th>${mf:h(msg['label.decNumHex'])}</th><td><span id="decNumHex" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.japanese'}"><tr><th>${mf:h(msg['label.decNumJP'])}</th><td><span id="decNumJP" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
				</table>
			</div>
		</div>
		
		<div id="encoded" ${(hasEncoded) ? '' : 'style="display: none;"'}>
			<h2 data-toggle-show="#encodedListContainer">
				<span class="toggle-icon glyphicon glyphicon-collapse-down"></span>
				${mf:h(msg['label.encoded'])}
				<img id="encodingIndicator" src="${pageContext.request.contextPath}/res/img/loading-indicator.gif" style="display: none;" />
			</h2>
			<div id="encodedListContainer">
				<table id="encodedList" class="dencoded-list">
					<c:if test="${type eq 'all' or type eq 'string'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.bin'}"><tr><th>${mf:h(msg['label.encBin'])}</th><td><span id="encBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.hex'}"><tr><th>${mf:h(msg['label.encHex'])}</th><td><span id="encHex" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.htmlEscape'}"><tr><th>${mf:h(msg['label.encHTMLEscape'])}</th><td><span id="encHTMLEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.urlEncoding'}"><tr><th>${mf:h(msg['label.encURLEncoding'])}</th><td><span id="encURLEncoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.base64'}"><tr><th>${mf:h(msg['label.encBase64Encoding'])}</th><td><span id="encBase64Encoding" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.quotedPrintable'}"><tr><th>${mf:h(msg['label.encQuotedPrintable'])}</th><td><span id="encQuotedPrintable" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicodeEscape'}"><tr><th>${mf:h(msg['label.encUnicodeEscape'])}</th><td><span id="encUnicodeEscape" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.programString'}"><tr><th>${mf:h(msg['label.encProgramString'])}</th><td><span id="encProgramString" class="for-disp"></span></td></tr></c:if>
						</tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.camelCase'}"><tr><th>${mf:h(msg['label.encUpperCamelCase'])}</th><td><span id="encUpperCamelCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.camelCase'}"><tr><th>${mf:h(msg['label.encLowerCamelCase'])}</th><td><span id="encLowerCamelCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.snakeCase'}"><tr><th>${mf:h(msg['label.encUpperSnakeCase'])}</th><td><span id="encUpperSnakeCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.snakeCase'}"><tr><th>${mf:h(msg['label.encLowerSnakeCase'])}</th><td><span id="encLowerSnakeCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.chainCase'}"><tr><th>${mf:h(msg['label.encUpperChainCase'])}</th><td><span id="encUpperChainCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.chainCase'}"><tr><th>${mf:h(msg['label.encLowerChainCase'])}</th><td><span id="encLowerChainCase" class="for-disp"></span></td></tr></c:if>
						</tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.characterWidth'}"><tr><th>${mf:h(msg['label.encHalfWidth'])}</th><td><span id="encHalfWidth" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.characterWidth'}"><tr><th>${mf:h(msg['label.encFullWidth'])}</th><td><span id="encFullWidth" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.letterCase'}"><tr><th>${mf:h(msg['label.encUpperCase'])}</th><td><span id="encUpperCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.letterCase'}"><tr><th>${mf:h(msg['label.encLowerCase'])}</th><td><span id="encLowerCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.letterCase'}"><tr><th>${mf:h(msg['label.encSwapCase'])}</th><td><span id="encSwapCase" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.letterCase'}"><tr><th>${mf:h(msg['label.encCapitalize'])}</th><td><span id="encCapitalize" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.textInitials'}"><tr><th>${mf:h(msg['label.encInitials'])}</th><td><span id="encInitials" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.textReverse'}"><tr><th>${mf:h(msg['label.encReverse'])}</th><td><span id="encReverse" class="for-disp"></span></td></tr></c:if>
						<tbody>
						<tbody>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicodeNormalization'}"><tr><th>${mf:h(msg['label.encUnicodeNFC'])}</th><td><span id="encUnicodeNFC" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'string.all' or method eq 'string.unicodeNormalization'}"><tr><th>${mf:h(msg['label.encUnicodeNFKC'])}</th><td><span id="encUnicodeNFKC" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'number'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.bin'}"><tr><th>${mf:h(msg['label.encNumBin'])}</th><td><span id="encNumBin" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.oct'}"><tr><th>${mf:h(msg['label.encNumOct'])}</th><td><span id="encNumOct" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.hex'}"><tr><th>${mf:h(msg['label.encNumHex'])}</th><td><span id="encNumHex" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.japanese'}"><tr><th>${mf:h(msg['label.encNumJP'])}</th><td><span id="encNumJP" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'number.all' or method eq 'number.japanese'}"><tr><th>${mf:h(msg['label.encNumJPDaiji'])}</th><td><span id="encNumJPDaiji" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'date'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.unixTime'}"><tr><th>${mf:h(msg['label.encDateUnixTime'])}</th><td><span id="encDateUnixTime" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.iso8601'}"><tr><th>${mf:h(msg['label.encDateISO8601'])}</th><td><span id="encDateISO8601" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.rfc2822'}"><tr><th>${mf:h(msg['label.encDateRFC2822'])}</th><td><span id="encDateRFC2822" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'date.all' or method eq 'date.ctime'}"><tr><th>${mf:h(msg['label.encDateCTime'])}</th><td><span id="encDateCTime" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'color'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.name'}"><tr><th>${mf:h(msg['label.encColorName'])}</th><td><span id="encColorName" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.rgb'}"><tr><th>${mf:h(msg['label.encColorRGBHex3'])}</th><td><span id="encColorRGBHex3" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.rgb'}"><tr><th>${mf:h(msg['label.encColorRGBHex6'])}</th><td><span id="encColorRGBHex6" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.rgb'}"><tr><th>${mf:h(msg['label.encColorRGBFn8'])}</th><td><span id="encColorRGBFn8" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.rgb'}"><tr><th>${mf:h(msg['label.encColorRGBFn'])}</th><td><span id="encColorRGBFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.hsl'}"><tr><th>${mf:h(msg['label.encColorHSLFn'])}</th><td><span id="encColorHSLFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.hsv'}"><tr><th>${mf:h(msg['label.encColorHSVFn'])}</th><td><span id="encColorHSVFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.cmy'}"><tr><th>${mf:h(msg['label.encColorCMYFn'])}</th><td><span id="encColorCMYFn" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'color.all' or method eq 'color.cmyk'}"><tr><th>${mf:h(msg['label.encColorCMYKFn'])}</th><td><span id="encColorCMYKFn" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
					<c:if test="${type eq 'all' or type eq 'hash'}">
						<tbody>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.md2'}"><tr><th>${mf:h(msg['label.encMD2'])}</th><td><span id="encMD2" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.md5'}"><tr><th>${mf:h(msg['label.encMD5'])}</th><td><span id="encMD5" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.sha1'}"><tr><th>${mf:h(msg['label.encSHA1'])}</th><td><span id="encSHA1" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.sha256'}"><tr><th>${mf:h(msg['label.encSHA256'])}</th><td><span id="encSHA256" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.sha384'}"><tr><th>${mf:h(msg['label.encSHA384'])}</th><td><span id="encSHA384" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.sha512'}"><tr><th>${mf:h(msg['label.encSHA512'])}</th><td><span id="encSHA512" class="for-disp"></span></td></tr></c:if>
							<c:if test="${method eq 'all' or method eq 'hash.all' or method eq 'hash.crc32'}"><tr><th>${mf:h(msg['label.encCRC32'])}</th><td><span id="encCRC32" class="for-disp"></span></td></tr></c:if>
						</tbody>
					</c:if>
				</table>
			</div>
		</div>
		
		<div id="otherDencodeNav">
			<c:if test="${type ne 'all'}">
				<a id="otherDencodeLink" href="#" data-parent-dencode-method="${mf:h((fn:endsWith(method, '.all')) ? 'all' : mf:strcat(type, '.all'))}">${mf:h(msg[mf:strcat('label.otherDencodeLink.', (fn:endsWith(method, '.all')) ? 'all' : mf:strcat(type, '.all'))])}</a>
			</c:if>
		</div>
	</div>
</div>

<footer>
	© <a href="https://github.com/mozq/dencode-web" target="_blank">Mozq</a>
</footer>

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
	<input id="linkURL" type="text" value="{{permanentLink}}" />
</script>

<script type="text/javascript" src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/hogan.js/3.0.2/hogan.min.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/chosen/1.8.2/chosen.jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/res/js/core.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/res/js/main.js"></script>
<script type="text/javascript">
	"use strict";

	setDefaultErrorMessage(newMessage(
			null,
			"${mf:h(msg['default.error.level'])}",
			"${mf:h(msg['default.error'])}",
			"${mf:h(msg['default.error.detail'])}"
			));
</script>
<script type="text/javascript">
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-44831029-1', 'dencode.com');
  ga('send', 'pageview');
</script>
</body>
</html>
