#----------------------------
# Added by Zinit's installer
#----------------------------
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

#----------------------------
# End of Zinit's installer chunk
#----------------------------

#----------------------------
# Zinit
#----------------------------
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
zinit ice wait lucid
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

#----------------------------
# History
#----------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt share_history
setopt hist_ignore_alldups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history


#----------------------------
# Utility
#----------------------------
setopt AUTO_CD
setopt AUTO_PARAM_KEYS

#----------------------------
# Alias
#----------------------------
alias ls='ls --color=auto'
alias la='ls -a'
alias c='clear'
eval "$(anyenv init -)"
alias air=~/.air


# Change Prompt if x64_
if [ "$(uname -m)" != "arm64" ]; then
	PROMPT+='%F{cyan}x86_64 ❯ %f'
fi
