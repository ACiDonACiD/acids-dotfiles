# 📁 Structuring the `config.d/` Directory

To enable **modular configuration** in i3, we use a `config.d/` directory where individual configuration snippets are split into smaller, more manageable files. These are then loaded into the main `config` file using a structured, numerically-prefixed approach.

---

## 🔥 [IMPORTANT!] Variable Scope & Script Hierarchy

Due to how **i3 parses configuration files and variables**, there are a few critical rules to understand:

- 🧠 **Variables defined in included files are NOT passed back** to parent scripts.
- 📉 **Inclusion order matters** — configs must be loaded in a **descending tree structure**, starting with the most general settings.
- ⚠️ Misplacing variable definitions may result in **warnings, errors, or broken configs**.

> ✅ **ALWAYS define all variables in the first (or at latest, second) config layer.**  
> 🔒 **Make a backup before experimenting or restructuring your config.**

---

## 📐 Prefixing System for File Order

Each file in `config.d/` must follow a **numeric prefix naming scheme**. This controls the order in which i3 processes them.

### ✅ Valid Prefix Patterns

Any file with a numeric prefix of `0` will be parsed first (highest priority):

```
0_i3.conf
00_i3.conf
000_i3.conf
```

➡️ The lower the number, the **earlier** the file is processed.  
➡️ Prefixes can use any number of digits, but **the numeric value controls order**, not the number of zeros.

---

## 🗂 Example Directory Structure

```bash
config.d/
├── 00_variables.conf      # 🌍 Global variables (highest priority)
├── 10_fonts.conf          # 🖋 UI / Font settings
├── 20_bindings.conf       # ⌨️ Keybindings
├── 30_workspaces.conf     # 🧩 Workspace setup
├── 40_apps.conf           # 🚀 Autostart / app-specific configs
├── 99_custom.conf         # 🛠 Custom overrides / last-minute fixes
```

---

## ⚠️ NOTES & REMINDERS

- 🔁 **Variables DO NOT back-propagate** (they won't "return" to a parent or calling script).
- 📌 Ensure **all critical variables are declared early** — preferably in `00_variables.conf`.
- 🧯 A misplaced variable may silently fail, leading to unexpected behavior.
- 🗃 Always **keep a backup** of your working config before restructuring!

---
