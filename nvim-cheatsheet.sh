#!/bin/bash

# Omarchy Neovim Keybindings Setup
# Adds SUPER N → Neovim Cheatsheet, SUPER E → Neovim
#
# Omarchy configures Hyprland in Lua (bindings.lua, o.bind/hl.unbind) and
# uses the Omarchy menu (omarchy menu select) as the native dmenu.

set -e

BINDINGS_FILE="$HOME/.config/hypr/bindings.lua"
CHEATSHEET_SCRIPT="$HOME/.local/bin/neovim-cheatsheet"

# Ensure ~/.local/bin exists and is in PATH
mkdir -p "$HOME/.local/bin"

# Create the neovim cheatsheet script
cat > "$CHEATSHEET_SCRIPT" << 'SCRIPT'
#!/bin/bash
printf '%s\n' \
"--- MODES & FILES ---" \
"i                                           → Insert mode" \
"v                                           → Visual mode (chars)" \
"V                                           → Visual line mode" \
"Esc                                         → Normal mode" \
":w                                          → Save file" \
":q!                                         → Quit without saving" \
":wq                                         → Save and quit" \
"--- NAVIGATING ---" \
"h / j / k / l                               → Left / Down / Up / Right" \
"w / b                                       → Word forward / backward" \
"0 / $                                       → Start / End of line" \
"gg / G                                      → Top / Bottom of file" \
":{num}                                      → Go to line number" \
"Ctrl+d                                      → Page Down" \
"Ctrl+u                                      → Page Up" \
"--- EDITING ---" \
"x                                           → Delete character" \
"dd                                          → Cut current line" \
"yy                                          → Copy current line" \
"p / P                                       → Paste after / before" \
"u                                           → Undo last action" \
"Ctrl+r                                      → Redo last action" \
"o / O                                       → New line below / above" \
"A                                           → Append at end of line" \
".                                           → Repeat last action" \
"--- TEXT OBJECTS ---" \
"ciw                                         → Change inner word" \
"ci\"                                         → Change inside quotes" \
"di(                                         → Delete inside parens" \
"--- SEARCH & REPLACE ---" \
"/{str}                                      → Search forward" \
"n / N                                       → Next / Previous match" \
":%s/{old}/{new}/g                           → Global replace" \
"--- SPLITS & TERMINAL ---" \
":vsplit                                     → Split vertically" \
":split                                      → Split horizontally" \
"Ctrl+w                                      → Switch window split" \
":term                                       → Open terminal" \
| omarchy menu select 'Neovim Keybindings' -- --width 800 --maxheight 600
SCRIPT

chmod +x "$CHEATSHEET_SCRIPT"

# Backup bindings file
cp "$BINDINGS_FILE" "$BINDINGS_FILE.bak.$(date +%s)"

# Remove existing SUPER N and SUPER E bindings if present
sed -i '/^o\.bind("SUPER + N"/Id' "$BINDINGS_FILE"
sed -i '/^o\.bind("SUPER + E"/Id' "$BINDINGS_FILE"

# Add new bindings
sed -i '$a\
-- Neovim Cheatsheet on SUPER N\
o.bind("SUPER + N", "Neovim Cheatsheet", "neovim-cheatsheet")\
-- Neovim on SUPER E\
o.bind("SUPER + E", "Neovim", "uwsm-app -- xdg-terminal-exec nvim")' "$BINDINGS_FILE"

# Reload and validate Hyprland
hyprctl reload
hyprctl configerrors

echo "Done! Bindings:"
echo "  SUPER N          → Neovim Cheatsheet"
echo "  SUPER E          → Neovim"