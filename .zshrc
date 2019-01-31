# Direnv
eval "$(direnv hook zsh)"

# Aliases.
alias vi="nvim"

# Home manager.
source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Make a nix shell environment.
nixify() {
  if [ ! -e ./.envrc ]; then
    echo "use nix" > .envrc
    direnv allow
  fi
  if [ ! -e shell.nix ]; then
    cat > shell.nix <<'EOF'
with import <nixpkgs> {};
pkgs.mkShell {
  buildInputs = [
    bashInteractive
  ];
}
EOF
    ${EDITOR:-nvim} shell.nix
  fi
}
