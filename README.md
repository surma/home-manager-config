# home-manager-config

## Installation

```sh
# 1. Install nix (remove `--daemon` on MacOS)
$ sh <(curl -L https://nixos.org/nix/install) --daemon

# 2. Install and apply home-assistant config (replace machine name if appropropriate)
$ nix --extra-experimental-features 'nix-command flakes' \
  run 'github:LnL7/nix-darwin' -- \
  --extra-experimental-features 'nix-command flakes' \
  switch --flake 'github:surma/home-manager-config#generic-macos'

# 2. Same but for linux
$ nix --extra-experimental-features 'nix-command flakes' \
  run 'github:nix-community/home-manager' -- \
  --extra-experimental-features 'nix-command flakes' \
  -b backup \
  switch --flake 'github:surma/home-manager-config#generic-linux'

# 3. Decrypt secrets
$ decrypt-secrets
```
