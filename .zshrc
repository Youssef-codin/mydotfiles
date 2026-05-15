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
alias lz='lazygit'
alias confhypr='nvim ~/.config/hypr'
alias confkitty='nvim ~/.config/kitty/kitty.conf'
alias hyprmatrix='cmatrix -C magenta'
alias sync='rclone sync ~/Documents gDrive:DocumentsBackup'
alias mnt='~/scripts/mount-games.sh'
alias vnc='~/scripts/wayvnc.sh'

bindkey -s '^[s' '^U~/scripts/sessionizer.sh^M'

# Precommands (e.g., sudo, time): Neon blue
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#04d9ff'  

#ssh
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if ! ssh-add -l &>/dev/null; then
    pass show prod.pem | ssh-add -
fi

fastfetch

eval "$(zoxide init zsh)"
source <(fzf --zsh)
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!

if [[ $- == *i* ]]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
export PATH="$PATH:$HOME/.dotnet/tools"
export SUDO_EDITOR=nvim
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=~/.npm-global/bin:$PATH # or /home/joe-arch/.bashrc
export PATH="/home/joe-arch/.bun/bin:$PATH"

