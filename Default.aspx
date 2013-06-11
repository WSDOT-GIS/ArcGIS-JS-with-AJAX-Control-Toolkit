<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ArcGisJSWithAjaxControlToolkit._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
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
	</style>
	<script>
		(function () {
			"use strict";
			var mapFrame;

			if (!window.mapStuff) {
				window.mapStuff = {};
			}

			function onTabClick(/** {Sys.Extended.UI.TabPanel} */ tabPanel, /** {EventArgs} */ e) {
				var mapFrame;
				if (!mapFrame) {
					mapFrame = document.createElement("iframe");
					mapFrame.src = "Map.html";
					mapFrame.width = 800;
					mapFrame.height = 600;
					tabPanel._element.appendChild(mapFrame);
				}
			}

			window.mapStuff.onTabClick = onTabClick;
		}());
	</script>
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
							<ajaxToolkit:TabPanel ID="MapTabPanel" HeaderText="Map" runat="server" OnClientClick="mapStuff.onTabClick">
								<ContentTemplate>
									<%--<iframe id="mapFrame" src="Map.html" sandbox="allow-same-origin allow-scripts"></iframe>--%>
								</ContentTemplate>
							</ajaxToolkit:TabPanel>
						</ajaxToolkit:TabContainer>
					</Content>
				</ajaxToolkit:AccordionPane>
			</Panes>
		</ajaxToolkit:Accordion>

	</form>
</body>
</html>
