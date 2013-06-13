Sample: Issue with ArcGIS JavaScript API Map and Ajax Control Toolkit
=====================================================================

## Problem ##

When placing an [ArcGIS API for JavaScript] map inside of an [AJAX Control Toolkit] TabPanel, graphics drawn on the map are offset from where they should be.

![Offset screenshot](offset.png)

## Workaround ##

Placing the map into an `iframe` element seems to solve these issues.

## Remaining Issues ##

See the [issues list on GitHub].

## Notes ##

* The map `iframe`'s size will be 400 px x 400 px if certain conditions are not met.
	* The `iframe` cannot be given an `id` attribute.
	* The `iframe` must be created after the containing tab panel has been activated (i.e., in the tab panel's `OnClientClick` event handler). 

* The best way to handle events from the `iframe` window in the parent window is to use [window.postMessage]. This seems to be the *only* way that will work with Internet Explorer 8.


[ArcGIS API for JavaScript]:http://help.arcgis.com/en/webapi/javascript/arcgis/
[AJAX Control Toolkit]:http://www.ajaxcontroltoolkit.com/
[issues list on GitHub]:https://github.com/WSDOT-GIS/ArcGIS-JS-with-AJAX-Control-Toolkit/issues
[Map]:http://help.arcgis.com/en/webapi/javascript/arcgis/jsapi/map.html
[window.postMessage]:https://developer.mozilla.org/en-US/docs/Web/API/window.postMessage