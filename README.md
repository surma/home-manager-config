# home-manager-config

## Installation

```sh
# 1. Install nix
$ sh <(curl -L https://nixos.org/nix/install) --daemon

# 2. Install and apply home-assistant config (replace `generic-linux` if necessary)
$ nix --extra-experimental-features 'nix-command flakes' \
  run 'github:nix-community/home-manager' -- \
  --extra-experimental-features 'nix-command flakes' \
  switch --flake 'github:surma/home-manager-config/flake#generic-linux' 

# 3. Decrypt secrets
$ decrypt-secrets
```
