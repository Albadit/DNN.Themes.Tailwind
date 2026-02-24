<dnn:META ID="mobileScale" runat="server" Name="viewport" Content="width=device-width, initial-scale=1.0" />
<dnn:DnnCssExclude runat="server" Name="dnndefault" />

<!-- DNN  default skin CSS -->
<dnn:DnnCssInclude runat="server" FilePath="src/css/default.css" Priority="2" PathNameAlias="SkinPath" />

<!-- Tailwind CSS Browser Runtime: compiles Tailwind classes in the browser from the <style> block below -->
<dnn:DnnJsInclude runat="server" FilePath="src/js/tailwind4.js" Priority="100" PathNameAlias="SkinPath" ForceProvider="DnnFormBottomProvider" />
<dnn:DnnJsInclude runat="server" FilePath="src/js/lucide.min.js" Priority="100" PathNameAlias="SkinPath" ForceProvider="DnnFormBottomProvider" />

<!-- Initialize Lucide icons globally after the DOM is ready -->
<script>
  document.addEventListener('DOMContentLoaded', function() {
    if (window.lucide) lucide.createIcons();
  });
</script>

<!-- Tailwind theme config for browser runtime to process -->
<!--#include file="css/_theme.html" -->
<!--#include file="css/_global.html" -->
<!--#include file="css/_dnn.html" -->


