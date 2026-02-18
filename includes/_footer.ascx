<footer class="footer-section">
    <!-- Accent Bar -->
    <div class="h-1 bg-gradient-to-r from-slate-600 to-cyan-700"></div>

    <!-- Footer Content -->
    <div class="mx-auto max-w-7xl px-4 py-10 sm:px-6 lg:px-8">
        <div class="flex flex-col gap-8 lg:flex-row lg:items-start lg:justify-between">

            <!-- Left: Nav Links -->
            <div>
                <nav class="mb-6">
                    <dnn:MENU runat="server" id="dnnMENU_Footer" MenuStyle="menus/FooterMenu" NodeSelector="*,0,1" />
                </nav>

                <!-- Terms / Privacy -->
                <div class="flex flex-wrap items-center gap-2 text-sm text-white/70">
                    <dnn:TERMS runat="server" id="dnnTerms" CssClass="text-cyan-400 hover:text-white transition-colors" />
                    <span class="text-white/30">|</span>
                    <dnn:PRIVACY runat="server" id="dnnPrivacy" CssClass="text-cyan-400 hover:text-white transition-colors" />
                </div>

                <!-- Copyright -->
                <div class="mt-2 text-sm text-white/70">
                    <dnn:COPYRIGHT runat="server" id="dnnCopyright" CssClass="inline" />
                </div>
            </div>

            <!-- Right: Logo watermark -->
            <div class="hidden lg:block">
                <dnn:LOGO runat="server" id="dnnLOGO_Footer" CssClass="h-32 w-auto opacity-30" />
            </div>
        </div>
    </div>
</footer>
