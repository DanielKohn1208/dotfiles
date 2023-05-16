# Created by Zap installer
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "MAHcodes/distro-prompt"
plug "wintermi/zsh-lsd"


export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:/home/daniel/.local/bin:$PATH
export PATH=$HOME/.dotnet/tools:$PATH
export PATH=$HOME/.cargo/bin:$PATH
# Path to your oh-my-zsh installation.
export EDITOR="nvim"
export VISUAL="nvim"
export TERM=xterm-256color
DISABLE_AUTO_TITLE="true"

export MANPATH="/usr/local/man:$MANPATH"

export BAT_THEME="Nord"
alias ant="ant -emacs"
alias cat="bat"
alias vnotes="nvim ~/notes"
alias dwmconf="cd ~/.config/suckless/dwm/dwm-6.3/"
alias vi="nvim"
alias hx="helix"

# eval "$(starship init zsh)"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
