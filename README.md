# DNN.Themes.Tailwind

A modern, responsive skin (theme) for **DNN 10** built with **Tailwind CSS 4.2.0** and **Lucide Icons 0.575.0**. It features a clean design with mobile-first responsive layout, sticky navigation, hero sections, and custom containers â€” all styled using utility-first Tailwind classes compiled in the browser.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![DNN](https://img.shields.io/badge/DNN-10%2B-blue)
![Tailwind CSS](https://img.shields.io/badge/Tailwind%20CSS-4.2.0-38bdf8)
![Lucide](https://img.shields.io/badge/Lucide-0.575.0-f97316)

---

## Table of Contents

- [What Is This?](#what-is-this)
- [Requirements](#requirements)
- [Quick Start â€” Install in 3 Steps](#quick-start--install-in-3-steps)
- [VS Code Setup](#vs-code-setup)
- [Project Structure](#project-structure)
- [How the Skin Works](#how-the-skin-works)
  - [Layout (Content Panes)](#layout-content-panes)
  - [Header & Navigation](#header--navigation)
  - [Footer](#footer)
  - [Containers](#containers)
  - [Styling with Tailwind CSS](#styling-with-tailwind-css)
  - [CSS Files Explained](#css-files-explained)
  - [Menus](#menus)
- [Customization Guide](#customization-guide)
  - [Change Colors](#change-colors)
  - [Change Fonts](#change-fonts)
  - [Edit the Layout](#edit-the-layout)
  - [Add a New Content Pane](#add-a-new-content-pane)
  - [Create a New Container](#create-a-new-container)
- [Build the Install Package](#build-the-install-package)
- [Apply the Skin in DNN](#apply-the-skin-in-dnn)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## What Is This?

If you run a website on **DNN (DotNetNuke)**, a "skin" controls how your site looks â€” the header, footer, layout, colors, fonts, etc. **DNN.Themes.Tailwind** is a ready-to-use skin that gives your DNN site a modern look using Tailwind CSS.

**No build tools needed.** Tailwind CSS runs directly in the browser, so you just edit HTML/CSS files and see changes immediately.

---

## Requirements

| Requirement       | Version        |
| ----------------- | -------------- |
| DNN Platform      | 10.0.0 or later |
| Tailwind CSS      | 4.2.0 (browser build, bundled) |
| Lucide Icons      | 0.575.0 (bundled) |
| Browser           | Any modern browser (Chrome, Firefox, Edge, Safari) |
| Build (optional)  | PowerShell 5.1+ (Windows) â€” only needed to create the install package |

---

## Quick Start â€” Install in 3 Steps

### Step 1: Build the Package

Open PowerShell in the project folder and run:

```powershell
.\build.ps1
```

This creates an installable zip file at:

```
dist/DNN.Themes.Tailwind_1.0.0_Install.zip
```

### Step 2: Install in DNN

1. Log in to your DNN site as **Host** (Super Admin).
2. Go to **Settings â†’ Extensions** (or **Host â†’ Extensions** in older menus).
3. Click **Install Extension**.
4. Upload the `DNN.Themes.Tailwind_01.00.00_Install.zip` file.
5. Follow the wizard and click **Next** until installation is complete.

### Step 3: Apply the Skin

1. Go to **Settings â†’ Site Settings â†’ Appearance** (or **Admin â†’ Site Settings**).
2. Under **Site Skin**, select **DNN.Themes.Tailwind â€” default**.
3. Under **Site Container**, select **DNN.Themes.Tailwind â€” Title** or **DNN.Themes.Tailwind â€” None**.
4. Click **Save**.

Your site is now using DNN.Themes.Tailwind! ðŸŽ‰

---

## VS Code Setup

For the best development experience with **Tailwind CSS IntelliSense** (autocomplete, linting, hover previews) in DNN skin files, add the following to your VS Code **settings.json** (workspace or user settings):

```json
{
  "tailwindCSS.includeLanguages": {
    "aspnetcorerazor": "html",
    "razor": "html",
    "cshtml": "html",
    "html": "html",
    "xml": "html"
  },
  "tailwindCSS.emmetCompletions": true
}
```

**What each setting does:**

| Setting | Purpose |
| ------- | ------- |
| `tailwindCSS.includeLanguages` | Enables Tailwind IntelliSense in Razor/cshtml files by treating them as HTML. |
| `tailwindCSS.emmetCompletions` | Enables Emmet-style completions for Tailwind classes (e.g., typing `bg-` shows suggestions). |

> **Note:** You need the [Tailwind CSS IntelliSense](https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss) extension installed in VS Code for the `tailwindCSS.*` settings to work.

> **Tip:** If you're editing the skin directly inside your DNN installation folder, create a `.vscode/settings.json` file at the DNN site root with these settings for a workspace-level configuration.

---

## Project Structure

```
DNN.Themes.Tailwind/
â”œâ”€â”€ default.ascx              â† Main skin layout (the page template)
â”œâ”€â”€ manifest.dnn              â† DNN package manifest (defines what gets installed)
â”œâ”€â”€ build.ps1                 â† Build script to create the install zip
â”œâ”€â”€ skin.doctype.xml          â† Sets HTML5 doctype
â”œâ”€â”€ License.txt               â† MIT License
â”œâ”€â”€ ReleaseNotes.txt          â† Version history
â”‚
â”œâ”€â”€ .vscode/                  â† VS Code workspace settings
â”‚   â””â”€â”€ settings.json         â† Tailwind CSS IntelliSense configuration
â”‚
â”œâ”€â”€ containers/               â† Module containers (wrappers around modules)
â”‚   â”œâ”€â”€ Title.ascx            â† Container WITH a module title
â”‚   â””â”€â”€ None.ascx             â† Container WITHOUT a module title (bare pane)
â”‚
â”œâ”€â”€ css/                      â† Stylesheets
â”‚   â”œâ”€â”€ default.css           â† DNN default skin stylesheet (typography, forms, etc.)
â”‚   â”œâ”€â”€ dnn.css               â† DNN custom skin stylesheet (login, edit forms, dialogs)
â”‚   â””â”€â”€ tailwind.css          â† Tailwind theme config for VS Code IntelliSense (keep in sync with _styles.html)
â”‚
â”œâ”€â”€ js/                       â† JavaScript
â”‚   â”œâ”€â”€ tailwind4.js          â† Tailwind CSS 4.1 browser runtime (minified)
â”‚   â”œâ”€â”€ lucide.js             â† Lucide icons (full)
â”‚   â””â”€â”€ lucide.min.js         â† Lucide icons (minified)
â”‚
â”œâ”€â”€ partials/                 â† Reusable parts included in the skin
â”‚   â”œâ”€â”€ _registers.ascx       â† DNN control registrations (required)
â”‚   â”œâ”€â”€ _includes.ascx        â† CSS/JS includes, fonts, Tailwind + Lucide config
â”‚   â”œâ”€â”€ _header.ascx          â† Header with logo, navigation, mobile menu
â”‚   â”œâ”€â”€ _footer.ascx          â† Footer with links, terms, copyright
â”‚   â””â”€â”€ css/                  â† Tailwind CSS style blocks
â”‚       â””â”€â”€ _styles.html      â† Theme, base styles, global components, and UI library (single file)
â”‚
â””â”€â”€ menus/                    â† DDRMenu Razor templates (navigation rendering)
    â”œâ”€â”€ header/               â† Desktop navigation (dropdowns)
    â”‚   â”œâ”€â”€ HeaderMenu.cshtml
    â”‚   â””â”€â”€ menudef.xml
    â””â”€â”€ footer/               â† Footer navigation (flat links)
        â”œâ”€â”€ FooterMenu.cshtml
        â””â”€â”€ menudef.xml
```

---

## How the Skin Works

### Layout (Content Panes)

The main layout is defined in `default.ascx`. It contains **content panes** â€” these are areas where you drop DNN modules (like HTML content, forms, galleries, etc.).

Here are the available panes:

| Pane Name      | Description                                       |
| -------------- | ------------------------------------------------- |
| `BannerPane`   | Full-width area at the top, ideal for hero/banner  |
| `ContentPane`  | Full-width main content area                       |
| `FluidPane`    | Full-width area below content, for extra sections  |

**How to add content to a pane:**

1. In DNN, go to the page you want to edit.
2. Click **Edit Page** (pencil icon or Edit mode).
3. Click **Add Module** on a pane.
4. Choose a module (e.g., "HTML/Text") and place it in the desired pane.

### Header & Navigation

The header (`partials/_header.ascx`) includes:

- **Top bar** â€” Login/Register and user info links (dark background).
- **Main header** â€” Your site logo + desktop navigation with dropdowns.
- **Mobile menu** â€” A hamburger button that toggles the menu on small screens (no animation).

The header is **sticky** â€” it stays at the top of the page as you scroll.

### Footer

The footer (`partials/_footer.ascx`) includes:

- Footer navigation links.
- Terms of Use and Privacy Policy links.
- Copyright notice.
- A faded logo watermark (visible on large screens).

### Containers

Containers wrap around individual DNN modules. This skin comes with two:

| Container  | File           | Use When...                              |
| ---------- | -------------- | ---------------------------------------- |
| **Title**  | `Title.ascx`   | You want to show the module's title/heading |
| **None**   | `None.ascx`    | You want to hide the module's title (bare content pane) |

**To change a module's container:**

1. Edit the page.
2. Click the **gear icon** on the module.
3. Go to **Module Settings â†’ Page Settings**.
4. Under **Module Container**, select `DNN.Themes.Tailwind - Title` or `DNN.Themes.Tailwind - None`.
5. Click **Update**.

### Styling with Tailwind CSS

This skin uses **Tailwind CSS 4.2.0** running in the browser. That means:

- **No build step for CSS** â€” Tailwind compiles classes on-the-fly in the browser.
- You style elements by adding Tailwind utility classes directly in the HTML.
- The browser runtime (`js/tailwind4.js`) reads `<style type="text/tailwindcss">` blocks and generates the CSS.

**Example:** To make a div with blue background and white text:

```html
<div class="bg-primary-500 text-white p-4 rounded-lg">
    Hello World
</div>
```

### CSS Files Explained

Tailwind CSS styles live in `partials/css/_styles.html` as a single `<style type="text/tailwindcss">` block. Separate plain CSS files in `css/` handle DNN defaults and overrides:

| File                 | What It Does                                                         |
| -------------------- | -------------------------------------------------------------------- |
| `partials/css/_styles.html` | **All-in-one Tailwind style block** â€” color palettes, fonts, design tokens (light & dark mode), base styles, hamburger/mobile menu, and your custom UI component library. **Edit this file to change colors, fonts, and add Tailwind components.** |
| `css/default.css`           | DNN default skin stylesheet â€” typography reset, headings, links, lists, forms, tables, utility classes, and DNN module/pane overrides. |
| `css/dnn.css`               | Custom DNN component styles â€” login forms, edit settings panels, dialogs, drag & drop, and module containers. |
| `css/tailwind.css`          | Tailwind CSS config file used **only for VS Code IntelliSense** (autocomplete, hover previews). Contains hardcoded values mirroring `_styles.html`. **Not used in production.** Must be kept in sync manually â€” see note below. |

### Menus

Menus use DNN's **DDRMenu** system. Menu templates are text files with HTML and DDRMenu tokens:

| Menu           | Location                    | Used For                        |
| -------------- | --------------------------- | ------------------------------- |
| **HeaderMenu** | `menus/header/`             | Desktop navigation with dropdown submenus |
| **FooterMenu** | `menus/footer/`             | Simple flat footer links        |

The menu templates are **Razor `.cshtml` files** that use the DNN DDRMenu API (`MenuNode`, `Model.Source.root.Children`, etc.) to render your DNN page tree as navigation. Each folder also contains a `menudef.xml` that tells DDRMenu which template to use.

---

## Customization Guide

### Change Colors

Open `partials/css/_styles.html` and edit the CSS variables in the `:root` block:

```css
:root {
    /* Primary â€” Blue (links, buttons, nav highlights) */
    --primary-500: #006FEE;   /* â† Change this to your brand color */
    --primary-600: #005bc4;
    --primary-700: #004493;
    /* ... other shades (50â€“950) ... */

    /* Secondary â€” Purple */
    --secondary-500: #7828c8;

    /* Success â€” Green */
    --success-500: #17c964;

    /* Warning â€” Yellow */
    --warning-500: #f5a524;

    /* Danger â€” Red/Pink */
    --danger-500: #f31260;

    /* Default â€” Zinc/Neutral */
    --default-500: #71717a;

    /* Footer */
    --color-footer-bg: #18181b;

    /* Buttons */
    --color-button-solid-bg: #006FEE;
}
```

> **Tip:** Use [Tailwind CSS Color Generator](https://uicolors.app/create) to generate a full color palette from a single brand color.

> **Important:** After changing colors or design tokens in `_styles.html`, you must also update `css/tailwind.css` with the same values to keep VS Code IntelliSense accurate. The `tailwind.css` file is not used in production â€” it only exists so the Tailwind CSS IntelliSense extension can provide autocomplete and hover previews for your custom theme tokens.

### Change Fonts

In the same `partials/css/_styles.html` file, change the font variables in the `:root` block:

```css
:root {
    --font-sans: "Your Font", ui-sans-serif, system-ui, sans-serif;
    --font-heading: "Your Heading Font", ui-sans-serif, system-ui, sans-serif;
}
```

Then add your font import (e.g., Google Fonts) in `partials/_includes.ascx`.

### Edit the Layout

Open `default.ascx` to change the page structure. Each `<div>` with `runat="server"` is a DNN content pane:

```html
<div id="ContentPane" class="flex flex-col w-full justify-center" runat="server"></div>
```

You can change Tailwind classes to adjust width, padding, alignment, etc.

### Add a New Content Pane

To add a new pane, add a `<div>` with a unique `id` and `runat="server"`:

```html
<div class="max-w-4xl mx-auto px-8 mt-16">
    <div id="MyNewPane" class="w-full" runat="server"></div>
</div>
```

After installing the updated skin, this pane will appear as a droppable area in DNN's page editor.

### Create a New Container

1. Create a new `.ascx` file in the `containers/` folder, e.g., `CardContainer.ascx`:

```html
<%@ Control AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<div class="bg-white rounded-lg shadow-card p-6 mb-6">
    <h3 class="text-lg font-semibold text-gray-900 mb-3">
        <dnn:TITLE runat="server" id="dnnTITLE" />
    </h3>
    <div id="ContentPane" runat="server"></div>
</div>
```

2. Add the new container to `manifest.dnn` inside the `<containerFiles>` section:

```xml
<containerFile>
    <path></path>
    <name>CardContainer.ascx</name>
</containerFile>
```

3. Rebuild and reinstall the package.

---

## Build the Install Package

Run the build script from the project root:

```powershell
.\build.ps1
```

**What it does:**

1. Packages all skin files (`.ascx`, `partials/`, `menus/`, `css/`, `js/`) into `Resources.zip`.
2. Packages container files into `ContainerResources.zip`.
3. Combines everything with `manifest.dnn`, `License.txt`, and `ReleaseNotes.txt` into the final install zip.

**Output:**

```
dist/DNN.Themes.Tailwind_1.0.0_Install.zip
```

You can customize the output directory:

```powershell
.\build.ps1 -OutputDir "C:\MyPackages" -PackageName "MyCustomSkin"
```

---

## Apply the Skin in DNN

### Apply to the Entire Site

1. Go to **Settings â†’ Site Settings â†’ Appearance**.
2. Set **Site Skin** to `DNN.Themes.Tailwind â€” default`.
3. Set **Site Container** to `DNN.Themes.Tailwind â€” Title` (or `None`).
4. Click **Save**.

### Apply to a Single Page

1. Go to the page you want to change.
2. Open **Page Settings** (gear icon â†’ Page Settings).
3. Under **Appearance**, set **Page Skin** to `DNN.Themes.Tailwind â€” default`.
4. Set **Page Container** to your preferred container.
5. Click **Save**.

### Apply a Container to a Single Module

1. Edit the page.
2. Click the **pencil/gear icon** on the module.
3. Go to **Module Settings**.
4. Under **Page Settings**, set **Module Container**.
5. Click **Update**.

---

## Troubleshooting

| Problem | Solution |
| ------- | -------- |
| Styles don't load / page looks unstyled | Make sure `js/tailwind4.js` is included. Check the browser console for errors. |
| DNN default styles override Tailwind | The skin includes conflict overrides in `css/dnn.css`. If you see conflicts, add more resets there. |
| Mobile menu doesn't open | Check that the hamburger button's `onclick` targets `#mobile-menu` and the `<div id="mobile-menu">` exists. |
| Navigation dropdowns don't show | Ensure the `menus/header/` folder was included in the build. Check the DDRMenu module is installed. |
| Build script fails | Make sure you're running PowerShell 5.1+ and you're in the project root folder. |
| Package won't install in DNN | Verify `manifest.dnn` is well-formed XML. Check the DNN event log for detailed error messages. |

---

## License

This project is licensed under the **MIT License** â€” see [License.txt](License.txt) for details.
