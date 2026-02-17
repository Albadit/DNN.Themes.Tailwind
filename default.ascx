<!--#include file="includes/_registers.ascx" -->
<!--#include file="includes/_includes.ascx" -->

<!-- Header/NavBar -->
<!--#include file="includes/_header.ascx" -->

<!-- Main Content -->
<main>
	<div class="flex">
		<div id="ContentPane" class="w-full prose text-center max-w-none" runat="server"></div>
	</div>

	<div class="flex flex-col items-center justify-center px-8 mx-auto mt-16 space-y-0 md:max-w-6xl md:space-x-6 md:flex-row">
		<div id="DoublePaneOneOne" class="w-full prose max-w-none md:w-6/12" runat="server"></div>
		<div id="DoublePaneOneTwo" class="w-full prose bg-gray-300 max-w-none md:w-6/12" runat="server"></div>
	</div>

	<div class="bg-tertiary">
		<div class="flex flex-col items-center justify-center px-8 mx-auto mt-16 space-y-0 md:max-w-6xl md:space-x-6 md:flex-row">
			<div id="FullWidthBGDoublePaneOne" class="w-full prose max-w-none md:w-6/12" runat="server"></div>
			<div id="FullWidthBGDoublePaneTwo" class="w-full prose max-w-none md:w-6/12" runat="server"></div>
		</div>
	</div>

	<div class="flex justify-center max-w-3xl px-8 mx-auto mt-16">
		<div id="SinglePaneOne" class="w-full prose text-center max-w-none" runat="server"></div>
	</div>
</main>

<!-- Footer -->
<!--#include file="includes/_footer.ascx" -->
