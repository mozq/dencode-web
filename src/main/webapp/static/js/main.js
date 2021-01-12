"use strict";

$(document).ready(function () {
	var _inProc = false;
	var _v = null;
	var _oe = null;
	var _nl = null;
	var _tz = null;
	var _options = null;
	
	var _lengthTmpl = null;
	var _permanentLinkTmpl = null;
	var _forCopyTmpl = null;
	
	var _config = null;
	
	var $window = $(window);
	var $document = $(document);
	var $localeMenuLinks = $("#localeMenu .dropdown-menu a");
	var $typeMenu = $("#typeMenu");
	var $typeMenuItems = $typeMenu.find("li[data-dencode-type]");
	var $typeMenuLinks = $typeMenu.find("a");
	var $typeMenuLabels = $typeMenu.find(".dropdown-menu-label");
	var $methodMenuItems = $typeMenu.find("li[data-dencode-method]");
	var $top = $("#top");
	var $exp = $("#exp");
	var $follow = $("#follow");
	var $vLen = $("#vLen");
	var $v = $("#v");
	var $tz = $("#tz");
	var $oeGroup = $("#oeGroup");
	var $oeGroupBtns = $oeGroup.find(".btn:not(.dropdown-toggle)");
	var $oexBtn = $("#oex");
	var $oexMenuItems = $("#oexMenu li:not(.divider)");
	var $nlGroup = $("#nlGroup");
	var $nlGroupBtns = $nlGroup.find(".btn");
	var $subHeaders = $("h2");
	var $decIndicator = $("#decodingIndicator");
	var $encIndicator = $("#encodingIndicator");
	var $listRows = $(".dencoded-list").find("tr");
	var $optionGroups = $(".dencode-option-group");
	var $options = $(".dencode-option");
	var $otherDencodeLinks = $(".other-dencode-link");
	
	var hash = location.hash;
	if (hash !== null && hash.lastIndexOf("#v=", 0) === 0) {
		$v.val(decodeURIComponent(hash.substring(3)));
		if (history.replaceState) {
			history.replaceState(null, null, location.pathname + location.search);
		} else {
			location.hash = "";
		}
	}
	
	var ajaxDencodeSettings = {
		async: true,
		type: "POST",
		url: contextPath + "/dencode",
		data: null,
		cache: false,
		dataType: "json",
		success: function (data, dataType) {
			clearMessages();
			handleAjaxSuccess(data, dataType);
			render(data.response);
		},
		error: function (xhr, textStatus, errorThrown) {
			handleAjaxError(xhr, textStatus, errorThrown);
		},
		complete: function (xhr, textStatus) {
			_inProc = false;
			
			dencode();
			
			$decIndicator.hide();
			$encIndicator.hide();
		}
	};
	
	if (window.File) {
		$document.on("drop", function (ev) {
			var encoding = $oeGroupBtns.filter(".active").data("oe");
			
			var file = ev.originalEvent.dataTransfer.files[0];
			var reader = new FileReader();
			reader.onload = function (ev) {
				$v.text(ev.target.result);
			};
			reader.readAsText(file, encoding);
			
			return false;
		});
		
		$document.on("dragenter dragover dragleave dragend", false);
	}
	
	$window.on("resize", function () {
		hidePopover($(".popover-toggle.active"));
	});
	
	$document.on("click", function (ev) {
		var $target = $(ev.target);

		// hide popover when other area clicked
		if ($target.closest(".popover-toggle, .popover").length === 0) {
			hidePopover($(".popover-toggle.active"));
		}
	});
	
	$document.on("focus", ".select-on-focus", function () {
		setTimeout(function() {
			selectAllTextValue(this);
		}.bind(this), 1);
	});
	
	$document.on("click", ".copy-to-clipboard", function () {
		var $this = $(this);
		
		copyToClipboard($this);
		$this.focus();
		
		return false;
	});
	
	$document.on("click", ".popover-toggle.permanent-link", function () {
		var $this = $(this);
		
		if ($this.hasClass("active")) {
			hidePopover($this);
		} else {
			var method = $this.closest("[data-dencode-method]").attr("data-dencode-method");
			if (!$this.data("bs.popover")) {
				loadConfig(function (config) {
					$this.popover({
						trigger: "manual",
						container: "body",
						placement: "left",
						html: true,
						sanitizeFn: function (content) {
							return content;
						},
						content: function () {
							var permanentLink = getPermanentLink(method, config);
							return getPermanentLinkTmpl().render({
								permanentLink: permanentLink,
								permanentLinkUrlEncoded: encodeURIComponent(permanentLink)
							});
						}
					});
					$this.popover("show");
				});
			} else {
				$this.popover("show");
			}
		}
	});
	
	$document.on("show.bs.popover", ".popover-toggle", function () {
		var $this = $(this);
		
		hidePopover($(".popover-toggle.active").not($this));
		
		$this.addClass("active");
	});
	
	$document.on("hidden.bs.popover", ".popover-toggle", function () {
		var $this = $(this);
		
		$this.removeClass("active");
	});
	
	$("[data-value-link-to]").on("change", function () {
		var $this = $(this);
		
		$($this.attr("data-value-link-to")).val($this.val());
	});
	
	$localeMenuLinks.on("click", function (ev) {
		var $this = $(this);
		
		if ($this.closest("li").hasClass("active")) {
			ev.preventDefault();
			return;
		}
		
		var v = $v.val();
		if (0 < v.length) {
			this.href += "#v=" + encodeURIComponent(v);
		}
	});
	
	$typeMenuLinks.on("click", function (ev) {
		var $this = $(this);

		if ($this.hasClass("dropdown-toggle") || $this.closest("li").hasClass("active")) {
			ev.preventDefault();
			return;
		}
		
		var v = $v.val();
		if (0 < v.length) {
			this.href += "#v=" + encodeURIComponent(v);
		}
	});
	
	$typeMenuLabels.on("click", function () {
		var $this = $(this);
		
		var $dropdownMenuLink = $this.closest("li").find("ul.dropdown-menu li:first a");
		$dropdownMenuLink[0].click();
		
		return false;
	});

	$v.on("input paste", function () {
		dencode();
	});

	if ($oeGroup.data("enable")) {
		$oeGroup.show();
		
		$oeGroupBtns.on("click", function () {
			var $this = $(this);
			
			if ($this.hasClass("active")) {
				return;
			}
			
			$oeGroupBtns.removeClass("active");
			$this.addClass("active");
			
			dencode();
		});

		$oexMenuItems.on("click", function () {
			var $this = $(this);
			
			$oeGroupBtns.removeClass("active");
			$oexMenuItems.removeClass("active");
			$this.addClass("active");
			$oexBtn.addClass("active");

			$oexBtn.text($this.text());
			$oexBtn.data("oe", $this.data("oe"));
			$oexBtn.data("oe-iana", $this.data("oe-iana"));
			
			dencode();
		});
		
		var $oexMenuItem = $oexMenuItems.filter(".active");
		if ($oexMenuItem.length === 0) {
			$oexMenuItem = $oexMenuItems.eq(0);
		}
		$oexBtn.text($oexMenuItem.text());
		$oexBtn.data("oe", $oexMenuItem.data("oe"));
		$oexBtn.data("oe-iana", $oexMenuItem.data("oe-iana"));
	}

	if ($nlGroup.data("enable")) {
		$nlGroup.show();
		
		$nlGroupBtns.on("click", function () {
			var $this = $(this);

			if ($this.hasClass("active")) {
				return;
			}
			
			$nlGroupBtns.removeClass("active");
			$this.addClass("active");
			
			dencode();
		});
	}

	if ($tz.data("enable")) {
		$tz.show();
		
		$tz.chosen({
			no_results_text: $tz.data("msg-chosen-no-results"),
			search_contains: true
		});
		
		$tz.on("change", function () {
			dencode();
		});
	}
	
	$subHeaders.on("click", function () {
		var $this = $(this);
		var $toggleIcon = $this.children(".toggle-icon");
		var $toggleShow = $($this.data("toggle-show"));
		
		if ($toggleIcon.hasClass("glyphicon-collapse-down")) {
			$toggleShow.slideUp();
			$toggleIcon.removeClass("glyphicon-collapse-down").addClass("glyphicon-expand");
		} else {
			$toggleShow.slideDown();
			$toggleIcon.removeClass("glyphicon-expand").addClass("glyphicon-collapse-down");
		}
	});
	
	$listRows.on("click", function (ev) {
		hidePopover($(".popover-toggle.active"));
		
		if ($(ev.target).closest(".for-copy").length !== 0) {
			return;
		}
		
		var $row = $(this);
		
		if ($row.hasClass("invalid-value")) {
			return;
		}
		
		if ($row.hasClass("active")) {
			$row.trigger("deselectrow.dencode");
		} else {
			$listRows.filter(".active").each(function () {
				$(this).trigger("deselectrow.dencode");
			});
			
			$row.trigger("selectrow.dencode");
		}
	});
	
	$optionGroups.on("click", false);
	
	$options.on("change", function () {
		dencode();
	});
	
	$listRows.on("selectrow.dencode", function () {
		var $row = $(this);
		
		$row.addClass("active");
		
		var $forDisp = $row.find(".for-disp");
		var id = $forDisp.attr("id");
		var val = $forDisp.text();
		
		var forCopyHtml = getForCopyTmpl().render({
			id: id,
			value: val
		});
		
		var $forCopy = $(forCopyHtml);
		$forDisp.after($forCopy);
	});
	
	$listRows.on("deselectrow.dencode", function () {
		var $row = $(this);
		
		$row.removeClass("active");
		
		var $forCopy = $row.find(".for-copy");
		$forCopy.remove();
	});
	
	$follow.on("click", function () {
		toggleFollow();
	});
	if (document.cookie.indexOf("follow=yes") != -1) {
		toggleFollow();
	}
	
	$vLen.on("click", function () {
		var $this = $(this);
		
		if ($this.hasClass("active")) {
			$this.popover("hide");
		} else {
			$this.popover("show");
		}
	});
	
	$vLen.popover({
		trigger: "manual",
		placement: "left",
		html: false,
		sanitizeFn: function (content) {
			return content;
		},
		content: function () {
			var chars = Number($vLen.data("len-chars"));
			var bytes = Number($vLen.data("len-bytes"));
			return getLengthTmpl().render({
				chars: chars,
				oneChar: (chars == 1),
				bytes: bytes,
				oneByte: (bytes == 1)
			});
		}
	});
	
	$otherDencodeLinks.on("click", function (ev) {
		var $this = $(this);
		var method = $this.data("other-dencode-method");
		
		var $menuLinks = $methodMenuItems.filter("[data-dencode-method='" + method + "']").find("a");
		if (0 < $menuLinks.length) {
			$menuLinks[0].click();
		}
		
		ev.preventDefault();
	});
	
	dencode();
	
	$v.focus();
	
	
	// function definitions
	
	function dencode() {
		var type = $typeMenuItems.filter(".active").data("dencode-type");
		var method = $methodMenuItems.filter(".active").data("dencode-method");
		var v = $v.val();
		var oe = $oeGroupBtns.filter(".active").data("oe");
		var oex = $oexMenuItems.filter(".active").data("oe");
		var nl = $nlGroupBtns.filter(".active").data("nl");
		var tz = $tz.val();
		var options = $options.serializeArray();
		
		if (!type) {
			type = "all";
		}
		
		if (!method) {
			method = "all";
		}
		
		if (v === _v && oe === _oe && nl === _nl && tz === _tz) {
			if (_options !== null) {
				var matched = true;
				for (var i = 0; i < options.length; i++) {
					if (_options[i].value !== options[i].value) {
						matched = false;
						break;
					}
				}
				if (matched) {
					return;
				}
			}
		}
		
		var len = v.length - (v.match(/[\uD800-\uDBFF][\uDC00-\uDFFF]/g) || []).length;
		$vLen.text(separateThousand(len));
		
		setCookie("oe", oe);
		setCookie("oex", oex);
		setCookie("nl", nl);
		setCookie("tz", tz);
		
		
		if (_inProc) {
			return;
		}
		_inProc = true;
		_v = v;
		_oe = oe;
		_nl = nl;
		_tz = tz;
		_options = options;
		
		
		$decIndicator.show();
		$encIndicator.show();
		
		ajaxDencodeSettings.data = {
				t: type,
				m: method,
				v: v,
				oe: oe,
				nl: nl,
				tz: tz
			};
		options.forEach(function (option) {
			ajaxDencodeSettings.data[option.name] = option.value;
		});
		
		$.ajax(ajaxDencodeSettings);
	}

	function render(res) {
		$vLen.text(separateThousand(res.textLength));
		$vLen.data("len-chars", res.textLength);
		$vLen.data("len-bytes", res.textByteLength);
		
		var bgColor = res.encColorRGBHex6;
		var color;
		if (bgColor) {
			var r = parseInt(bgColor.substring(1, 3), 16);
			var g = parseInt(bgColor.substring(3, 5), 16);
			var b = parseInt(bgColor.substring(5, 7), 16);
			var a = (7 < bgColor.length) ? parseInt(bgColor.substring(7), 16) / 255.0 : 1.0;
			
			if (382 < (r + g + b) || a < 0.5) {
				color = "black";
			} else {
				color = "white";
			}
			
			// Temporary code: convert the color format #RRGGBBAA (CSS4) to rgba(R,G,B,A) (CSS3)
			bgColor = "rgba(" + r + "," + g + "," + b + "," + (Math.round(a * 100) / 100) + ")";
		} else {
			color = "black";
			bgColor = "transparent";
		}
		$v.css("color", color);
		$v.css("background-color", bgColor);
		
		for (var k in res) {
			setResponseValue(k, res[k]);
		}
	}
	
	function toggleFollow() {

		if ($follow.hasClass("active")) {
			$follow.removeClass("active");

			if ($exp.hasClass("follow")) {
				$exp.removeClass("follow");
			} else {
				$window.off("scroll.follow");
				$exp.offset({top: $top.offset().top});
			}

			setCookie("follow", "no");
		} else {
			$follow.addClass("active");

			if (CSS && CSS.supports && CSS.supports("position", "sticky")) {
				$exp.addClass("follow");
			} else {
				$window.on("scroll.follow", function () {
					var scrollTop = $window.scrollTop();
					var offsetTop = $top.offset().top;
					if (scrollTop < offsetTop) {
						scrollTop = offsetTop;
					}
					$exp.offset({top: scrollTop});
				});
			}
			
			setCookie("follow", "yes");
		}
	}
	
	function getPermanentLink(method, config) {
		var v = $v.val();
		
		var $methodMenuItem = $methodMenuItems.filter("[data-dencode-method='" + method + "']");
		var oeEnabled = (config[method + ".useOe"] === "true");
		var nlEnabled = (config[method + ".useNl"] === "true");
		var tzEnabled = (config[method + ".useTz"] === "true");
		
		var path = $methodMenuItem.find("a").attr("href");
		if (!path) {
			path = location.pathname;
		}
		
		var url = location.protocol + "//" + location.host + path;
		
		url += "?v=" + encodeURIComponent(v);
		
		if (oeEnabled) {
			var oe = $oeGroupBtns.filter(".active").data("oe");
			url += "&oe=" + encodeURIComponent(oe);
		}
		if (nlEnabled) {
			var nl = $nlGroupBtns.filter(".active").data("nl");
			url += "&nl=" + encodeURIComponent(nl);
		}
		if (tzEnabled) {
			var tz = $tz.val();
			url += "&tz=" + encodeURIComponent(tz);
		}
		
		return url;
	}
	
	function getLengthTmpl() {
		if (_lengthTmpl === null) {
			_lengthTmpl = Hogan.compile($("#lengthTmpl").html());
		}
		return _lengthTmpl;
	}
	
	function getPermanentLinkTmpl() {
		if (_permanentLinkTmpl === null) {
			_permanentLinkTmpl = Hogan.compile($("#permanentLinkTmpl").html());
		}
		return _permanentLinkTmpl;
	}
	
	function getForCopyTmpl() {
		if (_forCopyTmpl === null) {
			_forCopyTmpl = Hogan.compile($("#forCopyTmpl").html());
		}
		return _forCopyTmpl;
	}
	
	function loadConfig(callback) {
		if (_config) {
			callback(_config);
		} else {
			$.getJSON(contextPath + "/config", function (config) {
				_config = config;
				callback(_config);
			});
		}
	}
});


