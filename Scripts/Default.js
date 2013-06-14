/*jslint white:true,browser:true,nomen:true */
(function () {
	"use strict";
	var extentSelectorFrame, mapStuff;

	// Create a global variable to act as a namespace for the global variables we need for this page.
	if (!window.mapStuff) {
		window.mapStuff = {};
	}

	/** Creates the map iframe if it does not already exist.
	@param {Sys.Extended.UI.TabPanel} tabPanel The tab panel that was just activated.
	@param {HTMLDivElement} tabPanel._element This is the div element of the tab panel.
	@param {EventArgs} e
	*/
	function onExtentSelectorTabClick(tabPanel, e) {
		var handleExtentChange;
		if (!extentSelectorFrame) {
			extentSelectorFrame = document.createElement("iframe");
			extentSelectorFrame.src = "extentSelector.html";
			if (location.hash.length > 1) {
				extentSelectorFrame.setAttribute("data-extent", location.hash.substring(1, location.hash.length - 1));
			}
			extentSelectorFrame.name = "extentSelector";
			tabPanel._element.appendChild(extentSelectorFrame);

			// Setup the event handler for the extent change.
			handleExtentChange = function (event) {
				var geom;
				// Get the state plane geometry.
				if (event && event.data !== undefined) {
					if (event.data != null) {
						geom = event.data.stateGeometry;
					}
				}

				// Set the hash to the geometry if available.
				location.hash = geom ? [geom.xmin, geom.ymin, geom.xmax, geom.ymax].join(",") : "";
			};

			// Setup event listeners for messages from child iframe window.
			// Modern browsers use addEventListener, but not all browsers do.
			if (window.addEventListener) {
				window.addEventListener("message", handleExtentChange, false);
			} else if (window.attachEvent) {
				window.attachEvent("onmessage", handleExtentChange);
			} else if (window.onmessage) {
				window.onmessage = handleExtentChange;
			}
		}
	}

	// Make the onTabClick function globally available in the page.
	window.mapStuff.onExtentSelectorTabClick = onExtentSelectorTabClick;
}());