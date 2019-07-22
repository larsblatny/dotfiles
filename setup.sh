#!/bin/bash

# install necessary packages through apt
echo 'Installing git curl mosh'
sudo apt update
sudo apt install git curl mosh -y

# get Nerd Font Meslo and install
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
mkdir -p ~/.local/share/fonts # -p: no error if existing
mv -f Meslo\ LG\ M\ Regular\ Nerd\ Font\ Complete\ Mono.ttf ~/.local/share/fonts/Meslo\ LG\ M\ Regular\ Nerd\ Font\ Complete\ Mono.ttf # -u: only move if updating
fc-cache -f -v
fc-list | grep "Meslo"
echo "====== Verify that there's Meslo Nerd Font installed. Press any key to continue..."; read -k1 -s

# install zsh
echo 'Installing zsh'
sudo apt install zsh -y
chsh -s $(which zsh)
ln -sf .zshrc ~/.zshrc
echo 'Installing Tomorrow-Night-Theme'
wget https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/Gnome-Terminal/setup-theme.sh
sudo apt install gconf2 -y
zsh setup-theme.sh
rm setup-theme.sh
wget https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night.vim
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install powerlevel9k and necessary symbols
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.local/share/fonts/
mv -u PowerlineSymbols.otf ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/
mkdir -p ~/.config/fontconfig/conf.d/
mv -u 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# install vim
echo 'Installing vim'
sudo apt install vim neovim silversearcher-ag ctags -y
ln -sf .vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo 'Open vim and call :PlugInstall'
echo 'Once finished, press any key to continue...'; read -k1 -s
cd ~/.vim/plugged/YouCompleteMe
echo 'Installing the necessary packages for YouCompleteMe'
sudo apt install build-essential cmake python3-dev clang -y
python3 install.py --clang-completer
cd -

# install tmux
echo 'Installing tmux'
sudo apt install tmux -y
mkdir -p ~/.tmux
ln .tmux.conf ~/.tmux.conf

# install nvim
echo 'Installing neovim'
sudo apt install neovim -y
mkdir -p ~/.config/nvim
cat <<EOF > ~/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOF

# install latex related packages
sudo apt install texlive texlive-science latexmk






echo "To do list: "
echo "1. Open the repository and run 'ctags -R *"
echo "2. Log out of your session and login again."
