if status is-interactive
end

starship init fish | source
zoxide init fish | source
eval "$(rbenv init -)"

set fish_greeting

# Java
set -Ux JAVA_HOME /opt/homebrew/opt/openjdk@17
set -Ux PATH $JAVA_HOME/bin $PATH

# Android SDK
set -Ux ANDROID_HOME $HOME/Library/Android/sdk
set -Ux ANDROID_SDK_ROOT $ANDROID_HOME

alias v="nvim"
alias c="clear"
alias cd="z"
alias gs="git status"
alias build="sudo -i nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake ~/mac-dotfiles#hope"
alias venv="source ./.venv/bin/activate.fish"
alias lg="lazygit"
alias lsa="ls -a"
