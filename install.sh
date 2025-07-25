#!/bin/bash
#
# This script creates symlinks from the home directory to any desired dotfiles in this repository.

# --- Variables ---
# The directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Your home directory
HOME_DIR=~

# --- List of files/folders to symlink ---
# Add any other files you want to manage here
files_to_stow=(
    zshrc
    p10k.zsh
    gitconfig
    # Add other files like 'vimrc', 'tmux.conf', etc.
)

# --- Create Symlinks ---
echo "Stowing dotfiles..."

for file in "${files_to_stow[@]}"; do
    source_file="$DOTFILES_DIR/$file"
    destination_file="$HOME_DIR/.$file" # Note the added '.' prefix here

    # Check if the source file actually exists
    if [ -e "$source_file" ]; then
        echo "  -> Symlinking .$file"
        # Create a symbolic link, forcing overwrite of any existing link/file
        # -s for symbolic, -f for force, -n to handle links to directories safely
        ln -sfn "$source_file" "$destination_file"
    else
        echo "  -> Warning: Source file '$file' not found in dotfiles directory. Skipping."
    fi
done

echo ""
echo "✅ Dotfiles stowed successfully."
echo "Please restart your shell (or open a new tab) for changes to take effect."
