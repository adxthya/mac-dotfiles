if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
set fish_greeting
alias v="nvim"
alias c="clear"
alias gs="git status"
alias build="sudo -i nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake ~/mac-dotfiles#hope"
