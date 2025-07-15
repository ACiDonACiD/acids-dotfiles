# i3 Window Manager Configuration

This repository contains a customized configuration for the **i3 window manager**, including modular configuration files, custom i3blocks scripts, and Inter-Process Communication (IPC) utilities. The setup is designed to be modular, extensible, and maintainable.

## Table of Contents
- [Overview](#overview)
- [Directory Structure](#directory-structure)
  - [config](#config)
  - [config.d/](#configd)
  - [blocks.d/](#blocksd)
  - [ipc/](#ipc)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration Details](#configuration-details)
- [Contributing](#contributing)
- [License](#license)

## Overview
The i3 window manager is a lightweight, tiling window manager designed for efficiency and customization. This repository provides a structured setup for i3, with modular configuration files, custom status bar blocks, and IPC utilities to enhance functionality and interactivity. The provided example outlines my current structure, but feel free to implement your own configuration structure if desired.

## Directory Structure

### config
The `config` file serves as the main configuration entry point for i3, typically sourcing the modular files in `config.d/`.

### config.d/
The `config.d/` directory contains modular configuration files that define the behavior and appearance of the i3 window manager. Each file is prefixed with a numeric value to determine the order of processing, ensuring critical configurations are loaded first.

- **00_variables.conf**: Defines global variables used across other configuration files.
- **01_base.conf**: Core i3 settings and basic configurations.
- **02_core.conf**: Essential behaviors and rules for i3.
- **20_appearance.conf**: Visual settings, such as bar appearance and colors.
- **21_gaps.conf**: Settings for window gaps and spacing.
- **22_assignment.conf**: Rules for assigning windows to specific workspaces or programs.
- **30_keymap.conf**: Keybindings for navigation and control.
- **60_autostart.conf**: Applications launched automatically on i3 startup.
- **61_client.conf**: Configurations for managing i3 clients (windows).
- **62_bar.conf**: Settings for the i3 status bar.
- **63_i3blocks.conf**: Configuration for i3blocks integration with the status bar.
- **70_mode.conf**: Custom modes and their associated keybindings.
- **99_local.conf**: Local overrides for other configuration files.
- **README.md**: Documentation for the `config.d/` directory.

**Note**: Numeric prefixes (e.g., `00`, `01`, `20`) indicate the priority of configuration files. It is recommended to use intervals of 10 (e.g., `00`, `10`, `20`) to avoid conflicts and maintain clarity. Files with the same prefix are sorted alphabetically, which may affect dependency loading if not carefully managed.

**Recommended Prefix Structure**:
- **00–10**: High-priority, critical configurations.
- **11–20**: Moderately important configurations.
- **90–99**: Low-priority or local overrides.

### blocks.d/
The `blocks.d/` directory contains custom scripts and binaries for displaying dynamic information in the i3 status bar using **i3blocks**.

- **bin/**: Contains executable scripts or binaries (e.g., `block_2`).
- **config/**: Configuration files for defining block behavior.
- **src/**: Source code for block modules (e.g., `block_2.c`).
- **Makefile**: Build instructions for compiling block source code.
- **README.md**: Documentation for the `blocks.d/` directory.

### ipc/
The `ipc/` directory contains utilities for Inter-Process Communication, enabling programmatic interaction with i3 and other processes.

- **event_loop.py**: Manages event handling for IPC.
- **__init__.py**: Marks the directory as a Python package.
- **ipc_connector.py**: Script for establishing IPC connections.
- **main.py**: Entry point for IPC utilities.
- **_private/**: Private directory for additional files (currently empty or reserved).
- **README.md**: Documentation for the `ipc/` directory.

## Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/i3-config.git ~/.config/i3
   ```
2. **Install Dependencies**:
   Ensure you have the following installed:
   - i3 window manager
   - i3blocks (for status bar functionality)
   - Python 3 (for IPC utilities)
   - A C compiler (e.g., `gcc`) for compiling block source code in `blocks.d/src/`.

3. **Build Blocks** (if necessary):
   Navigate to `blocks.d/` and run:
   ```bash
   make
   ```
   This compiles the source code in `src/` to generate binaries in `bin/`.

4. **Symlink Configuration** (Optional):
   If you prefer to keep the repository elsewhere, create a symlink:
   ```bash
   ln -s /path/to/repo ~/.config/i3
   ```

5. **Reload i3**:
   Reload i3 to apply the configuration:
   ```bash
   i3-msg reload
   ```

## Usage
- **Modify Configurations**: Edit the `config` file or files in `config.d/` to customize i3 behavior, keybindings, or appearance.
- **Add Custom Blocks**: Place new scripts or binaries in `blocks.d/bin/`, update `blocks.d/config/`, and recompile if necessary using `make`.
- **Use IPC Utilities**: Run `ipc/main.py` to interact with i3 programmatically. Refer to `ipc/README.md` for details.
- **Test Changes**: After modifying files, reload i3 (`i3-msg reload`) or restart i3 (`i3-msg restart`).

## Configuration Details
- **Modularity**: The `config.d/` structure allows for easy addition or removal of configuration modules.
- **Priority System**: Numeric prefixes ensure predictable loading order.
- **Extensibility**: Custom blocks and IPC utilities can be extended to add new functionality.
- **Build Support**: The `blocks.d/Makefile` simplifies compilation of custom blocks.

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

Please ensure your changes follow the numeric prefix convention for `config.d/` files and include appropriate documentation.

## License
This project is licensed under the MIT License.

Copyright (c) 2025 Kieran O'Neill

See the [LICENSE](LICENSE) file for details.
