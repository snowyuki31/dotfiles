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
  # Git ルートを取得（リポジトリ外なら即終了）
  local git_root
  git_root="$(git rev-parse --show-toplevel 2>/dev/null)" || return 1

  # .kiro/spec が無ければ終了
  local spec_base="${git_root}/.kiro/spec"
  [[ -d "${spec_base}" ]] || return 1

  # 直下のディレクトリ一覧を FZF で選択
  local selected
  selected="$(command find "${spec_base}" -mindepth 1 -maxdepth 1 -type d -printf '%P\n' \
              | fzf --prompt='.kiro/spec> ' --query="$LBUFFER")" || return 1

  # 選択結果をクリップボードへ
  if [[ -n "${selected}" ]]; then
    local rel_path=".kiro/spec/${selected}/"
    printf '%s' "${rel_path}" | pbcopy   # macOS
    # printf '%s' "${rel_path}" | xclip -selection clipboard   # Linux の場合
  fi

  zle reset-prompt
}

# ZLE ウィジェットとして登録して Ctrl-K に割り当て
zle -N kiro-spec-fzf
bindkey "^k" kiro-spec-fzf 

zle -N ghq-fzf
bindkey "^g" ghq-fzf

zle -N git-fzf-branch
bindkey "^f" git-fzf-branch
