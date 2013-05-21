<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ArcGisJSWithAjaxControlToolkit._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<link rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/js/esri/css/esri.css">
	<script data-dojo-config="{async: true}"></script>
	<script src="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/"></script>
</head>
<body>
	<form id="form1" runat="server">
		<ajaxToolkit:ToolkitScriptManager runat="server"></ajaxToolkit:ToolkitScriptManager>
		<ajaxToolkit:TabContainer ID="TabContainer1" runat="server">
			<ajaxToolkit:TabPanel HeaderText="Other Tab" runat="server">
				<ContentTemplate><p>This is just a placeholder.  Click on the "Map" tab.</p></ContentTemplate>
			</ajaxToolkit:TabPanel>
			<ajaxToolkit:TabPanel HeaderText="Map" runat="server">
				<ContentTemplate>
					<div id="map"></div>
				</ContentTemplate>
			</ajaxToolkit:TabPanel>
		</ajaxToolkit:TabContainer>
	</form>
	<script>
		/*global require*/
		require(["esri/map", "dojo/ready"], function (Map, ready) {
			ready(function () {
				var map;
				map = new Map(document.getElementById("map"), {
					basemap: "topo",
					center: [-120.80566406246835, 47.41322033015946],
					zoom: 7,
				});
			});
		});
	</script>
</body>
</html>