function setResponseValue(id, value) {
	var forDispElm = document.getElementById(id);
	if (forDispElm === null) {
		return;
	}
	
	var $forDisp = $(forDispElm);
	
	var $row = $forDisp.closest("tr");
	if (value === null) {
		$row.addClass("invalid-value");
		$forDisp.text("");
	} else {
		$row.removeClass("invalid-value");
		$forDisp.text(value);
	}
	
	var forCopyTextareaElm = document.getElementById(id + "ForCopy");
	if (forCopyTextareaElm) {
		$(forCopyTextareaElm).val(value);
	}
}

function selectAllTextValue(elm) {
	if (elm.select) {
		elm.select();
	}
	
	if (document.createRange && window.getSelection) {
		var range = document.createRange();
		range.selectNode(elm);
		var selection = window.getSelection();
		selection.removeAllRanges();
		selection.addRange(range);
	}
	
	if (elm.setSelectionRange) {
		elm.setSelectionRange(0, 2147483647);
	}
}

function clearSelection(elm) {
	if (window.getSelection) {
		var selection = window.getSelection();
		selection.removeAllRanges();
	}
	
	if (elm.setSelectionRange) {
		elm.setSelectionRange(0, 0);
	}
}

function hidePopover($popovers) {
	$popovers.popover("destroy");
}

