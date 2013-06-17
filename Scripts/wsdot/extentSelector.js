/*global define, require, Proj4js*/
/*jslint browser:true*/

/** @file Creates a map from which a user can select an extent.
*/

/**
* @external Element
* @see {@link https://developer.mozilla.org/en-US/docs/Web/API/element Element}
*/

/**
 * The built in string object.
 * @external String
 * @see {@link https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/String String}
 */

/**
* The ArcGIS JavaScript API Map object.
* @external Map
* @see {@link http://help.arcgis.com/en/webapi/javascript/arcgis/jsapi/map-amd.html  Map}
*/

/**
* @external Extent
* @see {@link http://help.arcgis.com/en/webapi/javascript/arcgis/jsapi/extent-amd.html Extent}
*/

/**
* @external GraphicsLayer
* @see {@link http://help.arcgis.com/en/webapi/javascript/arcgis/jsapi/graphicslayer-amd.html GraphicsLayer}
*/

define(["dojo/Evented",
	"dojo/_base/declare",
	"dojo/on",
	"esri/map",
	"esri/graphic",
	"esri/geometry/Extent",
	"esri/toolbars/draw",
	"dojo/_base/connect",
	"dojo/dom-construct",
	"dojo/dom-class",
	"esri/layers/GraphicsLayer",
	"esri/renderers/SimpleRenderer",
	"esri/symbols/SimpleFillSymbol",
	"esri/symbols/SimpleLineSymbol",
	"dojo/_base/Color",
	"dijit/Dialog",
	"dojo/domReady!",
	"//cdnjs.cloudflare.com/ajax/libs/proj4js/1.1.0/proj4js-compressed.js"
], /** 
* @exports wsdot/extentSelector 
*/
function (Evented, declare, on, Map, Graphic, Extent, Draw, connect, domConstruct, domClass,
	GraphicsLayer, SimpleRenderer, SimpleFillSymbol, SimpleLineSymbol, Color, Dialog) {
	"use strict";

	var mapProj, stateProj;

	// Define the state plane projection.
	Proj4js.defs["EPSG:2927"] = "+proj=lcc +lat_1=47.33333333333334 +lat_2=45.83333333333334 +lat_0=45.33333333333334 +lon_0=-120.5 +x_0=500000.0001016001 +y_0=0 +ellps=GRS80 +to_meter=0.3048006096012192 +no_defs";

	// Create variables for map and state plane projections.
	mapProj = new Proj4js.Proj("GOOGLE");
	stateProj = new Proj4js.Proj("EPSG:2927");

	/** Creates a projected version of an extent. If the extent is in state plane than the
	returned extent will be in the map's projection and vice-versa.
	@param {external:Extent} extent
	@returns {external:Extent} A projected copy of the input extent.
	*/
	function projectExtent(extent) {
		var minPt, maxPt, sourcePrj, destPrj;
		// Determine source and destination projections.
		sourcePrj = extent.spatialReference.wkid === 2927 ? stateProj : mapProj;
		destPrj = sourcePrj === mapProj ? stateProj : mapProj;
		// Extract points from extent.
		minPt = new Proj4js.Point(extent.xmin, extent.ymin);
		maxPt = new Proj4js.Point(extent.xmax, extent.ymax);
		// Project the points.
		Proj4js.transform(sourcePrj, destPrj, minPt);
		Proj4js.transform(sourcePrj, destPrj, maxPt);
		// Create the output extent.
		return new Extent({
			xmin: minPt.x,
			ymin: minPt.y,
			xmax: maxPt.x,
			ymax: maxPt.y,
			spatialReference: {
				wkid: destPrj === stateProj ? 2927 : 3857
			}
		});

	}



	return declare([Evented], /** @lends extentSelector */ {


		/** 
		@instance
		@type {external:Map} 
		*/
		map: null,
		/** 
		@type {external:GraphicsLayer}
		@instance
		*/
		graphicsLayer: null,
		/** Gets the currently selected extent in the map.
		@param {Boolean} [useMapProjection] Set to true to return the extent in the original map projection, false to return in state plane. Defaults to false.
		@instance
		@returns {external:Extent} The first (and only) extent graphic shown on the map. The spatial reference will match that of the map. Will return null if no graphics are currently in the map.
		*/
		getSelectedExtent: function (useMapProjection) {
			var self = this, extent = null;
			if (self.graphicsLayer) {
				if (self.graphicsLayer.graphics.length) {
					extent = self.graphicsLayer.graphics[0].geometry;
				}
			}
			if (extent && !useMapProjection) {
				extent = projectExtent(extent);
			}
			return extent;
		},
		/** 
		* Adds an extent graphic to the map, replacing any existing graphics.
		* @param {external:Extent} extent
		* @instance
		* @returns {extentSelector} Returns the caller, allowing for chaining.
		*/
		setExtent: function (extent) {
			if (this.graphicsLayer) {
				this.graphicsLayer.clear();
				// Project the extent if it is in state plane.
				if (extent.spatialReference && extent.spatialReference.wkid === 2927) {
					extent = projectExtent(extent);
				}
				this.graphicsLayer.add(new Graphic(extent));
			}
			return this;
		},
		_dialog: null,
		_createDialog: function () {
			var docFragment = document.createDocumentFragment(), props = ["xmin", "ymin", "xmax", "ymax"], node, div;
			for (var i = 0; i < props.length; i++) {
				div = document.createElement("div");

				node = document.createElement("label");
				node.textContent = props[i];
				div.appendChild(node);

				node = document.createElement("input");
				node.setAttribute("type", "number");
				node.setAttribute("data-property", props[i]);
				div.appendChild(node);

				docFragment.appendChild(div);
			}
			div = document.createElement("div");
			domClass.add(div, "table");

			div.appendChild(docFragment);

			return new Dialog({
				title: "Enter Cooridnates",
				content: div
			});
		},
		showDialog: function () {
			var self = this;
			if (!self._dialog) {

				self._dialog = self._createDialog();
			}
			self._dialog.show();
		},
		/**
		* @param {external:Element|external:String} mapDiv The element where the extentSelector will be created, or its id.
		* @param {Object} options
		* @param {external:Extent} options.initExtent The initial extent the map will be zoomed to.
		* @constructs
		*/
		constructor: function (mapDiv, options) {
			var self = this;

			/**
			 * extent-change event
			 * @event extentSelector#extent-change
			 * @type {Event}
			 * @property {external:Extent} geometry Geometry of the shape that was drawn. Coordinates of this geometry have the same spatial reference of the map. 
			 * @property {external:Extent} geographicGeometry Geometry of the drawn shape in geographic coordinates (latitude, longitude). Only available when the map's spatial reference is Web Mercator or Geographic (4326). 
			 * @see {@link http://help.arcgis.com/en/webapi/javascript/arcgis/jsapi/draw-amd.html#ondrawcomplete Draw.onDrawComplete}
			 */

			/** Creates the draw toolbar controls for the map.
			@param {DOMElement} mapRoot The element into which the toolbar div will be placed.
			@private
			*/
			function createToolbarControls(mapRoot) {
				var docFrag, draw, toolbar, drawButton, clearButton, dialogButton;
				// Create the draw toolbar.
				draw = new Draw(self.map);
				// Setup the draw-complete event.
				// The Draw toolbar does not yet support dojo/on.  Must use legacy dojo/_base/connect instead.
				connect.connect(draw, "onDrawComplete", function (event) {
					if (event.geometry) {
						self.graphicsLayer.clear();
						self.graphicsLayer.add(new Graphic(event.geometry));
					}
					draw.deactivate();
					drawButton.textContent = "Draw";
					event.stateGeometry = event.geometry ? projectExtent(event.geometry) : null;
					self.emit("extent-change", event);
				});

				// Create the toolbar div and its buttons...
				docFrag = document.createDocumentFragment();
				toolbar = document.createElement("div");
				//// Doesn't work in IE 8
				//toolbar.classList.add("map-toolbar");
				domClass.add(toolbar, "map-toolbar");
				docFrag.appendChild(toolbar);

				drawButton = domConstruct.toDom("<button id='drawButton' type='button'>Draw</button>");
				toolbar.appendChild(drawButton);

				clearButton = domConstruct.toDom("<button id='clearButton' type='button'>Clear</button>");
				toolbar.appendChild(clearButton);

				dialogButton = domConstruct.toDom("<button id='dialogButton' type='button'>Manual Entry</button>");
				toolbar.appendChild(dialogButton);

				// Add the toolbar to the document.
				mapRoot.appendChild(toolbar);

				// Setup the button click events.
				on(drawButton, "click", function () {
					if (this.textContent === "Draw") {
						draw.activate(Draw.EXTENT, null);
						this.textContent = "Cancel";
					} else {
						draw.deactivate();
						this.textContent = "Draw";
					}
				});

				on(clearButton, "click", function () {
					self.graphicsLayer.clear();
					self.emit("extent-change", null);
				});

				on(dialogButton, "click", function () {
					self.showDialog();
				});
			}

			if (typeof (mapDiv) === "string") {
				mapDiv = document.getElementById(mapDiv);
			}

			//if (!mapDiv instanceof Element) {
			//	throw new TypeError("mapDiv must be either an Element or the id of an Element.");
			//}

			self.map = new Map(mapDiv, {
				basemap: "streets",
				center: [-120.80566406246835, 47.41322033015946],
				zoom: 7
			});




			on(self.map, "load", function () {
				var renderer, symbol;

				createToolbarControls(self.map.root);

				symbol = new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID,
					new SimpleLineSymbol(SimpleLineSymbol.STYLE_DASHDOT,
					new Color([255, 0, 0]), 2), new Color([255, 255, 0, 0.25])
					);

				self.graphicsLayer = new GraphicsLayer({ id: "graphics" });
				renderer = new SimpleRenderer(symbol);
				self.graphicsLayer.setRenderer(renderer);
				self.map.addLayer(self.graphicsLayer);
				if (options && options.initExtent) {
					self.setExtent(options.initExtent);
					self.map.setExtent(self.getSelectedExtent(true), true);
				}
			});
		}
	});

});