# TailwindDNN

A modern, responsive skin (theme) for **DNN 10** built with **Tailwind CSS 4.1**. It features a clean design with mobile-first responsive layout, sticky navigation, hero sections, and custom containers — all styled using utility-first Tailwind classes compiled in the browser.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![DNN](https://img.shields.io/badge/DNN-10%2B-blue)
![Tailwind CSS](https://img.shields.io/badge/Tailwind%20CSS-4.1-38bdf8)

---

## Table of Contents

- [What Is This?](#what-is-this)
- [Requirements](#requirements)
- [Quick Start — Install in 3 Steps](#quick-start--install-in-3-steps)
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

If you run a website on **DNN (DotNetNuke)**, a "skin" controls how your site looks — the header, footer, layout, colors, fonts, etc. **TailwindDNN** is a ready-to-use skin that gives your DNN site a modern look using Tailwind CSS.

**No build tools needed.** Tailwind CSS runs directly in the browser, so you just edit HTML/CSS files and see changes immediately.

---

## Requirements

| Requirement       | Version        |
| ----------------- | -------------- |
| DNN Platform      | 10.0.0 or later |
| Browser           | Any modern browser (Chrome, Firefox, Edge, Safari) |
| Build (optional)  | PowerShell 5.1+ (Windows) — only needed to create the install package |

---

## Quick Start — Install in 3 Steps

### Step 1: Build the Package

Open PowerShell in the project folder and run:

```powershell
.\build.ps1
```

This creates an installable zip file at:

```
dist/TailwindDNN_1.0.0_Install.zip
```

### Step 2: Install in DNN

1. Log in to your DNN site as **Host** (Super Admin).
2. Go to **Settings → Extensions** (or **Host → Extensions** in older menus).
3. Click **Install Extension**.
4. Upload the `TailwindDNN_1.0.0_Install.zip` file.
5. Follow the wizard and click **Next** until installation is complete.

### Step 3: Apply the Skin

1. Go to **Settings → Site Settings → Appearance** (or **Admin → Site Settings**).
2. Under **Site Skin**, select **TailwindDNN — default**.
3. Under **Site Container**, select **TailwindDNN — Title** or **TailwindDNN — NoTitle**.
4. Click **Save**.

Your site is now using TailwindDNN! 🎉

---

## Project Structure

```
TailwindDNN/
├── default.ascx              ← Main skin layout (the page template)
├── manifest.dnn              ← DNN package manifest (defines what gets installed)
├── build.ps1                 ← Build script to create the install zip
├── skin.doctype.xml          ← Sets HTML5 doctype
├── License.txt               ← MIT License
├── ReleaseNotes.txt          ← Version history
│
├── containers/               ← Module containers (wrappers around modules)
│   ├── Title.ascx            ← Container WITH a module title
│   └── NoTitle.ascx          ← Container WITHOUT a module title
│
├── includes/                 ← Reusable parts included in the skin
│   ├── _registers.ascx       ← DNN control registrations (required)
│   ├── _includes.ascx        ← CSS/JS includes + Tailwind config
│   ├── _header.ascx          ← Header with logo, navigation, mobile menu
│   ├── _footer.ascx          ← Footer with links, terms, copyright
│   └── css/                  ← Tailwind CSS style files
│       ├── _theme.html       ← Color palettes, fonts, design tokens
│       ├── _global.html      ← Hamburger button, mobile menu, base styles
│       ├── _dnn.html         ← DNN pane/module styles & conflict fixes
│       └── _dnnUI.html       ← Full DNN UI styling (headings, forms, tables, etc.)
│
├── menus/                    ← DDRMenu templates (navigation rendering)
│   ├── HeaderMenu/           ← Desktop navigation (dropdowns)
│   └── FooterMenu/           ← Footer navigation (flat links)
│
└── src/
    └── js/
        └── tailwind4.js      ← Tailwind CSS 4.1 browser runtime (minified)
```

---

## How the Skin Works

### Layout (Content Panes)

The main layout is defined in `default.ascx`. It contains **content panes** — these are areas where you drop DNN modules (like HTML content, forms, galleries, etc.).

Here are the available panes:

| Pane Name                  | Width    | Description                          |
| -------------------------- | -------- | ------------------------------------ |
| `ContentPane`              | Full     | Full-width top content area          |
| `DoublePaneOneOne`         | 50%      | Left column of a two-column section  |
| `DoublePaneOneTwo`         | 50%      | Right column (gray background)       |
| `FullWidthBGDoublePaneOne` | 50%      | Left column with colored background  |
| `FullWidthBGDoublePaneTwo` | 50%      | Right column with colored background |
| `SinglePaneOne`            | Narrow   | Centered narrow content area         |

**How to add content to a pane:**

1. In DNN, go to the page you want to edit.
2. Click **Edit Page** (pencil icon or Edit mode).
3. Click **Add Module** on a pane.
4. Choose a module (e.g., "HTML/Text") and place it in the desired pane.

### Header & Navigation

The header (`includes/_header.ascx`) includes:

- **Top bar** — Login/Register and user info links (dark background).
- **Main header** — Your site logo + desktop navigation with dropdowns.
- **Mobile menu** — A hamburger button that toggles the menu on small screens (no animation).

The header is **sticky** — it stays at the top of the page as you scroll.

### Footer

The footer (`includes/_footer.ascx`) includes:

- Footer navigation links.
- Terms of Use and Privacy Policy links.
- Copyright notice.
- A faded logo watermark (visible on large screens).

### Containers

Containers wrap around individual DNN modules. This skin comes with two:

| Container  | File           | Use When...                              |
| ---------- | -------------- | ---------------------------------------- |
| **Title**  | `Title.ascx`   | You want to show the module's title/heading |
| **NoTitle** | `NoTitle.ascx` | You want to hide the module's title       |

**To change a module's container:**

1. Edit the page.
2. Click the **gear icon** on the module.
3. Go to **Module Settings → Page Settings**.
4. Under **Module Container**, select `TailwindDNN - Title` or `TailwindDNN - NoTitle`.
5. Click **Update**.

### Styling with Tailwind CSS

This skin uses **Tailwind CSS 4.1** running in the browser. That means:

- **No build step for CSS** — Tailwind compiles classes on-the-fly in the browser.
- You style elements by adding Tailwind utility classes directly in the HTML.
- The browser runtime (`src/js/tailwind4.js`) reads `<style type="text/tailwindcss">` blocks and generates the CSS.

**Example:** To make a div with blue background and white text:

```html
<div class="bg-primary-500 text-white p-4 rounded-lg">
    Hello World
</div>
```

### CSS Files Explained

All styles live in `includes/css/` as `<style type="text/tailwindcss">` blocks:

| File            | What It Does                                                         |
| --------------- | -------------------------------------------------------------------- |
| `_theme.html`   | Defines your **color palettes** (primary, secondary, accent, tertiary), **fonts**, shadows, and border radius. **Edit this file to change your site's colors and fonts.** |
| `_global.html`  | Defines **base styles** (body font, smooth scrolling), the hamburger button animation, and mobile menu toggle/layout styles. |
| `_dnn.html`     | Styles for DNN panes (`.dnn-pane`) and modules (`.dnn-module`, `.dnn-module-title`). Also contains overrides to prevent DNN's default CSS from conflicting with Tailwind. |
| `_dnnUI.html`   | Complete styling for **all standard HTML elements** (headings, paragraphs, lists, tables, forms, inputs, buttons, etc.) so DNN content looks great out of the box. |

### Menus

Menus use DNN's **DDRMenu** system. Menu templates are text files with HTML and DDRMenu tokens:

| Menu           | Location                    | Used For                        |
| -------------- | --------------------------- | ------------------------------- |
| **HeaderMenu** | `menus/HeaderMenu/`         | Desktop navigation with dropdown submenus |
| **FooterMenu** | `menus/FooterMenu/`         | Simple flat footer links        |

The menu templates use DDRMenu tokens like `[=TEXT]`, `[=URL]`, `[?NODE]`, `[*>NODE]`, etc. to render your DNN page tree as navigation.

---

## Customization Guide

### Change Colors

Open `includes/css/_theme.html` and edit the CSS variables in the `:root` block:

```css
:root {
    /* Primary palette — used for links, buttons, nav highlights */
    --primary-500: #3b82f6;   /* ← Change this to your brand color */
    --primary-600: #2563eb;
    --primary-700: #1d4ed8;
    /* ... other shades ... */

    /* Secondary palette — used for success states, secondary actions */
    --secondary-500: #22c55e;

    /* Accent palette — used for decorative elements */
    --accent-500: #a855f7;

    /* Footer */
    --color-footer-bg: #111827;

    /* Buttons */
    --color-button-solid-bg: #14b8a6;
}
```

> **Tip:** Use [Tailwind CSS Color Generator](https://uicolors.app/create) to generate a full color palette from a single brand color.

### Change Fonts

In the same `_theme.html` file, change the font variables:

```css
@theme {
    --font-sans: "Your Font", ui-sans-serif, system-ui, sans-serif;
    --font-heading: "Your Heading Font", ui-sans-serif, system-ui, sans-serif;
}
```

Then add your font import (e.g., Google Fonts) in `includes/_includes.ascx`.

### Edit the Layout

Open `default.ascx` to change the page structure. Each `<div>` with `runat="server"` is a DNN content pane:

```html
<div id="ContentPane" class="w-full prose text-center max-w-none" runat="server"></div>
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

1. Packages all skin files (`.ascx`, `includes/`, `menus/`, `src/js/`) into `Resources.zip`.
2. Packages container files into `ContainerResources.zip`.
3. Combines everything with `manifest.dnn`, `License.txt`, and `ReleaseNotes.txt` into the final install zip.

**Output:**

```
dist/TailwindDNN_1.0.0_Install.zip
```

You can customize the output directory:

```powershell
.\build.ps1 -OutputDir "C:\MyPackages" -PackageName "MyCustomSkin"
```

---

## Apply the Skin in DNN

### Apply to the Entire Site

1. Go to **Settings → Site Settings → Appearance**.
2. Set **Site Skin** to `TailwindDNN — default`.
3. Set **Site Container** to `TailwindDNN — Title` (or `NoTitle`).
4. Click **Save**.

### Apply to a Single Page

1. Go to the page you want to change.
2. Open **Page Settings** (gear icon → Page Settings).
3. Under **Appearance**, set **Page Skin** to `TailwindDNN — default`.
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
| Styles don't load / page looks unstyled | Make sure `src/js/tailwind4.js` is included. Check the browser console for errors. |
| DNN default styles override Tailwind | The skin includes conflict overrides in `_dnn.html`. If you see conflicts, add more resets there. |
| Mobile menu doesn't open | Check that the hamburger button's `onclick` targets `#mobile-menu` and the `<div id="mobile-menu">` exists. |
| Navigation dropdowns don't show | Ensure the `menus/HeaderMenu/` folder was included in the build. Check the DDRMenu module is installed. |
| Build script fails | Make sure you're running PowerShell 5.1+ and you're in the project root folder. |
| Package won't install in DNN | Verify `manifest.dnn` is well-formed XML. Check the DNN event log for detailed error messages. |

---

## License

This project is licensed under the **MIT License** — see [License.txt](License.txt) for details.
