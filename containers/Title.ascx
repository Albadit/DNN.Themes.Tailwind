<%@ Control AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<div class="dnn-module">
    <h2 class="dnn-module-title"><dnn:TITLE runat="server" id="dnnTITLE" CssClass="" /></h2>
    <div class="dnn-module-content" id="ContentPane" runat="server"></div>
</div>
