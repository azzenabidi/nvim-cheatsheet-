# nvim-cheatsheet-

A small setup script for Omarchy and Hyprland that adds a Neovim cheatsheet launcher and convenient keyboard shortcuts.

![Neovim cheatsheet screenshot](https://i.redd.it/3yblupqp51eh1.png)

## What it does

The script:

- creates a launcher script at ~/.local/bin/neovim-cheatsheet
- opens a searchable cheatsheet popup with common Neovim keybindings
- adds a Super+N binding to open the cheatsheet
- adds a Super+E binding to launch Neovim in a terminal
- backs up your Hyprland bindings file before updating it
- reloads Hyprland so the new bindings take effect

## Requirements

- Omarchy 3 or another Hyprland-based setup (<= 0.56)
- bash
- walker (for the dmenu-style launcher popup)

## Installation

1. Clone or download this repository.
2. Make the script executable:
   ```bash
   chmod +x nvim-cheatsheet.sh
   ```
3. Run it:
   ```bash
   ./nvim-cheatsheet.sh
   ```

## Usage

- Press Super+N to open the Neovim cheatsheet.
- Press Super+E to launch Neovim.

## Notes

The script creates a timestamped backup of your Hyprland bindings file at:

```bash
~/.config/hypr/bindings.conf.bak.<timestamp>
```

If you want to remove the bindings later, you can delete the added lines from your bindings configuration or restore the backup file.
