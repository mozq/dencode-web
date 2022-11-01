"use strict";

(function (window, document) {

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
	
	var _colors = null;
	
	var dencodeType = document.body.getAttribute("data-dencode-type");
	var dencodeMethod = document.body.getAttribute("data-dencode-method");
	
	var $window = $(window);
	var $document = $(document);
	var $localeMenuLinks = $("#localeMenu .dropdown-menu a");
	var $typeMenu = $("#typeMenu");
	var $typeMenuLinks = $typeMenu.find("a");
	var $typeMenuLabels = $typeMenu.find(".dropdown-menu-label");
	var $methodMenuItems = $typeMenu.find("li[data-dencode-method]");
	var $top = $("#top");
	var $exp = $("#exp");
	var $follow = $("#follow");
	var $vLen = $("#vLen");
	var $v = $("#v");
	var $tz = $("#tz");
	var $loadBtn = $("#load");
	var $loadFile = $("#loadFile");
	var $loadFileInput = $("#loadFileInput");
	var $loadQrcode = $("#loadQrcode");
	var $loadQrcodeInput = $("#loadQrcodeInput");
	var $oeGroup = $("#oeGroup");
	var $oeGroupBtns = $oeGroup.find(".btn:not(.dropdown-toggle)");
	var $oexBtn = $("#oex");
	var $oexMenuItems = $("#oexMenu li:not(.divider)");
	var $nlGroup = $("#nlGroup");
	var $nlGroupBtns = $nlGroup.find(".btn");
	var $subHeaders = $("h2");
	var $decIndicator = $("#decodingIndicator");
	var $encIndicator = $("#encodingIndicator");
	var $listRows = $(".dencoded-list > tbody > tr");
	var $optionGroups = $(".dencode-option-group");
	var $options = $(".dencode-option");
	var $otherDencodeLinks = $(".other-dencode-link");
	
	
	// Load previous settings from local storage
	try {
		if (localStorage) {
			$options.each(function () {
				var value = localStorage.getItem("options." + this.name);
				if (value !== null) {
					this.value = value;
				} else if ("defaultValue" in this.dataset) {
					this.value = this.dataset.defaultValue;
				}
			});
		}
	} catch (ex) {
		// NOP
	}
	
	// Load settings from location hash
	var hash = location.hash;
	if (hash !== null && hash.lastIndexOf("#v=", 0) === 0) {
		$v.val(decodeURIComponent(hash.substring(3)));
		if (history.replaceState) {
			history.replaceState(null, null, location.pathname + location.search);
		} else {
			location.hash = "";
		}
	}
	
	if (window.File) {
		$document.on("drop", function (ev) {
			var file = ev.originalEvent.dataTransfer.files[0];
			loadValueFromFile(file);
			
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
	
	$("[data-value-link-to]").on("input paste change", function () {
		var $this = $(this);
		
		var $target = $($this.attr("data-value-link-to"));
		$target.val($this.val());
		$target.trigger("init.dencode");
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

	$v.on("keyup click", function () {
		setBgColor($v, _colors);
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
			
			dencode();
		});
		
		var $oexMenuItem = $oexMenuItems.filter(".active");
		if ($oexMenuItem.length === 0) {
			$oexMenuItem = $oexMenuItems.eq(0);
		}
		$oexBtn.text($oexMenuItem.text());
		$oexBtn.data("oe", $oexMenuItem.data("oe"));
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
	
	$loadFile.on("click", function () {
		if (!window.File) {
			showMessageDialog($loadFile.attr("data-load-unsupported-message"));
			return false;
		}
		
		$loadFileInput.click();
	});
	
	$loadFileInput.on("change",  function () {
		if (this.files.length === 0) {
			showMessageDialog($loadFile.attr("data-load-error-message"));
			return;
		}
		
		var file = this.files[0];
		this.value = "";
		
		loadValueFromFile(file);
		showTooltip($loadBtn, $loadFile.attr("data-load-message"), 2000);
	});
	
	$loadQrcode.on("click", function () {
		if (!window.File) {
			showMessageDialog($loadQrcode.attr("data-load-unsupported-message"));
			return false;
		}
		
		$loadQrcodeInput.click();
	});
	
	$loadQrcodeInput.on("change",  function () {
		if (this.files.length === 0) {
			showMessageDialog($loadQrcode.attr("data-load-error-message"));
			return;
		}
		
		var file = this.files[0];
		this.value = "";
		
		var reader = new FileReader();
		reader.onload = function () {
			var img = new Image();
			img.onload = function () {
				var code = readQrcodeFromImage(img, [600, 200, 1000, 400, 800, 1200, 1400, 1600]);
				if (code === null) {
					showMessageDialog($loadQrcode.attr("data-load-error-message"));
					return;
				}
				
				updateValue(code.data);
				showTooltip($loadBtn, $loadQrcode.attr("data-load-message"), 2000);
			};
			img.src = this.result;
		}
		reader.readAsDataURL(file);
	});
	
	$subHeaders.on("click", function () {
		var $this = $(this);
		var $toggleIcon = $this.children(".toggle-icon");
		var $toggleShow = $($this.data("toggle-show"));
		
		if ($toggleIcon.hasClass("bi-caret-down-square")) {
			$toggleShow.slideUp();
			$toggleIcon.removeClass("bi-caret-down-square").addClass("bi-caret-right-square");
		} else {
			$toggleShow.slideDown();
			$toggleIcon.removeClass("bi-caret-right-square").addClass("bi-caret-down-square");
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
	
	$options.on("input paste change", function () {
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
	
	
	(function () {
		// for cipher.enigma
		
		var $optMachines = $("select[name=encCipherEnigmaMachine],select[name=decCipherEnigmaMachine]");
		
		if ($optMachines.length === 0) {
			return;
		}
		
		var $optReflectors = $("select[name=encCipherEnigmaReflector],select[name=decCipherEnigmaReflector]");
		var $optPlugboards = $("input[name=encCipherEnigmaPlugboard],input[name=decCipherEnigmaPlugboard]");
		var $optUkwds = $("input[name=encCipherEnigmaUkwd],input[name=decCipherEnigmaUkwd]");
		
		$optMachines.on("change init.dencode", function () {
			var $this = $(this);
			var prefix = this.name.substr(0, 3) + "CipherEnigma";
			
			var $selectedOption = $this.find("option:selected");
			var reflectors = $selectedOption.attr("data-reflectors").split(",");
			var rotors = $selectedOption.attr("data-rotors").split(",");
			var has = $selectedOption.attr("data-has").split(",");
			
			var $optReflector = $("select[name=" + prefix + "Reflector]");
			var $optRotor3 = $("select[name=" + prefix + "Rotor3]");
			var $optRotor2 = $("select[name=" + prefix + "Rotor2]");
			var $optRotor1 = $("select[name=" + prefix + "Rotor1]");
			
			setupSelectOptions($optReflector, reflectors);
			setupSelectOptions($optRotor3, rotors);
			setupSelectOptions($optRotor2, rotors);
			setupSelectOptions($optRotor1, rotors);
			
			var $enigma = $this.closest(".cipher-enigma");
			addOrRemoveClass($enigma, "cipher-enigma-has-4wheels", (has.indexOf("4wheels") !== -1));
			addOrRemoveClass($enigma, "cipher-enigma-has-plugboard", (has.indexOf("plugboard") !== -1));
			addOrRemoveClass($enigma, "cipher-enigma-has-uhr", (has.indexOf("uhr") !== -1));
			addOrRemoveClass($enigma, "cipher-enigma-has-settable-reflector", (has.indexOf("settable-reflector") !== -1));
			addOrRemoveClass($enigma, "cipher-enigma-has-ukwd", (has.indexOf("ukwd") !== -1));
			
			$optReflector.trigger("init.dencode");
		});
		
		$optReflectors.on("change init.dencode", function () {
			var $this = $(this);
			var prefix = this.name.substr(0, 3) + "CipherEnigma";
			
			var $optUkwd = $("input[name=" + prefix + "Ukwd]");
			var $optRotor4 = $("select[name=" + prefix + "Rotor4]");
			var $optRotor4Ring = $("select[name=" + prefix + "Rotor4Ring]");
			var $optRotor4Position = $("select[name=" + prefix + "Rotor4Position]");
			var ukwd = ($this.val() === "UKW-D");
			
			$optUkwd.prop("disabled", !ukwd);
			$optRotor4.prop("disabled", ukwd);
			$optRotor4Ring.prop("disabled", ukwd);
			$optRotor4Position.prop("disabled", ukwd);
		});
		
		$optPlugboards.on("input paste change init.dencode", function () {
			var $this = $(this);
			var prefix = this.name.substr(0, 3) + "CipherEnigma";
			
			var val = this.value.toUpperCase().replace(/[^A-Z\s]/g, "");
			
			var sidx = this.selectionStart;
			this.value = val;
			this.selectionStart = this.selectionEnd = sidx;
			
			var pairs = val.trim().split(/\s+/);
			var err = !validateWiring(pairs, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
			
			addOrRemoveClass($this, "dencode-option-error", err);
			$("select[name=" + prefix + "Uhr]").prop("disabled", err || (pairs.length !== 10));
		});
		
		$optUkwds.on("input paste change init.dencode", function () {
			var $this = $(this);
			
			var val = this.value.toUpperCase().replace(/[^A-Z\s]/g, "");
			
			var sidx = this.selectionStart;
			this.value = val;
			this.selectionStart = this.selectionEnd = sidx;
			
			var pairs = val.trim().split(/\s+/);
			var err = !validateWiring(pairs, "AZXWVUTSRQPONMLKIHGFEDCB");
			
			addOrRemoveClass($this, "dencode-option-error", err);
		});
		
		$optMachines.trigger("init.dencode");
		$optPlugboards.trigger("init.dencode");
		$optUkwds.trigger("init.dencode");
		
		function setupSelectOptions($select, optionValues) {
			var currentIdx = $select.prop("selectedIndex");
			
			var $options = $select.find("option");
			var newIdx = -1;
			$options.each(function(index) {
				var $option = $(this);
				
				var enable = (optionValues.indexOf($option.val()) !== -1);
				$option.prop("disabled", !enable);
				$option.prop("hidden", !enable);
				if (enable && (index <= currentIdx || newIdx === -1)) {
					newIdx = index;
				}
			});
			
			$select.prop("selectedIndex", newIdx);
		}
		
		function addOrRemoveClass($elm, className, add) {
			if (add) {
				$elm.addClass(className);
			} else {
				$elm.removeClass(className);
			}
		}
		
		function validateWiring(pairs, letters) {
			if (pairs.length === 0 || pairs[0].length === 0) {
				return true;
			}
			
			for (var i = 0; i < pairs.length; i++) {
				if (pairs[i].length !== 2) {
					// Illegal format
					return false;
				}
			}
			
			var chars = pairs.join("");
			
			for (var i = 0; i < chars.length; i++) {
				var ch = chars.charAt(i);
				
				if (letters.indexOf(ch) === -1) {
					// Unsupported
					return false;
				}
				
				if (chars.indexOf(ch, i + 1) !== -1) {
					// Duplicates
					return false;
				}
			}
			
			return true;
		}
	})();
	
	
	dencode();
	
	
	// function definitions
	
	function dencode() {
		var type = dencodeType;
		var method = dencodeMethod;
		var v = $v.val();
		var oe = $oeGroupBtns.filter(".active").data("oe");
		var oex = $oexMenuItems.filter(".active").data("oe");
		var nl = $nlGroupBtns.filter(".active").data("nl");
		var tz = $tz.val();
		var options = {};
		$options.each(function () {
			options[this.name] = this.value;
		});
		
		if (!type || !method) {
			type = "all";
		}
		
		if (!method) {
			method = "all.all";
		}
		
		if (v === _v && oe === _oe && nl === _nl && tz === _tz) {
			if (_options !== null) {
				var matched = true;
				for (var key in options) {
					if (_options[key] !== options[key]) {
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
		
		// Store settings to Cookie
		setCookie("oe", oe);
		setCookie("oex", oex);
		setCookie("nl", nl);
		setCookie("tz", tz);
		
		// Store option settings to local storage
		try {
			if (localStorage) {
				$options.each(function () {
					localStorage.setItem("options." + this.name, this.value);
				});
			}
		} catch (ex) {
			// NOP
		}
		
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
		
		var requestData = {
				type: type,
				method: method,
				value: v,
				oe: oe,
				nl: nl,
				tz: tz,
				options: options
			};
		
		fetch(contextPath + "/dencode", {
			method: "POST",
			cache: "no-cache",
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify(requestData)
		}).then(function (response) {
			if (response.headers.get("Content-Type").indexOf("application/json") === -1) {
				var messageObject = getMessageDefinition(null);
				var error = new Error(messageObject.message);
				error.messageObject = messageObject;
				throw error;
			}
			
			if (!response.ok) {
				var error = new Error(response.statusText);
				error.statusCode = response.status;
				throw error;
			}
			
			return response.json();
		}).then(function (responseJson) {
			clearMessages();
			handleAjaxResponse(responseJson);
			render(responseJson.response);
			
			$document.trigger("dencoded.dencode", [requestData, responseJson]);
		}).catch(function (error) {
			if (error.messageObject) {
				// Handled error
				setMessage(error.messageObject);
			} else if (error.statusCode) {
				// HTTP 4xx or 5xx error
				setMessage(getMessageDefinition(null));
			} else {
				// Network error
				setMessage(getMessageDefinition("network.error"));
			}
			focusMessages();
			
			$document.trigger("dencoded.dencode", [requestData, null]);
		}).finally(function () {
			_inProc = false;
			
			$decIndicator.hide();
			$encIndicator.hide();
			
			dencode();
		});
	}
	
	function render(res) {
		$vLen.text(separateThousand(res.textLength));
		$vLen.data("len-chars", res.textLength);
		$vLen.data("len-bytes", res.textByteLength);
		
		_colors = (res.encColorRGBHex) ? res.encColorRGBHex.split("\n") : null;
		if (_colors) {
			setBgColor($v, _colors);
		}
		
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
			fetch(contextPath + "/config")
			.then(function (response) {
				return response.json();
			}).then(function (config) {
				_config = config;
				callback(_config);
			});
		}
	}
	
	function loadValueFromFile(file) {
		var encoding = $oeGroupBtns.filter(".active").data("oe");
		
		var reader = new FileReader();
		reader.onload = function (ev) {
			updateValue(this.result);
		};
		reader.readAsText(file, encoding);
	}
	
	function updateValue(val) {
		$v.text(val);
		$v.trigger("input");
		
		$v.removeClass("updating");
		$v.removeClass("updated");
		$v.addClass("updating");
		setTimeout(function () {
			$v.addClass("updated");
			
			setTimeout(function () {
				$v.removeClass("updating");
				$v.removeClass("updated");
			}, 2000);
		}, 1);
	}
	
	function showMessageDialog(message) {
		$("#messageDialogBody").text(message);
		$("#messageDialog").modal("show");
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

function setBgColor($elm, colors) {
	var bgColor = null;
	if (colors) {
		bgColor = getNonBlankValue(colors, getCurrentLineIndex($elm[0]));
	}
	
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
	
	$elm.css("color", color);
	$elm.css("background-color", bgColor);
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

function getCurrentLineIndex(elm) {
	var cursorPos = elm.selectionStart;
	var val = elm.value;
	
	var n = (val.substring(0, cursorPos).match(/\n/g) || []).length;
	
	return n;
}

function hidePopover($popovers) {
	$popovers.each(function(i, elm) {
		var popover = bootstrap.Popover.getInstance(elm);
		if (popover) {
			popover.hide();
		}
	});
}

function showTooltip($elm, message, time) {
	var tooltip = new bootstrap.Tooltip($elm[0], {
		trigger: "manual",
		container: "body",
		title: message
	});
	
	tooltip.show();
	
	setTimeout(function() {
		tooltip.dispose();
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
		
		setTimeout(function () {
			$copy.removeClass("copying");
			$copy.removeClass("copied");
		}, 2000);
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
}

function setCookie(name, value) {
	document.cookie = name + "=" + encodeURIComponent(value) + "; path=/";
}

function getNonBlankValue(values, index) {
	if (!values) {
		return null;
	}
	
	var value;
	
	for (var i = Math.min(index, values.length - 1); 0 <= i; i--) {
		value = values[i];
		if (value !== "") {
			return value;
		}
	}
	
	for (var i = index + 1; i < values.length; i++) {
		value = values[i];
		if (value !== "") {
			return value;
		}
	}
	
	return null;
}

function readQrcodeFromImage(imgElm, maxSizes) {
	var minImgSize = Math.min(imgElm.width, imgElm.height);
	
	var canvas = document.createElement("canvas");
	
	var code = null;
	var parsedOrgSize = false;
	for (var i = 0; i < maxSizes.length; i++) {
		var r = Math.min(1.0, 1.0 * maxSizes[i] / minImgSize);
		
		if (1.0 <= r) {
			if (parsedOrgSize) {
				break;
			}
			parsedOrgSize = true;
		}
		
		canvas.width = imgElm.width * r;
		canvas.height = imgElm.height * r;
		
		var ctx = canvas.getContext("2d");
		ctx.scale(r, r);
		ctx.drawImage(imgElm, 0, 0);
		var imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
		
		code = jsQR(imageData.data, imageData.width, imageData.height);
		if (code !== null) {
			break;
		}
	}
	
	return code;
}

})(window, document);
