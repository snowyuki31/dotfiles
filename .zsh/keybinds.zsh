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

zle -N ghq-fzf
bindkey "^g" ghq-fzf

zle -N git-fzf-branch
bindkey "^f" git-fzf-branch
