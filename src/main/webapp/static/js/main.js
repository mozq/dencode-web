(function (window, document) {
"use strict";

$(document).ready(function () {
	let _inProc = false;
	let _v = null;
	let _oe = null;
	let _nl = null;
	let _tz = null;
	let _options = null;
	
	let _lengthTmpl = null;
	let _permanentLinkTmpl = null;
	let _forCopyTmpl = null;
	
	let _config = null;
	
	let _colors = null;
	
	const dencodeType = document.body.getAttribute("data-dencode-type");
	const dencodeMethod = document.body.getAttribute("data-dencode-method");
	
	const $window = $(window);
	const $document = $(document);
	const $localeMenuLinks = $("#localeMenu .dropdown-menu a");
	const $typeMenu = $("#typeMenu");
	const $typeMenuLinks = $typeMenu.find("a");
	const $typeMenuLabels = $typeMenu.find(".dropdown-menu-label");
	const $methodMenuItems = $typeMenu.find("li[data-dencode-method]");
	const $top = $("#top");
	const $exp = $("#exp");
	const $follow = $("#follow");
	const $vLen = $("#vLen");
	const $v = $("#v");
	const $tz = $("#tz");
	const $tzGroup = $("#tzGroup");
	const $tzMenuItems = $("#tzMenuItems [data-tz]");
	const $tzMenuFilter = $("#tzMenuFilter");
	const $loadBtn = $("#load");
	const $loadFile = $("#loadFile");
	const $loadFileInput = $("#loadFileInput");
	const $loadQrcode = $("#loadQrcode");
	const $loadQrcodeInput = $("#loadQrcodeInput");
	const $oeGroup = $("#oeGroup");
	const $oeGroupBtns = $oeGroup.find(".btn:not(.dropdown-toggle)");
	const $oexBtn = $("#oex");
	const $oexMenuItems = $("#oexMenu li:not(.divider)");
	const $nlGroup = $("#nlGroup");
	const $nlGroupBtns = $nlGroup.find(".btn");
	const $subHeaders = $("h2");
	const $decIndicator = $("#decodingIndicator");
	const $encIndicator = $("#encodingIndicator");
	const $listRows = $(".dencoded-list > tbody > tr");
	const $optionGroups = $(".dencode-option-group");
	const $options = $(".dencode-option");
	const $otherDencodeLinks = $(".other-dencode-link");
	
	
	// Load previous settings from local storage
	try {
		if (localStorage) {
			$options.each(function () {
				const value = localStorage.getItem("options." + this.name);
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
	const hash = location.hash;
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
			const file = ev.originalEvent.dataTransfer.files[0];
			loadValueFromFile(file);
			
			return false;
		});
		
		$document.on("dragenter dragover dragleave dragend", false);
	}
	
	$window.on("resize", function () {
		hidePopover($(".popover-toggle.active"));
	});
	
	$document.on("click", function (ev) {
		const $target = $(ev.target);

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
		const $this = $(this);
		
		copyToClipboard($this);
		$this.focus();
		
		return false;
	});
	
	$document.on("click", ".popover-toggle.permanent-link", function () {
		const $this = $(this);
		
		if ($this.hasClass("active")) {
			hidePopover($this);
		} else {
			const method = $this.closest("[data-dencode-method]").attr("data-dencode-method");
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
							const permanentLink = getPermanentLink(method, config);
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
		const $this = $(this);
		
		hidePopover($(".popover-toggle.active").not($this));
		
		$this.addClass("active");
	});
	
	$document.on("hidden.bs.popover", ".popover-toggle", function () {
		const $this = $(this);
		
		$this.removeClass("active");
	});
	
	$("[data-value-link-to]").on("input paste change", function () {
		const $this = $(this);
		
		const $target = $($this.attr("data-value-link-to"));
		$target.val($this.val());
		$target.trigger("init.dencode");
	});
	
	$localeMenuLinks.on("click", function (ev) {
		const $this = $(this);
		
		if ($this.closest("li").hasClass("active")) {
			ev.preventDefault();
			return;
		}
		
		const v = $v.val();
		if (0 < v.length) {
			this.href += "#v=" + encodeURIComponent(v);
		}
	});
	
	$typeMenuLinks.on("click", function (ev) {
		const $this = $(this);

		if ($this.hasClass("dropdown-toggle") || $this.closest("li").hasClass("active")) {
			ev.preventDefault();
			return;
		}
		
		const v = $v.val();
		if (0 < v.length) {
			this.href += "#v=" + encodeURIComponent(v);
		}
	});
	
	$typeMenuLabels.on("click", function () {
		const $this = $(this);
		
		const $dropdownMenuLink = $this.closest("li").find("ul.dropdown-menu li:first a");
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
		let $oexMenuItem = $oexMenuItems.filter(".active");
		if ($oexMenuItem.length === 0) {
			$oexMenuItem = $oexMenuItems.eq(0);
		}
		$oexBtn.text($oexMenuItem.text());
		$oexBtn.data("oe", $oexMenuItem.data("oe"));
		
		$oeGroup.show();
		
		$oeGroupBtns.on("click", function () {
			const $this = $(this);
			
			if ($this.hasClass("active")) {
				return;
			}
			
			$oeGroupBtns.removeClass("active");
			$this.addClass("active");
			
			dencode();
		});

		$oexMenuItems.on("click", function () {
			const $this = $(this);
			
			$oeGroupBtns.removeClass("active");
			$oexMenuItems.removeClass("active");
			$this.addClass("active");
			$oexBtn.addClass("active");

			$oexBtn.text($this.text());
			$oexBtn.data("oe", $this.data("oe"));
			
			dencode();
		});
	}

	if ($nlGroup.data("enable")) {
		$nlGroup.show();
		
		$nlGroupBtns.on("click", function () {
			const $this = $(this);

			if ($this.hasClass("active")) {
				return;
			}
			
			$nlGroupBtns.removeClass("active");
			$this.addClass("active");
			
			dencode();
		});
	}

	if ($tzGroup.data("enable")) {
		let $tzMenuItem = $tzMenuItems.filter(".active");
		if ($tzMenuItem.length === 0) {
			$tzMenuItem = $tzMenuItems.eq(0);
		}
		$tz.text($tzMenuItem.text());
		$tz.data("tz", $tzMenuItem.data("tz"));
		
		$tzGroup.show();
		
		$tzMenuFilter.on("input paste", function () {
			const svals = $(this).val().toLowerCase().split(/\s+/g);
			
			$tzMenuItems.each(function () {
				const $this = $(this);
				let val = $this.attr("data-tz-lc");
				if (!val) {
					val = $this.text().toLowerCase();
					$this.attr("data-tz-lc", val);
				}
				
				let matched = true;
				for (const sval of svals) {
					if (!val.includes(sval)) {
						matched = false;
						break;
					}
				}
				
				if (matched) {
					$this.show();
				} else {
					$this.hide();
				}
			});
		});
		
		$tzMenuItems.on("click", function () {
			const $this = $(this);
			
			$tzMenuItems.removeClass("active");
			$this.addClass("active");
			
			$tz.text($this.text());
			$tz.data("tz", $this.data("tz"));
			
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
		
		const file = this.files[0];
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
		
		const file = this.files[0];
		this.value = "";
		
		const reader = new FileReader();
		reader.onload = function () {
			const img = new Image();
			img.onload = function () {
				const code = readQrcodeFromImage(img, [600, 200, 1000, 400, 800, 1200, 1400, 1600]);
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
		const $this = $(this);
		const $toggleIcon = $this.children(".toggle-icon");
		
		if ($toggleIcon.hasClass("bi-caret-down-square")) {
			$toggleIcon.removeClass("bi-caret-down-square").addClass("bi-caret-right-square");
		} else {
			$toggleIcon.removeClass("bi-caret-right-square").addClass("bi-caret-down-square");
		}
	});
	
	$listRows.on("click", function (ev) {
		hidePopover($(".popover-toggle.active"));
		
		if ($(ev.target).closest(".for-copy").length !== 0) {
			return;
		}
		
		const $row = $(this);
		
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
		const $row = $(this);
		
		$row.addClass("active");
		
		const $forDisp = $row.find(".for-disp");
		const id = $forDisp.attr("id");
		const val = $forDisp.text();
		
		const forCopyHtml = getForCopyTmpl().render({
			id: id,
			value: val
		});
		
		const $forCopy = $(forCopyHtml);
		$forDisp.after($forCopy);
	});
	
	$listRows.on("deselectrow.dencode", function () {
		const $row = $(this);
		
		$row.removeClass("active");
		
		const $forCopy = $row.find(".for-copy");
		$forCopy.remove();
	});
	
	$follow.on("click", function () {
		toggleFollow();
	});
	if (document.cookie.indexOf("follow=yes") != -1) {
		toggleFollow();
	}
	
	$vLen.on("click", function () {
		const $this = $(this);
		
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
			const chars = Number($vLen.data("len-chars"));
			const bytes = Number($vLen.data("len-bytes"));
			return getLengthTmpl().render({
				chars: chars,
				oneChar: (chars == 1),
				bytes: bytes,
				oneByte: (bytes == 1)
			});
		}
	});
	
	$otherDencodeLinks.on("click", function (ev) {
		const $this = $(this);
		const method = $this.data("other-dencode-method");
		
		const $menuLinks = $methodMenuItems.filter("[data-dencode-method='" + method + "']").find("a");
		if (0 < $menuLinks.length) {
			$menuLinks[0].click();
		}
		
		ev.preventDefault();
	});
	
	
	(function () {
		// for cipher.enigma
		
		const $optMachines = $("select[name=encCipherEnigmaMachine],select[name=decCipherEnigmaMachine]");
		
		if ($optMachines.length === 0) {
			return;
		}
		
		const $optReflectors = $("select[name=encCipherEnigmaReflector],select[name=decCipherEnigmaReflector]");
		const $optPlugboards = $("input[name=encCipherEnigmaPlugboard],input[name=decCipherEnigmaPlugboard]");
		const $optUkwds = $("input[name=encCipherEnigmaUkwd],input[name=decCipherEnigmaUkwd]");
		
		$optMachines.on("change init.dencode", function () {
			const $this = $(this);
			const prefix = this.name.substr(0, 3) + "CipherEnigma";
			
			const $selectedOption = $this.find("option:selected");
			const reflectors = $selectedOption.attr("data-reflectors").split(",");
			const rotors = $selectedOption.attr("data-rotors").split(",");
			const has = $selectedOption.attr("data-has").split(",");
			
			const $optReflector = $("select[name=" + prefix + "Reflector]");
			const $optRotor3 = $("select[name=" + prefix + "Rotor3]");
			const $optRotor2 = $("select[name=" + prefix + "Rotor2]");
			const $optRotor1 = $("select[name=" + prefix + "Rotor1]");
			
			setupSelectOptions($optReflector, reflectors);
			setupSelectOptions($optRotor3, rotors);
			setupSelectOptions($optRotor2, rotors);
			setupSelectOptions($optRotor1, rotors);
			
			const $enigma = $this.closest(".cipher-enigma");
			addOrRemoveClass($enigma, "cipher-enigma-has-4wheels", (has.indexOf("4wheels") !== -1));
			addOrRemoveClass($enigma, "cipher-enigma-has-plugboard", (has.indexOf("plugboard") !== -1));
			addOrRemoveClass($enigma, "cipher-enigma-has-uhr", (has.indexOf("uhr") !== -1));
			addOrRemoveClass($enigma, "cipher-enigma-has-settable-reflector", (has.indexOf("settable-reflector") !== -1));
			addOrRemoveClass($enigma, "cipher-enigma-has-ukwd", (has.indexOf("ukwd") !== -1));
			
			$optReflector.trigger("init.dencode");
		});
		
		$optReflectors.on("change init.dencode", function () {
			const $this = $(this);
			const prefix = this.name.substr(0, 3) + "CipherEnigma";
			
			const $optUkwd = $("input[name=" + prefix + "Ukwd]");
			const $optRotor4 = $("select[name=" + prefix + "Rotor4]");
			const $optRotor4Ring = $("select[name=" + prefix + "Rotor4Ring]");
			const $optRotor4Position = $("select[name=" + prefix + "Rotor4Position]");
			const ukwd = ($this.val() === "UKW-D");
			
			$optUkwd.prop("disabled", !ukwd);
			$optRotor4.prop("disabled", ukwd);
			$optRotor4Ring.prop("disabled", ukwd);
			$optRotor4Position.prop("disabled", ukwd);
		});
		
		$optPlugboards.on("input paste change init.dencode", function () {
			const $this = $(this);
			const prefix = this.name.substr(0, 3) + "CipherEnigma";
			
			const val = this.value.toUpperCase().replace(/[^A-Z\s]/g, "");
			
			const sidx = this.selectionStart;
			this.value = val;
			this.selectionStart = this.selectionEnd = sidx;
			
			const pairs = val.trim().split(/\s+/);
			const err = !validateWiring(pairs, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
			
			addOrRemoveClass($this, "dencode-option-error", err);
			$("select[name=" + prefix + "Uhr]").prop("disabled", err || (pairs.length !== 10));
		});
		
		$optUkwds.on("input paste change init.dencode", function () {
			const $this = $(this);
			
			const val = this.value.toUpperCase().replace(/[^A-Z\s]/g, "");
			
			const sidx = this.selectionStart;
			this.value = val;
			this.selectionStart = this.selectionEnd = sidx;
			
			const pairs = val.trim().split(/\s+/);
			const err = !validateWiring(pairs, "AZXWVUTSRQPONMLKIHGFEDCB");
			
			addOrRemoveClass($this, "dencode-option-error", err);
		});
		
		$optMachines.trigger("init.dencode");
		$optPlugboards.trigger("init.dencode");
		$optUkwds.trigger("init.dencode");
		
		function setupSelectOptions($select, optionValues) {
			const currentIdx = $select.prop("selectedIndex");
			
			const $options = $select.find("option");
			let newIdx = -1;
			$options.each(function(index) {
				const $option = $(this);
				
				const enable = (optionValues.indexOf($option.val()) !== -1);
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
			
			for (const pair of pairs) {
				if (pair.length !== 2) {
					// Illegal format
					return false;
				}
			}
			
			const chars = pairs.join("");
			
			for (let i = 0; i < chars.length; i++) {
				const ch = chars.charAt(i);
				
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
		const type = dencodeType;
		const method = dencodeMethod;
		const v = $v.val();
		const oe = $oeGroupBtns.filter(".active").data("oe");
		const oex = $oexMenuItems.filter(".active").data("oe");
		const nl = $nlGroupBtns.filter(".active").data("nl");
		const tz = $tz.data("tz");
		let options = {};
		$options.each(function () {
			options[this.name] = this.value;
		});
		
		if (v === _v && oe === _oe && nl === _nl && tz === _tz) {
			if (_options !== null) {
				let matched = true;
				for (const key in options) {
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
		
		const len = v.length - (v.match(/[\uD800-\uDBFF][\uDC00-\uDFFF]/g) || []).length;
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
		
		const requestData = {
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
				const messageObject = getMessageDefinition(null);
				const error = new Error(messageObject.message);
				error.messageObject = messageObject;
				throw error;
			}
			
			if (!response.ok) {
				const error = new Error(response.statusText);
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
		
		for (const k in res) {
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
					let scrollTop = $window.scrollTop();
					const offsetTop = $top.offset().top;
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
		const v = $v.val();
		
		const $methodMenuItem = $methodMenuItems.filter("[data-dencode-method='" + method + "']");
		const oeEnabled = (config[method + ".useOe"] === "true");
		const nlEnabled = (config[method + ".useNl"] === "true");
		const tzEnabled = (config[method + ".useTz"] === "true");
		
		let path = $methodMenuItem.find("a").attr("href");
		if (!path) {
			path = location.pathname;
		}
		
		let url = location.protocol + "//" + location.host + path;
		
		url += "?v=" + encodeURIComponent(v);
		
		if (oeEnabled) {
			const oe = $oeGroupBtns.filter(".active").data("oe");
			url += "&oe=" + encodeURIComponent(oe);
		}
		if (nlEnabled) {
			const nl = $nlGroupBtns.filter(".active").data("nl");
			url += "&nl=" + encodeURIComponent(nl);
		}
		if (tzEnabled) {
			const tz = $tz.data("tz");
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
		const encoding = $oeGroupBtns.filter(".active").data("oe");
		
		const reader = new FileReader();
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
	const forDispElm = document.getElementById(id);
	if (forDispElm === null) {
		return;
	}
	
	const $forDisp = $(forDispElm);
	
	const $row = $forDisp.closest("tr");
	if (value === null) {
		$row.addClass("invalid-value");
		$forDisp.text("");
	} else {
		$row.removeClass("invalid-value");
		$forDisp.text(value);
	}
	
	const forCopyTextareaElm = document.getElementById(id + "ForCopy");
	if (forCopyTextareaElm) {
		$(forCopyTextareaElm).val(value);
	}
}

function setBgColor($elm, colors) {
	let bgColor = null;
	if (colors) {
		bgColor = getNonBlankValue(colors, getCurrentLineIndex($elm[0]));
	}
	
	let color;
	if (bgColor) {
		const r = parseInt(bgColor.substring(1, 3), 16);
		const g = parseInt(bgColor.substring(3, 5), 16);
		const b = parseInt(bgColor.substring(5, 7), 16);
		const a = (7 < bgColor.length) ? parseInt(bgColor.substring(7), 16) / 255.0 : 1.0;
		
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
		const range = document.createRange();
		range.selectNode(elm);
		const selection = window.getSelection();
		selection.removeAllRanges();
		selection.addRange(range);
	}
	
	if (elm.setSelectionRange) {
		elm.setSelectionRange(0, 2147483647);
	}
}

function clearSelection(elm) {
	if (window.getSelection) {
		const selection = window.getSelection();
		selection.removeAllRanges();
	}
	
	if (elm.setSelectionRange) {
		elm.setSelectionRange(0, 0);
	}
}

function getCurrentLineIndex(elm) {
	const cursorPos = elm.selectionStart;
	const val = elm.value;
	
	const n = (val.substring(0, cursorPos).match(/\n/g) || []).length;
	
	return n;
}

function hidePopover($popovers) {
	$popovers.each(function(i, elm) {
		const popover = bootstrap.Popover.getInstance(elm);
		if (popover) {
			popover.hide();
		}
	});
}

function showTooltip($elm, message, time) {
	const tooltip = new bootstrap.Tooltip($elm[0], {
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

	const copyElm = document.getElementById($elm.attr("data-copy-id"));
	const $copy = $(copyElm);
	const msg = $elm.attr("data-copy-message");
	const errMsg = $elm.attr("data-copy-error-message");
	
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
		const readOnly = copyElm.readOnly;
		const contentEditable = copyElm.contentEditable;
		
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
	
	let value;
	
	for (let i = Math.min(index, values.length - 1); 0 <= i; i--) {
		value = values[i];
		if (value !== "") {
			return value;
		}
	}
	
	for (let i = index + 1; i < values.length; i++) {
		value = values[i];
		if (value !== "") {
			return value;
		}
	}
	
	return null;
}

function readQrcodeFromImage(imgElm, maxSizes) {
	const minImgSize = Math.min(imgElm.width, imgElm.height);
	
	const canvas = document.createElement("canvas");
	
	let code = null;
	let parsedOrgSize = false;
	for (const maxSize of maxSizes) {
		const r = Math.min(1.0, 1.0 * maxSize / minImgSize);
		
		if (1.0 <= r) {
			if (parsedOrgSize) {
				break;
			}
			parsedOrgSize = true;
		}
		
		canvas.width = imgElm.width * r;
		canvas.height = imgElm.height * r;
		
		const ctx = canvas.getContext("2d");
		ctx.scale(r, r);
		ctx.drawImage(imgElm, 0, 0);
		const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
		
		code = jsQR(imageData.data, imageData.width, imageData.height);
		if (code !== null) {
			break;
		}
	}
	
	return code;
}

})(window, document);