function showTooltip($elm, message, time) {
	var title = $elm.attr("title");
	$elm.removeAttr("title");
	
	$elm.tooltip({
		trigger: "manual",
		container: "body",
		title: message
	});
	$elm.tooltip("show");
	
	setTimeout(function() {
		$elm.tooltip("destroy");
		$elm.attr("title", title);
	}, time);
}

function copyToClipboard($elm) {

	var copyElm = document.getElementById($elm.attr("data-copy-id"));
	var $copy = $(copyElm);
	var msg = $elm.attr("data-copy-message");
	var errMsg = $elm.attr("data-copy-error-message");
	
	$copy.removeClass("copying");
	$copy.removeClass("copied");
	
	$copy.addClass("copying");
	setTimeout(function () {
		$copy.addClass("copied");
	}, 1);
	
	if (navigator.clipboard) {
		navigator.clipboard.writeText(copyElm.value).then(function() {
			showTooltip($elm, msg, 2000);
		}).catch(function (err) {
			showTooltip($elm, errMsg, 2000);
		});
	} else {
		var readOnly = copyElm.readOnly;
		var contentEditable = copyElm.contentEditable;
		
		copyElm.readOnly = true;
		copyElm.contentEditable = true;
		
		copyElm.focus();
		selectAllTextValue(copyElm);
		
		try {
			document.execCommand("copy");
			
			showTooltip($elm, msg, 2000);
		} catch (ex) {
			showTooltip($elm, errMsg, 2000);
		} finally {
			copyElm.readOnly = readOnly;
			copyElm.contentEditable = contentEditable;
			
			clearSelection(copyElm);
			$copy.blur();
		}
	}
	
	setTimeout(function () {
		$copy.removeClass("copying");
		$copy.removeClass("copied");
	}, 1000);
}

function setCookie(name, value) {
	document.cookie = name + "=" + encodeURIComponent(value) + "; path=/";
}
