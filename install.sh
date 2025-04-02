# get os type
set -e
set -x
OS=$(cat /etc/os-release|grep "\<ID="|awk -F'=' '{print $2}')
script_dir=$(dirname $0)

# install oh-my-zsh
# will enter zsh shell, manually exit to continue install
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

rm -rf ~/.zshrc
ln -nsf ${script_dir}/.zshrc ~/.zshrc
# cp $script_dir/.zshrc ~/.zshrc

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install ripgrep zsh -y
  mkdir -p ~/bin && cd ~/bin 
  wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  tar xf nvim-linux-x86_64.tar.gz
  echo "alias vim='~/bin/nvim-linux-x86_64/bin/nvim'" >> ~/.zshrc
  echo "alias vimdiff='vim -d'" >> ~/.zshrc
  git config --global core.editor ~/bin/nvim-linux-x86_64/bin/nvim
  if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  fi
  ~/.fzf/install
elif [[ $OS == "arch" ]]; then
  sudo pacman -S neovim zsh fzf ripgrep
  git config --global core.editor nvim
  echo "source <(fzf --zsh)" >> ~/.zshrc
else
  echo "Unknown operating system"
  exit 1
fi

# install nvchad
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim

# git clone git@github.com:duoml/NvimConfig.git ~/.config/nvim
git clone https://github.com/duoml/NvimConfig.git ~/.config/nvim
# run nvim and :MasonInstallAll

# installing zsh plugins
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

zsh
