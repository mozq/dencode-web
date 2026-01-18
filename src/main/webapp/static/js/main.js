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
	
	let _colors = null;
	
	const contextPath = document.body.getAttribute("data-context-path");
	const dencodeType = document.body.getAttribute("data-dencode-type");
	const dencodeMethod = document.body.getAttribute("data-dencode-method");
	
	const dencoderDefs = JSON.parse($.id("dencoderDefs").textContent);
	
	const elMessages = $.id("messages");
	const elMenuLinks = $.all("#localeMenu a, #typeMenu a");
	const elExp = $.id("exp");
	const elFollow = $.id("follow");
	const elVLen = $.id("vLen");
	const elV = $.id("v");
	const elLoadBtn = $.id("load");
	const elLoadFile = $.id("loadFile");
	const elLoadFileInput = $.id("loadFileInput");
	const elLoadImage = $.id("loadImage");
	const elLoadImageInput = $.id("loadImageInput");
	const elLoadCode = $.id("loadCode");
	const elLoadCodeInput = $.id("loadCodeInput");
	const elOeGroup = $.id("oeGroup");
	const elOeGroupBtns = $.all("#oeGroup .btn:not(.dropdown-toggle)");
	const elOexBtn = $.id("oex");
	const elOexMenu = $.id("oexMenu");
	const elOexMenuItems = $.all("#oexMenu [data-oe]");
	const elNl = $.id("nl");
	const elNlGroup = $.id("nlGroup");
	const elNlMenuItems = $.all("#nlMenu [data-nl]");
	const elTz = $.id("tz");
	const elTzGroup = $.id("tzGroup");
	const elTzMenuItems = $.all("#tzMenuItems [data-tz]");
	const elTzMenuFilter = $.id("tzMenuFilter");
	const elDecIndicator = $.id("decodingIndicator");
	const elEncIndicator = $.id("encodingIndicator");
	const elListRows = $.all(".dencoded-list > tbody > tr");
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
		elNl.setAttribute("data-nl", selectItem(elNlMenuItems, elNlGroup, "nl", "nl"));
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
	
	// Initialize value
	try {
		// Load value from session storage
		const value = window.sessionStorage.getItem("value");
		if (value !== null) {
			elV.value = value;
			window.sessionStorage.removeItem("value");
		}
	} catch (ex) {
		// NOP
	} finally {
		// Load value from location hash
		if (window.location.hash.startsWith("#v=")) {
			elV.value = decodeURIComponent(window.location.hash.substring(3));
			clearLocationHash();
		}
	}
	
	// Initialize menu
	$.all(`#typeMenu li:has(a[data-dencode-method="${dencodeMethod}"])`).forEach((el) => el.classList.add("active"));
	
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
		let elNlMenuItem = elNlMenuItems.find((el) => el.classList.contains("active"));
		if (!elNlMenuItem) {
			elNlMenuItem = elNlMenuItems[0];
		}
		elNl.textContent = elNlMenuItem.textContent;
		elNl.setAttribute("data-nl", elNlMenuItem.getAttribute("data-nl"));
		
		elNlGroup.style.display = "";
		
		$.on(elNlMenuItems, "click", function () {
			elNlMenuItems.forEach((el) => el.classList.remove("active"));
			this.classList.add("active");
			
			elNl.textContent = this.textContent;
			elNl.setAttribute("data-nl", this.getAttribute("data-nl"));
			
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
	
	// Initialize focus
	if (!("ontouchstart" in window) && !navigator.maxTouchPoints) {
		// If non-touch screen
		// Focus the textarea
		elV.focus();
	}
	
	
	// Add event listeners
	$.on(window, "hashchange", function () {
		handleHash(window.location.hash);
	});
	
	$.on(document, "click", function (ev) {
		// Hide dropdown menus when another area is clicked
		const dropdownToggle = ev.target.closest(".dropdown-toggle") ?? ev.target.closest(".dropdown-menu")?.previousElementSibling;
		$.all(".dropdown-toggle[aria-expanded='true']").forEach((el) => {
			if (el !== dropdownToggle) {
				el.setAttribute("aria-expanded", false);
			}
		});
		
		// Hide popovers when another area is clicked
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
	
	$.on("[aria-controls][aria-expanded]", "click", function () {
		const id = this.getAttribute("aria-controls");
		const el = $.id(id);
		if (el) {
			el.classList.toggle("expanded");
			this.setAttribute("aria-expanded", el.classList.contains("expanded"));
		}
	});
	
	$.on("[data-close='modal']", "click", function () {
		$.all(".modal[open]").forEach((el) => {
			el.close();
		});
	});
	
	$.on("[data-close='message']", "click", function () {
		this.closest(".message").remove();
	});
	
	$.on(".select-on-focus", "focus", function () {
		setTimeout(() => {
			this.select();
			this.setSelectionRange(0, this.value.length);
		}, 1);
	}, true);
	
	$.on(".copy-to-clipboard", "click", function () {
		const elCopy = $.id(this.getAttribute("data-copy-id"));
		
		highlightInput(elCopy);
		
		window.navigator.clipboard.writeText(elCopy.value)
			.then(() => showTooltip(this, this.getAttribute("data-copy-message"), 2000))
			.catch(() => showTooltip(this, this.getAttribute("data-copy-error-message"), 2000));
	});
	
	$.on(".dropdown-toggle", "click", function (ev) {
		if (ev.target.closest(".dropdown-menu, a[href]")) {
			return;
		}
		if (this.matches(".toggle-manual")) {
			return;
		}
		
		const expanded = (this.getAttribute("aria-expanded") === "true");
		this.setAttribute("aria-expanded", !expanded);
		
		const elMenu = this.querySelector(".dropdown-menu") ?? this.nextElementSibling;
		if (elMenu) {
			elMenu.style.transform = "none";
			
			const rect = elMenu.getBoundingClientRect();
			
			if (window.innerWidth < rect.right) {
				elMenu.style.transform = "translateX(" + (window.innerWidth - rect.right) +  "px)";
			} else if (rect.left < 0) {
				elMenu.style.transform = "translateX(" + (-rect.left) +  "px)";
			}
		}
	});
	
	$.on(".dropdown-menu li", "click", function () {
		const toggle = this.closest(".dropdown-toggle") ?? this.closest(".dropdown-menu")?.previousElementSibling;
		if (toggle) {
			toggle.setAttribute("aria-expanded", false);
		}
	});
	
	$.on(".dropdown-menu li", "keydown", function (ev) {
		if (ev.key === "Enter" || ev.key === " ") {
			ev.preventDefault();
			ev.target.click();
		}
	});
	
	$.on(".popover-toggle.permanent-link", "click", function (ev) {
		if (ev.target.closest(".popover")) {
			return;
		}
		
		if (this.classList.contains("active")) {
			hidePopovers($.all(".popover-toggle.active"));
		} else {
			const title = this.getAttribute("title");
			const method = this.closest("[data-dencode-method]").getAttribute("data-dencode-method");
			const dcDef = dencoderDefs[method];
			const permanentLink = getPermanentLink(method, dcDef);
			
			showPopover(this, title, renderTemplate("permanentLinkTmpl", {
				permanentLink: permanentLink,
				permanentLinkUrlEncoded: encodeURIComponent(permanentLink)
			}));
		}
	});
	
	$.on("#permanentLink .btn.share", "click", function () {
		if (navigator.share) {
			navigator.share({
				url: $.id("linkURL").value
			}).catch(() => {
				// NOP
			});
		} else {
			const expanded = (this.getAttribute("aria-expanded") === "true");
			this.setAttribute("aria-expanded", !expanded);
		}
	});
	
	$.on(elMenuLinks, "click", function (ev) {
		if (this.closest("li").classList.contains("active")) {
			ev.preventDefault();
			return;
		}
		
		const v = elV.value;
		if (0 < v.length) {
			try {
				window.sessionStorage.setItem("value", v);
			} catch(ex) {
				this.href += "#v=" + encodeURIComponent(v);
			}
		}
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
	
	$.on(elVLen, "click", function (ev) {
		if (ev.target.closest(".popover")) {
			return;
		}
		
		if (this.classList.contains("active")) {
			hidePopovers($.all(".popover-toggle.active"));
		} else {
			const title = this.getAttribute("title");
			const chars = Number(this.getAttribute("data-len-chars"));
			const bytes = Number(this.getAttribute("data-len-bytes"));
			
			showPopover(this, title, renderTemplate("lengthTmpl", {
				chars: chars,
				oneChar: (chars == 1),
				bytes: bytes,
				oneByte: (bytes == 1)
			}));
		}
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
	
	$.on(elLoadCode, "click", function () {
		elLoadCodeInput.click();
	});
	
	$.on(elLoadCodeInput, "change", async function () {
		if (this.files.length === 0) {
			return;
		}
		
		const file = this.files[0];
		this.value = "";
		
		try {
			updateValue(await readCodeAsync(file));
			showTooltip(elLoadBtn, elLoadCode.getAttribute("data-load-message"), 2000);
		} catch (ex) {
			showMessageDialog(elLoadCode.getAttribute("data-load-error-message"));
		}
	});
	
	$.on(elListRows, "click", function (ev) {
		if (ev.target.closest(".for-copy, .dencode-option-group")) {
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
	
	$.on(elListRows, "dencode:select-row", function () {
		this.classList.add("active");
		
		const elForDisp = this.querySelector(".for-disp");
		const id = elForDisp.getAttribute("id");
		const val = elForDisp.textContent;
		
		const elForCopy = renderTemplate("forCopyTmpl", {
			id: id,
			value: val
		});
		
		elForDisp.before(elForCopy);
	});
	
	$.on(elListRows, "dencode:deselect-row", function () {
		this.classList.remove("active");
		
		const elForCopy = this.querySelector(".for-copy");
		elForCopy.remove();
	});
	
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
	
	$.on(elOtherDencodeLinks, "click", function (ev) {
		const method = this.getAttribute("data-other-dencode-method");
		
		$.one(`#typeMenu a[data-dencode-method="${method}"]:last-child`).click();
		
		ev.preventDefault();
	});
	
	$.on(elPolicyDialog, "close", function () {
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
	
	// Hash routing
	handleHash(window.location.hash);
	
	
	dencode();
	
	
	// Function definitions
	
	function dencode() {
		const type = dencodeType;
		const method = dencodeMethod;
		const v = elV.value;
		const oe = elOeGroupBtns.find((el) => el.classList.contains("active"))?.getAttribute("data-oe");
		const oex = elOexMenuItems.find((el) => el.classList.contains("active"))?.getAttribute("data-oe");
		const nl = elNl.getAttribute("data-nl");
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
				const messageObject = getMessageObject("default.error");
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
				showMessages(getMessageObject("default.error"));
			} else {
				// Network error
				showMessages(getMessageObject("network.error"));
			}
			
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
		setBgColor(elV, _colors, isDarkMode());
		
		for (const k in res) {
			setResponseValue(k, res[k]);
		}
	}
	
	function handleHash(hash) {
		if (hash == "#policy") {
			elPolicyDialog.showModal();
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
			const nl = elNl.getAttribute("data-nl");
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
	
	async function readCodeAsync(file) {
		const img = await readFileAsImageAsync(file);
		
		let code = await detectCodeAsync(img);
		if (code === null) {
			code = await detectCodeByZXingAsync(img);
		}
		if (code === null) {
			throw new Error("Could not parse.");
		}
		
		return code;
	}
	
	async function detectCodeAsync(img) {
		if (!("BarcodeDetector" in window)) {
			return null;
		}
		
		const canvas = toCanvas(img, 1.0, "white");
		
		const detector = new BarcodeDetector();
		const barcodes = await detector.detect(canvas);
		
		if (barcodes.length === 0) {
			return null;
		}
		
		const code = Array.from(barcodes, (barcode) => barcode.rawValue).join("\n");
		
		if (code.length === 0) {
			return null;
		}
		
		return code;
	}
	
	async function detectCodeByZXingAsync(img) {
		await loadScriptAsync("#scriptZXing");
		
		const codeReader = new ZXing.BrowserMultiFormatReader();
		const hints = new Map([
			[ZXing.DecodeHintType.TRY_HARDER, true]
		]);
		
		let parsedOrgSize = false;
		let result = null;
		for (let maxSize of [480, 640, 800, 1024, 1280, 1600, 1920, 2160]) {
			const scale = calcImageScale(img, maxSize);
			if (scale === 1.0) {
				if (parsedOrgSize) {
					continue;
				}
				parsedOrgSize = true;
			}
			
			const canvas = toCanvas(img, scale, "white");
			
			try {
				result = await codeReader.decodeFromImageUrl(canvas.toDataURL("image/png"), hints);
				break;
			} catch (ex) {
				continue;
			}
		}
		
		if (result === null) {
			return null;
		}
		
		let code = result.getText();
		if (code.includes("\uFFFD")) {
			// Binary to hex string
			code = Array.from(result.getRawBytes(), (b) => b.toString(16).padStart(2, "0")).join("");
		}
		
		return code;
	}
	
	function updateValue(val) {
		elV.value = val;
		elV.dispatchEvent(new Event("input"));
		
		highlightInput(elV);
	}
	
	function showMessages(messageObjects) {
		clearMessages();
		
		if (messageObjects) {
			if (Array.isArray(messageObjects)) {
				for (const messageObject of messageObjects) {
					elMessages.appendChild(renderTemplate("messageTmpl", messageObject));
				}
			} else {
				elMessages.appendChild(renderTemplate("messageTmpl", messageObjects));
			}
		}
		
		window.scroll({
			top: $.id("messages").offsetTop - 10,
			behavior: "smooth"
		});
	}
	
	function clearMessages() {
		elMessages.innerHTML = "";
	}
	
	function showMessageDialog(messageText) {
		$.id("messageDialogBody").textContent = messageText;
		$.id("messageDialog").showModal();
	}
});


function isDarkMode() {
	return (document.documentElement.getAttribute("data-ui-theme") === "dark");
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
	let bgColor = getNonBlankValue(colors, getCurrentLineIndex(el), "");
	
	let color;
	if (bgColor) {
		// '#RRGGBBAA'
		const r = parseInt(bgColor.substring(1, 3), 16);
		const g = parseInt(bgColor.substring(3, 5), 16);
		const b = parseInt(bgColor.substring(5, 7), 16);
		const a = (7 < bgColor.length) ? parseInt(bgColor.substring(7), 16) / 255.0 : 1.0;
		
		if (a < 0.5) {
			color = (darkMode) ? "white" : "black";
		} else {
			color = ((r + g + b) < 384) ? "white" : "black"; // 384 = 256 * 3 / 2
		}
	} else {
		color = "";
	}
	
	el.style.color = color;
	el.style.backgroundColor = bgColor;
}

function getCurrentLineIndex(el) {
	const cursorPos = el.selectionStart;
	const val = el.value;
	
	const n = (val.substring(0, cursorPos).match(/\n/g) || []).length;
	
	return n;
}

function showPopover(el, title, elPopoverBody) {
	hidePopovers($.all(".popover-toggle.active"));
	
	const elPopover = renderTemplate("popoverTmpl", {
		title: title,
		body: elPopoverBody
	});
	
	el.appendChild(elPopover);
	el.classList.add("active");
}

function hidePopovers(elPopoverToggles) {
	elPopoverToggles.forEach((el) => {
		el.classList.remove("active");
		el.querySelector(".popover")?.remove();
	});
}

function showTooltip(el, message, time) {
	const elTooltip = document.createElement("span");
	elTooltip.className = "tooltip";
	elTooltip.innerText = message;
	el.appendChild(elTooltip);
	
	setTimeout(() => {
		elTooltip.remove();
	}, time);
}

function highlightInput(el) {
	el.classList.add("input-highlight");
	setTimeout(() => {
		el.classList.add("input-highlight-transition");
		el.classList.remove("input-highlight");
		setTimeout(() => {
			el.classList.remove("input-highlight-transition");
		}, 2000);
	}, 1);
}

function getNonBlankValue(values, index, defaultValue) {
	if (!values) {
		return defaultValue;
	}
	
	for (let i = Math.min(index, values.length - 1); 0 <= i; i--) {
		const value = values[i];
		if (value !== null && value !== "") {
			return value;
		}
	}
	
	for (let i = index + 1; i < values.length; i++) {
		const value = values[i];
		if (value !== null && value !== "") {
			return value;
		}
	}
	
	return defaultValue;
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

function calcImageScale(img, maxSize) {
	const maxImgSize = Math.max(img.naturalWidth, img.naturalHeight);
	const scale = Math.min(1.0, 1.0 * maxSize / maxImgSize);
	return scale;
}

function toCanvas(img, scale, bgColor) {
	const canvas = document.createElement("canvas");
	canvas.width = img.naturalWidth * scale;
	canvas.height = img.naturalHeight * scale;
	
	const ctx = canvas.getContext("2d");
	if (bgColor) {
		ctx.fillStyle = bgColor;
		ctx.fillRect(0, 0, canvas.width, canvas.height);
	}
	ctx.imageSmoothingEnabled = true;
	ctx.imageSmoothingQuality = "high";
	ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
	
	return canvas;
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

function getMessageObject(messageId) {
	const m = $.one(`script[type='text/message'][data-id='${messageId}']`);
	return {
			"messageId": m.dataset.id,
			"level": m.dataset.level,
			"message": m.dataset.message,
			"detail": m.dataset.detail
		};
}

function clearLocationHash() {
	window.history.replaceState(window.history.state, "", window.location.pathname + window.location.search);
}

function renderTemplate(templateId, data) {
	const elTmplContent = $.id(templateId).content.cloneNode(true);
	
	const walker = document.createTreeWalker(
		elTmplContent,
		NodeFilter.SHOW_ELEMENT | NodeFilter.SHOW_TEXT,
		(node) => {
			if (node.nodeType === Node.ELEMENT_NODE) {
				for (const attr of node.attributes) {
					if (attr.value.includes("{{")) {
						return NodeFilter.FILTER_ACCEPT;
					}
				}
			} else {
				// Node.TEXT_NODE
				if (node.nodeValue.includes("{{")) {
					return NodeFilter.FILTER_ACCEPT;
				}
			}
			
			return NodeFilter.FILTER_SKIP;
		});
	
	let node;
	while (node = walker.nextNode()) {
		if (node.nodeType === Node.ELEMENT_NODE) {
			for (const attr of node.attributes) {
				attr.value = renderTemplateValue(attr.value, data);
			}
		} else {
			// Node.TEXT_NODE
			const v = renderTemplateValue(node.nodeValue, data);
			if (v instanceof Node) {
				node.parentNode.replaceChild(v, node);
			} else {
				node.nodeValue = v;
			}
		}
	}
	
	return elTmplContent;
}

function renderTemplateValue(tmpl, data) {
	if (!tmpl.includes("{{")) {
		return tmpl;
	}
	
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
			buf = appendTemplateValue(buf, pv);
		}
		
		if (type === "#") {
			currentName = name;
			skip = !data[name];
		 } else if (type === "^") {
			currentName = name;
			skip = data[name];
		} else if (type === "/") {
			if (name !== currentName) {
				throw new Error("Wrong close mustache {{/" + name + "}}");
			}
			currentName = "";
			skip = false;
		} else if (type === "") {
			if (!skip) {
				const v = data[name];
				buf = appendTemplateValue(buf, v);
			}
		} else {
			throw new Error("Unsupported type {{" + type + "}}");
		}
		
		if (!skip) {
			buf = appendTemplateValue(buf, sv);
		}
	}
	
	return buf;
}

function appendTemplateValue(buf, value) {
	if (value === undefined || value === null || value === "") {
		return buf;
	}
	
	if (value instanceof Node && typeof buf === "string") {
		// Change the buffer type to DocumentFragment node
		const f = document.createDocumentFragment();
		if (buf.length) {
			f.append(buf);
		}
		buf = f;
	}
	
	if (buf instanceof Node) {
		buf.append(value);
	} else {
		// string
		buf += value;
	}
	
	return buf;
}

})(window, document);
