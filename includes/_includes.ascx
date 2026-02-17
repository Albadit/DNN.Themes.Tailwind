<dnn:META ID="mobileScale" runat="server" Name="viewport" Content="width=device-width, initial-scale=1.0" />
<dnn:DnnCssExclude runat="server" Name="dnndefault" />

<!-- Tailwind CSS Browser Runtime: compiles Tailwind classes in the browser from the <style> block below -->
<dnn:DnnJsInclude runat="server" FilePath="src/js/tailwind4.js" Priority="5" PathNameAlias="SkinPath" ForceProvider="DnnFormBottomProvider" />

<!-- Pre-compiled CSS fallback (covers all classes found at build time) -->
<dnn:DnnCssInclude runat="server" FilePath="src/css/styles.min.css" Priority="100" PathNameAlias="SkinPath" />

<!-- Tailwind theme config for browser runtime to process -->
<link rel="stylesheet" type="text/tailwindcss" href="<%= SkinPath %>src/css/browser-config.css" />
