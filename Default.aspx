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
			var mapFrame, mapStuff;

			if (!window.mapStuff) {
				window.mapStuff = {};
			}

			/** Creates the map iframe if it does not already exist.
			@param {Sys.Extended.UI.TabPanel} tabPanel The tab panel that was just activated.
			@param {HTMLDivElement} tabPanel._element This is the div element of the tab panel.
			@param {EventArgs} e
			*/
			function onTabClick(tabPanel, e) {
				if (!mapFrame) {
					mapFrame = document.createElement("iframe");
					mapFrame.src = "Map.html";
					// Specify the desired size of the map iframe here.
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
					<Content>Nothing to see here.  Click on the <em>Map</em> pane header.</Content>
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
									<%-- If the iframe needs to be created in the OnClientClick event to 
										prevent the map from being forced to be 400 x 400 pixels. --%>
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
