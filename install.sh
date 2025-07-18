#!/bin/bash
# Install dotfiles

# Install dependencies
if command -v apt &> /dev/null; then
    # Ubuntu/Debian
    sudo apt update
    sudo apt install -y zsh git curl xclip xsel
elif command -v brew &> /dev/null; then
    # macOS
    brew install zsh git curl
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Install micro
if ! command -v micro &> /dev/null; then
    curl https://getmic.ro | bash
    sudo mv micro /usr/local/bin/
fi

# Link dotfiles
ln -sf $(pwd)/zshrc ~/.zshrc
mkdir -p ~/.config/micro
ln -sf $(pwd)/micro-config ~/.config/micro

# Change shell to zsh
chsh -s $(which zsh)

echo "Dotfiles installed! Restart terminal."
