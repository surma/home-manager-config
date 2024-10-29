{
  enable = true;
  shellAliases = {
    ".." = "cd ..";
    ga = "git add";
    gc = "git commit -v";
    gca = "git commit -av";
    gd = "git diff -- . ':(exclude)*-lock.json' ':(exclude)*.lock'";
    gdc = "git diff --cached -- . ':(exclude)package-lock.json'";
    gs = "git status";
    gidiot = "git commit --amend --no-edit";
    gra = "git reset --hard origin/main";
    hms = "${"$"}{CONFIG_MANAGER:-home-manager} switch --flake $FLAKE_CONFIG_URI";
  };
  initExtra = ''
    # Nix
    test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

    # This is needed for gpg+pinentry to work
    export GPG_TTY=$(tty)
    # Only dashes are considered part of a word. 
    # This makes ^w behave more intuitively.
    export WORDCHARS='-'

    # nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

    # Rustup
    . "$HOME/.cargo/env"
  '';
}
