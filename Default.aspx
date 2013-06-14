<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ArcGisJSWithAjaxControlToolkit._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<link href="Styles/Default.css" rel="stylesheet" />
	<script src="Scripts/Default.js"></script>
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
									<p>This is just a placeholder.  Click on another tab.</p>
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
