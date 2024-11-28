((window, document) => {
"use strict";

const $ = new Commons(window, document);

$.onReady(function () {
	let _inProc = false;
	let _v = null;
	let _oe = null;
	let _nl = null;
	let _tz = null;
	let _options = null;
	
	let _messageTmpl = null;
	let _lengthTmpl = null;
	let _permanentLinkTmpl = null;
	let _forCopyTmpl = null;
	
	let _colors = null;
	
	const contextPath = document.body.getAttribute("data-context-path");
	const dencodeType = document.body.getAttribute("data-dencode-type");
	const dencodeMethod = document.body.getAttribute("data-dencode-method");
	
	const dencoderDefs = JSON.parse($.id("dencoderDefs").textContent);
	
	const elLocaleMenuLinks = $.all("#localeMenu .dropdown-menu a");
	const elTypeMenuLabels = $.all("#typeMenu .dropdown-menu-label");
	const elTypeMenuMethodLinks = $.all("#typeMenu a[data-dencode-method]");
	const elExp = $.id("exp");
	const elFollow = $.id("follow");
	const elVLen = $.id("vLen");
	const elV = $.id("v");
	const elLoadBtn = $.id("load");
	const elLoadFile = $.id("loadFile");
	const elLoadFileInput = $.id("loadFileInput");
	const elLoadImage = $.id("loadImage");
	const elLoadImageInput = $.id("loadImageInput");
	const elLoadQrcode = $.id("loadQrcode");
	const elLoadQrcodeInput = $.id("loadQrcodeInput");
	const elOeGroup = $.id("oeGroup");
	const elOeGroupBtns = $.all("#oeGroup .btn:not(.dropdown-toggle)");
	const elOexBtn = $.id("oex");
	const elOexMenu = $.id("oexMenu");
	const elOexMenuItems = $.all("#oexMenu .dropdown-item");
	const elNlGroup = $.id("nlGroup");
	const elNlGroupBtns = $.all("#nlGroup .btn");
	const elTz = $.id("tz");
	const elTzGroup = $.id("tzGroup");
	const elTzMenuItems = $.all("#tzMenuItems [data-tz]");
	const elTzMenuFilter = $.id("tzMenuFilter");
	const elSubHeaders = $.all("h2");
	const elDecIndicator = $.id("decodingIndicator");
	const elEncIndicator = $.id("encodingIndicator");
	const elListRows = $.all(".dencoded-list > tbody > tr");
	const elOptionGroups = $.all(".dencode-option-group");
	const elOptions = $.all(".dencode-option:not([name^=_])");
	const elSyncOptions = $.all(".dencode-option[data-sync-with]");
	const elOtherDencodeLinks = $.all(".other-dencode-link");
	const elPolicyDialog = $.id("policyDialog");
	
	
	// Initialize default time-zone
	try {
		const tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
		if (tz) {
			elTzGroup.setAttribute("data-default-value", tz);
		}
	} catch (ex) {
		// NOP
	}
	
	// Initialize options
	try {
		const params = new URLSearchParams(window.location.search);
		
		elOexBtn.setAttribute("data-oe", selectItem(elOexMenuItems, elOexMenu, "oe", "oex"));
		selectItem(elOeGroupBtns, elOeGroup, "oe", "oe");
		selectItem(elNlGroupBtns, elNlGroup, "nl", "nl");
		elTz.setAttribute("data-tz", selectItem(elTzMenuItems, elTzGroup, "tz", "tz"));
		
		elOptions.forEach((el) => {
			const name = el.name;
			const value = selectOption(el, name);
			
			elSyncOptions.forEach((elSyncOpt) => {
				if (elSyncOpt.getAttribute("data-sync-with") === name) {
					elSyncOpt.value = value;
				}
			});
		});
		
		
		// Functions
		function selectItem(elItems, elItemGroup, name, storageName) {
			const getters = [
				() => params.get(name),
				() => getLocalStorage(storageName),
				() => elItemGroup.getAttribute("data-default-value")
				];
			
			for (const getter of getters) {
				const v = getter();
				if (v !== null && v !== undefined) {
					const attrName = `data-${name}`;
					const elItem = elItems.find((el) => el.getAttribute(attrName) === v);
					if (elItem) {
						elItem.classList.add("active");
						return v;
					}
				}
			}
			
			return null;
		}
		
		function selectOption(option, name) {
			const getters = [
				() => params.get(name),
				() => (name.startsWith(dencodeMethod)) ? params.get(name.substring(dencodeMethod.length + 1)) : null,
				() => getLocalStorage("options." + name),
				() => option.dataset.defaultValue
				];
			
			for (const getter of getters) {
				const v = getter();
				if (v !== null && v !== undefined) {
					option.value = v;
					
					if (option.selectedIndex === -1) {
						continue;
					}
					
					return v;
				}
			}
			
			if (option.selectedIndex === -1) {
				option.selectedIndex = 0;
				return option.value;
			}
			
			return option.value;
		}
		
		function getLocalStorage(key) {
			try {
				return window.localStorage.getItem(key);
			} catch (ex) {
				// NOP
			}
			return null;
		}
	} catch (ex) {
		// NOP
	}
	
	const hash = window.location.hash;
	if (hash !== null) {
		if (hash.startsWith("#v=")) {
			// Load value from location hash
			elV.value = decodeURIComponent(hash.substring(3));
			clearLocationHash();
		} else if (hash === "#policy") {
			const policyDialog = bootstrap.Modal.getOrCreateInstance(elPolicyDialog);
			policyDialog.show();
		}
	}
	
	// Initialize menu
	$.one(`#typeMenu a[data-dencode-method="${dencodeMethod}"]`).classList.add("active");
	
	// Initialize buttons
	if (dencoderDefs[dencodeMethod].useOe) {
		let elOexMenuItem = elOexMenuItems.find((el) => el.classList.contains("active"));
		if (!elOexMenuItem) {
			elOexMenuItem = elOexMenuItems[0];
		}
		elOexBtn.textContent = elOexMenuItem.textContent;
		elOexBtn.setAttribute("data-oe", elOexMenuItem.getAttribute("data-oe"));
		
		elOeGroup.style.display = "";
		
		$.on(elOeGroupBtns, "click", function () {
			if (this.classList.contains("active")) {
				return;
			}
			
			elOeGroupBtns.forEach((el) => el.classList.remove("active"));
			this.classList.add("active");
			
			dencode();
		});
		
		$.on(elOexMenuItems, "click", function () {
			elOeGroupBtns.forEach((el) => el.classList.remove("active"));
			elOexMenuItems.forEach((el) => el.classList.remove("active"));
			this.classList.add("active");
			elOexBtn.classList.add("active");
			
			elOexBtn.textContent = this.textContent;
			elOexBtn.setAttribute("data-oe", this.getAttribute("data-oe"));
			
			dencode();
		});
	}
	
	if (dencoderDefs[dencodeMethod].useNl) {
		elNlGroup.style.display = "";
		
		$.on(elNlGroupBtns, "click", function () {
			if (this.classList.contains("active")) {
				return;
			}
			
			elNlGroupBtns.forEach((el) => el.classList.remove("active"));
			this.classList.add("active");
			
			dencode();
		});
	}
	
	if (dencoderDefs[dencodeMethod].useTz) {
		let elTzMenuItem = elTzMenuItems.find((el) => el.classList.contains("active"));
		if (!elTzMenuItem) {
			elTzMenuItem = elTzMenuItems[0];
		}
		elTz.textContent = elTzMenuItem.textContent;
		elTz.setAttribute("data-tz", elTzMenuItem.getAttribute("data-tz"));
		
		elTzGroup.style.display = "";
		
		$.on(elTzMenuFilter, "input paste", function () {
			const svals = this.value.toLowerCase().split(/\s+/g);
			
			elTzMenuItems.forEach((elItem) => {
				let val = elItem.getAttribute("data-tz-lc");
				if (!val) {
					val = elItem.textContent.toLowerCase();
					elItem.setAttribute("data-tz-lc", val);
				}
				
				let matched = true;
				for (const sval of svals) {
					if (!val.includes(sval)) {
						matched = false;
						break;
					}
				}
				elItem.style.display = (matched) ? "" : "none";
			});
		});
		
		$.on(elTzMenuItems, "click", function () {
			elTzMenuItems.forEach((el) => el.classList.remove("active"));
			this.classList.add("active");
			
			elTz.textContent = this.textContent;
			elTz.setAttribute("data-tz", this.getAttribute("data-tz"));
			
			dencode();
		});
	}
	
	// Initialize popovers
	new bootstrap.Popover(elVLen, {
		trigger: "click",
		content: (el) => {
			const chars = Number(el.getAttribute("data-len-chars"));
			const bytes = Number(el.getAttribute("data-len-bytes"));
			return renderTemplate(getLengthTmpl(), {
				chars: chars,
				oneChar: (chars == 1),
				bytes: bytes,
				oneByte: (bytes == 1)
			});
		}
	});
	
	new bootstrap.Popover(document.body, {
		selector: ".popover-toggle.permanent-link",
		trigger: "click",
		html: true,
		sanitize: false,
		content: (el) => {
			const method = el.closest("[data-dencode-method]").getAttribute("data-dencode-method");
			const dcDef = dencoderDefs[method];
			const permanentLink = getPermanentLink(method, dcDef);
			return renderTemplate(getPermanentLinkTmpl(), {
				permanentLink: permanentLink,
				permanentLinkUrlEncoded: encodeURIComponent(permanentLink)
			});
		}
	});
	
	
	// Add event listeners
	$.on(window, "resize", function () {
		adjustPopovers($.all(".popover-toggle.active"));
	});
	
	$.on(document, "click", function (ev) {
		// hide popover when other area clicked
		if (!ev.target.closest(".popover-toggle, .popover")) {
			hidePopovers($.all(".popover-toggle.active"));
		}
	});
	
	if (window.File) {
		$.on(document, "drop", async function (ev) {
			const file = ev.originalEvent.dataTransfer.files[0];
			updateValue(await readTextFileAsync(file));
			
			ev.preventDefault();
		});
		
		$.on(document, "dragenter dragover dragleave dragend", function (ev) {
			ev.preventDefault();
		});
	}
	
	$.on(".select-on-focus", "focus", function () {
		setTimeout(function () {
			selectAllTextValue(this);
		}.bind(this), 1);
	}, true);
	
	$.on(".copy-to-clipboard", "click", function (ev) {
		copyToClipboard(this);
		this.focus();
		
		ev.preventDefault();
	});
	
	$.on(".popover-toggle", "show.bs.popover", function () {
		hidePopovers($.all(".popover-toggle.active"));
		
		this.classList.add("active");
	});
	
	$.on(".popover-toggle", "hidden.bs.popover", function () {
		this.classList.remove("active");
	});
	
	$.on($.all(".dropdown-item"), "keyup", function (ev) {
		if (ev.key === "Enter") {
			ev.target.click();
		}
	});
	
	$.on(elLocaleMenuLinks, "click", function (ev) {
		if (this.closest("li").classList.contains("active")) {
			ev.preventDefault();
			return;
		}
		
		const v = elV.value;
		if (0 < v.length) {
			this.href += "#v=" + encodeURIComponent(v);
		}
	});
	
	$.on(elTypeMenuMethodLinks, "click", function (ev) {
		if (this.classList.contains("active")) {
			ev.preventDefault();
			return;
		}
		
		const v = elV.value;
		if (0 < v.length) {
			this.href += "#v=" + encodeURIComponent(v);
		}
	});
	
	$.on(elTypeMenuLabels, "click", function (ev) {
		const elDropdownMenuLink = this.closest("li").querySelector("ul.dropdown-menu li a");
		elDropdownMenuLink.click();
		
		ev.preventDefault();
	});

	$.on(elV, "input paste", function () {
		dencode();
	});

	$.on(elV, "keyup click", function () {
		setBgColor(elV, _colors, isDarkMode());
	});
	
	$.on(elLoadFile, "click", function () {
		elLoadFileInput.click();
	});
	
	$.on(elLoadFileInput, "change", async function () {
		if (this.files.length === 0) {
			return;
		}
		
		const file = this.files[0];
		this.value = "";
		
		try {
			updateValue(await readTextFileAsync(file));
			showTooltip(elLoadBtn, elLoadFile.getAttribute("data-load-message"), 2000);
		} catch (ex) {
			showMessageDialog(elLoadFile.getAttribute("data-load-error-message"));
		}
	});

	$.on(elLoadImage, "click", function () {
		elLoadImageInput.click();
	});

	$.on(elLoadImageInput, "change", async function () {
		if (this.files.length === 0) {
			return;
		}
		
		const file = this.files[0];
		this.value = "";
		
		try {
			updateValue(await readImageFileAsync(file));
			showTooltip(elLoadBtn, elLoadImage.getAttribute("data-load-message"), 2000);
		} catch (ex) {
			showMessageDialog(elLoadImage.getAttribute("data-load-error-message"));
		}
	});
	
	$.on(elLoadQrcode, "click", function () {
		elLoadQrcodeInput.click();
	});
	
	$.on(elLoadQrcodeInput, "change", async function () {
		if (this.files.length === 0) {
			return;
		}
		
		const file = this.files[0];
		this.value = "";
		
		try {
			updateValue(await readQrcodeAsync(file));
			showTooltip(elLoadBtn, elLoadQrcode.getAttribute("data-load-message"), 2000);
		} catch (ex) {
			showMessageDialog(elLoadQrcode.getAttribute("data-load-error-message"));
		}
	});
	
	$.on(elSubHeaders, "click", function () {
		const elToggleIcon = this.querySelector(".toggle-icon");
		
		if (elToggleIcon.classList.contains("bi-caret-down-square")) {
			elToggleIcon.classList.remove("bi-caret-down-square");
			elToggleIcon.classList.add("bi-caret-right-square");
		} else {
			elToggleIcon.classList.remove("bi-caret-right-square");
			elToggleIcon.classList.add("bi-caret-down-square");
		}
	});
	
	$.on(elListRows, "click", function (ev) {
		hidePopovers($.all(".popover-toggle.active"));
		
		if (ev.target.closest(".for-copy")) {
			return;
		}
		if (this.classList.contains("invalid-value")) {
			return;
		}
		
		if (this.classList.contains("active")) {
			this.dispatchEvent(new Event("dencode:deselect-row"));
		} else {
			elListRows.forEach((el) => {
				if (el.classList.contains("active")) {
					el.dispatchEvent(new Event("dencode:deselect-row"));
				}
			});
			
			this.dispatchEvent(new Event("dencode:select-row"));
		}
	});
	
	$.on(elOptionGroups, "click", function (ev) {
		ev.stopPropagation();
	}, { capture: true });
	
	$.on(elOptions, "input paste change", function () {
		const name = this.name;
		const value = this.value;
		
		elSyncOptions.forEach((elSyncOpt) => {
			if (elSyncOpt.getAttribute("data-sync-with") === name) {
				elSyncOpt.value = value;
				elSyncOpt.dispatchEvent(new Event("dencode:init"));
			}
		});
		
		dencode();
	});
	
	$.on(elSyncOptions, "input paste change", function () {
		const optName = this.getAttribute("data-sync-with");
		const elOpt = elOptions.find((el) => el.name === optName);
		elOpt.value = this.value;
		elOpt.dispatchEvent(new Event("change"));
	});
	
	$.on(elListRows, "dencode:select-row", function () {
		this.classList.add("active");
		
		const elForDisp = this.querySelector(".for-disp");
		const id = elForDisp.getAttribute("id");
		const val = elForDisp.textContent;
		
		const forCopyHtml = renderTemplate(getForCopyTmpl(), {
			id: id,
			value: val
		});
		
		const elTmpl = document.createElement("template");
		elTmpl.innerHTML = forCopyHtml;
		const elForCopy = elTmpl.content;
		
		elForDisp.parentNode.insertBefore(elForCopy, elForDisp);
	});
	
	$.on(elListRows, "dencode:deselect-row", function () {
		this.classList.remove("active");
		
		const elForCopy = this.querySelector(".for-copy");
		elForCopy.parentNode.removeChild(elForCopy);
	});
	
	$.on(elFollow, "click", function () {
		toggleFollow();
	});
	try {
		if (window.localStorage.getItem("follow") === "true") {
			toggleFollow();
		}
	} catch (ex) {
		// NOP
	}
	
	$.on(elOtherDencodeLinks, "click", function (ev) {
		const method = this.getAttribute("data-other-dencode-method");
		
		$.one(`#typeMenu a[data-dencode-method="${method}"]`).click();
		
		ev.preventDefault();
	});
	
	$.on(elPolicyDialog, "show.bs.modal", function () {
		window.location.hash = "#policy";
	});
	
	$.on(elPolicyDialog, "hide.bs.modal", function () {
		clearLocationHash();
	});
	
	
	(() => {
		// for cipher.enigma
		
		const elOptMachines = $.all(".dencode-option[name='cipher.enigma.machine'],.dencode-option[name='_cipher.enigma.machine']");
		
		if (elOptMachines.length === 0) {
			return;
		}
		
		const elOptReflectors = $.all(".dencode-option[name='cipher.enigma.reflector'],.dencode-option[name='_cipher.enigma.reflector']");
		const elOptPlugboards = $.all(".dencode-option[name='cipher.enigma.plugboard'],.dencode-option[name='_cipher.enigma.plugboard']");
		const elOptUkwds = $.all(".dencode-option[name='cipher.enigma.ukwd'],.dencode-option[name='_cipher.enigma.ukwd']");
		
		$.on(elOptMachines, "change dencode:init", function () {
			const prefix = this.name.substring(0, this.name.lastIndexOf("."));
			
			const elOptMachineOption = this.options[this.selectedIndex];
			const reflectors = elOptMachineOption.getAttribute("data-reflectors")?.split(",") || [];
			const rotors = elOptMachineOption.getAttribute("data-rotors")?.split(",") || [];
			const has = elOptMachineOption.getAttribute("data-has")?.split(",") || [];
			
			const has4wheels = (has.indexOf("4wheels") !== -1);
			const hasPlugboard = (has.indexOf("plugboard") !== -1);
			const hasUhr = (has.indexOf("uhr") !== -1);
			const hasSettableReflector = (has.indexOf("settable-reflector") !== -1);
			const hasUkwd = (has.indexOf("ukwd") !== -1);
			
			const elOptReflector = $.one(`.dencode-option[name="${prefix}.reflector"]`);
			const elOptReflectorOptSet = $.all(`.dencode-option[name^="${prefix}.reflector-"]`);
			const elOptRotor4Set = $.all(`.dencode-option[name^="${prefix}.rotor4"]`);
			const elOptRotor3 = $.one(`.dencode-option[name="${prefix}.rotor3"]`);
			const elOptRotor2 = $.one(`.dencode-option[name="${prefix}.rotor2"]`);
			const elOptRotor1 = $.one(`.dencode-option[name="${prefix}.rotor1"]`);
			const elOptPlugboard = $.one(`.dencode-option[name='${prefix}.plugboard']`);
			const elOptUhr = $.one(`.dencode-option[name='${prefix}.uhr']`);
			const elOptUkwd = $.one(`.dencode-option[name='${prefix}.ukwd']`);
			
			setupSelectOptions(elOptReflector, reflectors);
			setupSelectOptions(elOptRotor3, rotors);
			setupSelectOptions(elOptRotor2, rotors);
			setupSelectOptions(elOptRotor1, rotors);
			
			elOptReflectorOptSet.forEach((el) => el.setAttribute("data-disabled", !hasSettableReflector));
			elOptRotor4Set.forEach((el) => el.setAttribute("data-disabled", !has4wheels));
			elOptPlugboard.setAttribute("data-disabled", !hasPlugboard);
			elOptUhr.setAttribute("data-disabled", !hasUhr);
			elOptUkwd.setAttribute("data-disabled", !hasUkwd);
			
			const elEnigma = this.closest(".cipher-enigma");
			addOrRemoveClass(elEnigma, "cipher-enigma-has-settable-reflector", hasSettableReflector);
			addOrRemoveClass(elEnigma, "cipher-enigma-has-4wheels", has4wheels);
			addOrRemoveClass(elEnigma, "cipher-enigma-has-plugboard", hasPlugboard);
			addOrRemoveClass(elEnigma, "cipher-enigma-has-uhr", hasUhr);
			addOrRemoveClass(elEnigma, "cipher-enigma-has-ukwd", hasUkwd);
			
			elOptReflector.dispatchEvent(new Event("dencode:init"));
		});
		
		$.on(elOptReflectors, "change dencode:init", function () {
			const prefix = this.name.substring(0, this.name.lastIndexOf("."));
			
			const elOptUkwd = $.one(`.dencode-option[name="${prefix}.ukwd"]`);
			const elOptRotor4Set = $.all(`.dencode-option[name^="${prefix}.rotor4"]`);
			const ukwd = (this.value === "UKW-D");
			
			elOptUkwd.disabled = !ukwd;
			elOptRotor4Set.forEach((el) => el.disabled = ukwd);
		});
		
		$.on(elOptPlugboards, "input paste change dencode:init", function () {
			const prefix = this.name.substring(0, this.name.lastIndexOf("."));
			
			const val = this.value.toUpperCase().replace(/[^A-Z\s]/g, "");
			
			const sidx = this.selectionStart;
			this.value = val;
			this.selectionStart = this.selectionEnd = sidx;
			
			const pairs = val.trim().split(/\s+/);
			const err = !validateWiring(pairs, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
			
			addOrRemoveClass(this, "dencode-option-error", err);
			
			const elOptUhr = $.one(`.dencode-option[name='${prefix}.uhr']`);
			elOptUhr.disabled = (err || (pairs.length !== 10));
		});
		
		$.on(elOptUkwds, "input paste change dencode:init", function () {
			const val = this.value.toUpperCase().replace(/[^A-Z\s]/g, "");
			
			const sidx = this.selectionStart;
			this.value = val;
			this.selectionStart = this.selectionEnd = sidx;
			
			const pairs = val.trim().split(/\s+/);
			const err = !validateWiring(pairs, "AZXWVUTSRQPONMLKIHGFEDCB");
			
			addOrRemoveClass(this, "dencode-option-error", err);
		});
		
		elOptMachines.forEach((el) => el.dispatchEvent(new Event("dencode:init")));
		elOptPlugboards.forEach((el) => el.dispatchEvent(new Event("dencode:init")));
		elOptUkwds.forEach((el) => el.dispatchEvent(new Event("dencode:init")));
		
		function setupSelectOptions(elSelect, optionValues) {
			const elSelOpts = elSelect.options;
			const currentIdx = elSelect.selectedIndex;
			
			let newIdx = -1;
			for (let i = 0; i < elSelOpts.length; i++) {
				const elSelOpt = elSelOpts[i];
				const enable = (optionValues.indexOf(elSelOpt.value) !== -1);
				
				elSelOpt.disabled = !enable;
				elSelOpt.hidden = !enable;
				if (enable && (i <= currentIdx || newIdx === -1)) {
					newIdx = i;
				}
			}
			
			elSelect.selectedIndex = newIdx;
		}
		
		function addOrRemoveClass(el, className, add) {
			if (add) {
				el.classList.add(className);
			} else {
				el.classList.remove(className);
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
		const v = elV.value;
		const oe = elOeGroupBtns.find((el) => el.classList.contains("active"))?.getAttribute("data-oe");
		const oex = elOexMenuItems.find((el) => el.classList.contains("active"))?.getAttribute("data-oe");
		const nl = elNlGroupBtns.find((el) => el.classList.contains("active"))?.getAttribute("data-nl");
		const tz = elTz.getAttribute("data-tz");
		let options = {};
		elOptions.forEach((el) => {
			options[el.name] = el.value;
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
		elVLen.textContent = separateThousand(len);
		
		// Store settings to local storage
		try {
			if (window.localStorage) {
				window.localStorage.setItem("oe", oe);
				window.localStorage.setItem("oex", oex);
				window.localStorage.setItem("nl", nl);
				window.localStorage.setItem("tz", tz);
				
				for (let key in options) {
					window.localStorage.setItem("options." + key, options[key]);
				};
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
		
		
		elDecIndicator.style.display = "";
		elEncIndicator.style.display = "";
		
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
		}).then((response) => {
			if (response.headers.get("Content-Type").indexOf("application/json") === -1) {
				const messageObject = getMessage("default.error");
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
		}).then((responseJson) => {
			if (responseJson.redirectUrl) {
				window.location.href = responseJson.redirectUrl;
			}
			
			clearMessages();
			if (responseJson.messages !== null && 0 < responseJson.messages.length) {
				showMessages(responseJson.messages);
				focusMessages();
			}
			
			render(responseJson.response);
			
			document.dispatchEvent(new CustomEvent("dencode:dencoded", {
				detail: {
					requestData: requestData,
					responseJson: responseJson
				}
			}));
		}).catch((err) => {
			if (err.messageObject) {
				// Handled error
				showMessages(err.messageObject);
			} else if (err.statusCode) {
				// HTTP 4xx or 5xx error
				showMessages(getMessage("default.error"));
			} else {
				// Network error
				showMessages(getMessage("network.error"));
			}
			focusMessages();
			
			document.dispatchEvent(new CustomEvent("dencode:dencoded", {
				detail: {
					requestData: requestData,
					responseJson: null
				}
			}));
		}).finally(() => {
			_inProc = false;
			
			elDecIndicator.style.display = "none";
			elEncIndicator.style.display = "none";
			
			dencode();
		});
	}
	
	function render(res) {
		elVLen.textContent = separateThousand(res.textLength);
		elVLen.setAttribute("data-len-chars", res.textLength);
		elVLen.setAttribute("data-len-bytes", res.textByteLength);
		
		_colors = (res.encColorRGBHex) ? res.encColorRGBHex.split("\n") : null;
		if (_colors) {
			setBgColor(elV, _colors, isDarkMode());
		}
		
		for (const k in res) {
			setResponseValue(k, res[k]);
		}
	}
	
	function toggleFollow() {
		const isFollowActive = elFollow.classList.contains("active");
		if (isFollowActive) {
			elFollow.classList.remove("active");
			elExp.classList.remove("follow");
		} else {
			elFollow.classList.add("active");
			elExp.classList.add("follow");
		}
		
		try {
			window.localStorage.setItem("follow", (isFollowActive) ? "false" : "true");
		} catch (ex) {
			// NOP
		}
	}
	
	function getPermanentLink(method, dcDef) {
		const v = elV.value;
		const path = $.one(`#typeMenu a[data-dencode-method="${method}"]`).getAttribute("href");
		
		let url = window.location.protocol + "//" + window.location.host + path;
		
		url += "?v=" + encodeURIComponent(v);
		
		if (dcDef === null || dcDef.useOe) {
			const oe = elOeGroupBtns.find((el) => el.classList.contains("active"))?.getAttribute("data-oe");
			url += "&oe=" + encodeURIComponent(oe);
		}
		if (dcDef === null || dcDef.useNl) {
			const nl = elNlGroupBtns.find((el) => el.classList.contains("active"))?.getAttribute("data-nl");
			url += "&nl=" + encodeURIComponent(nl);
		}
		if (dcDef === null || dcDef.useTz) {
			const tz = elTz.getAttribute("data-tz");
			url += "&tz=" + encodeURIComponent(tz);
		}
		
		if (!method.endsWith(".all")) {
			elOptions.forEach((el) => {
				if (el.disabled || el.dataset.disabled === "true") {
					return;
				}
				if (!el.name.startsWith(method + ".")) {
					return;
				}
				
				const pk = el.name.substring(method.length + 1);
				const pv = el.value;
				
				url += "&" + encodeURIComponent(pk) + "=" + encodeURIComponent(pv);
			});
		}
		
		return url;
	}
	
	function getMessageTmpl() {
		if (_messageTmpl === null) {
			_messageTmpl = $.id("messageTmpl").innerHTML;
		}
		return _messageTmpl;
	}
	
	function getLengthTmpl() {
		if (_lengthTmpl === null) {
			_lengthTmpl = $.id("lengthTmpl").innerHTML;
		}
		return _lengthTmpl;
	}
	
	function getPermanentLinkTmpl() {
		if (_permanentLinkTmpl === null) {
			_permanentLinkTmpl = $.id("permanentLinkTmpl").innerHTML;
		}
		return _permanentLinkTmpl;
	}
	
	function getForCopyTmpl() {
		if (_forCopyTmpl === null) {
			_forCopyTmpl = $.id("forCopyTmpl").innerHTML;
		}
		return _forCopyTmpl;
	}
	
	async function readTextFileAsync(file) {
		const encoding = elOeGroupBtns.find((el) => el.classList.contains("active"))?.getAttribute("data-oe");
		
		return await readFileAsTextAsync(file, encoding);
	}
	
	async function readImageFileAsync(file) {
		await loadScriptAsync("#scriptTesseract");
		
		let language;
		switch (document.documentElement.lang) {
			case "ja": language = "jpn"; break;
			case "ru": language = "rus"; break;
			default: language = "eng"; break;
		}
		
		const worker = await Tesseract.createWorker(language);
		const ret = await worker.recognize(file);
		worker.terminate();
		
		return ret.data.text;
	}
	
	async function readQrcodeAsync(file) {
		await loadScriptAsync("#scriptJsqr");
		
		const img = await readFileAsImageAsync(file);
		
		const code = readQrcodeFromImage(img, [600, 200, 1000, 400, 800, 1200, 1400, 1600]);
		if (code === null) {
			reject(new Error("Could not parse."));
			return;
		}
		
		let data;
		if (code.data.length === 0 && 0 < code.binaryData.length) {
			// If the QR code cannot be parsed as UTF-8 text
			try {
				// Parse the binary data as JIS X 0208 (Shift_JIS) text
				data = new TextDecoder("shift-jis", {fatal: true}).decode(Uint8Array.from(code.binaryData));
			} catch (ex) {
				// Convert the binary data to hex string
				data = code.binaryData.map((b) => ("0" + (b & 0xFF).toString(16)).slice(-2)).join("");
			}
		} else {
			data = code.data;
		}
		
		return data;
	}
	
	function updateValue(val) {
		elV.value = val;
		elV.dispatchEvent(new Event("input"));
		
		elV.classList.remove("updating");
		elV.classList.remove("updated");
		elV.classList.add("updating");
		setTimeout(() => {
			elV.classList.add("updated");
			
			setTimeout(() => {
				elV.classList.remove("updating");
				elV.classList.remove("updated");
			}, 2000);
		}, 1);
	}
	
	function showMessages(messages) {
		let messagesHtml = "";
		
		if (messages) {
			if (Array.isArray(messages)) {
				for (const message of messages) {
					messagesHtml += renderTemplate(getMessageTmpl(), formatMessage(message));
				}
			} else {
				messagesHtml = renderTemplate(getMessageTmpl(), formatMessage(messages));
			}
		}
		
		$.id("messages").innerHTML = messagesHtml;
	}
	
	function clearMessages() {
		$.id("messages").textContent = "";
	}

	function focusMessages() {
		window.scroll({
			top: $.id("messages").offsetTop - 10,
			behavior: "smooth"
		});
	}
	
	function showMessageDialog(messageText) {
		$.id("messageDialogBody").textContent = messageText;
		const modal = bootstrap.Modal.getOrCreateInstance($.id("messageDialog"));
		modal.show();
	}
});


function isDarkMode() {
	return (document.documentElement.getAttribute("data-bs-theme") === "dark");
}

function setResponseValue(id, value) {
	const elForDisp = $.id(id);
	if (elForDisp === null) {
		return;
	}
	
	const elRow = elForDisp.closest("tr");
	if (value === null) {
		elRow.classList.add("invalid-value");
		elForDisp.textContent = "";
	} else {
		elRow.classList.remove("invalid-value");
		elForDisp.textContent = value;
	}
	
	const elForCopyTextarea = $.id(id + "ForCopy");
	if (elForCopyTextarea) {
		elForCopyTextarea.value = value;
	}
}

function setBgColor(el, colors, darkMode) {
	let bgColor = null;
	if (colors) {
		bgColor = getNonBlankValue(colors, getCurrentLineIndex(el));
	}
	
	let color;
	if (bgColor) {
		const r = parseInt(bgColor.substring(1, 3), 16);
		const g = parseInt(bgColor.substring(3, 5), 16);
		const b = parseInt(bgColor.substring(5, 7), 16);
		const a = (7 < bgColor.length) ? parseInt(bgColor.substring(7), 16) / 255.0 : 1.0;
		
		if (a < 0.5) {
			color = (darkMode) ? "white" : "black";
		} else {
			color = ((r + g + b) < 384) ? "white" : "black"; // 384 = 256 * 3 / 2
		}
		
		// Temporary code: convert the color format #RRGGBBAA (CSS4) to rgba(R,G,B,A) (CSS3)
		bgColor = "rgba(" + r + "," + g + "," + b + "," + (Math.round(a * 100) / 100) + ")";
	} else {
		color = "var(--bs-body-color)";
		bgColor = "transparent";
	}
	
	el.style.color = color;
	el.style.backgroundColor = bgColor;
}

function selectAllTextValue(el) {
	if (el.select) {
		el.select();
	}
	
	if (document.createRange && window.getSelection) {
		const range = document.createRange();
		range.selectNode(el);
		const selection = window.getSelection();
		selection.removeAllRanges();
		selection.addRange(range);
	}
	
	if (el.setSelectionRange) {
		el.setSelectionRange(0, 2147483647);
	}
}

function clearSelection(el) {
	if (window.getSelection) {
		const selection = window.getSelection();
		selection.removeAllRanges();
	}
	
	if (el.setSelectionRange) {
		el.setSelectionRange(0, 0);
	}
}

function getCurrentLineIndex(el) {
	const cursorPos = el.selectionStart;
	const val = el.value;
	
	const n = (val.substring(0, cursorPos).match(/\n/g) || []).length;
	
	return n;
}

function adjustPopovers(elPopovers) {
	elPopovers.forEach((el) => {
		const popover = bootstrap.Popover.getInstance(el);
		if (popover) {
			popover.update();
		}
	});
}

function hidePopovers(elPopovers) {
	elPopovers.forEach((el) => {
		const popover = bootstrap.Popover.getInstance(el);
		if (popover) {
			popover.hide();
		}
	});
}

function showTooltip(el, message, time) {
	const tooltip = new bootstrap.Tooltip(el, {
		trigger: "manual",
		container: "body",
		title: message
	});
	
	tooltip.show();
	
	setTimeout(() => {
		tooltip.dispose();
	}, time);
}

function copyToClipboard(el) {
	const elCopy = $.id(el.getAttribute("data-copy-id"));
	const msg = el.getAttribute("data-copy-message");
	const errMsg = el.getAttribute("data-copy-error-message");
	
	elCopy.classList.remove("copying");
	elCopy.classList.remove("copied");
	elCopy.classList.add("copying");
	setTimeout(() => {
		elCopy.classList.add("copied");
		
		setTimeout(() => {
			elCopy.classList.remove("copying");
			elCopy.classList.remove("copied");
		}, 2000);
	}, 1);
	
	if (window.navigator.clipboard) {
		window.navigator.clipboard.writeText(elCopy.value)
			.then(() => showTooltip(el, msg, 2000))
			.catch(() => showTooltip(el, errMsg, 2000));
	} else {
		const readOnly = elCopy.readOnly;
		const contentEditable = elCopy.contentEditable;
		
		elCopy.readOnly = true;
		elCopy.contentEditable = true;
		
		elCopy.focus();
		selectAllTextValue(elCopy);
		
		try {
			document.execCommand("copy");
			
			showTooltip(el, msg, 2000);
		} catch (ex) {
			showTooltip(el, errMsg, 2000);
		} finally {
			elCopy.readOnly = readOnly;
			elCopy.contentEditable = contentEditable;
			
			clearSelection(elCopy);
			elCopy.blur();
		}
	}
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

function loadScriptAsync(scriptTagQuery) {
	return new Promise((resolve, reject) => {
		const s = $.one(scriptTagQuery);
		if (s.dataset.loaded === "true") {
			resolve(s);
			return;
		}
		
		s.remove();
		s.addEventListener("load", function () {
			s.dataset.loaded = "true";
			resolve(s);
		});
		s.addEventListener("error", function (err) {
			s.dataset.loaded = "true";
			reject(err);
		});
		s.src = s.dataset.src;
		document.body.appendChild(s);
	});
}

function readFileAsTextAsync(file, encoding) {
	return new Promise((resolve, reject) => {
		const reader = new FileReader();
		reader.onload = () => resolve(reader.result);
		reader.onerror = (err) => reject(err);
		reader.readAsText(file, encoding);
	});
}

function readFileAsImageAsync(file) {
	return new Promise((resolve, reject) => {
		const reader = new FileReader();
		reader.onload = () => {
			const img = new Image();
			img.onload = () => resolve(img);
			img.onerror = (err) => reject(err);
			img.src = reader.result;
		};
		reader.onerror = (err) => reject(err);
		reader.readAsDataURL(file);
	});
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

function separateThousand(num) {
	let strNum = String(num);
	
	const decPos = strNum.indexOf(".");
	let dec = null;
	if (0 <= decPos) {
		dec = strNum.substring(decPos);
		strNum = strNum.substring(0, decPos);
	}
	
	if (3 < strNum.length) {
		strNum = strNum.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
	}
	
	if (dec !== null) {
		strNum += dec;
	}
	
	return strNum;
}

function getMessage(messageId) {
	const m = $.one(`script[type='text/message'][data-id='${messageId}']`);
	return newMessage(
			m.dataset.id,
			m.dataset.level,
			m.dataset.message,
			m.dataset.detail
			);
}

function formatMessage(message) {
	if (message.type) {
		return message;
	} else {
		return newMessage(
				message.messageId,
				message.level,
				message.message,
				message.detail
				);
	}
}

function newMessage(messageId, level, message, detail) {
	return {
		"messageId": messageId,
		"level": level,
		"type": toMessageType(level),
		"message": message,
		"detail": detail
	};
}

function toMessageType(level) {
	switch (level) {
	case "success":
		return "success";
	case "info":
		return "info";
	case "warn":
		return "warning";
	case "error": //FALLTHRU
	case "fatal": //FALLTHRU
	default:
		return "danger";
	}
}

function clearLocationHash() {
	if (window.history.replaceState) {
		window.history.replaceState(null, null, window.location.pathname + window.location.search);
	} else {
		window.location.hash = "";
	}
}

function renderTemplate(tmpl, p) {
	const r = /([\s\S]*?)\{\{([\#\^/]?)(.+?)\}\}([^\{]*)/g;
	let buf = "";
	let currentName = "";
	let skip = false;
	let m;
	while ((m = r.exec(tmpl)) != null) {
		const pv = m[1];
		const type = m[2];
		const name = m[3];
		const sv = m[4];
		
		if (!skip) {
			buf += pv;
		}
		
		if (type === "#") {
			currentName = name;
			skip = !p[name];
		 } else if (type === "^") {
			currentName = name;
			skip = p[name];
		} else if (type === "/") {
			if (name !== currentName) {
				throw new Error("Wrong close mustache {{/" + name + "}}");
			}
			currentName = "";
			skip = false;
		} else if (type === "") {
			if (!skip) {
				const v = p[name];
				if (v !== undefined && v !== null && v !== "") {
					buf += ("" + v).replace(/&/g, "&amp;")
							.replace(/</g, "&lt;")
							.replace(/>/g, "&gt;")
							.replace(/"/g, "&quot;")
							.replace(/'/g, "&#39;");
				}
			}
		} else {
			throw new Error("Unsupported type {{" + type + "}}");
		}
		
		if (!skip) {
			buf += sv;
		}
	}
	
	return buf;
}

})(window, document);
