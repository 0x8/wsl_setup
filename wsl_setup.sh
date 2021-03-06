#!/bin/bash
# Set up script for a terminator environment on WSL (Windows Subsystem for Linux)
# Makes use of VcxServ to run an x-server natively through Windows 10.

# Ensure repos are update
sudo apt update

# Must have applications
sudo apt install terminator python3 python3-pip python-pip make gcc nmap \
zsh gcc-multilib gdb gcc-5-arm-linux-gnueabi gcc-arm-linux-gnueabi \
vim

# Pip upgrade (out of date on WSL for some reason)
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip

# Fix pip (Debian breaks it by wrongful use of main)
sudo python -m pip install --force-reinstall pip
sudo python3 -m pip install --force-reinstall pip

# Powerline
sudo pip install powerline-status

# Vim Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Python Virtual Environments
sudo pip install virtualenvwrapper  # The rest of the setup is handled by the dotfiles

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# pwndbg
git clone https://github.com/pwndbg/pwndbg ~/.pwndbg
cd ~/.pwndbg
./setup.sh

# dircolors fix from https://github.com/seebi/dircolors-solarized
if [ -d "$HOME/.dircolors" ]
then
    echo "Found ~/.dircolors directory, moving it to backup"
    mv "$HOME/.dircolors" "$HOME/.dircolors.backup"
fi
git clone https://github.com/seebi/dircolors-solarized "$HOME/.dircolors"

# nptr_dotfiles
git clone --single-branch --branch wsl https://github.com/0x8/nptr_dotfiles ~/.nptr_dotfiles
cd ~/.nptr_dotfiles
./install.sh
