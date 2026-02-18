<header class="sticky top-0 z-50">
    <!-- Top Bar: User/Login -->
    <div class="bg-slate-800 text-white">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div class="flex h-10 items-center justify-end gap-4 text-sm">
                <dnn:LOGIN runat="server" id="dnnLogin" CssClass="text-white hover:text-cyan-300 transition-colors font-medium" />
                <dnn:USER runat="server" id="dnnUser" CssClass="text-cyan-300 hover:text-white transition-colors" />
            </div>
        </div>
    </div>

    <!-- Main Header: Logo + Nav -->
    <div class="bg-gradient-to-r from-slate-600 to-cyan-700">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div class="flex h-20 items-center justify-between">

                <!-- Logo -->
                <div class="flex shrink-0 items-center">
                    <dnn:LOGO runat="server" id="dnnLOGO" CssClass="h-12 w-auto" />
                </div>

                <!-- Desktop Navigation -->
                <nav class="hidden lg:flex lg:items-center lg:gap-2" aria-label="Main Navigation">
                    <dnn:MENU runat="server" id="dnnMENU" MenuStyle="menus/MainMenu" NodeSelector="*,0,2" />
                </nav>

                <!-- Mobile Menu Button -->
                <button type="button"
                        class="inline-flex items-center justify-center rounded-md p-2 text-white/80 hover:bg-white/10 hover:text-white focus:outline-none focus:ring-2 focus:ring-white/50 lg:hidden"
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
    <div id="mobile-menu" class="hidden bg-slate-700 lg:hidden">
        <div class="mx-auto max-w-7xl space-y-1 px-4 pb-4 pt-2">
            <dnn:MENU runat="server" id="dnnMENU_Mobile" MenuStyle="menus/MainMenu" NodeSelector="*,0,2" />
        </div>
        <div class="border-t border-white/10 px-4 py-3">
            <div class="flex items-center gap-3 text-sm">
                <dnn:USER runat="server" id="dnnUser_Mobile" CssClass="text-white/70" />
                <dnn:LOGIN runat="server" id="dnnLogin_Mobile" CssClass="text-cyan-300 text-xs font-medium" />
            </div>
        </div>
    </div>
</header>
