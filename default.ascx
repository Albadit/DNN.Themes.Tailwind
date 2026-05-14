<!--#include file="partials/_registers.ascx" -->
<!--#include file="partials/_includes.ascx" -->

<!-- Header -->
<dnn:MENU runat="server" id="dnnMENU" MenuStyle="menus/header" NodeSelector="*,0,2" />

<!-- Main Content -->
<main class="flex-1">
  <div id="BannerPane" runat="server"></div>
  <div id="ContentPane" class="mx-auto max-w-7xl px-8 w-full" runat="server"></div> 
  <div id="FluidPane" runat="server"></div>
</main>

<!-- Footer -->
<dnn:MENU runat="server" id="dnnMENU_Footer" MenuStyle="menus/footer" NodeSelector="*,0,1" />