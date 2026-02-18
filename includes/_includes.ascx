<dnn:META ID="mobileScale" runat="server" Name="viewport" Content="width=device-width, initial-scale=1.0" />
<dnn:DnnCssExclude runat="server" Name="dnndefault" />

<!-- Tailwind CSS Browser Runtime: compiles Tailwind classes in the browser from the <style> block below -->
<dnn:DnnJsInclude runat="server" FilePath="src/js/tailwind4.js" Priority="5" PathNameAlias="SkinPath" ForceProvider="DnnFormBottomProvider" />

<!-- Tailwind theme config for browser runtime to process -->
<!--#include file="css/_theme.html" -->
<!--#include file="css/_global.html" -->
<!--#include file="css/_dnn.html" -->
<!--#include file="css/_dnnUI.html" -->
