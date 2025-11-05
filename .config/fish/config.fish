if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
zoxide init fish | source
eval "$(rbenv init -)"
set fish_greeting
alias v="nvim"
alias c="clear"
alias cd="z"
alias gs="git status"
alias build="sudo -i nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake ~/mac-dotfiles#hope"
alias venv="source ./.venv/bin/activate.fish"
