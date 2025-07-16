bindkey -e

function ghq-fzf() {
    local selected_dir=$(ghq list | fzf --query="$LBUFFER")

    if [ -n "$selected_dir" ]; then
        BUFFER="cd $(ghq root)/${selected_dir}"
        zle accept-line
    fi

    zle reset-prompt
}

function git-fzf-branch() {
    if [ ! -d ".git" ]; then
        return 1
    fi

    local selected_branch=$(git branch | sed 's/^[ *]*//g' | fzf --query="$LBUFFER")

    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi

    zle reset-prompt
}

# --- Ctrl-K: .kiro/spec/ ディレクトリを FZF で選択してパスを pbcopy ---
function kiro-spec-fzf() {
  local base sel
  base="$(git -C . rev-parse --show-toplevel 2>/dev/null)/.kiro/specs" || return
  [[ -d $base ]] || return

  sel=$(ls -1 "$base" | fzf --query="$LBUFFER") || return
  [[ -n $sel ]] || return

  printf '.kiro/specs/%s/\n' "$sel" | pbcopy   # macOS（Linux は xclip 等に置換）
}

# ZLE ウィジェットとして登録して Ctrl-K に割り当て
zle -N kiro-spec-fzf
bindkey "^k" kiro-spec-fzf 

zle -N ghq-fzf
bindkey "^g" ghq-fzf

zle -N git-fzf-branch
bindkey "^f" git-fzf-branch
