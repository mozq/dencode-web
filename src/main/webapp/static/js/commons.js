"use strict";

class Commons {
	constructor(windowObject, documentObject) {
		this._window = windowObject;
		this._document = documentObject;
	}
	
	id(id) {
		return this._document.getElementById(id);
	}
	
	one(selector) {
		return this._document.querySelector(selector);
	}
	
	all(selector) {
		return [...this._document.querySelectorAll(selector)];
	}
	
	onReady(listener) {
		if (this._document.readyState === "loading") {
			this._document.addEventListener("DOMContentLoaded", listener);
		} else {
			listener();
		}
	}

	on(target, type, listener, options) {
		if (target === null) {
			return null;
		}
		
		let elements = target;
		let listenerFn = listener;
		if (typeof elements === "string") {
			const selector = elements;
			
			elements = [this._document];
			listenerFn = function (event) {
				const elTarget = event.target.closest(selector);
				if (elTarget) {
					return listener.apply(elTarget, arguments);
				}
				return true;
			};
		} else if (!elements.forEach) {
			elements = [elements];
		}
		
		const types = type.split(/\s+/);
		
		elements.forEach((el) => {
			types.forEach((t) => {
				el.addEventListener(t, listenerFn, options);
			})
		});
		
		return listenerFn;
	}
	
	off(target, type, listener, options) {
		if (target === null) {
			return;
		}
		
		let elements = target;
		if (typeof elements === "string") {
			elements = [this._document];
		} else if (!elements.forEach) {
			elements = [elements];
		}
		
		const types = type.split(/\s+/);
		
		elements.forEach((el) => {
			types.forEach((t) => {
				el.removeEventListener(t, listener, options);
			})
		});
	}
}
