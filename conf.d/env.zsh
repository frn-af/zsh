#!/usr/bin/env zsh
# macOS-friendly environment setup

# Basic PATH prepending
PATH="$HOME/.local/bin:$PATH"

# Detect macOS and set appropriate defaults
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS-native directories
    XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/Library/Application Support}"
    XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/Library/Caches}"
    XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
    
    # macOS user directories (no xdg-user-dir needed)
    XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-$HOME/Desktop}"
    XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
    XDG_DEVELOPER_DIR="${XDG_DEVELOPER_DIR:-$HOME/Developer}"
    XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$HOME/Documents}"
    XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-$HOME/Music}"
    XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}" 
    XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME/Movies}"

    export PATH \
    XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME XDG_STATE_HOME XDG_DESKTOP_DIR \
    XDG_DOWNLOAD_DIR XDG_DEVELOPER_DIR XDG_DOCUMENTS_DIR XDG_MUSIC_DIR \
    XDG_PICTURES_DIR XDG_VIDEOS_DIR

else
    # Linux/Unix defaults (your original code)
    XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
    XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
    
    # Use xdg-user-dir if available
    if command -v xdg-user-dir >/dev/null 2>&1; then
        XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-$(xdg-user-dir DESKTOP)}"
        XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$(xdg-user-dir DOWNLOAD)}"
        # ... other directories
    fi
    
    # Hyprland config (Linux only)
    export HYPRLAND_CONFIG="${XDG_DATA_HOME}/hypr/hyprland.conf"
fi
