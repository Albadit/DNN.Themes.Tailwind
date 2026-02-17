<header class="sticky top-0 z-50 bg-white shadow-nav">
    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div class="flex h-16 items-center justify-between">

            <!-- Logo -->
            <div class="flex shrink-0 items-center">
                <dnn:LOGO runat="server" id="dnnLOGO" CssClass="h-8 w-auto" />
            </div>

            <!-- Desktop Navigation -->
            <nav class="hidden lg:flex lg:items-center lg:gap-1" aria-label="Main Navigation">
                <dnn:MENU runat="server" id="dnnMENU" MenuStyle="MegaMenu" NodeSelector="*,0,2" />
            </nav>

            <!-- Right Side Actions -->
            <div class="flex items-center gap-3">

                <!-- Search -->
                <div class="hidden sm:block">
                    <dnn:SEARCH runat="server" id="dnnSearch" CssClass="relative" ShowSite="false" ShowWeb="false" />
                </div>

                <!-- User Controls -->
                <div class="hidden items-center gap-2 text-sm md:flex">
                    <dnn:USER runat="server" id="dnnUser" CssClass="text-gray-600 hover:text-primary-600 transition-colors" />
                    <span class="text-gray-300">|</span>
                    <dnn:LOGIN runat="server" id="dnnLogin" CssClass="text-gray-600 hover:text-primary-600 transition-colors font-medium" />
                </div>

                <!-- Mobile Menu Button -->
                <button type="button"
                        class="inline-flex items-center justify-center rounded-md p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 lg:hidden"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                        onclick="document.getElementById('mobile-menu').classList.toggle('hidden');">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
                    </svg>
                </button>
            </div>
        </div>
    </div>

    <!-- Mobile Navigation Menu -->
    <div id="mobile-menu" class="hidden border-t border-gray-100 lg:hidden">
        <div class="mx-auto max-w-7xl space-y-1 px-4 pb-4 pt-2">
            <dnn:MENU runat="server" id="dnnMENU_Mobile" MenuStyle="MegaMenu" NodeSelector="*,0,2" />
        </div>
        <div class="border-t border-gray-100 px-4 py-3">
            <div class="flex items-center gap-3 text-sm">
                <dnn:USER runat="server" id="dnnUser_Mobile" CssClass="text-gray-600" />
                <dnn:LOGIN runat="server" id="dnnLogin_Mobile" CssClass="btn-primary text-xs" />
            </div>
        </div>
    </div>
</header>
