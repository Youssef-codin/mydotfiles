#!/usr/bin/env bash

PROJECT_ROOT="$HOME/projects"
CACHE_FILE="$HOME/.cache/sessionizer.log"

mkdir -p "$(dirname "$CACHE_FILE")"

log_project() {
    echo "$(date +%s)|$1" >>"$CACHE_FILE"
}

recent_projects() {
    awk -F'|' '{print $2}' "$CACHE_FILE" 2>/dev/null | tac | awk '!seen[$0]++'
}

preview_project() {
    local project="$1"
    [[ -z "$project" ]] && return
    local path="$PROJECT_ROOT/$project"

    local RESET=$'\033[0m'
    local TITLE=$'\033[1;95m'
    local LABEL=$'\033[1;94m'
    local OK=$'\033[32m'
    local WARN=$'\033[33m'
    local DIM=$'\033[2;37m'

    local icon="󰈙"
    local name="Unknown"

    # ── Framework detection ────────────────────────────
    if [[ -f "$path/package.json" ]]; then
        if rg -q '"next"' "$path/package.json"; then
            icon="󰔶"
            name="Next.js"
        elif rg -q '"react"' "$path/package.json"; then
            icon=""
            name="React"
        elif rg -q '"express"' "$path/package.json"; then
            icon=""
            name="Express.js"
        else
            icon=""
            name="Node.js"
        fi
    elif [[ -f "$path/manage.py" ]]; then
        icon=""
        name="Django"
    elif [[ -f "$path/app.py" || -f "$path/wsgi.py" ]]; then
        icon=""
        name="Flask"
    elif [[ -f "$path/pom.xml" || -f "$path/build.gradle" ]]; then
        icon=""
        name="Spring Boot"
    elif [[ -f "$path/Cargo.toml" ]]; then
        icon=""
        name="Rust"
    elif [[ -f "$path/go.mod" ]]; then
        icon=""
        name="Go"
    elif compgen -G "$path"/*.csproj >/dev/null; then
        icon="󰌛"
        name="ASP.NET"
    fi

    # ── Language fallback ─────────────────────────────
    if [[ "$name" == "Unknown" ]]; then
        if compgen -G "$path"/*.cpp >/dev/null || compgen -G "$path"/*.c >/dev/null; then
            icon=""
            name="C / C++"
        elif compgen -G "$path"/*.py >/dev/null; then
            icon=""
            name="Python"
        fi
    fi

    printf "%b\n" "${TITLE}󰏓  $project${RESET}"
    printf "%b\n" "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    printf "%b\n" "${LABEL}${icon}  ${name}${RESET}"
    printf "%b\n\n" "${DIM}$path${RESET}"

    # ── Docker detection ──────────────────────────────
    if [[ -f "$path/Dockerfile" || -f "$path/docker-compose.yml" || -f "$path/compose.yml" ]]; then
        printf "%b\n\n" "${LABEL}󰡨  Docker detected${RESET}"
    fi

    # ── Git info ──────────────────────────────────────
    if [[ -d "$path/.git" ]]; then
        cd "$path" || return
        local branch dirty
        branch=$(git branch --show-current 2>/dev/null)
        dirty=$(git status --porcelain | wc -l)

        printf "%b\n" "${LABEL}  Git${RESET}"
        printf "    Branch: %b\n" "${OK}${branch}${RESET}"

        if [[ "$dirty" -gt 0 ]]; then
            printf "    Status: %b\n" "${WARN}$dirty changes${RESET}"
            git status --porcelain | head -5 | sed 's/^/    /'
        else
            printf "    Status: %b\n" "${OK}clean${RESET}"
        fi
    fi

    # ── Recent files ──────────────────────────────────
    printf "\n%b\n" "${LABEL}󰥔  Recent files${RESET}"
    find "$path" -type f -not -path '*/.git/*' -printf '%T@ %p\n' 2>/dev/null |
        sort -nr | head -5 | cut -d' ' -f2- | sed 's|^.*/|  |'

    # ── TODO / FIXME (clean output) ───────────────────
    printf "\n%b\n" "${LABEL}󰄬  TODO / FIXME${RESET}"
    (
        cd "$path" || exit
        rg -n "TODO|FIXME|HACK" 2>/dev/null | head -5 |
            sed -E 's|^(.*/)?([^/:]+):([0-9]+):(.*)|  \2:\3  \4|'
    ) || printf "  %b\n" "${DIM}None found${RESET}"
}

export -f preview_project
export PROJECT_ROOT

projects=$(find "$PROJECT_ROOT" -mindepth 2 -maxdepth 2 -type d |
    sed "s|$PROJECT_ROOT/||")

recent=$(recent_projects)
sorted=$(printf "%s\n%s\n" "$recent" "$projects" | awk 'NF && !seen[$0]++')

project=$(printf "%s\n" "$sorted" | while read -r p; do
    if [[ -d "$PROJECT_ROOT/$p/.git" ]]; then
        dirty=$(git -C "$PROJECT_ROOT/$p" status --porcelain | wc -l)
        [[ "$dirty" -gt 0 ]] && printf "*|%s|%d\n" "$p" "$dirty" || printf " |%s|\n" "$p"
    else
        printf " |%s|\n" "$p"
    fi
done | fzf \
    --ansi \
    --height=100% \
    --margin=3,5 \
    --delimiter='|' \
    --with-nth=2 \
    --preview 'bash -c "preview_project {2}"' \
    --preview-window=right:60% \
    --prompt="󰮕  " \
    --pointer="❯ " \
    --header="  Project Sessionizer  " |
    awk -F'|' '{print $2}')

[[ -z "$project" ]] && exit 0
log_project "$project"

path="$PROJECT_ROOT/$project"
session=$(basename "$project")

tmux has-session -t "$session" 2>/dev/null || {
    tmux new-session -d -s "$session" -n nvim -c "$path"
    tmux send-keys -t "$session:nvim" "nvim ." C-m

    tmux new-window -t "$session" -n run -c "$path"
    tmux new-window -t "$session" -n git -c "$path"
    tmux send-keys -t "$session:git" "lazygit" C-m

    tmux select-window -t nvim
}

tmux attach -t "$session"
