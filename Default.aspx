<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ArcGisJSWithAjaxControlToolkit._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<link rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/js/esri/css/esri.css">
	<script data-dojo-config="{async: true}"></script>
	<script src="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/"></script>
	<style>
		.accordion .header, .accordion .selected-header {
			padding: 0.2em 0.5em;
		}
		.accordion .header {
			border: 1px solid black;
			background-color: #a79191;
		}
		.accordion .selected-header {
			border: 1px solid black;
			background-color: yellow;
		}
		#map {
			width: 100%;
			height: 100%;
		}
	</style>
</head>
<body>
	<form id="form1" runat="server">
		<ajaxToolkit:ToolkitScriptManager runat="server" CombineScripts="true"></ajaxToolkit:ToolkitScriptManager>
		<ajaxToolkit:Accordion ID="Accordion1" runat="server" CssClass="accordion" 
			HeaderCssClass="header" HeaderSelectedCssClass="selected-header" ContentCssClass="content">
			<Panes>
				<ajaxToolkit:AccordionPane runat="server" ID="PlaceholderPane">
					<Header>Placeholder</Header>
					<Content>Go to the map pane</Content>
				</ajaxToolkit:AccordionPane>
				<ajaxToolkit:AccordionPane runat="server" ID="MapPane">
					<Header>Map</Header>
					<Content>
						<ajaxToolkit:TabContainer ID="TabContainer1" runat="server">
							<ajaxToolkit:TabPanel ID="PlaceholderTabPanel" HeaderText="Other Tab" runat="server">
								<ContentTemplate>
									<p>This is just a placeholder.  Click on the "Map" tab.</p>
								</ContentTemplate>
							</ajaxToolkit:TabPanel>
							<ajaxToolkit:TabPanel ID="MapTabPanel" HeaderText="Map" runat="server">
								<ContentTemplate>
									<div id="map"></div>
								</ContentTemplate>
							</ajaxToolkit:TabPanel>
						</ajaxToolkit:TabContainer>
					</Content>
				</ajaxToolkit:AccordionPane>
			</Panes>
		</ajaxToolkit:Accordion>

	</form>
	<script>
		/*global require*/
		/*jslint browser:true*/
		require(["esri/map", "dojo/ready", "dojo/domReady!"], function (Map, ready) {
			"use strict";
			ready(function () {
				var map;
				map = new Map(document.getElementById("map"), {
					basemap: "topo",
					center: [-120.80566406246835, 47.41322033015946],
					zoom: 6
				});
			});
		});
	</script>
</body>
</html>
