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
		.accordion .content {
			border: 2px inset lightgray;
			padding: 1em;
		}
		.accordion .selected-header {
			border: 1px solid black;
			background-color: yellow;
		}
		/* Specify the size of the iframe here */
		iframe[src='Map.html'], iframe[src='extentSelector.html'] {
			width: 100%;
			height: 600px; /* Height must be an explicit value. */
		}
	</style>
	<script>
		/*jslint white:true,browser:true,nomen:true */
		(function () {
			"use strict";
			var mapFrame, extentSelectorFrame, mapStuff;

			// Create a global variable to act as a namespace for the global variables we need for this page.
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
					mapFrame.name = "Map";
					tabPanel._element.appendChild(mapFrame);
				}
			}

			/** Creates the map iframe if it does not already exist.
			@param {Sys.Extended.UI.TabPanel} tabPanel The tab panel that was just activated.
			@param {HTMLDivElement} tabPanel._element This is the div element of the tab panel.
			@param {EventArgs} e
			*/
			function onExtentSelectorTabClick(tabPanel, e) {
				var extentSelector, handleExtentChange;
				if (!extentSelectorFrame) {
					extentSelectorFrame = document.createElement("iframe");
					extentSelectorFrame.src = "extentSelector.html";
					extentSelectorFrame.name = "extentSelector";
					tabPanel._element.appendChild(extentSelectorFrame);

					handleExtentChange = function (e) {
						if (console) {
							console.log(e);
						}
					};

					if (extentSelectorFrame.addEventListener) {
						extentSelectorFrame.addEventListener("extentchange", handleExtentChange);
					} else if (extentSelectorFrame.attachEvent) {
						extentSelectorFrame.attachEvent("onextentchange", handleExtentChange);
					}
				}
			}

			// Make the onTabClick function globally available in the page.
			window.mapStuff.onTabClick = onTabClick;
			window.mapStuff.onExtentSelectorTabClick = onExtentSelectorTabClick;
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
									<p>This is just a placeholder.  Click on one of the other tabs.</p>
								</ContentTemplate>
							</ajaxToolkit:TabPanel>
							<ajaxToolkit:TabPanel ID="MapTabPanel" HeaderText="Map" runat="server" OnClientClick="mapStuff.onTabClick">
								<ContentTemplate>
									<%-- If the iframe needs to be created in the OnClientClick event to 
										prevent the map from being forced to be 400 x 400 pixels. --%>
								</ContentTemplate>
							</ajaxToolkit:TabPanel>
							<ajaxToolkit:TabPanel ID="ExtentSelectorTabPanel" HeaderText="ExtentSelector" runat="server" OnClientClick="mapStuff.onExtentSelectorTabClick">
								<ContentTemplate>

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
