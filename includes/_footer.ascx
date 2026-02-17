<footer class="footer-section">
    <!-- Footer Panes: 4-Column Grid -->
    <div class="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4">

            <!-- Footer Pane 1 -->
            <div class="dnn-pane" id="FooterPane1" runat="server">
            </div>

            <!-- Footer Pane 2 -->
            <div class="dnn-pane" id="FooterPane2" runat="server">
            </div>

            <!-- Footer Pane 3 -->
            <div class="dnn-pane" id="FooterPane3" runat="server">
            </div>

            <!-- Footer Pane 4 -->
            <div class="dnn-pane" id="FooterPane4" runat="server">
            </div>
        </div>
    </div>

    <!-- Footer Bottom Bar -->
    <div class="border-t border-gray-700/50">
        <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
            <div class="flex flex-col items-center justify-between gap-4 sm:flex-row">

                <!-- Copyright -->
                <div class="text-gray-400 text-sm">
                    <dnn:COPYRIGHT runat="server" id="dnnCopyright" CssClass="inline" />
                </div>

                <!-- Links & Controls -->
                <div class="flex flex-wrap items-center justify-center gap-4 text-sm">
                    <dnn:PRIVACY runat="server" id="dnnPrivacy" CssClass="text-gray-400 hover:text-white transition-colors" />
                    <span class="text-gray-600">·</span>
                    <dnn:TERMS runat="server" id="dnnTerms" CssClass="text-gray-400 hover:text-white transition-colors" />
                    <span class="text-gray-600">·</span>
                    <dnn:LANGUAGE runat="server" id="dnnLanguage" CssClass="text-gray-400 hover:text-white transition-colors" ShowLinks="True" ShowMenu="False" />
                </div>
            </div>
        </div>
    </div>
</footer>
