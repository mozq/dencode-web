"use strict";

var _lengthTmpl = Hogan.compile($("#lengthTmpl").html());
var _permanentLinkTmpl = Hogan.compile($("#permanentLinkTmpl").html());

$(document).ready(function () {
	var _inProc = false;
	var _v = null;
	var _oe = null;
	var _nl = null;
	var _tz = null;
	
	var $window = $(window);
	var $html = $("html");
	var $popovers = $('[data-toggle="popover"]');
	var $localeMenuLinks = $("#localeMenu .dropdown-menu a");
	var $typeMenuItems = $("#typeMenu ul.nav > li");
	var $typeMenuLinks = $("#typeMenu a");
	var $typeMenuLabels = $("#typeMenu .dropdown-menu-label");
	var $methodMenuItems = $("#typeMenu ul.nav > li ul.dropdown-menu > li");
	var $top = $("#top");
	var $exp = $("#exp");
	var $follow = $("#follow");
	var $link = $("#link");
	var $vLen = $("#vLen");
	var $v = $("#v");
	var $tz = $("#tz");
	var $oeGroup = $("#oeGroup");
	var $oeGroupBtns = $oeGroup.find(".btn:not(.dropdown-toggle)");
	var $oexBtn = $("#oex");
	var $oexMenuItems = $("#oexMenu li:not(.divider)");
	var $nlGroup = $("#nlGroup");
	var $nlGroupBtns = $nlGroup.find(".btn");
	var $decIndicator = $("#decodingIndicator");
	var $encIndicator = $("#encodingIndicator");
	var $listRows = $(".dencoded-list").find("tr");
	
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
	
	$window.on("resize", function () {
		hidePopover($popovers);
	});
	
	$window.on("click", function (ev) {
		var $target = $(ev.target);

		// hide popover when other area clicked
		if ($target.data("toggle") !== "popover"
			&& $target.parents('[data-toggle="popover"]').length === 0
			&& $target.parents(".popover.in").length === 0) {
			hidePopover($popovers);
		}
	});
	
	if (window.File) {
		$html.on("drop", function (ev) {
			ev.preventDefault();
			ev.stopPropagation();
			
			var oeIana = $oeGroupBtns.filter(".active").data("oe-iana");
			
			var file = ev.originalEvent.dataTransfer.files[0];
			var reader = new FileReader();
			reader.onload = function (ev) {
				$v.text(ev.target.result);
			};
			reader.readAsText(file, oeIana);
		});
		
		$html.on("dragenter dragover dragleave dragend", function (ev) {
			ev.preventDefault();
			ev.stopPropagation();
		});
	}
	
	$popovers.on("show.bs.popover", function () {
		var $this = $(this);
		
		hidePopover($popovers.not($this));
		$this.addClass("active");
	});
	
	$popovers.on("hide.bs.popover", function () {
		var $this = $(this);
		
		$this.removeClass("active");
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
	
	$typeMenuLabels.on("click", function (ev) {
		var $this = $(this);
		
		var $dropdownMenuLink = $this.closest("li").find("ul.dropdown-menu li:first a");
		$dropdownMenuLink[0].click();
		
		ev.preventDefault();
		ev.stopPropagation();
	});
	
	if (/*@cc_on @if(@_jscript_version <= 5.8) ! @end @*/false) {
		// for <=IE8
		$v.on("keyup", function () {
			dencode();
		});
	} else {
		$v.on("input paste", function () {
			dencode();
		});
	}

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
			$oexMenuItem = $oexMenuItems.get(0);
		}
		$oexBtn.text($oexMenuItem.text());
		$oexBtn.data("oe", $oexMenuItem.data("oe"));
		$oexBtn.data("oe-iana", $oexMenuItem.data("oe-iana"));
		$oexBtn.show();
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
	
	$("h2").on("click", function () {
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

	$listRows.on("click", function () {
		var $row = $(this);

		if ($row.hasClass("invalid-value")) {
			return;
		}
		if ($row.hasClass("selection")) {
			removeCopyTextareaElm($row.find(".for-copy"));
			$row.removeClass("selection");
			return;
		}

		$row.addClass("selection");
		
		var $disp = $row.find(".for-disp");
		var id = $disp.attr("id");
		var val = $disp.text();
		
		var $copy = $("<textarea>");
		$copy.addClass("for-copy");
		$copy.data("id", id);
		$copy.text(val);
		$copy.on("click", function (ev) {
			ev.stopPropagation();
		});
		$copy.on("focusout", removeCopyTextarea);
		$copy.on("focus", selectAllTextValue); // for iOS

		$disp.hide();
		$disp.after($copy);
		$copy.select();
	});
	
	$follow.on("click", function () {
		toggleFollow();
	});
	if (document.cookie.indexOf("follow=yes") != -1) {
		toggleFollow();
	}
	
	$link.on("shown.bs.popover", function () {
		var $linkURL = $("#linkURL");
		
		$linkURL.on("click", function (ev) {
			ev.stopPropagation();
		});
		$linkURL.on("focus", selectAllTextValue);
		$linkURL.focus();
		$linkURL.select();
	});
	
	$link.popover({
		trigger: "click",
		placement: "left",
		html: true,
		content: function () {
			return _permanentLinkTmpl.render({
				permanentLink: getPermanentLink()
			});
		}
	});
	
	$vLen.popover({
		trigger: "click",
		placement: "left",
		html: false,
		content: function () {
			var chars = Number($vLen.data("len-chars"));
			var bytes = Number($vLen.data("len-bytes"));
			return _lengthTmpl.render({
				chars: chars,
				oneChar: (chars == 1),
				bytes: bytes,
				oneByte: (bytes == 1)
			});
		}
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
		
		if (!method) {
			method = "";
		}
		
		if (v === _v && oe === _oe && nl === _nl && tz === _tz) {
			return;
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
		$.ajax(ajaxDencodeSettings);
	}

	function render(res) {
		$vLen.text(separateThousand(res.textLength));
		$vLen.data("len-chars", res.textLength);
		$vLen.data("len-bytes", res.textByteLength);
		
		var bgColor = res.encColorRGBHex6;
		var color;
		if (bgColor === null) {
			color = "black";
			bgColor = "transparent";
		} else {
			var r = parseInt(bgColor.substring(1, 3), 16);
			var g = parseInt(bgColor.substring(3, 5), 16);
			var b = parseInt(bgColor.substring(5, 7), 16);
			
			if (382 < r + g + b) {
				color = "black";
			} else {
				color = "white";
			}

			if (7 < bgColor.length) {
				bgColor = bgColor.substring(0, 7);
			}
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

			$window.off("scroll.follow");

			$exp.offset({top: $top.offset().top});

			setCookie("follow", "no");
		} else {
			$follow.addClass("active");

			$window.on("scroll.follow", function () {
				var scrollTop = $window.scrollTop();
				var offsetTop = $top.offset().top;
				if (scrollTop < offsetTop) {
					scrollTop = offsetTop;
				}
				$exp.offset({top: scrollTop});
			});
			
			setCookie("follow", "yes");
		}
	}
	
	function getPermanentLink() {
		var v = $v.val();
		
		var url = location.protocol + "//" + location.host + location.pathname;
		url += "?v=" + encodeURIComponent(v);
		
		if ($oeGroup.data("enable")) {
			var oe = $oeGroupBtns.filter(".active").data("oe");
			url += "&oe=" + encodeURIComponent(oe);
		}
		if ($nlGroup.data("enable")) {
			var nl = $nlGroupBtns.filter(".active").data("nl");
			url += "&nl=" + encodeURIComponent(nl);
		}
		if ($tz.data("enable")) {
			var tz = $tz.val();
			url += "&tz=" + encodeURIComponent(tz);
		}
		
		return url;
	}
});


function setResponseValue(id, value) {
	var dispElm = document.getElementById(id);
	if (dispElm === null) {
		return;
	}
	
	var $disp = $(dispElm);
	var $row = $disp.closest("tr");
	if (value === null) {
		$row.addClass("invalid-value");
		$disp.text("");
	} else {
		$row.removeClass("invalid-value");
		$disp.text(value);
	}
}

function removeCopyTextarea() {
	removeCopyTextareaElm(this);
}

function removeCopyTextareaElm(copyElm) {
	var $copy = $(copyElm);
	var $row = $copy.closest("tr");
	var id = $copy.data("id");
	var $disp = $(document.getElementById(id));
	$copy.remove();
	$disp.show();
	$row.removeClass("selection");
}

function selectAllTextValue() {
	if (this.setSelectionRange) {
		this.setSelectionRange(0, 2147483647);
	} else {
		$(this).select();
	}
}

function hidePopover($popover) {
	$popover.popover("hide");
	$popover.removeClass("active");
}

function setCookie(name, value) {
	document.cookie = name + "=" + encodeURIComponent(value) + "; path=/";
}
