# home-manager-config

## Installation

```console
# 1. Install nix
$ sh <(curl -L https://nixos.org/nix/install) --daemon
# 2. Install and apply home-assistant config
$ nix run --extra-experimental-features "nix-command flakes" 'github:nix-community/home-manager' -- switch --flake 'github:surma/home-manager-config#generic-linux'
# 3. Decrypt secrets
$ decrypt-secrets
```
