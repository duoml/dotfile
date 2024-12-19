# get os type
OS=$(cat /etc/os-release|grep "\<ID="|awk -F'=' '{print $2}')
script_dir=$(dirname $0)

# ln -nsf script_dir/.zshrc ~/.zshrc
cp script_dir/.zshrc ~/.zshrc

if [[ $OS == "ubuntu" ]]; then
  sudo apt-get install ripgrep zsh -y
  mkdir -p ~/bin && cd bin 
  wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  tar xf nvim-linux64.tar.gz
  echo "alias vim='~/bin/nvim-linux64/bin/nvim'" >> ~/.zshrc
  echo "alias vimdiff='vim -d'" >> ~/.zshrc
  git config --global core.editor ~/bin/nvim-linux64/bin/nvim
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
elif [[ $OS == "arch" ]]; then
  sudo pacman -S neovim zsh fzf ripgrep
  git config --global core.editor nvim
else
  echo "Unknown operating system"
  exit 1
fi

# install nvchad
git clone git@github.com:duoml/NvimConfig.git ~/.config/nvim
# run nvim and :MasonInstallAll

# installing fzf plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use

vim
