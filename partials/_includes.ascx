<dnn:META ID="mobileScale" runat="server" Name="viewport" Content="width=device-width, initial-scale=1.0" />
<dnn:DnnCssExclude runat="server" Name="dnndefault" />

<!-- Google Fonts: Inter -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet" />

<!-- DNN  default skin CSS -->
<dnn:DnnCssInclude runat="server" FilePath="src/css/default.css" Priority="2" PathNameAlias="SkinPath" />

<!-- Tailwind CSS Browser Runtime: compiles Tailwind classes in the browser from the <style> block below -->
<dnn:DnnJsInclude runat="server" FilePath="src/js/tailwind4.js" Priority="5" PathNameAlias="SkinPath" ForceProvider="DnnFormBottomProvider" />

<!-- Tailwind theme config for browser runtime to process -->
<!--#include file="../css/_theme.html" -->
<!--#include file="../css/_global.html" -->
<!--#include file="../css/_dnn.html" -->


