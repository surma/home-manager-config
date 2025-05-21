{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;

  podman = (callPackage (import ../extra-pkgs/podman) { });
in
{
  home.packages =
    (with pkgs; [
      google-cloud-sdk
      opentofu
    ])
    ++ [
      podman.podman
      podman.podman-compose
    ];

  xdg.configFile = {
    "containers/policy.json".text = builtins.toJSON {
      default = [ { type = "insecureAcceptAnything"; } ];
    };
    "containers/registries.conf".text = ''
      unqualified-search-registries = ['docker.io']

      [[registry]]
      prefix = "docker.io"
      location = "docker.io"
    '';
  };
}
