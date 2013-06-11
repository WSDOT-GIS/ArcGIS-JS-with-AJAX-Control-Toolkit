Sample: Issue with ArcGIS JavaScript API Map and Ajax Control Toolkit
=====================================================================

## Problem ##

When placing an [ArcGIS API for JavaScript] map inside of an [AJAX Control Toolkit] TabPanel, graphics drawn on the map are offset from where they should be.

![Offset screenshot](offset.png)

## Workaround ##

Placing the map into an `iframe` element seems to solve these issues.

## Remaining Issues ##

### Cannot Shift + Draw box to zoom in IE 10 ###

In all of the other tested browsers, the user is still able to zoom in by holding down shift and drawing a box.  This does not work in IE 10, though (unless IE 10 is set to an earlier version of the browser through the debugging tools).

The user can still zoom using the mouse wheel, so this is a slight inconvenience, but not a show stopper.

## Notes ##

* The map `iframe`'s size will be 400 px x 400 px if certain conditions are not met.
	* The `iframe` cannot be given an `id` attribute.
	* The `iframe` must be created after the containing tab panel has been activated (i.e., in the tab panel's `OnClientClick` event handler). 


[ArcGIS API for JavaScript]:http://help.arcgis.com/en/webapi/javascript/arcgis/
[AJAX Control Toolkit]:http://www.ajaxcontroltoolkit.com/
[Map]:http://help.arcgis.com/en/webapi/javascript/arcgis/jsapi/map.html
