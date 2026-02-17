<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title></title>
    
    <!-- Tailwind CSS (Compiled) -->
    <link rel="stylesheet" type="text/css" href="<%=SkinPath%>dist/css/skin.css" />
    
    <!-- DNN Meta -->
    <dnn:DnnCssInclude runat="server" FilePath="dist/css/skin.css" PathNameAlias="SkinPath" />
</head>
<body class="bg-gray-50 text-gray-900 font-sans antialiased">
    
    <!-- Header -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo -->
                <div class="flex-shrink-0 flex items-center">
                    <dnn:LOGO runat="server" id="dnnLOGO" />
                </div>
                
                <!-- Navigation -->
                <nav class="hidden md:flex space-x-8">
                    <dnn:MENU runat="server" MenuStyle="MegaMenu" />
                </nav>
                
                <!-- Right Actions -->
                <div class="flex items-center space-x-4">
                    <dnn:SEARCH runat="server" id="dnnSEARCH" CssClass="hidden lg:block" />
                    <dnn:USER runat="server" id="dnnUSER" CssClass="text-sm font-medium text-gray-700 hover:text-primary" />
                    <dnn:LOGIN runat="server" id="dnnLOGIN" CssClass="text-sm font-medium text-primary hover:text-primary/80" />
                </div>
            </div>
        </div>
    </header>

    <!-- Breadcrumb -->
    <div class="bg-gray-100 border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3">
            <dnn:BREADCRUMB runat="server" id="dnnBREADCRUMB" CssClass="text-sm text-gray-500" />
        </div>
    </div>

    <!-- Hero Section (Optional Pane) -->
    <div id="HeroPane" runat="server" class="bg-gradient-to-r from-primary to-accent text-white py-20" containertype="G" containername="Hero" containersrc="hero.ascx">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="dnn-pane"></div>
        </div>
    </div>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            
            <!-- Left Sidebar -->
            <aside class="lg:col-span-3 hidden lg:block">
                <div id="LeftPane" runat="server" class="dnn-pane space-y-6" containertype="G" containername="Default" containersrc="default.ascx"></div>
            </aside>

            <!-- Content Area -->
            <div class="lg:col-span-6">
                <div id="ContentPane" runat="server" class="dnn-pane" containertype="G" containername="Default" containersrc="default.ascx"></div>
            </div>

            <!-- Right Sidebar -->
            <aside class="lg:col-span-3">
                <div id="RightPane" runat="server" class="dnn-pane space-y-6" containertype="G" containername="Default" containersrc="default.ascx"></div>
            </aside>
        </div>

        <!-- Full Width Bottom -->
        <div class="mt-12">
            <div id="BottomPane" runat="server" class="dnn-pane" containertype="G" containername="Default" containersrc="default.ascx"></div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-900 text-gray-300">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div id="FooterPane1" runat="server" class="dnn-pane" containertype="G" containername="Footer" containersrc="footer.ascx"></div>
                <div id="FooterPane2" runat="server" class="dnn-pane" containertype="G" containername="Footer" containersrc="footer.ascx"></div>
                <div id="FooterPane3" runat="server" class="dnn-pane" containertype="G" containername="Footer" containersrc="footer.ascx"></div>
                <div id="FooterPane4" runat="server" class="dnn-pane" containertype="G" containername="Footer" containersrc="footer.ascx"></div>
            </div>
            
            <div class="border-t border-gray-800 mt-8 pt-8 flex flex-col md:flex-row justify-between items-center">
                <div class="text-sm">
                    <dnn:COPYRIGHT runat="server" id="dnnCOPYRIGHT" />
                </div>
                <div class="flex space-x-6 mt-4 md:mt-0 text-sm">
                    <dnn:PRIVACY runat="server" id="dnnPRIVACY" CssClass="hover:text-white transition" />
                    <dnn:TERMS runat="server" id="dnnTERMS" CssClass="hover:text-white transition" />
                    <dnn:LANGUAGE runat="server" id="dnnLANGUAGE" />
                </div>
            </div>
        </div>
    </footer>

</body>
</html>