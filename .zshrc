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

zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

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

#----------------------------
# Other tools
#----------------------------
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

#----------------------------
# Other settings
#----------------------------
# Limit the number of files to open.
ulimit -n 10240

# Apply local settings
if [ -e ~/.zshrc.local ]; then source ~/.zshrc.local; fi

# Apply .zsh/* settings
for i in ~/.zsh/*.zsh; do
	 source $i


done

# NODE OPTIONS
export NODE_OPTIONS="--max-old-space-size=4096"

[ -f "/Users/yuki/.ghcup/env" ] && . "/Users/yuki/.ghcup/env" # ghcup-env
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yuki/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yuki/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yuki/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yuki/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
