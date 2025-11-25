eval "$(starship init zsh)"
# Enable autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Main color: Soft neon pink
ZSH_HIGHLIGHT_STYLES[default]='fg=#ff8cc1'  

# Invalid commands: pink (bold)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ff8cc1,bold'  

# Commands: Neon pink 
ZSH_HIGHLIGHT_STYLES[command]='fg=#ff8cc1'  

# Built-in commands (e.g., cd, echo): Neon cyan
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#00ffff'  

# Paths: Neon Orange
ZSH_HIGHLIGHT_STYLES[path]='fg=#ff8800'  
 

# Options (e.g., -l, --help): Neon yellow
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ffff00,bold'  
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ffff00,bold'  

# Aliases: Cyan (to differentiate from commands)
ZSH_HIGHLIGHT_STYLES[alias]='fg=#00ffff'  
alias ls='ls -C -t -X -A -p --color=auto'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lzdot='lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias confhypr='nvim ~/.config/hypr/hyprland.conf'
alias confkitty='nvim ~/.config/kitty/kitty.conf'
alias hyprmatrix='cmatrix -C magenta'
alias webdev='~/scripts/webdev.bsh'
alias java='~/scripts/java.bsh'
alias c#='~/scripts/csharp.bsh'
alias cpp='~/scripts/cpp.bsh'
alias py='~/scripts/python.bsh'

gpprun() {
    local src="$1"
    local out="${src%.*}"  # strip extension -> main.cpp -> main
    g++ "$src" -o "$out" && ./"$out"
}

# Precommands (e.g., sudo, time): Neon blue
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#04d9ff'  

fastfetch

eval "$(zoxide init zsh)"
source <(fzf --zsh)
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="/home/joe-arch/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/joe-arch/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
