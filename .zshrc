# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
DEFAULT_USER="mua"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Docker completions: MUST be before OMZ/compinit
fpath=(/Users/mua/.docker/completions $fpath)


plugins=(
  colorize
  colored-man-pages
  sublime
  common-aliases
  zsh-autosuggestions
  zsh-syntax-highlighting
  macos
)

source $ZSH/oh-my-zsh.sh

# eval "$(starship init zsh)"

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

source $HOME/.zshrc_private

##### nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" --no-use  # This loads nvm

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

##### direnv
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

##### jenv
eval "$(jenv init -)"

##### homebrew
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

TREE_IGNORE="cache|log|logs|node_modules|vendor"

alias ls='eza'
alias la='eza -a'
alias ll='eza --git -l'
alias lt='eza --tree -D -L 2 -I "$TREE_IGNORE"'
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yyt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "
alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"
alias brew_update="brew update && brew upgrade && brew upgrade --cask --greedy --quiet"

alias claude-work='CLAUDE_CONFIG_DIR=~/.claude command claude'
alias claude-personal='CLAUDE_CONFIG_DIR=~/.claude-personal command claude'

fpullall() {
  local dir
  for dir in */; do
    if [[ -d "$dir/.git" ]]; then
      echo "----- ${dir%/} -----"
      git -C "$dir" pull
    fi
  done
}

mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

boop () {
  local last="$?"
  if [[ "$last" == '0' ]]; then
    say -r 400 ok
  else
    say -r 400 nop
  fi
  return "$last"
}

##### pnpm
export PNPM_HOME="/Users/mua/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

##### pyenv

eval "$(pyenv init -)"

export GPG_TTY=$(tty)

# MyNamirial token generator (used by update-mynamirial-token skill)
export MYNAMIRIAL_TOKEN_SCRIPT_DIR="$HOME/Projects/namirial/namirial-sign-utils/GenerateMyNamirialToken"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
