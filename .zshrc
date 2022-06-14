# zmodload zsh/zprof
# Path to your oh-my-zsh installation.
export ZSH=/home/mua/.oh-my-zsh

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="starship"

plugins=(aws nmap colorize colored-man-pages git npm sublime common-aliases zsh-autosuggestions zsh-syntax-highlighting archlinux battery docker docker-compose fzf kubectl)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/mua/bin:/home/mua/.scripts"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#export PATH="/usr/local/sbin:$PATH"
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

unalias t

alias dotfiles='/usr/bin/git --git-dir=/home/mua/.dotfiles/ --work-tree=/home/mua'
alias vim="nvim"
alias cleanup="sudo pacman -Rns \$(pacman -Qtdq)"
alias upgrade="sudo yay -Syu"
alias psmem="ps aux | sort -nr -k 4 | head -10"
alias pscpu="ps aux | sort -nr -k 3 | head -10"
alias jctl="journalctl -p 3 -xb"
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias cp="cp -v -i"
alias mv="mv -v -i"


function pullall() {
  for i in `ls -D`
    do
      if [[ -d "$i/.git" ]]
      then
        echo "----- $i -----"
        cd $i
        git pull
        cd ..
      fi
    done
}

eval "$(gh completion -s zsh)"

source /home/mua/.zshrc_private

# source /usr/share/nvm/init-nvm.sh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh


export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$HOME/.cargo/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

export PATH="$PATH:/home/mua/.dotnet/tools"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
